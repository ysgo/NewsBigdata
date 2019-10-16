package com.mynews.newsbigdata;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import dao.NewsDetailDAO;
import service.NewsDetailService;
import vo.NewsVO;
import vo.Pagination;

@Controller
@SessionAttributes("status")
public class NewsDetailController {
	@Autowired
	NewsDetailDAO dao;
	@Autowired
	NewsDetailService service;
	
	@RequestMapping(value = "/TestView2", method = RequestMethod.GET)
	public String home() {
		return "TestView2";
	}
	
	
	// NewsDetail 첫 화면
	/*
	 * @RequestMapping(value = "/main", method = RequestMethod.GET) ModelAndView
	 * select00() { System.out.println("상세검색 처음 접속시 발생"); ModelAndView mav = new
	 * ModelAndView(); mav.setViewName("main"); return mav; }
	 */
	
	
	// NewsDetail 첫 화면
	@RequestMapping(value = "/NewsdetailView", method = RequestMethod.POST)
	ModelAndView select0() {
		System.out.println("상세검색 처음 접속시 발생");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("newsDetailView");
		return mav;
	}

	// NewsDetail 검색 시작
	//main.do?action=search&curPage=1&keyword=대통령
	//@RequestMapping(value = "/NewsdetailView.do", method = RequestMethod.GET)
	@ResponseBody
	@RequestMapping(value = "/main/NewsdetailView", method = RequestMethod.GET
							,produces = "application/json; charset=utf-8")
	//public ModelAndView select1(Model model,NewsVO newsinfo, 
	public HashMap<String, Object> select1(Model model,NewsVO newsinfo, 
				int curPage) {
		
		HashMap<String, Object> map = new HashMap<>();
		
		System.out.println("뉴스 디테일 keyword 값:" + newsinfo.getKeyword()  
							+ " 페이지넘버" + newsinfo.getPageNo());

		int listCnt = dao.allListCount(newsinfo);
		newsinfo.setPageNo((curPage - 1) * 10);
		//System.out.println("listCnt 값 :" + listCnt + "curPage 값 :" + curPage);

		Pagination pagination = new Pagination(listCnt, curPage);
		newsinfo.setStartIndex(pagination.getStartIndex());
		newsinfo.setCntPerPage(pagination.getPageSize());
		//System.out.println(pagination);

		List<NewsVO> list ;
		//HashMap<String, String> map = new HashMap<String, String>();
		
		// 전체리스트 출력
		if (newsinfo.getAction().equals("search")) {

			// 1 - 전체조회
			if (newsinfo.getKeyword() == "") {
				list = service.selectTitle(newsinfo);
				//map.put("todayNews",list);
				
				pagination = new Pagination(listCnt, curPage);
				//mav.addObject("list1", list);
				//mav.addObject("listCnt", listCnt);
				//mav.addObject("pagination", pagination);
				//mav.setViewName("main");
				map.put("listtt",list);
				map.put("listCnttt", listCnt);
				map.put("paginationttt", pagination);
				return map;

			}
			// 2 - 키워드검색
			else {
				System.out.println("특정 키워드만 검색 : " + newsinfo.getKeyword());
				list = service.search(newsinfo);
				listCnt = dao.searchListCnt(newsinfo);
				//System.out.println("키워드 listCnt :"+listCnt);
				//System.out.println("리스트 출력 :"+ list);	
				//mav.addObject 를 해쉬 맵으로 수정
				pagination = new Pagination(listCnt, curPage);
				
				map.put("listtt",list);
				map.put("listCnttt", listCnt);
				map.put("paginationttt", pagination);
				
				System.out.println("맵 list 테스트"+map.get("listtt"));
				System.out.println(" ");
				System.out.println("맵 listCnt 테스트"+map.get("listCnttt"));
				System.out.println(" ");
				System.out.println("맵 pagination 테스트"+map.get("paginationttt"));
				System.out.println(" ");
				
				//mav.addObject("list1", list);
				//mav.addObject("listCnt", listCnt);
				//mav.addObject("pagination", pagination);
				return map;
			}
		}
		return map;
		
		//mav.setViewName("main");
		//return mav;
	}

}
