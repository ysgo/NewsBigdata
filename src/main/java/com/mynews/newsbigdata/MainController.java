package com.mynews.newsbigdata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {
	@Autowired
	private Environment env;
	
	@RequestMapping("/main")
	public ModelAndView main() {
		ModelAndView mav = new ModelAndView("main");
		mav.addObject("naverID", env.getProperty("naver.ID"));
		return mav;
	}
}
