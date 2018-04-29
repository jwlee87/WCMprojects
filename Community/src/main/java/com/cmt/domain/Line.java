package com.cmt.domain;

import java.sql.Timestamp;

public class Line {
	
	/// field
	private int uniqueID;
	private int UserUniqueID;
	private Timestamp createDateTime;
	private String chat;
	private int state;
	private int useDate;
	private int colorKey;
	
	/// defalut constructor
	public Line() {
	}

	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public int getUserUniqueID() {
		return UserUniqueID;
	}

	public void setUserUniqueID(int userUniqueID) {
		UserUniqueID = userUniqueID;
	}

	public Timestamp getCreateDateTime() {
		return createDateTime;
	}

	public void setCreateDateTime(Timestamp createDateTime) {
		this.createDateTime = createDateTime;
	}

	public String getChat() {
		return chat;
	}

	public void setChat(String chat) {
		this.chat = chat;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public int getUseDate() {
		return useDate;
	}

	public void setUseDate(int useDate) {
		this.useDate = useDate;
	}

	public int getColorKey() {
		return colorKey;
	}

	public void setColorKey(int colorKey) {
		this.colorKey = colorKey;
	}

	@Override
	public String toString() {
		return "Line [uniqueID=" + uniqueID + ", UserUniqueID=" + UserUniqueID + ", createDateTime=" + createDateTime
				+ ", chat=" + chat + ", state=" + state + ", useDate=" + useDate + ", colorKey=" + colorKey + "]";
	}

}
