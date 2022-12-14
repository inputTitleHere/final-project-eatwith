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
			Member member=gatherService.getMemberInfo(loginId);//????????? ??????
			log.debug("member={}",member);
			model.addAttribute("member",member);
			
		}
	}
	
	@PostMapping("/gatherEnroll")
	public String gatherEnroll(Gather gather, MemberGather memberGather, RedirectAttributes redirectAttr) {
		log.debug("gather = {}", gather);
		log.debug("memberGather ={}", memberGather);
		int result = gatherService.gatherEnroll(gather); // selectkey?????? ???????????? no??? ??????????????????. -- ?????????
		redirectAttr.addFlashAttribute("msg", "????????? ?????????????????????.");

		// ????????? 2022/09/20 ?????? ????????? ?????? ?????? ???????????? ?????? ?????????
		String restaurantNo = gather.getRestaurantNo();
		Restaurant restaurant = restaurantService.selectOneRestaurant(restaurantNo); // ???????????? ??????.
		String title = String.format("?????? ?????? : \"%s\"?????? ????????? ?????? [%s]??? ????????????!", restaurant.getName(), gather.getTitle()); // ??????
																														// ?????????
		String content = String.format("[%s]?????? ????????? [%s] ????????? ???????????????!\n" + "????????? %s??? ???????????????.!\n" + "?????? ???????????? ??? ????????? ??????!",
				restaurant.getName(), gather.getTitle(),
				gather.getMeetDate().format(DateTimeFormatter.ofPattern("yyyy??? MM??? dd??? E?????? a hh??? mm???")));
		List<Integer> users = favoriteRestaurantService.getUsersByRestaurantNo(restaurantNo);
		// ??? ????????? ?????? ????????? ?????????.
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

			// favorite_restaurant - restaurantNo ???????????? userNo list??? ???????????? List<String>?????? ??????
			// notification??? ??? ???????????????.
		}
		// ????????? END
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
			Member member=gatherService.getMemberNo(loginId);//??????????????????????????????
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
		// 1. content??????
		List<Map<String, Object>> lists = gatherService.getGatherList();
		log.debug("lists = {}", lists);
		model.addAttribute("lists", lists);
	}

	@GetMapping("/getNearClosure")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNearClosure() {
		List<CustomMap> result = gatherService.getNearClosure();
		log.debug("???????????? = {}", result.get(0).get("meetDate").getClass().getName());
		log.debug("==???????????? = {} ", result);
		return ResponseEntity.ok(result);
	}

	@GetMapping("/gatherUpdate")
	public String gatherUpdate(Principal principal,@RequestParam int no, Model model) {
		Gather gatherO=gatherService.selectOneGather(no);
		Map<String,Object> gather = gatherService.selectOneGatherInfo(no);
		if(isAuthenticated()) {
			String loginId=principal.getName();
			log.debug("loginId={}",loginId);
			Member member=gatherService.getMemberInfo(loginId);//????????? ??????
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
		redirectAttr.addFlashAttribute("msg", "????????? ??????????????? ??????????????????.");
		return "redirect:/gather/gatherDetail?no=" + gather.getNo();
	}

	@PostMapping("/gatherDelete")
	public String gatherDelete(@RequestParam int no, RedirectAttributes redirectAttr) {
		int result = gatherService.gatherDelete(no);
		log.debug("gatherDelete = {}", result);
		return "redirect:/gather/gatherList";
	}

	/**
	 * ?????? ????????? ??????????????? ?????? ?????????????????????. ?????????
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
		// ????????? ????????????
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		int result = gatherService.applyGather(param);
		log.debug("result={}", result);
		// ????????? ????????????
		/**
		 * ??????????????? ?????? ??? db ??????. ????????????
		 */
		Gather gather = gatherService.selectOneGather(gatherNo);
		String gatherDate = gather.getMeetDate().format(DateTimeFormatter.ofPattern("yyyy??? MM??? dd??? E?????? a hh??? mm???"));
		Restaurant restaurant = restaurantService.selectOneRestaurant(gather.getRestaurantNo());
		String title = String.format("[%s]????????? ??????????????????!", gather.getTitle());
		String content = String.format(
				"[%s]?????? ????????? [%s]????????? ??????????????????.\n" + "%s?????? ???????????????!\n" + "????????? ??????????????? ??? ???????????? ?????? ???????????? ???????????????!",
				restaurant.getName(), gather.getTitle(), gatherDate);

		Notification note = Notification.builder().userNo(loginMember).gatherNo(gatherNo)
				.restaurantNo(gather.getRestaurantNo()).type(NotificationType.J).title(title).content(content).build();
		/**
		 * ????????????
		 * 
		 */
		int ownerNo = gather.getUserNo();
		int gatherEnrolledCount = gatherService.countGatherMem(gatherNo);
		title = String.format("[%s]????????? ????????? ???????????? ??????????????????!", gather.getTitle());
		content = String.format("[%s]????????? ????????? ???????????? ??????????????????!\n" + "?????? ?????? : [%s]\n" + "???????????? : ( %d / %d )",
				gather.getTitle(), gatherDate, gatherEnrolledCount, gather.getCount()+1);
		Notification ownerNote = Notification.builder().userNo(ownerNo).gatherNo(gatherNo)
				.restaurantNo(gather.getRestaurantNo()).type(NotificationType.J).title(title).content(content).build();
		/**
		 * ????????? DB??? ??????.
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

	@PostMapping("/checkLeaderIn")//?????? ????????? ?????? ??????????????? ???????????? ??????
	@ResponseBody
	public ResponseEntity<?> checkLeaderIn(@RequestParam("userNo") int userNo,@RequestParam("gNo") int gNo){
		log.debug("userNo",userNo);
		log.debug("gNo",gNo);
		Map<String,Object> param=new HashMap<String,Object>();
		param.put("gNo",gNo);
		param.put("userNo", userNo);
		int inresult=gatherService.checkLeaderIn(param);
		// userNo : ?????? ?????????
		// gNo : ????????? 
		Gather gather = gatherService.selectOneGather(gNo);
		String gatherDate = gather.getMeetDate().format(DateTimeFormatter.ofPattern("yyyy??? MM??? dd??? E?????? a hh??? mm???"));
		String title=String.format("????????? [%s]????????? ?????? ????????? ???????????????!", gather.getTitle());
		String content = String.format("[%s]????????? ????????? ?????????????????????!\n"
				+ "[%s]??? ????????? [%s]????????? ???????????? ??????????????? ??????????????????.\n"
				+ "????????? ???????????? ?????? ???????????? ?????????!",gather.getTitle(),gatherDate,gather.getTitle());
		Notification note = Notification.builder().userNo(userNo).gatherNo(gNo).restaurantNo(gather.getRestaurantNo()).type(NotificationType.N).title(title).content(content).build();
		List<Notification> toSend = new ArrayList<Notification>();
		toSend.add(note);
		param = new HashMap<String, Object>();
		param.put("toSend", toSend);
		notificationSerivce.insertNotification(param);
		
		log.debug("inresult={}",inresult);
		
		return ResponseEntity.ok(inresult);
	}
	@PostMapping("/checkLeaderOut")//?????? ????????? ?????? ??????????????? ???????????? ??????
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
	// ????????? START
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
	
	
	// ????????? END

}
