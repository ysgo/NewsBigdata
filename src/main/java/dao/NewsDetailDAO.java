package dao;


import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.NewsVO;
import vo.Pagination;

@Repository
public class NewsDetailDAO {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper.";

	public List<NewsVO> allTitle() {
		System.out.println("selectTitle에 들어옴");
		String statement = mapperRoute + "allTitle";
		return session.selectList(statement);
	}
	
	// 뉴스 타이틀 전체출력
	public List<NewsVO> selectTitle(NewsVO info) {
		System.out.println("selectTitle에 들어옴");
		String statement = mapperRoute + "selectTitle";
		return session.selectList(statement);
	}

	public List<NewsVO> search(NewsVO info) {
		System.out.println("DAO - 키워드 검색 들어옴");
		System.out.println("DAO 키워드 값 : " + info.getKeyword());
		System.out.println("DAO pageNo값: " + info.getPageNo());

		List<NewsVO> list;
		String statement = "resource.NewsMapper.search";
		list = session.selectList(statement, info);
		return list;
	}
	
	public List<Pagination> searchCnt(NewsVO info) {
		System.out.println("DAO - searchCnt들어옴 :"+info.getKeyword());
		List<Pagination> list;
		String statement = "resource.NewsMapper.search";
		list = session.selectList(statement, info);
		return list;
	}
	public int selectCount(NewsVO info) {
		String statement = "resource.NewsMapper.NewsListCount";
		return session.selectOne(statement, info);
	}
}
/*
 * 
 * */