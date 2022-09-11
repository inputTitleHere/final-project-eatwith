package com.kh.eatwith.gather.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
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
import com.kh.eatwith.gather.model.dto.Gather;
import com.kh.eatwith.gather.model.dto.MemberGather;
import com.kh.eatwith.gather.model.service.GatherService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/gather")
public class GatherController {
	
	@Autowired
	private GatherService gatherService;
	
	@GetMapping("/gatherEnroll")
	public void gatherEnroll() {}
	
	@GetMapping("/gatherDetail")
	public void gatherDetail(@RequestParam int no, Model model) {
		Gather gather=gatherService.selectOneGather(no);
		log.debug("gather = {}",gather);
		model.addAttribute("gather",gather);
		
		Map<String,Object> gatherD=gatherService.getOneGather(no);
		log.debug("gatherDetail = {}",gatherD);
		model.addAttribute("gatherD",gatherD);
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
	
	@PostMapping("/gatherEnroll")
	public String gatherEnroll(Gather gather, MemberGather memberGather, RedirectAttributes redirectAttr) {
		log.debug("gather = {}",gather);
		log.debug("memberGather ={}",memberGather);
		int result=gatherService.gatherEnroll(gather);
		redirectAttr.addFlashAttribute("msg","모임이 등록되었습니다.");
		
		return "redirect:/gather/gatherList";
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
}
