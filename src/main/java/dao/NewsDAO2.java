package dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.TestVO;

@Repository
public class NewsDAO2 {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper2.";
	
	public int insertNews(TestVO vo) {
		String statement = mapperRoute+"insertNews";
		return session.insert(statement,vo);
	}
	

}
