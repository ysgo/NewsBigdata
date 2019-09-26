package com.mynews.newsbigdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import service.NewsService;
import vo.NewsVO;

@Controller
@SessionAttributes("status")
public class NewsController {
	@Value("${naverID}")
	private String naverClientID;
	@Autowired
	NewsService service;
	
	
	@RequestMapping(value="/main.do", method=RequestMethod.GET)
	public ModelAndView newsMap(Model model) {
		// http://localhost:8000/newsbigdata/main.do?fid=01
//		model.addAttribute("apiKey", naverClientID);
		ModelAndView mav = new ModelAndView();
		List<NewsVO> list = service.listAll();
		mav.addObject("list1", list);
		mav.setViewName("main");
		return mav;
	}
	
//	@RequestMapping(value="/main.do", method=RequestMethod.POST)
//	public ModelAndView newsMap() {
//		return new ModelAndView("main");
//	}
}
