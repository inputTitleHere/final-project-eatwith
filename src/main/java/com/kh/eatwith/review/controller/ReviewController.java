package com.kh.eatwith.review.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.ws.Response;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.eatwith.common.typehandler.EatWithUtils;
import com.kh.eatwith.review.model.dto.Attachment;
import com.kh.eatwith.review.model.dto.Review;
import com.kh.eatwith.review.model.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/review")
public class ReviewController extends HttpServlet {
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private ServletContext application;
	
	@GetMapping("/writeReview")
	public void writeReview() {
		
	}
	
	@PostMapping("/writeReview")
	public String writeReview (
		Review review,
		@RequestParam(name="upFile") List<MultipartFile> upFileList,
		RedirectAttributes redirectAttr) throws IllegalStateException, IOException {
		
		for(MultipartFile upFile : upFileList) {
			if(!upFile.isEmpty()) {
				//서버컴퓨터에 저장
				String saveDirectory=application.getRealPath("/resources/upload/review");
				String renamedFilename = EatWithUtils.getRenamedFilename(upFile.getOriginalFilename());
				File destFile = new File(saveDirectory,renamedFilename);
				upFile.transferTo(destFile);
				//DB저장을 위해 Attachment객체 생성
				Attachment attach = new Attachment(upFile.getOriginalFilename(),renamedFilename);
				review.add(attach);
			}
		}
		log.debug("review = {}",review);
		
		//db저장
		int result = reviewService.insertReview(review);
		redirectAttr.addFlashAttribute("msg","리뷰를 성공적으로 등록했습니다.");
		return "redirect:/restaurant/restaurantList";
	}
	
	@GetMapping("/getBestReviews")
	@ResponseBody
	@CrossOrigin("*")
	public ResponseEntity<?> getBestReviews(){
		List<Review> reviews=reviewService.getBestReviews();
		
		
		
		return ResponseEntity.ok(reviews);
	}
	
}


