package com.mynews.newsbigdata;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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

	// NewsDetail 첫 화면
	@RequestMapping(value = "/NewsdetailView", method = RequestMethod.POST)
	ModelAndView select0() {
		System.out.println("상세검색 처음 접속시 발생");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("newsDetailView");
		return mav;
	}

	// NewsDetail 검색 시작
	@RequestMapping(value = "/NewsdetailView", method = RequestMethod.GET)
	ModelAndView select1(@ModelAttribute("NewsVO") NewsVO newsinfo, 
				int curPage) {

		System.out.println("뉴스 디테일 keyword 값:" + newsinfo.getKeyword()  
							+ " 페이지넘버" + newsinfo.getPageNo());

		ModelAndView mav = new ModelAndView();
		int listCnt = dao.allListCount(newsinfo);
		
		newsinfo.setPageNo((curPage - 1) * 10);
		System.out.println("listCnt 값 :" + listCnt + "curPage 값 :" + curPage);

		Pagination pagination = new Pagination(listCnt, curPage);
		newsinfo.setStartIndex(pagination.getStartIndex());
		newsinfo.setCntPerPage(pagination.getPageSize());
		System.out.println(pagination);

		List<NewsVO> list;
		// 전체리스트 출력
		if (newsinfo.getAction().equals("search")) {

			// 1 - 전체조회
			if (newsinfo.getKeyword() == "") {
				list = service.selectTitle(newsinfo);
				pagination = new Pagination(listCnt, curPage);
				mav.addObject("list1", list);
				mav.addObject("listCnt", listCnt);
				mav.addObject("pagination", pagination);

			}
			// 2 - 키워드검색
			else {
				System.out.println("특정 키워드만 검색 : " + newsinfo.getKeyword());
				list = service.search(newsinfo);
				listCnt = dao.searchListCnt(newsinfo);
				System.out.println("키워드 listCnt :"+listCnt);
				
				pagination = new Pagination(listCnt, curPage);
				mav.addObject("list1", list);
				mav.addObject("listCnt", listCnt);
				mav.addObject("pagination", pagination);
			}
		}

		mav.setViewName("newsDetailView");
		return mav;
	}
}

/*
  이하 무시; 
  @RequestMapping(value="/TestView2.do") ModelAndView test() {
  System.out.println("테스트뷰"); ModelAndView mav = new ModelAndView();
  //List<NewsVO> list = dao.selectTitle(); //mav.addObject("list1", list);
  mav.setViewName("TestView2"); return mav; }
 */
