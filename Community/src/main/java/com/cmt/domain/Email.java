package com.cmt.domain;

public class Email {
	
	private int uniqueID;
	private int userUniqueID;
	private int authKey;
	private int token;
	
	private String subject;
	private String content;
	private String receiver;
	
	public Email() {
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getAuthKey() {
		return authKey;
	}

	public void setAuthKey(int authKey) {
		this.authKey = authKey;
	}

	public int getToken() {
		return token;
	}

	public void setToken(int token) {
		this.token = token;
	}

	public String getReceiver() {
		return receiver;
	}

	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}

	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public int getUserUniqueID() {
		return userUniqueID;
	}

	public void setUserUniqueID(int userUniqueID) {
		this.userUniqueID = userUniqueID;
	}
	
}
