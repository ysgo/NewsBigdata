package com.mynews.newsbigdata;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

@Controller
@SessionAttributes("status")
public class NewsMapController {
	@Value("${naverID}")
	private String naverClientID;
	
	@RequestMapping(value="/main.do", method=RequestMethod.GET)
	public ModelAndView newsMap(Model model) {
		model.addAttribute("apiKey", naverClientID);
		return new ModelAndView("main");
	}
	
//	@RequestMapping(value="/main.do", method=RequestMethod.POST)
//	public ModelAndView newsMap() {
//		return new ModelAndView("main");
//	}
}
