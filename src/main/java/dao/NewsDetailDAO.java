package dao;


import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import vo.NewsVO;

@Repository
public class NewsDetailDAO {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper.";

	// 뉴스 타이틀 전체출력
	public List<NewsVO> selectTitle() {
		System.out.println("selectTitle에 들어옴");
		String statement = mapperRoute + "selectTitle";
		return session.selectList(statement);
	}

	public List<NewsVO> search(NewsVO info) {
		System.out.println("DAO - 키워드 검색 들어옴");
		System.out.println("DAO 키워드 값 : " + info.getKeyword());
		List<NewsVO> list;
		String statement = "resource.NewsMapper.search";
		list = session.selectList(statement, info);
		System.out.println("DAO " + info.getTitle());
		return list;
	}

	public int selectCount(NewsVO info) {
		String statement = "resource.NewsMapper.selectNewsCount";
		return session.selectOne(statement, info);
	}
}
















/*
 * 
 * */