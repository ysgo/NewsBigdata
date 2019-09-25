package dao;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.support.SessionStatus;

import vo.MemberVO;

@Repository
public class MemberDAO {
	@Inject
	SqlSession session = null;	 
	String mapperRoute = "resource.MemberMapper.";
	
	// 회원 가입
	public boolean signup(MemberVO vo) throws Exception {
		boolean result=true;
		String statement = mapperRoute+"signup";
		if(session.insert(statement, vo) != 1)
			result = false;
		return result;
	}
	
	// 회원 로그인 정보
	public MemberVO viewMember(MemberVO vo) {
		String statement = mapperRoute+"viewMember";
		return session.selectOne(statement, vo);
	}
	
	// 회원가입 닉네임 체크
	public int checkOverName(String userName) {
		String statement = mapperRoute+"checkOverName";
		return session.selectOne(statement,	userName);
	}
	
	// 회원가입 아이디 체크
	public int checkOverId(String userId) {
		String statement = mapperRoute+"checkOverId";
		return session.selectOne(statement,	userId);
	}

	// 회원 로그아웃
	public void signout(SessionStatus session) {
		session.setComplete();
	}

	// 회원 탈퇴
	public boolean withdrawal(String userId) {
		boolean result = true;
		String statement = mapperRoute+"withdrawal";
		if(session.delete(statement, userId)!=1) {
			result = false;
		}
		return result;
	}
	
	// 회원 정보 수정
	public boolean updateMember(MemberVO vo) {
		boolean result = true;
		String statement = mapperRoute+"updateMember";
		if(session.update(statement, vo) != 1) {
			result = false;
		}
		return result;
	}
}
