package com.cmt.dao.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.cmt.dao.MemberDao;
import com.cmt.domain.Email;
import com.cmt.domain.RewardList;
import com.cmt.domain.Member;
import com.cmt.domain.ServerList;

@Repository("memberDaoImpl")
public class MemberDaoImpl implements MemberDao {

	///Field
	@SuppressWarnings("unused")
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	///Constructor
	public MemberDaoImpl() {
	}

	///Method
	@Override
	public int getMember() throws Exception {
		return sqlSession.selectOne("MemberMapper.selectMemberCount");
	}

	@Override
	public Member getMemberByTM(String iTradeMark) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectMemberByTM", iTradeMark);
	}

	@Override
	public Member getMemberByNick(String nickName) throws Exception {
		return sqlSession.selectOne("MemberMapper.selectMemberByNick", nickName);
	}

	@Override
	public int addAuthKey(Email email) throws Exception {
		return sqlSession.insert("BoardMapper.addAuthKey", email);
	}

	@Override
	public void deleteCheck(int uniqueID) throws Exception {
		sqlSession.delete("BoardMapper.deleteCheck", uniqueID);
	}

	@Override
	public Email getMailCheck(int userUniqueID) throws Exception {
		return sqlSession.selectOne("BoardMapper.getMailCheck", userUniqueID);
	}

	@Override
	public void updateAuthKey(int userUniqueID) throws Exception {
		sqlSession.update("BoardMapper.updateAuthKey", userUniqueID);
	}

	@Override
	public int updatePass(HashMap paramMap) throws Exception {
		return sqlSession.update("MemberMapper.updatePass", paramMap);
	}

	@Override
	public Member getMemberByUniqueID(int uniqueID) throws Exception {
		return sqlSession.selectOne("MemberMapper.getMemberByUniqueID", uniqueID);
	}

	@Override
	public List<RewardList> getRewardList(int userUniqueID) throws Exception {
		return sqlSession.selectList("MemberMapper.getRewardList", userUniqueID);
	}
	
	@Override
	public List<RewardList> getRewardListTNK(int userUniqueID) throws Exception {
		return sqlSession.selectList("MemberMapper.getRewardListTNK", userUniqueID);
	}

	@Override
	public void addReward(HashMap<String, Object> paramMap) throws Exception {
		sqlSession.insert("MemberMapper.addReward", paramMap);
	}

	@Override
	public ServerList getServerList() throws Exception {
		return sqlSession.selectOne("MemberMapper.getServerList");
	}

	@Override
	public int updatePoint(HashMap<String, Object> paramMap) throws Exception {
		System.out.println(paramMap);
		return sqlSession.update("MemberMapper.updatePoint", paramMap);
	}
	
}
