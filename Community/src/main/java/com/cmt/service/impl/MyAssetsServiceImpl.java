package com.cmt.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.cmt.dao.MyAssetsDao;
import com.cmt.service.MyAssetsService;

@Service("myAssetsServiceImpl")
public class MyAssetsServiceImpl implements MyAssetsService {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	@Autowired
	@Qualifier("myAssetsDaoImpl")
	private MyAssetsDao myAssetsDao;

	public MyAssetsServiceImpl() {
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public int getTotalCount(HashMap<String, Object> paramMap) {
		return myAssetsDao.getTotalCount(paramMap);
	}

	@Override
	public HashMap<String, Object> getMyAssets(HashMap<String, Object> paramMap) {
		logger.debug(paramMap);
		List<HashMap<String, Object>> al = myAssetsDao.getMyAssets(paramMap);
		if( al.size() == 1) {
			for(HashMap<String, Object> hm : al) {
				BigDecimal coin = (BigDecimal) hm.get("_Coin");
				BigDecimal lCoin = (BigDecimal) hm.get("_LockCoin");
				hm.put("_Coin", coin);
				hm.put("_LockCoin", lCoin);
				hm.put("no", paramMap.get("no"));
				hm.put("uNo", paramMap.get("uNo"));
//				System.out.println(hm);
			}
		}else {
			al.add(new HashMap<String, Object>());
		}
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("list", al);
		return returnMap;
	}

	@Override
	public HashMap<String, Object> getDetailContents(HashMap<String, Object> paramMap) {
		logger.debug(paramMap);
		ArrayList<HashMap<String, Object>> al = (ArrayList<HashMap<String, Object>>) myAssetsDao.getTransactionList(paramMap);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("list", al);
		return resultMap;
	}

	

}
