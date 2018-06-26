package test.testmode;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Locale;

public class TestMainClass {

	public TestMainClass() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00.000", Locale.KOREA);
		
		Date currentTime = new Date();
		String returnValue = sdf.format(currentTime);
		System.out.println(returnValue);
		
		Calendar c1 = new GregorianCalendar();
		c1.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
		String d = sdf.format(c1.getTime()); // String으로 저장
		System.out.println(d);
		
	}

}
