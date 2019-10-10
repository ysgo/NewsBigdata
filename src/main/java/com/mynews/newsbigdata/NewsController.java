package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
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
	
	@RequestMapping(value="/mainNews", method=RequestMethod.GET)
	public HashMap<String, Object> mainNews() {
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
		}
//		System.out.println(map);
		return map;
	}
	
	// 메인페이지 뉴스 기사 리스트 출력 & 모달페이지 뉴스 기사 내용 출력
	@RequestMapping(value="/readNews", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public NewsVO readNews(@ModelAttribute NewsVO vo) {
		try {
			vo = service.readNews(vo);
		} catch(NullPointerException e) {
			System.out.println("There is no matching article with the title!");
		}
		return vo;
	}
	
	@RequestMapping(value="/selectZone", method=RequestMethod.GET, produces="application/json; charset=utf-8")
	public Map<String, Object> selectZone(@RequestParam("zoneName") String zoneName) {
		HashMap<String, Object> map = new HashMap<>();
		System.out.println(zoneName);
		int len = zoneName.length();
		if(len == 4) {
			map.put("strFirst", zoneName.charAt(0));
			map.put("strSecond", zoneName.charAt(2));
		} else {
			map.put("strFirst", zoneName.charAt(0));
			map.put("strSecond", zoneName.charAt(1));
		}
		try {
			map.put("zoneNews", service.zoneTitle(map));
		} catch(NullPointerException e) {
			System.out.println("There are no local news articles!");
		}
		return map;
	}
}
