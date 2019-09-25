package com.mynews.newsbigdata;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import dao.HadoopDAO;

@Controller
public class HadoopController {
	@Autowired
	HadoopDAO dao;
	
	public HadoopController() {
		System.out.println("HadoopController 파일 실행");
	}
	
	// http://localhost:8000/newsbigdata/hadooprw_test.do?filename=president_moon.txt
	@RequestMapping(value ="/hadooprw_test.do")
	public ModelAndView put(String filename) {
		System.out.println("테스트");
		String result = dao.readwrite(filename);
		ModelAndView mav = new ModelAndView();
		mav.addObject("hadooprw_test", result);
		mav.setViewName("hadoopView_test");
		return mav;
	}
}
