package com.mynews.newsbigdata;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MembershipController {
	@RequestMapping("/signIn.do")
	public ModelAndView signIn() {
		return new ModelAndView("signIn");
	}
	
	@RequestMapping("/signUp.do")
	public ModelAndView signUp() {
		return new ModelAndView("signUp");
	}
	
	@RequestMapping("/myPage.do")
	public ModelAndView myPage() {
		return new ModelAndView("myPage");
	}
}
