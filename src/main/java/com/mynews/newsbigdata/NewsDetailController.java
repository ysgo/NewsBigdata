package com.mynews.newsbigdata;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import dao.NewsDetailDAO;
import service.NewsService;
import vo.NewsVO;
@Controller
public class NewsDetailController {
	@Autowired
	NewsDetailDAO dao;
	NewsService service;
	
	@Qualifier("hiveDataSource")	
	DataSource ds;
	
	@RequestMapping(value="/NewsdetailView.do")
	ModelAndView select1(String keyword) {
		// http://localhost:8000/newsbigdata/NewsdetailView.do?keyword=2019-09-26
		System.out.println("뉴스 디테일 keyword 값:"+keyword);
		ModelAndView mav = new ModelAndView();
		List<NewsVO> list = dao.selectTitle();			
		mav.addObject("list1", list);
		mav.setViewName("newsDetailView");
		return mav;	
	}
	
	
}
