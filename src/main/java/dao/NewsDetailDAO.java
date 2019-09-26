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
	@Autowired
	@Qualifier("hiveDataSource")	
	DataSource ds;

	public List<NewsVO> select1(String keyword) {
		System.out.println("입력된 time값 :"+keyword);
		List<NewsVO> list = new ArrayList<>();
		Connection conn = null;
		Statement stmt = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = ds.getConnection(); //"select *from news_test where content LIKE '%"+keyword+"%'"
			pstmt = conn.prepareStatement("select *from news_test");
			rs = pstmt.executeQuery();
			
			NewsVO vo = null;
			while(rs.next()) {
				vo = new NewsVO();				
				vo.setTitle(rs.getString(1));
				vo.setTime(rs.getString(2));
				vo.setContent(rs.getString(3));
				list.add(vo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if( rs != null ) rs.close();
				if( stmt != null ) stmt.close();
				if( conn != null ) conn.close();
			} catch (Exception e) {
				e.printStackTrace();				
			} 
		}
		return list;		
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

