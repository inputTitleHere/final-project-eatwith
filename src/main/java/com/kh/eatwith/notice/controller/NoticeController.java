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

import com.google.gson.JsonObject;
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
		
		//공지사항 List 영역 01 _ 5개 단위로 목록 나누기 위한 param 생성
		Map<String, Integer> param = new HashedMap();
		int limit = 5;
		param.put("cPage", cPage);
		param.put("limit", limit);
		
		//공지사항 List 영역 02 _ 공지사항 DB 내, 제목 등 가져오기
		List<Notice> list = noticeService.selectNoticeList(param);
		log.debug("list = {}", list);
		model.addAttribute("list", noticeService.selectNoticeList(param));
		
		//페이지 바 영역
		// * 이미 만들어두신 거 있어서 5개 기준으로 재 사용하였습니다.
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
	

	// 수정, 안되면 하단 코드로 진행
//	@GetMapping("/noticeDetail")
//	public void noticeDetail(@RequestParam(defaultValue = "1") int cPage, Model model, HttpServletRequest request) {
//		
//		//공지사항 List 영역 01 _ 5개 단위로 목록 나누기 위한 param 생성
//		Map<String, Integer> param = new HashedMap();
//		int limit = 5;
//		param.put("cPage", cPage);
//		param.put("limit", limit);
//		
//		//공지사항 List 영역 02 _ 공지사항 DB 내, 제목 등 가져오기
//		List<Notice> list = noticeService.selectNoticeList(param);
//		log.debug("list = {}", list);
//		model.addAttribute("list", noticeService.selectNoticeList(param));
//		
//		//페이지 바 영역
//		// * 이미 만들어두신 거 있어서 5개 기준으로 재 사용하였습니다.
//		int totalContent = noticeService.getTotalContent();
//		log.debug("totalContent = {}", totalContent);
//		String url = request.getRequestURI();
//		String pagebar = EatWithUtils.getPagebar(cPage, limit, totalContent, url);
//		model.addAttribute("pagebar", pagebar);
//	}
	
	// 수정 전 원본
//	@GetMapping("/noticeDetail")
//	public void noticeDetail(@RequestParam int noticeNo, Model model) {
//		// notice - Attachment
//		Notice notice = noticeService.selectOneNotice(noticeNo);
//		log.debug("notice = {}", notice);
//		// 게시글 조회 알림.
////		noticeService.sendNotice(notice);
//		model.addAttribute("notice", notice);
//	}
	
	// 수정 중
	@GetMapping("/noticeDetail")
	public void noticeDetail(@RequestParam int noticeNo, Model model) {
		// notice - Attachment
		Notice notice = noticeService.selectOneNotice(noticeNo);
		log.debug("notice = {}", notice);
		// 게시글 조회 알림.
//		noticeService.sendNotice(notice);
		model.addAttribute("notice", notice);
		
		Map<String, Integer> param = new HashedMap();
		param.put("noticeNo", noticeNo);
		List<Notice> list = noticeService.selectNoticeDetail(param);
		log.debug("list = {}", list);
		model.addAttribute("list", noticeService.selectNoticeDetail(param));
	}
	
	
	/**
	 * 
	 * Resource
	 * 다음 구현체들의 추상화레이어를 제공한다.
	 * 
	 * - 웹상 자원 UrlResource
	 * - classpath 자원 ClassPathResource
	 * - 서버컴퓨터 자원 FileSystemResource
	 * - ServletContext (web root) 자원 ServletContextResource
	 * - 입출력 자원 InputStreamResource
	 * - 이진데이터 자원 ByteArrayResource
	 * @throws IOException 
	 * 
	 * @ResponseBody - 핸들러의 반환된 자바객체를 응답메세지 바디에 직접 출력하는 경우
	 * 
	 *  
	 */
	
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
	
	
//	// 썸머노트 : 사진 이미지
//	@RequestMapping(value="/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
//	@ResponseBody
//	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
//		JsonObject jsonObject = new JsonObject();
//		
//        /*
//		 * String fileRoot = "C:\\summernote_image\\"; // 외부경로로 저장을 희망할때.
//		 */
//		
//		// 내부경로로 저장
//		String contextRoot = application.getRealPath("/");
//		String fileRoot = contextRoot+"/resources/upload/notice";
//		
//		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
//		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
//		String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
//		
//		File targetFile = new File(fileRoot + savedFileName);	
//		try {
//			InputStream fileStream = multipartFile.getInputStream();
//			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
//			jsonObject.addProperty("url", "/summernote/resources/upload/notice/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
//			jsonObject.addProperty("responseCode", "success");
//				
//		} catch (IOException e) {
//			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
//			jsonObject.addProperty("responseCode", "error");
//			e.printStackTrace();
//		}
//		String a = jsonObject.toString();
//		return a;
//	}
//	
	
}
