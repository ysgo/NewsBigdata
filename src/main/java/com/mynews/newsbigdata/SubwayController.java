package com.mynews.newsbigdata;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import dao.SubwayDAO;
import vo.SubwayVO;
@Controller
public class SubwayController {
	@Autowired
	SubwayDAO dao;
	@RequestMapping(value="/test5.do")
	ModelAndView detail() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("subwayView");
		return mav;	
	}
	
	@RequestMapping(value="/detailView.do")
	ModelAndView selectData1(int fid) {
		// http://localhost:8000/newsbigdata/detailView.do?fid=01
		System.out.println("뉴스데이터 detail의 i값:"+fid);
		ModelAndView mav = new ModelAndView();
		List<SubwayVO> list = dao.select1(fid);
		mav.addObject("list1", list);
		mav.setViewName("subwayView");
		return mav;	
	}
}
