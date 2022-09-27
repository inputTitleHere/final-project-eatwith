package com.kh.eatwith.gather.controller;

import java.security.Principal;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.common.CustomMap;
import com.kh.eatwith.common.typehandler.EatWithUtils;
import com.kh.eatwith.favorite.model.dto.FavoriteRestaurant;
import com.kh.eatwith.favorite.model.service.FavoriteRestaurantService;
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.gather.model.service.GatherService;
import com.kh.eatwith.member.model.dto.Member;
import com.kh.eatwith.notification.model.dto.Notification;
import com.kh.eatwith.notification.model.dto.NotificationType;
import com.kh.eatwith.notification.model.service.NotificationService;
import com.kh.eatwith.restaurant.model.dto.Restaurant;
import com.kh.eatwith.restaurant.model.service.RestaurantService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/gather")
public class GatherController {

	@Autowired
	private GatherService gatherService;

	@Autowired
	private RestaurantService restaurantService;

	@Autowired
	private NotificationService notificationSerivce;

	@Autowired
	FavoriteRestaurantService favoriteRestaurantService;

	@GetMapping("/gatherEnroll")
	public void gatherEnroll(Principal principal,Model model) {
		if(isAuthenticated()) {
			String loginId=principal.getName();
			log.debug("loginId={}",loginId);
			Member member=gatherService.getMemberInfo(loginId);//모임장 정보
			log.debug("member={}",member);
			model.addAttribute("member",member);
			
		}
	}
	
	@PostMapping("/gatherEnroll")
	public String gatherEnroll(Gather gather, MemberGather memberGather, RedirectAttributes redirectAttr) {
		log.debug("gather = {}", gather);
		log.debug("memberGather ={}", memberGather);
		int result = gatherService.gatherEnroll(gather); // selectkey으로 신규생셩 no를 받아왔음했음. -- 백승윤
		redirectAttr.addFlashAttribute("msg", "모임이 등록되었습니다.");

		// 백승윤 2022/09/20 모임 등록시 가게 찜한 사람에게 알림 보내기
		String restaurantNo = gather.getRestaurantNo();
		Restaurant restaurant = restaurantService.selectOneRestaurant(restaurantNo); // 레스토랑 이름.
		String title = String.format("찜한 가게 : \"%s\"에서 만나는 모임 [%s]가 생겼어요!", restaurant.getName(), gather.getTitle()); // 알림
																														// 컨텐트
		String content = String.format("[%s]에서 모이는 [%s] 모임이 생겼습니다!\n" + "모임은 %s에 진행됩니다.!\n" + "모임 상세에서 더 자세히 봐요!",
				restaurant.getName(), gather.getTitle(),
				gather.getMeetDate().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 E요일 a hh시 mm분")));
		List<Integer> users = favoriteRestaurantService.getUsersByRestaurantNo(restaurantNo);
		// 이 가게를 찜한 유저가 있으면.
		if (users.size() > 0) {
			log.debug("users:{}", users);
			List<Notification> toSend = new ArrayList<Notification>();
			log.debug("toSend:{}", toSend);
			for (int no : users) {
				Notification notification = Notification.builder().content(content).title(title).userNo(no)
						.gatherNo(gather.getNo()).restaurantNo(restaurantNo).type(NotificationType.N).build();
				toSend.add(notification);
			}
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("toSend", toSend);
			result = notificationSerivce.insertNotification(param);

			// favorite_restaurant - restaurantNo 기반으로 userNo list를 뽑아와서 List<String>으로 해서
			// notification에 쫙 뿌려야한다.
		}
		// 백승윤 END
		return "redirect:/gather/gatherList";
	}

	private boolean isAuthenticated() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication == null || AnonymousAuthenticationToken.class.isAssignableFrom(authentication.getClass())) {
			return false;
		}
		return authentication.isAuthenticated();
	}

	@GetMapping("/gatherDetail")
	public void gatherDetail(@RequestParam int no, Principal principal, Model model) {
		Gather gather=gatherService.selectOneGather(no);
		log.debug("gather = {}",gather);
		model.addAttribute("gather",gather);
		
		Map<String,Object> gatherD=gatherService.getOneGather(no);
		log.debug("gatherDetail = {}",gatherD);
		model.addAttribute("gatherD",gatherD);
		
		if(isAuthenticated()) {
			String loginId=principal.getName();
			log.debug("loginId={}",loginId);
			Member member=gatherService.getMemberNo(loginId);//모임참가여부가져오기
			log.debug("member={}",member);
			model.addAttribute("member",member);
			
			int gatherNo=no;
			Map<String,Object> param =new HashMap<String, Object>();
			param.put("gatherNo",gatherNo);
			param.put("loginId", loginId);
			Integer checked=gatherService.checkAttendance(param);
			log.debug("checked={}",checked);
			model.addAttribute("checked",checked);
		}

		int count = gatherService.countGatherMem(no);
		log.debug("count={}",count);
		model.addAttribute("count",count);
		

		Integer endGather=gatherService.gatherEnd(no);
		log.debug("endGather={}",endGather);
		model.addAttribute("endGather", endGather);
	}

	@GetMapping("/gatherList")
	public void gatherList(Model model, HttpServletRequest request) {
		// 1. content영역
		List<Map<String, Object>> lists = gatherService.getGatherList();
		log.debug("lists = {}", lists);
		model.addAttribute("lists", lists);
	}

	@GetMapping("/getNearClosure")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNearClosure() {
		List<CustomMap> result = gatherService.getNearClosure();
		log.debug("시간타입 = {}", result.get(0).get("meetDate").getClass().getName());
		log.debug("==마감임박 = {} ", result);
		return ResponseEntity.ok(result);
	}

	@GetMapping("/gatherUpdate")
	public String gatherUpdate(Principal principal,@RequestParam int no, Model model) {
		Gather gatherO=gatherService.selectOneGather(no);
		Map<String,Object> gather = gatherService.selectOneGatherInfo(no);
		if(isAuthenticated()) {
			String loginId=principal.getName();
			log.debug("loginId={}",loginId);
			Member member=gatherService.getMemberInfo(loginId);//모임장 정보
			log.debug("member={}",member);
			model.addAttribute("member",member);
		}
		model.addAttribute("gatherO",gatherO);
		model.addAttribute("gather",gather);
		log.debug("gatherO = {}",gatherO);
		log.debug("gather = {}",gather);
		return "gather/gatherUpdate";
	}

	@PostMapping("/gatherUpdate")
	public String gatherUpdate(Gather gather, RedirectAttributes redirectAttr) {
		int result = gatherService.gatherUpdate(gather);
		log.debug("gatherUpdate={}", result);
		redirectAttr.addFlashAttribute("msg", "모임을 성공적으로 수정했습니다.");
		return "redirect:/gather/gatherDetail?no=" + gather.getNo();
	}

	@PostMapping("/gatherDelete")
	public String gatherDelete(@RequestParam int no, RedirectAttributes redirectAttr) {
		int result = gatherService.gatherDelete(no);
		log.debug("gatherDelete = {}", result);
		return "redirect:/gather/gatherList";
	}

	/**
	 * 모임 참가시 알림보내는 기능 추가하였습니다. 백승윤
	 * 
	 * @param gatherNo
	 * @param loginMember
	 * @return
	 */
	@PostMapping("/applyGather")
	@ResponseBody
	public ResponseEntity<?> applyGather(@RequestParam("gatherNo") int gatherNo,
			@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}", gatherNo);
		log.debug("loginMember={}", loginMember);
		// 유경님 원본코드
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		int result = gatherService.applyGather(param);
		log.debug("result={}", result);
		// 백승윤 추가코드
		/**
		 * 알림메세지 생성 및 db 저장. 참가자용
		 */
		Gather gather = gatherService.selectOneGather(gatherNo);
		String gatherDate = gather.getMeetDate().format(DateTimeFormatter.ofPattern("yyyy년 MM월 dd일 E요일 a hh시 mm분"));
		Restaurant restaurant = restaurantService.selectOneRestaurant(gather.getRestaurantNo());
		String title = String.format("[%s]모임에 참가했습니다!", gather.getTitle());
		String content = String.format(
				"[%s]에서 열리는 [%s]모임에 참가했습니다.\n" + "%s까지 모여주세요!\n" + "모임의 상호약속을 잘 지켜키는 착한 이용자가 되어줍시다!",
				restaurant.getName(), gather.getTitle(), gatherDate);

		Notification note = Notification.builder().userNo(loginMember).gatherNo(gatherNo)
				.restaurantNo(gather.getRestaurantNo()).type(NotificationType.J).title(title).content(content).build();
		/**
		 * 모임장용
		 * 
		 */
		int ownerNo = gather.getUserNo();
		int gatherEnrolledCount = gatherService.countGatherMem(gatherNo);
		title = String.format("[%s]모임에 새로운 참여자가 들어왔습니다!", gather.getTitle());
		content = String.format("[%s]모임에 새로운 참가자가 들어왔습니다!\n" + "모임 일시 : [%s]\n" + "참가현황 : ( %d / %d )",
				gather.getTitle(), gatherDate, gatherEnrolledCount, gather.getCount()+1);
		Notification ownerNote = Notification.builder().userNo(ownerNo).gatherNo(gatherNo)
				.restaurantNo(gather.getRestaurantNo()).type(NotificationType.J).title(title).content(content).build();
		/**
		 * 메세지 DB에 저장.
		 */
		List<Notification> toSend = new ArrayList<Notification>();
		toSend.add(ownerNote);
		toSend.add(note);
		param = new HashMap<String, Object>();
		param.put("toSend", toSend);
		notificationSerivce.insertNotification(param);
		return ResponseEntity.ok(null);
	}

	@PostMapping("/cancelGather")
	@ResponseBody
	public ResponseEntity<?> cancelGather(@RequestParam("gatherNo") int gatherNo,
			@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}", gatherNo);
		log.debug("loginMember={}", loginMember);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		int resultC = gatherService.cancelGather(param);
		log.debug("resultC={}", resultC);
		return ResponseEntity.ok(null);
	}

	@PostMapping("/chkGatherIn")
	@ResponseBody
	public ResponseEntity<?> chkGatherIn(@RequestParam("gatherNo") int gatherNo,
			@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}", gatherNo);
		log.debug("loginMember={}", loginMember);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		Integer resultChk = gatherService.chkGatherIn(param);
		log.debug("resultChk={}", resultChk);
		return ResponseEntity.ok(resultChk);
	}

	@GetMapping("/checkLoca")
	@ResponseBody
	public ResponseEntity<?> checkLoca(@RequestParam("chk_location[]") List<String> checkLoca, Model model) {
		log.debug("chk_location={}", checkLoca);
		CustomMap param = new CustomMap();
		param.put("checkLoca", checkLoca);
		log.debug("param={}", param);
		List<Map<String, Object>> resultL = gatherService.getGatherByLocation(param);
		log.debug("resultL={}", resultL);
		model.addAttribute(resultL);
		return ResponseEntity.ok(resultL);
	}

	@GetMapping("/checkFood")
	@ResponseBody
	public ResponseEntity<?> checkFood(@RequestParam("checkFood") int checkFood, Model model) {

		log.debug("checkFood={}", checkFood);
		List<Gather> resultF = gatherService.checkFood(checkFood);
		log.debug("resultFood={}", resultF);
		return ResponseEntity.ok(resultF);
	}

	@GetMapping("/gatherListAll")
	@ResponseBody
	public ResponseEntity<?> gatherListAllMore(@RequestParam("startNum") int startNum){
		List<Map<String,Object>> listMore=gatherService.gatherMoreAll(startNum);
		log.debug("listMore={}",listMore);
		return ResponseEntity.ok(listMore);
	}
	
	@GetMapping("/gatherListNewest")
	@ResponseBody
	public ResponseEntity<?> gatherListNewestMore(@RequestParam("startNum") int startNum){
		List<Map<String,Object>> listMore=gatherService.gatherMore(startNum);
		log.debug("listMore={}",listMore);
		return ResponseEntity.ok(listMore);
	}
	@GetMapping("/gatherListLatestMore")
	@ResponseBody
	public ResponseEntity<?> gatherListLatestMore(@RequestParam("startNum") int startNum){
		List<Map<String,Object>> listMore=gatherService.gatherLatestMore(startNum);
		log.debug("listMore={}",listMore);
		return ResponseEntity.ok(listMore);
	}
	
	@GetMapping("/getLatestList")
	@ResponseBody
	public ResponseEntity<?> checkLatest() {
		List<Map<String, Object>> LatestList = gatherService.getLatestList();
		log.debug("LatestList={}", LatestList);
		return ResponseEntity.ok(LatestList);
	}

	@GetMapping("/checkLeader")
	public void checkLeader(@RequestParam("gatherNo") int gatherNo,Model model) {
		log.debug("gatherNo={}",gatherNo);
		model.addAttribute("gatherNo", gatherNo);
		List<Map<String,Object>> check=gatherService.checkLeader(gatherNo);
		log.debug("check={}",check);
		model.addAttribute("check",check);
	}
	
	@GetMapping("/gatherAllList")
	@ResponseBody
	public ResponseEntity<?> checkNewest(){
		List<Map<String,Object>> NewestList=gatherService.gatherAllList();
		log.debug("NewestList={}",NewestList);
		return ResponseEntity.ok(NewestList);
	}

	@PostMapping("/checkLeaderIn")//모임 조장이 직접 참여했는지 확인하는 코드
	@ResponseBody
	public ResponseEntity<?> checkLeaderIn(@RequestParam("userNo") int userNo,@RequestParam("gNo") int gNo){
		log.debug("userNo",userNo);
		log.debug("gNo",gNo);
		Map<String,Object> param=new HashMap<String,Object>();
		param.put("gNo",gNo);
		param.put("userNo", userNo);
		int inresult=gatherService.checkLeaderIn(param);
		// userNo : 어떤 유저가
		// gNo : 모임명 
		
		
		log.debug("inresult={}",inresult);
		
		return ResponseEntity.ok(inresult);
	}
	@PostMapping("/checkLeaderOut")//모임 조장이 직접 참여했는지 확인하는 코드
	@ResponseBody
	public ResponseEntity<?> checkLeaderOut(@RequestParam("userNo") int userNo,@RequestParam("gNo") int gNo){
		log.debug("userNo",userNo);
		log.debug("gNo",gNo);
		Map<String,Object> param=new HashMap<String,Object>();
		param.put("gNo",gNo);
		param.put("userNo", userNo);
		int outresult=gatherService.checkLeaderOut(param);
		log.debug("outresult={}",outresult);
		
		return ResponseEntity.ok(outresult);
	}
	// 백승윤 START
	@GetMapping("/getNewestGatherings")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNewestGatherings() {
		int items = 9;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("no", items);
		List<CustomMap> result = gatherService.getNewestGatherings(params);
		return ResponseEntity.ok(result);
	}

	@GetMapping("/getRestaurantGathering")
	@ResponseBody
	public ResponseEntity<?> getRestaurantGathering(@RequestParam String no) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("no", no);
		List<CustomMap> result = gatherService.getRestaurantGathering(params);

		return ResponseEntity.ok(result);
	}

	@GetMapping("/getMyGather")
	@ResponseBody
	public ResponseEntity<?> getMyGather(@CookieValue(value = "no") Cookie cookie){
		int userNo = Integer.parseInt(cookie.getValue());
		List<CustomMap> myGather = gatherService.getGatherByOwnerNo(userNo);
		log.debug("myGather = {}",myGather);
		
		
		return ResponseEntity.ok(myGather);
	}
	
	@GetMapping("/getMyGatherPast")
	@ResponseBody
	public ResponseEntity<?> getMyGatherPast(@CookieValue(value="no") Cookie cookie, @RequestParam int cPage){
		int userNo = Integer.parseInt(cookie.getValue());
		log.debug("cPage = {}",cPage);
		
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("no", userNo);
		params.put("cPage", cPage);
		params.put("limit",8);
		
		List<CustomMap> myPastGather = gatherService.getPastGatherByOwnerNo(params);
		
		
		return ResponseEntity.ok(myPastGather);
	}
	
	@GetMapping("/joinedGather")
	@ResponseBody
	public ResponseEntity<?> getJoinedGather(@CookieValue(value="no") Cookie cookie){
		int userNo = Integer.parseInt(cookie.getValue());
		List<CustomMap> joinedGather = gatherService.getJoinedGather(userNo);
		
		
		return ResponseEntity.ok(joinedGather);
	}
	@GetMapping("/joinedPastGather")
	@ResponseBody
	public ResponseEntity<?> getJoinedPastGather(@CookieValue(value="no") Cookie cookie, @RequestParam int cPage){
		int userNo = Integer.parseInt(cookie.getValue());
		Map<String, Integer> params = new HashMap<String, Integer>();
		params.put("cPage", cPage);
		params.put("limit", 9);
		params.put("no", userNo);
		List<CustomMap> joinedPastGather = gatherService.getJoinedPastGather(params);
		
		return ResponseEntity.ok(joinedPastGather);
	}
	
	
	// 백승윤 END

}
