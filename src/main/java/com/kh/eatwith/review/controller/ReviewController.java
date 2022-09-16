package com.kh.eatwith.review.controller;


import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServlet;

import org.apache.ibatis.annotations.Param;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.common.typehandler.EatWithUtils;
import com.kh.eatwith.review.model.dto.Attachment;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.dto.ReviewExt;
import com.kh.eatwith.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review")
@SuppressWarnings("serial")
public class ReviewController extends HttpServlet {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/writeReview")
	public void writeReview() {
		
	}
	
	@PostMapping("/writeReview")
	public String writeReview(@Param("gatherNo") int gatherNo, Model model) {

		Map<String,Object> reviewInfo=reviewService.writeReview(gatherNo);
		model.addAttribute("reviewInfo",reviewInfo);
		log.debug("reviewInfo={}",reviewInfo);
		return "review/writeReview";
	}
	
	@PostMapping("/enrollReview")
	public String enrollReview (
		Review review,
		@RequestParam(name="upFile") List<MultipartFile> upFileList,
		RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		
		for(MultipartFile upFile : upFileList) {
			if(!upFile.isEmpty()) {
				log.debug("사진이 1개라도 있음 !!!!!!!!!!!!!!!!");
				//서버컴퓨터에 저장
	//			String saveDirectory=application.getRealPath("/resources/upload/review");
//				log.debug("saveDirectory={}",saveDirectory);
				String saveDirectory = "C:\\Workspaces\\spring_workspace\\final-project-eatwith\\src\\main\\webapp\\resources\\upload\\review";
				String renamedFilename = EatWithUtils.getRenamedFilename(upFile.getOriginalFilename());
				log.debug("renamedFilename={}",renamedFilename);
				File destFile = new File(saveDirectory,renamedFilename);
				upFile.transferTo(destFile);
				//DB저장을 위해 Attachment객체 생성
				Attachment attach = Attachment.builder().imageName(renamedFilename).build(); 
				review.add(attach);
			}
		}
		
		//db저장
		int result = reviewService.insertReview(review);
		log.debug("review = {}",review);
		redirectAttr.addFlashAttribute("msg","리뷰를 성공적으로 등록했습니다.");
		return "redirect:/";
	}
	
	@GetMapping("/getBestReviews")
	@ResponseBody
	@CrossOrigin(origins="*")
	public ResponseEntity<?> getBestReviews(){
		List<Map<String, Object>> reviews=reviewService.getBestReviews();
		log.debug("reviews = {}",reviews);
	
		return ResponseEntity.ok(reviews);
	}
	
	@GetMapping("/getNewestReviews")
	@ResponseBody
	@CrossOrigin(origins = "*")
	public ResponseEntity<?> getNewestReviews(@RequestParam int currPage){
		int itemsPerPage = 6;
		Map<String, Integer> param = new HashMap<String, Integer>();
		param.put("currPage", currPage);
		param.put("limit", itemsPerPage);
		List<ReviewExt> result = reviewService.getNewestReviews(param);
		
		
		return ResponseEntity.ok(result);
	}
	
}


