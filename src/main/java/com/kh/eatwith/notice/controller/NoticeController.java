package com.kh.eatwith.notice.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ResourceLoader;
import org.springframework.http.ResponseEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.common.typehandler.EatWithUtils;
import com.kh.eatwith.notice.model.dto.Notice;
import com.kh.eatwith.notice.model.service.NoticeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/notice")
public class NoticeController {

	@Autowired
	NoticeService noticeService;

	@Autowired
	ServletContext application;
	
	@Autowired
	ResourceLoader resourceLoader;
	
	@GetMapping("/noticeList")
	public void noticeList(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
		
		Map<String, Integer> param = new HashMap();
		int limit = 10;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		List<Notice> list = noticeService.selectNoticeList(param);
		log.debug("list = {}", list);
		model.addAttribute("list", noticeService.selectNoticeList(param));

		int totalContent = noticeService.getTotalContent();
		log.debug("totalContent = {}", totalContent);
		String url = request.getRequestURI();
		String pagebar = EatWithUtils.getPagebar(cPage, limit, totalContent, url);
		model.addAttribute("pagebar", pagebar);
	}
	
	
	@GetMapping("/noticeForm")
	public void NoticeForm() {
		
	}
	
	@PostMapping("/noticeInsert")
	public String insertNotice(
			Notice notice, 
			RedirectAttributes redirectAttr) 
					throws IllegalStateException{

		
		log.debug("notice = {}", notice);
		
		int result = noticeService.insertNotice(notice);
		
		redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 저장했습니다.");
		
		return "redirect:/notice/noticeList";
	}

	@GetMapping("/noticeDetail")
	public void noticeDetail(@RequestParam int noticeNo, Model model) {
		
		Notice notice = noticeService.selectOneNotice(noticeNo);
		log.debug("notice = {}", notice);
		
		model.addAttribute("notice", notice);
		
		Map<String, Integer> param = new HashedMap();
		param.put("noticeNo", noticeNo);
		List<Notice> list = noticeService.selectNoticeDetail(param);
		log.debug("list = {}", list);
		model.addAttribute("list", noticeService.selectNoticeDetail(param));
	}
	
	
	@GetMapping("/noticeUpdate")
	public void noticeUpdate(@RequestParam int noticeNo, Model model) {
		Notice notice = noticeService.selectOneNotice(noticeNo);
		model.addAttribute("notice", notice);
	}
	
	/**
	 * - 게시글 수정
	 * - 첨부파일 삭제(파일삭제 && attachment row 제거)
	 * - 첨부파일 추가
	 * 
	 * @return
	 */
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(
				Notice notice, RedirectAttributes redirectAttr) 
					throws IllegalStateException {
		int result = noticeService.updateNotice(notice);				
		
		redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 수정했습니다.");
						
		return "redirect:/notice/noticeDetail?noticeNo=" + notice.getNoticeNo();
	}
	
	@PostMapping("/noticeDelete")
	public String noticeDelete(
			@RequestParam int noticeNo, RedirectAttributes redirectAttr) 
					throws IllegalStateException {
		int result = noticeService.deleteNotice(noticeNo);				
		
		redirectAttr.addFlashAttribute("msg", "게시글을 성공적으로 삭제되었습니다.");
						
		return "redirect:/notice/noticeList";
	}
}
