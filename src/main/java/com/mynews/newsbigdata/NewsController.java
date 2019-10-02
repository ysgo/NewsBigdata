package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
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
	@Value("${naverID}")
	private String naverClientID;
	@Autowired
	NewsService service;
	
	
	@RequestMapping(value="/mainNews.do", method=RequestMethod.GET)
	public ModelAndView newsMap(Model model) {
		// http://localhost:8000/newsbigdata/main.do?fid=01
//		model.addAttribute("apiKey", naverClientID);
		ModelAndView mav = new ModelAndView();
		List<NewsVO> list = service.listAll();
		mav.addObject("list1", list);
		mav.setViewName("main_news");
		return mav;
	}
	
//	@RequestMapping(value="/main.do", method=RequestMethod.POST)
//	public ModelAndView newsMap() {
//		return new ModelAndView("main");
//	}
	
	// 메인페이지 뉴스 기사 리스트 출력 & 모달페이지 뉴스 기사 내용 출력
	@RequestMapping(value="/readNews.do", method = RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> readNews(@ModelAttribute NewsVO vo) {
		HashMap<String, Object> map = new HashMap<>();
		try {
			vo = service.readNews(vo);
			map.put("readNews", vo);
		} catch(NullPointerException e) {
			System.out.println("제목과 매치되는 기사가 존재하지 않습니다.");
		}
		return map;
	}
}
