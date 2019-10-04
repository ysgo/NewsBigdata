package com.mynews.newsbigdata;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	int size = 5;
	@ModelAttribute("festainfo")
	public NewsVO createFestainfo() {
		return new NewsVO();
	}
	
	@RequestMapping(value="/NewsdetailView.do", method = RequestMethod.POST)
	ModelAndView select0() {
		System.out.println("상세검색 처음 접속시 발생");
		ModelAndView mav = new ModelAndView();
		//List<NewsVO> list = dao.selectTitle();			
		//mav.addObject("list1", list);
		mav.setViewName("newsDetailView");
		return mav;	
	}
	
	@RequestMapping(value="/NewsdetailView.do", method = RequestMethod.GET)
	ModelAndView select1(@ModelAttribute("NewsVO") NewsVO newsinfo
			, @RequestParam(defaultValue="1") int curPage)  {
		
		System.out.println("뉴스 디테일 keyword 값:"+newsinfo.getKeyword()+
										" 페이지넘버"+newsinfo.getPageNo());
		//List<NewsVO> list;
		ModelAndView mav = new ModelAndView();
		int listCnt  = dao.selectCount(newsinfo);
		System.out.println("listCnt 값 :"+listCnt +"curPage 값 :" + curPage);
		
		//현재 페이지 값1
		Pagination pagination = new Pagination(listCnt, curPage);
		newsinfo.setStartIndex(pagination.getStartIndex());
		newsinfo.setCntPerPage(pagination.getPageSize());
		System.out.println(pagination);
		System.out.println(newsinfo);
		
		// 전체리스트 출력
        if (newsinfo.getAction().equals("search")) {
			
			//전체조회 
			if(newsinfo.getKeyword()=="") {	
				service.selectTitle(newsinfo);
				System.out.println("키워드값이 비어있을때!");
				System.out.println(service.selectTitle(newsinfo));
			}
			else {			
				System.out.println("특정 키워드만 검색 : "+newsinfo.getKeyword());
				service.search(newsinfo);
				//service.searchCnt(newsinfo);
				System.out.println(service.searchCnt(newsinfo));		
			}
		}
		
        List<NewsVO> list = dao.allTitle();//30출력
		System.out.println("전체리스트 개수 값 "+listCnt );
		list = service.search(newsinfo);	
		
		mav.addObject("list1", list);
		mav.addObject("listCnt",listCnt);
		mav.addObject("pagination", pagination);
		mav.setViewName("newsDetailView");
		return mav;	
	}
	
	@RequestMapping(value="/TestView2.do")
	ModelAndView test() {
		System.out.println("테스트뷰");
		ModelAndView mav = new ModelAndView();
		//List<NewsVO> list = dao.selectTitle();			
		//mav.addObject("list1", list);
		mav.setViewName("TestView2");
		return mav;	
	}
}
