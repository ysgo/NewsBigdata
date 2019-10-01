package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.NewsDAO;
import vo.NewsVO;

@Service
public class NewsService {
	@Autowired
	private NewsDAO dao;
	
	// 뉴스 타이틀 전체 출력
	public List<NewsVO> listAll() {
		System.out.println("서비스의 listALL 출력");
		return dao.listAll();
	}
	
//	// 뉴스 리스트 지역관련 기사 출력
//	public List<NewsVO> nationList(NewsVO vo) {
//		return dao.nationList(vo);
//	}
	
	// 뉴스 타이틀 검색으로 기사 내용 가져오기
	public NewsVO readNews(NewsVO vo) {
		return dao.readNews(vo);
	}
}
