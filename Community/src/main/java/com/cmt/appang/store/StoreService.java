package com.cmt.appang.store;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
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
	
	// 결제 시스템
	@Override
	public HashMap<String, Object> payment(HttpServletRequest req) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean returnFlag = false;
		int checkFlag = 0;
		
		paramMap = HttpUtil.getParamMap(req);
		resultMap = sdi.selectPayment(paramMap);
		
		for(String key : resultMap.keySet()) {
			if(key.equals("resultListCount")) {
				if((resultMap.get(key).toString()).trim().equals("0")) {
					checkFlag = 1;
				}
			}
		}
		
		// 결제 프로세스 진행
		if(checkFlag==1) {
			checkFlag = 0;
			String userUniqueId = paramMap.get("UD").toString().trim();
			String p = paramMap.get("P").toString().trim();
			int uui = Integer.parseInt(userUniqueId);
			long price = Integer.parseInt(p);
			long priceGap = 0;
			HashMap<String, Object> tempMap = new HashMap<String, Object>();
			Member member = mdi.getMemberByUniqueID(uui);
			long memberPoint = member.getPoint();
			
			if(memberPoint > price) {
				priceGap = member.getPoint() - price;
				tempMap.put("uniqueID", uui);
				tempMap.put("priceGap", priceGap);
				if(mdi.updatePoint(tempMap)==1) {
					checkFlag=1;
				};
			}
			
			if(checkFlag==1) {
				//결제 정보 저장
				paramMap.put("US", 2);
				if(sdi.insertPayment(paramMap)==1) {
					returnFlag = true;
				}else{
					paramMap.put("P", memberPoint);
					mdi.updatePoint(paramMap);
				};
			}
			returnMap.put("money", priceGap);
		}
		returnMap.put("returnFlag", returnFlag);
		return returnMap;
	}

	// 환불 시스템
	@Override
	public HashMap<String, Object> refund(HttpServletRequest req) throws Exception {
		
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		boolean returnFlag = false;
		
		int checkFlag = 0;
		
		paramMap = HttpUtil.getParamMap(req);
		paramMap.put("USE_STATUS", 2);
		resultMap = sdi.selectPayment(paramMap);
		
		for(String key : resultMap.keySet()) {
			if(key.equals("resultListCount")) {
				if((resultMap.get(key).toString()).trim().equals("1")) {
					checkFlag = 1;
				}
			}
		}
		
		// 환불 프로세스 진행
		if(checkFlag==1) {
			checkFlag = 0;
			String userUniqueId = paramMap.get("UD").toString().trim();
			String p = paramMap.get("P").toString().trim();
			int uui = Integer.parseInt(userUniqueId);
			long price = Integer.parseInt(p);
			long priceGap = 0;
			HashMap<String, Object> tempMap = new HashMap<String, Object>();
			Member member = mdi.getMemberByUniqueID(uui);
			long memberPoint = member.getPoint();
			
			priceGap = member.getPoint() + price;
			
			tempMap.put("uniqueID", uui);
			tempMap.put("priceGap", priceGap);
			if(mdi.updatePoint(tempMap)==1) {
				checkFlag=1;
			};
			
			if(checkFlag==1) {
				//환불 정보 저장
				paramMap.put("US", 3);
				if(sdi.insertPayment(paramMap)==1) {
					returnFlag = true;
				}else{
					paramMap.put("P", memberPoint);
					mdi.updatePoint(paramMap);
				};
			}
		}
		returnMap.put("returnFlag", returnFlag);
		return returnMap;
	}

}
