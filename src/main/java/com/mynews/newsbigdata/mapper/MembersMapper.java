package com.mynews.newsbigdata.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.mynews.newsbigdata.model.Member;

@Mapper
public interface MembersMapper {
	public boolean signUp(Member vo);
	public boolean checkMember(Member vo);
	public Member viewMember(Member vo);
}
