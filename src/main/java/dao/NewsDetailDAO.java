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
		System.out.println("전체출력 pageNo값: " + info.getPageNo());
		String statement = mapperRoute + "selectTitle";
		return session.selectList(statement,info);
	}

	// 뉴스 키워드로 검색된 것만 출력
	public List<NewsVO> search(NewsVO info) {
		System.out.println("DAO 키워드 값 : " + info.getKeyword()
							+"DAO 언론사이름 값"+ info.getNewsname());
		List<NewsVO> list;
		String statement = "resource.NewsMapper.search";
		list = session.selectList(statement, info);
		return list;
	}
	
	public int allListCount(NewsVO info) {
		String statement = "resource.NewsMapper.allListCount";
		return session.selectOne(statement, info);
	}

	public int searchListCnt (NewsVO info) {
		String statement = "resource.NewsMapper.searchListCnt";
		return session.selectOne(statement, info);
	}
}
/*
 * 
 * */