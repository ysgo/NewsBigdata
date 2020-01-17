package com.mynews.newsbigdata.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mynews.newsbigdata.model.MemberVO;

@Mapper
public interface MembersMapper {
	public boolean signUp(MemberVO vo);
	public boolean checkMember(MemberVO vo);
	public MemberVO viewMember(MemberVO vo);
}
