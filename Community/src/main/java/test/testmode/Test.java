package test.testmode;
import java.util.regex.Pattern;

import com.cmt.common.EmailSender;
import com.cmt.domain.Email;

public class Test {

	public Test() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {

		String invalidEmail = "invalidEmailAddr";
		String validEmail = "validEmailAddr@naver";
		String validEmail2 = "validEmailAddr@naver.com";
		String validEmail3 = "validEma.ilAddr@naver.com";
		String validEmail4 = "validEma.ilAddr@na.ver.com";
		
		Test t = new Test();
		EmailSender es = new EmailSender();
		Email email = new Email();
		
		System.out.println("Invalid Check: "+t.checkEmailAddr(invalidEmail));
		System.out.println("Valid Check-1: "+t.checkEmailAddr(validEmail));
		System.out.println("Valid Check-2: "+t.checkEmailAddr(validEmail2));
		System.out.println("Valid Check-3: "+t.checkEmailAddr(validEmail3));
		System.out.println("Valid Check-4: "+t.checkEmailAddr(validEmail4));
		
//		email.setContent("테스트");
//		email.setSubject("테스트");
//		email.setReceiver(validEmail);
//		try {
//			es.sendEmail(email);
//		} catch (Exception e) {
//			System.out.println("ERROR! Email Send Exception!");
//			e.printStackTrace();
//		}

	}
	
	public boolean checkEmailAddr(String emailAddr) {
		boolean check = true;
		String regex = "^[_a-zA-Z0-9-]+(.[_a-zA-Z0-9-]+)*@(?:\\w+\\.)+\\w+$";
		/*Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(emailAddr);*/
		check = Pattern.matches(regex, emailAddr);
		if(check) {
			return check;
		} else {
			return check;
		}
	}

}
