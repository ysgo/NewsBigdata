package com.mynews.newsbigdata.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mynews.newsbigdata.mapper.MembersMapper;
import com.mynews.newsbigdata.model.MemberVO;

@Service
public class MemberService {
	@Autowired
	private MembersMapper mapper;

	public boolean signUp(MemberVO vo) {
		boolean result = mapper.checkMember(vo); 
		return result ? false : mapper.signUp(vo);
	}
	
	public MemberVO viewMember(MemberVO vo) {
		return mapper.viewMember(vo);
	}

}
