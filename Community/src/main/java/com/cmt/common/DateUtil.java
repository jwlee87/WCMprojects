package com.cmt.common;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

public class DateUtil {
	
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00.000", Locale.KOREA);

	public static String today() {
		Date currentTime = new Date();
		return sdf.format(currentTime);
	}
	
	public static String todayKoreanString() {
		SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일 E a hh:mm:ss", Locale.KOREAN);
		Date currentTime = new Date();
		return df.format(currentTime);
	}
	
	public static String yesterday() {
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
		return sdf.format(c1.getTime());
	}
	
	@SuppressWarnings("unchecked")
	public static HashMap<String, Object> transformateDate(HashMap<String, Object> paramMap) {
		HashMap<String, Object> resultMap = new HashMap<String, Object>(paramMap);
		List<HashMap<String, Object>> returnList = new ArrayList<HashMap<String, Object>>();
		for(HashMap<String, Object> foreachMap : (List<HashMap<String, Object>>) resultMap.get("list")) {
			HashMap<String, Object> tempMap = new HashMap<String, Object>(foreachMap);
			SimpleDateFormat df = new SimpleDateFormat("yyyy년 MM월 dd일 E a hh:mm:ss", Locale.KOREAN);
			tempMap.put("_DateTime", df.format(foreachMap.get("_DateTime")));
			returnList.add(tempMap);
		}
		resultMap.put("list", returnList);
		return resultMap;
	}

}
