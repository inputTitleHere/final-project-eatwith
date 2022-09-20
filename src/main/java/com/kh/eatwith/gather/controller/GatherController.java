package com.kh.eatwith.gather.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public void gatherEnroll() {}
	
	@PostMapping("/gatherEnroll")
	public String gatherEnroll(Gather gather, MemberGather memberGather, RedirectAttributes redirectAttr) {
		log.debug("gather = {}",gather);
		log.debug("memberGather ={}",memberGather);
		int result=gatherService.gatherEnroll(gather);
		redirectAttr.addFlashAttribute("msg","모임이 등록되었습니다.");
		
		// 백승윤 2022/09/20 모임 등록시 가게 찜한 사람에게 알림 보내기
		String restaurantNo = gather.getRestaurantNo();
		Restaurant restaurant = restaurantService.selectOneRestaurant(restaurantNo); // 레스토랑 이름.
		String content = String.format("찜한 가게 \"%s\"에서 만나는 모임 [%s]가 생성되었어요! 확인해봐요~!", restaurant.getName(), gather.getTitle()); // 알림 컨텐트
		List<Integer> users = favoriteRestaurantService.getUsersByRestaurantNo(restaurantNo);
		if(users.size()>0) {
			log.debug("users:{}",users);
			List<Notification> toSend = new ArrayList<Notification>();
			log.debug("toSend:{}",toSend);
			for(int no : users) {
				Notification notification = Notification.builder().content(content).userNo(no).build();
				toSend.add(notification);
			}
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("toSend", toSend);
			result = notificationSerivce.insertNotification(param);
			
			// favorite_restaurant - restaurantNo 기반으로 userNo list를 뽑아와서 List<String>으로 해서 notification에 쫙 뿌려야한다.			
		}
		// 백승윤 END
		return "redirect:/gather/gatherList";
	}
	
	private boolean isAuthenticated() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || AnonymousAuthenticationToken.class.
	      isAssignableFrom(authentication.getClass())) {
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
			Member member=gatherService.getMemberNo(loginId);
			log.debug("member={}",member);
			model.addAttribute("member",member);
		}
		
		int count=gatherService.countGatherMem(no);
		log.debug("count={}",count);
		model.addAttribute("count",count);
	}
	
	@GetMapping("/gatherList")
	public void gatherList(@RequestParam(defaultValue="1") int cPage,Model model, HttpServletRequest request) {
		// 1. content영역
		Map<String, Integer> param = new HashMap<>();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		List<Map<String,Object>> lists=gatherService.getGatherList();
		log.debug("lists = {}",lists);
		model.addAttribute("lists",lists);
		
		// 2. pagebar영역
		int totalContent = gatherService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI(); // /spring/board/boardList.do
		String pagebar = EatWithUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	@GetMapping("/getNearClosure")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNearClosure(){
		List<CustomMap> result = gatherService.getNearClosure();
		log.debug("시간타입 = {}",result.get(0).get("meetDate").getClass().getName());
		log.debug("==마감임박 = {} ",result);
		return ResponseEntity.ok(result);
	}
	
	@GetMapping("/gatherUpdate")
	public String gatherUpdate(@RequestParam int no, Model model) {
		Gather gatherO=gatherService.selectOneGather(no);
		Map<String,Object> gather = gatherService.selectOneGatherInfo(no);
		model.addAttribute("gatherO",gatherO);
		model.addAttribute("gather",gather);
		log.debug("gatherO = {}",gatherO);
		log.debug("gather = {}",gather);
		return "gather/gatherUpdate";
	}
	
	@PostMapping("/gatherUpdate")
	public String gatherUpdate(Gather gather,RedirectAttributes redirectAttr) {
		int result=gatherService.gatherUpdate(gather);
		log.debug("gatherUpdate={}",result);
		redirectAttr.addFlashAttribute("msg","모임을 성공적으로 수정했습니다.");
		return "redirect:/gather/gatherDetail?no="+gather.getNo();
	}
	
	@PostMapping("/gatherDelete")
	public String gatherDelete(@RequestParam int no,RedirectAttributes redirectAttr) {
		int result=gatherService.gatherDelete(no);
		log.debug("gatherDelete = {}",result);
		return "redirect:/gather/gatherList";
	}
	
	@PostMapping("/applyGather")
	@ResponseBody
	public ResponseEntity<?> applyGather(@RequestParam("gatherNo") int gatherNo,@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}",gatherNo);
		log.debug("loginMember={}",loginMember);
		Map<String,Object> param =new HashMap<String, Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		int result=gatherService.applyGather(param);
		log.debug("result={}",result);
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/cancelGather")
	@ResponseBody
	public ResponseEntity<?> cancelGather(@RequestParam("gatherNo") int gatherNo,@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}",gatherNo);
		log.debug("loginMember={}",loginMember);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		int resultC=gatherService.cancelGather(param);
		log.debug("resultC={}",resultC);
		return ResponseEntity.ok(null);
	}
	
	@PostMapping("/chkGatherIn")
	@ResponseBody
	public ResponseEntity<?> chkGatherIn(@RequestParam("gatherNo") int gatherNo,@RequestParam("loginMember") int loginMember) {
		log.debug("gatherNo={}",gatherNo);
		log.debug("loginMember={}",loginMember);
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("gatherNo", gatherNo);
		param.put("loginMember", loginMember);
		Integer resultChk=gatherService.chkGatherIn(param);
		log.debug("resultChk={}",resultChk);
		return ResponseEntity.ok(resultChk);
	}
	
	// 백승윤 START
	@GetMapping("/getNewestGatherings")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNewestGatherings(){
		int items = 9;
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("no", items);
		List<CustomMap> result = gatherService.getNewestGatherings(params);
		return ResponseEntity.ok(result);
	}
	
	
	// 백승윤 END
	
}
