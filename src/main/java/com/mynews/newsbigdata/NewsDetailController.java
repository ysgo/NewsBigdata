package com.mynews.newsbigdata;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;
import dao.NewsDetailDAO;
import service.NewsDetailService;
import vo.NewsVO;

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
	ModelAndView select1(NewsVO newsinfo) {
		
		System.out.println("뉴스 디테일 keyword 값:"+newsinfo.getKeyword()+
										" 페이지넘버"+newsinfo.getPageNo());
		List<NewsVO> list;
		ModelAndView mav = new ModelAndView();
		if (newsinfo.getAction().equals("search")) {
				System.out.println(newsinfo.getAction());
			 service.search(newsinfo);
		}
		int total = dao.selectCount(newsinfo);
		System.out.println("total값 "+total);
		list = service.search(newsinfo);	
				
		mav.addObject("list1", list);
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
