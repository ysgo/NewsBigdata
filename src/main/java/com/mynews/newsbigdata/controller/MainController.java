package com.mynews.newsbigdata.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@Autowired
	private Environment env;
	@RequestMapping("/")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("naverID", env.getProperty("naver.ID"));
		return mav;
	}
	
	@RequestMapping("/main")
	public ModelAndView view(HttpServletRequest request) throws Exception {
		ModelAndView mav = new ModelAndView("main2");
		mav.addObject("naverID", env.getProperty("naver.ID"));
		return mav;
	}
}
