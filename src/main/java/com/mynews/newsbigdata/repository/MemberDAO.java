package com.mynews.newsbigdata.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynews.newsbigdata.model.MemberVO;

@Repository
public class MemberDAO {
	private static final String NAMESPACE = "com.mynews.newsbigdata.MemberMapper.";
	
	@Autowired
	private SqlSessionTemplate sqlSession;	 
	
	public boolean signUp(MemberVO vo) {
		String statement = NAMESPACE + "signUp";
		int result = sqlSession.insert(statement, vo);
		return result==1 ? true : false;
	}
	
	public boolean checkMember(MemberVO vo) {
		String statement = NAMESPACE + "checkMember";
		int result = sqlSession.selectOne(statement, vo);
		return result==1 ? true : false;
	}
	
	public MemberVO viewMember(MemberVO vo) {
		String statement = NAMESPACE + "viewMember";
		return sqlSession.selectOne(statement, vo);
	}
}
