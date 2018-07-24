package com.cmt.common;


import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.javamail.JavaMailSender;

import com.cmt.domain.Email;

public class EmailSender {
	
	///Field
	@Autowired
	protected JavaMailSender mailSender;
	private Logger logger = LogManager.getLogger();
	
	///Method
	public void sendEmail(Email email) throws Exception {
		
		MimeMessage msg = mailSender.createMimeMessage();
		try {
			msg.setSubject(email.getSubject());
			msg.setText(email.getContent(), "utf-8", "html");
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(email.getReceiver()));
		} catch(MessagingException e) {
			logger.debug("MessagingException");
			e.printStackTrace();
		}
		
		try {
			mailSender.send(msg);
		} catch(MailException e) {
			logger.debug("MailException 발생");
			e.printStackTrace();
		}
	}
	
	//비밀번호 변경을 위한 메일을 보내자
	public String generateEmailContents(String tradeMark, String uri) throws Exception{
		return "<meta charset='utf-8'><div style='width=100%'>"
				+"<h2>안녕하세요!</h2><br><p>회원님께서 요청하신 내용입니다.</p><br>"
				+"<p>비밀번호가 기억나지 않으세요?</p>"
				+"===================================<br>"
				+"<a href='"+uri+"'>비밀번호 변경 페이지로 이동합니다.</a><br>"
				+"===================================<br>"
				+"<p>도움이 필요하시면 <a href='mailto:worldspon@gmail.com'>worldspon@gmail.com</a>으로 연락해 주세요.</p><br>"
				+"<p style='font-size: 8px;'>월드코인마켓 / 서비스이용방침 / 개인정보처리방침</p>"
				+"</div></meta>";
	}
	
	public int generateAuthKey() throws Exception{
		return (int)((Math.random() * (999999 - 100000 +1)) + 100000);
	}
}
