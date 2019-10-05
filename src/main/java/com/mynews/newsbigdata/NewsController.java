package com.mynews.newsbigdata;

import java.util.HashMap;
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
import vo.ProvinceVO;
import vo.SigunguVO;

@Controller
@SessionAttributes("status")
public class NewsController {
	@Autowired
	NewsService service;
	@Autowired
	private Environment env;
	
	@RequestMapping(value="/mainNews.do", method=RequestMethod.GET)
	public ModelAndView mainNews() {
		ModelAndView mav = new ModelAndView("main_news");
		List<NewsVO> list = null;
		try {
			list = service.listAll();
			mav.addObject("list1", list);
		} catch(NullPointerException e) {
			System.out.println("NewsList is null!");
		} finally {
			mav.addObject("naverID", env.getProperty("naver.ID"));
		}
		return mav;
	}
	
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
	
	// 지도에 시도명, 시군구명, 위도, 경도 데이터 로드
	@RequestMapping(value="/mainMap.do", method=RequestMethod.GET)
	@ResponseBody
	public HashMap<String, Object> mainMap() {
		HashMap<String, Object> map = new HashMap<>();
		List<ProvinceVO> province = null;
		List<SigunguVO> sigungu = null;
		try {
			province = service.provinceList();
			sigungu = service.sigunguList();
			map.put("province", province);
			map.put("sigungu", sigungu);
		} catch(NullPointerException e) {
			System.out.println("ProvinceList or SigunguList is null!");
		}
		System.out.println(map);
		return map;
	}
}
