package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttributes;

import service.NewsService;
import vo.NewsVO;
import vo.ProvinceVO;
import vo.SigunguVO;

@RestController
@SessionAttributes("status")
public class NewsController {
	@Autowired
	NewsService service;
	@Autowired
	private Environment env;
	
	@RequestMapping(value="/mainNews.do", method=RequestMethod.GET)
	public HashMap<String, Object> mainNews(Model model) {
		HashMap<String, Object> map = new HashMap<>();
		List<String> todayNews = null;
		List<ProvinceVO> province = null;
		List<SigunguVO> sigungu = null;
		try {
			// 오늘의 뉴스 데이터 로드
			todayNews = service.listAll();
			map.put("todayNews", todayNews);
			
			// 지도에 시도명, 시군구명, 위도, 경도 데이터 로드
			province = service.provinceList();
			sigungu = service.sigunguList();
			map.put("province", province);
			map.put("sigungu", sigungu);
		} catch(NullPointerException e) {
			System.out.println("NewsList or ProvinceList or SigunguList is null!");
		} finally {
			model.addAttribute("naverID", env.getProperty("naver.ID"));
		}
//		System.out.println(map);
		return map;
	}
	
	// 메인페이지 뉴스 기사 리스트 출력 & 모달페이지 뉴스 기사 내용 출력
	@RequestMapping(value="/readNews.do", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public NewsVO readNews(@ModelAttribute NewsVO vo, Model model) {
		try {
			vo = service.readNews(vo);
			model.addAttribute("readNews", vo);
		} catch(NullPointerException e) {
			System.out.println("제목과 매치되는 기사가 존재하지 않습니다.");
		}
		return vo;
	}
	
	@RequestMapping(value="/selectZone.do", method=RequestMethod.GET)
	public void selectZone(@RequestParam("name") String name) {
		System.out.println(name);
		
	}
}
