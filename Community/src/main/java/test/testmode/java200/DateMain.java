package test.testmode.java200;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class DateMain {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		long millis = System.currentTimeMillis();

		System.out.println("millis: "+millis);
		
		Calendar cal = Calendar.getInstance();
		Date cd=cal.getTime();
		long cl=cal.getTimeInMillis();
		cal.set(2016,10,5); // 2016,11,5
		System.out.println("cd: "+cd+", cl:"+cl+", cal:"+ cal.getTime());
		
		System.out.println("\n"+cal+"\n");
		

		Date toDate=new Date(); // 오늘
		Date tommorow=new Date( millis+24*60*60*1000);   //내일
		
		cal.setTime(tommorow);
		Date dl=cal.getTime();
		System.out.println("toDate: "+toDate+", tommorow: "+tommorow+", dl"+dl);

		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");

		String time=sdf.format(toDate);
		Date dtime;
		try {
			dtime = sdf.parse("2016-09-11");
			System.out.println("time: "+time+", dtime: "+dtime);
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		Calendar cal1970 = Calendar.getInstance();
		cal1970.set(1970, 1-1, 1);
		System.out.println("1970년: "+cal1970.getTime());
		
		Calendar today = Calendar.getInstance();
		long minus = today.getTimeInMillis() - cal1970.getTimeInMillis();
		
		System.out.println("minus: "+ minus);
		
		today.setTimeInMillis(minus);
		
		System.out.println("오늘: "+today.getTime());

		String st = "2018-122232-123";
		
		Date d2 = new Date();
		try{
			d2=sdf.parse(st);
		}catch(ParseException e){
		    System.out.println("parseException: "+d2);
		}catch(Exception e){
		    System.out.println(e);
		}
		
		System.out.println(d2);

	}

}
