package com.mynews.newsbigdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import service.NewsService;
import vo.NewsVO;

@Controller
@SessionAttributes("status")
public class NewsController {
	@Autowired
	NewsService service;
	@Autowired
	private Environment env;
	
	@RequestMapping(value="/mainNews.do", method=RequestMethod.GET)
	public ModelAndView newsMap() {
		// http://localhost:8000/newsbigdata/main.do?fid=01
		ModelAndView mav = new ModelAndView("main_news");
		List<NewsVO> list = service.listAll();
		mav.addObject("list1", list);
		mav.addObject("naverID", env.getProperty("naver.ID"));
		return mav;
	}
	
//	@RequestMapping(value="/main.do", method=RequestMethod.POST)
//	public ModelAndView newsMap() {
//		return new ModelAndView("main");
//	}
	
	// 메인페이지 뉴스 기사 리스트 출력 & 모달페이지 뉴스 기사 내용 출력
	@RequestMapping(value="/readNews.do", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	@ResponseBody
	public NewsVO readNews(@ModelAttribute NewsVO vo, Model model) {
		try {
			vo = service.readNews(vo);
			model.addAttribute("readNews", vo);
		} catch(NullPointerException e) {
			System.out.println("제목과 매치되는 기사가 존재하지 않습니다.");
		}
		return vo;
	}
}
