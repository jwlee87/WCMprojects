package com.cmt.service;

import java.util.HashMap;
import java.util.List;

import com.cmt.domain.Email;
import com.cmt.domain.RewardList;
import com.cmt.domain.Member;
import com.cmt.domain.ServerList;

public interface MemberService {
	public int getMember() throws Exception;
	public HashMap<String, Object> getMemberByTM(String iTradeMark, String iPassword) throws Exception;
	public Member getMemberByNick(String nickName) throws Exception;
	public Member getMemberByUniqueID(int uniqueID) throws Exception;
	
	public int addAuthKey(Email email) throws Exception;
	public void deleteCheck(int uniqueID) throws Exception;
	public Email getMailCheck(int userUniqueID) throws Exception;
	public void updateAuthKey(int userUniqueID) throws Exception;
	public int updatePass(HashMap paramMap) throws Exception;
	public List<RewardList> getRewardList(int userUniqueID) throws Exception;
	public List<RewardList> getRewardListTNK(int userUniqueID)throws Exception;
	public void addReward(HashMap<String, Object> paramMap) throws Exception;
	public ServerList getServerList() throws Exception;
	public int updateReward(HashMap<String, Object> paramMap) throws Exception;
	
}
