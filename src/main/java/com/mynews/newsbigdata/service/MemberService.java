package com.mynews.newsbigdata.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.model.MemberVO;
import com.mynews.newsbigdata.repository.MemberDAO;

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

}
