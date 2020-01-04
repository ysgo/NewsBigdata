package com.mynews.newsbigdata.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/news")
public class MainController {

	@GetMapping
	public String viewDashboard() {
		return "news/index";
	}
	
	@GetMapping("/user")
	public String viewUser() {
		return "news/user";
	}
	
	@GetMapping("/map")
	public String viewMap() {
		return "news/maps";
	}
}
