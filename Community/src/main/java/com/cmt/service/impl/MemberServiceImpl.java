package com.cmt.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.dao.MemberDao;
import com.cmt.domain.Email;
import com.cmt.domain.RewardList;
import com.cmt.domain.Member;
import com.cmt.domain.ServerList;
import com.cmt.service.MemberService;

@Service("memberServiceImpl")
public class MemberServiceImpl implements MemberService {

	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao memberDao;
	
	///Constructor
	public MemberServiceImpl() {
	}

	///Method
	@Override
	public int getMember() throws Exception {
		return memberDao.getMember();
	}

	@Override
	public HashMap<String, Object> getMemberByTM(String iTradeMark, String iPassword) throws Exception {
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		logger.debug("[MemberService] inputValue debug :: iTradeMark= "+iTradeMark+", iPassword="+iPassword);
		Member member = memberDao.getMemberByTM(iTradeMark);
		logger.debug(member);
		
		if(member == null) {
			logger.debug(" 아이디와 일치하는 회원 없음 ");
			resultMap.put("check", "noTM");
		}else{
			
			if(member.getTradeMark().toUpperCase().equals(iTradeMark.toUpperCase())){
				logger.debug("아이디 일치 단계");
				if(member.getPassword().trim().equals(iPassword)){
					logger.debug(" 아이디 비밀번호 일치 ");
					resultMap.put("member", member);
					resultMap.put("check", "ok");
				}else {
					logger.debug(" 패스워드 불일치 ");
					resultMap.put("check", "noPW");
				}
			}
		}
		
		return resultMap;
	}

	@Override
	public Member getMemberByPhone(String phone) throws Exception {
		return memberDao.getMemberByPhone(phone);
	}

	@Override
	public int addAuthKey(Email email) throws Exception {
		return memberDao.addAuthKey(email);
	}

	@Override
	public void deleteCheck(int uniqueID) throws Exception {
		memberDao.deleteCheck(uniqueID);
	}

	@Override
	public Email getMailCheck(int userUniqueID) throws Exception {
		return memberDao.getMailCheck(userUniqueID);
	}

	@Override
	public void updateAuthKey(int userUniqueID) throws Exception {
		memberDao.updateAuthKey(userUniqueID);
	}

	@Override
	public int updatePass(HashMap paramMap) throws Exception {
		return memberDao.updatePass(paramMap);
	}

	@Override
	public Member getMemberByUniqueID(int uniqueID) throws Exception {
		return memberDao.getMemberByUniqueID(uniqueID);
	}

	@Override
	public List<RewardList> getRewardList(int userUniqueID) throws Exception {
		return memberDao.getRewardList(userUniqueID);
	}

	@Override
	public void addReward(HashMap<String, Object> paramMap) throws Exception {
		memberDao.addReward(paramMap);
	}

	@Override
	public ServerList getServerList() throws Exception {
		return memberDao.getServerList();
	}
	
	
}
