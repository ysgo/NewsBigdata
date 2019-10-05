package dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class NewsAnalysisDAO {
	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper.";
	
	public boolean insertProvince(Object vo) {
		String statement = mapperRoute + "insertProvince";
		return session.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean insertSigungu(Object vo) {
		String statement = mapperRoute + "insertSigungu";
		return session.insert(statement, vo) == 1 ? true : false;
	}
	
	public boolean emptyZone(HashMap<String, String> map) {
		String statement = mapperRoute + "emptyZone";
		int result = session.selectOne(statement, map);
		return result == 0 ? true : false;
	}
}