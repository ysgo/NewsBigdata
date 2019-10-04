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
	public List<NewsVO> selectTitle() {
		System.out.println("서비스 - List에 들어옴");
		return dao.selectTitle();
	}

	public List<NewsVO> search(NewsVO info) {
		System.out.println("서비스 - 키워드 검색에 들어옴");
		System.out.println("서비스의 키워드값 : " + info.getKeyword());
		return dao.search(info);
	}
}
