package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dao.NewsDetailDAO;
import vo.NewsVO;

@Repository
public class NewsDetailService {
	@Autowired
	private NewsDetailDAO dao;

	// 뉴스 타이틀 전체출력
	public List<NewsVO> selectTitle(NewsVO info) {
		System.out.println("서비스 - List에 들어옴");
		return dao.selectTitle(info);
	}

	public List<NewsVO> search(NewsVO info) {
		System.out.println("서비스의 키워드값 : " + info.getKeyword());
		return dao.search(info);
	}
	/*
	public List<Pagination> searchCnt(NewsVO info) {
		System.out.println("서비스 - SearachCnt에 들어옴");
		return dao.searchCnt(info);
	}
	*/
}
