package com.mynews.newsbigdata.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/news")
public class MainController {

	@GetMapping
	public String viewMain() {
		return "news/index";
	}
	
	@GetMapping("/user")
	public String viewUser() {
		return "news/user";
	}
	
	@GetMapping("/dashboard")
	public String viewDashboard() {
		return "news/dashboard";
	}
}
