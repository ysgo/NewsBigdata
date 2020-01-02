package com.mynews.newsbigdata.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/newsbigdata")
public class MainController {

	@GetMapping
	public String main() {
//		mav.addObject("naverID", env.getProperty("naver.ID"));
		return "news/index";
	}
}
