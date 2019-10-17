package dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import vo.MemberVO;

@Repository
public class MemberDAO {
	@Inject
	SqlSession session = null;	 
	String mapperRoute = "resource.MemberMapper.";
	
	public boolean signUp(MemberVO vo) {
		String statement = mapperRoute+"signUp";
		int result = session.insert(statement, vo);
		return result==1 ? true : false;
	}
	
	public boolean checkMember(MemberVO vo) {
		String statement = mapperRoute+"checkMember";
		int result = session.selectOne(statement, vo);
		return result==1 ? true : false;
	}
	
	public MemberVO viewMember(MemberVO vo) {
		String statement = mapperRoute+"viewMember";
		return session.selectOne(statement, vo);
	}
}
