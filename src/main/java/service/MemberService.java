package service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.MemberDAO;
import vo.MemberVO;

@Service
public class MemberService {
	@Autowired
	private MemberDAO dao;

	public boolean signUp(MemberVO vo) {
		boolean result = dao.checkMember(vo);
		return result ? false : dao.signUp(vo);
	}
	
	public MemberVO viewMember(MemberVO vo) {
		return dao.viewMember(vo);
	}

	public void signOut(HttpSession session) {
		session.removeAttribute("memberInfo");
	}
}
