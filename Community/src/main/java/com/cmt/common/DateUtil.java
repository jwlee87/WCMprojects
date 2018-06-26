package com.cmt.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class DateUtil {
	
	static SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00.000", Locale.KOREA);

	public static String today() {
		Date currentTime = new Date();
		return sdf.format(currentTime);
	}
	
	public static String yesterday() {
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
		return sdf.format(c1.getTime());
	}
	

}
