package test.testmode;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

public class TestMainClass {

	public TestMainClass() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) throws InterruptedException {
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd 00:00:00.000", Locale.KOREA);
//		
//		Date currentTime = new Date();
//		String returnValue = sdf.format(currentTime);
//		System.out.println(returnValue);
//		
//		Calendar c1 = new GregorianCalendar();
//		c1.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
//		String d = sdf.format(c1.getTime()); // String으로 저장
//		System.out.println(d);
		
		CopyOnWriteArrayList<Integer> numbers = new CopyOnWriteArrayList<>(Arrays.asList(1, 2, 3, 4, 5));
//		List<Integer> numbers = new ArrayList<>(Arrays.asList(1, 2, 3, 4, 5));

        // new thread to concurrently modify the list
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    // sleep a little so that for loop below can print part of
                    // the list
                    Thread.sleep(250);
                } catch (InterruptedException e) {
                    Thread.currentThread().interrupt();
                }
                numbers.add(10);
                System.out.println("numbers : " + numbers+", size: "+numbers.size());
            }
        }).start();
        
        for (int i : numbers) {
            System.out.println(numbers.size() + ", index: "+i);
            // sleep a little to let other thread finish adding an element
            // before iteration is complete
            Thread.sleep(100);
        }
	}

}
