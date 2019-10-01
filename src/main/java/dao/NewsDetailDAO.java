package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import vo.NewsVO;

@Repository
public class NewsDetailDAO {
	@Qualifier("hiveDataSource")	
	DataSource ds;

	@Autowired
	SqlSession session = null;
	String mapperRoute = "resource.NewsMapper.";
	
	// 뉴스 타이틀 전체출력
	public List<NewsVO> selectTitle() {
		System.out.println("selectTitle에 들어옴");
		String statement = mapperRoute+"selectTitle";
		return session.selectList(statement);
	}
	
	// 뉴스 키워드 검색 출력
		public List<NewsVO> searchKeyWord() {
			System.out.println("searchKeyWord에 들어옴");
			String statement = mapperRoute+"searchKeyWord";
			return session.selectList(statement);
		}
}













/*
@Autowired
SqlSession session = null;
public NewsVO checklogin(String mid, String pw) {
	String statement= "resource.MemberMapper.login";
	HashMap<String, String> map = new HashMap<String,String>();
	map.put("mid", mid);
	map.put("pw", pw);
	System.out.println("checkLogin map객체 : "+map);
	NewsVO vo = session.selectOne(statement,map);
	if(session.selectOne(statement,map) != null) return vo;
	return null;
}

public List<NewsVO> select1(String keyword){
	List<NewsVO> list;
	System.out.println("searchDAO 걸림 .. 키워드 값"+keyword);		
	String statement = "resource.NewsListMapper.selectNews";
	list = session.selectList(statement, keyword);
	System.out.println("DAO에서 list 값 출력 :"+list);
	return list;
}*/

