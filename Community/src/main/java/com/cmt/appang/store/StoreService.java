package com.cmt.appang.store;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.common.HttpUtil;
import com.cmt.dao.MemberDao;
import com.cmt.domain.Member;

@Service
public class StoreService implements StoreServiceInterface {

	@Autowired
	private StoreDaoInterface sdi;
	
	@Autowired
	@Qualifier("memberDaoImpl")
	private MemberDao mdi;
	
	@Override
	public HashMap<String, Object> payment(HttpServletRequest req) {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean returnFlag = false;
		
		int checkFlag = 0;
		
		paramMap = HttpUtil.getParamMap(req);
		System.out.println(paramMap);
		resultMap = sdi.selectPayment(paramMap);
		
		for(String key : resultMap.keySet()) {
			if(key.equals("resultListCount")) {
				if((resultMap.get(key).toString()).trim().equals("0")) {
					checkFlag = 1;
					System.out.println(checkFlag);
				}
			}
		}
		
		if(checkFlag==1) {
			checkFlag = 0;
			String userUniqueId = paramMap.get("UD").toString().trim();
			String p = paramMap.get("P").toString().trim();
			int uui = Integer.parseInt(userUniqueId);
			long price = Integer.parseInt(p);
			long priceGap = 0;
			HashMap<String, Object> tempMap = new HashMap<String, Object>();
			try {
				Member member = mdi.getMemberByUniqueID(uui);
				System.out.println(member);
				if(member.getPoint() > price) {
					priceGap = member.getPoint() - price;
					System.out.println("priceGap= "+priceGap);
					
					tempMap.put("uniqueID", uui);
					tempMap.put("priceGap", priceGap);
					if(mdi.updatePoint(tempMap)==1) {
						checkFlag=1;
					};
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(checkFlag==1) {
				if(sdi.insertPayment(paramMap)==1) {
					returnFlag = true;
				}else{
					try {
//						포인트 환불 시스템 가동;
					} catch (Exception e) {
						e.printStackTrace();
					}
				};
			}
			returnMap.put("money", priceGap);
		}
		returnMap.put("returnFlag", returnFlag);
		
		return returnMap;
	}

}
