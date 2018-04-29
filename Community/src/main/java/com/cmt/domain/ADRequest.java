package com.cmt.domain;

import java.sql.Timestamp;

public class ADRequest {

	///Field
	private int adUniqueID;
	private int memberUniqueID;
	private String tradeMark;
	private String filePath;
	private String fileName;
	private String linkAddr;
	private long price;
	private int type;
	private int duration;
	private boolean state;
	private Timestamp reqDate;
	
	///Constructor
	public ADRequest() {
	}
	
	///Method
	public int getAdUniqueID() {
		return adUniqueID;
	}

	public void setAdUniqueID(int adUniqueID) {
		this.adUniqueID = adUniqueID;
	}

	public int getMemberUniqueID() {
		return memberUniqueID;
	}

	public void setMemberUniqueID(int memberUniqueID) {
		this.memberUniqueID = memberUniqueID;
	}

	public String getTradeMark() {
		return tradeMark;
	}

	public void setTradeMark(String tradeMark) {
		this.tradeMark = tradeMark;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getLinkAddr() {
		return linkAddr;
	}

	public void setLinkAddr(String linkAddr) {
		this.linkAddr = linkAddr;
	}

	public long getPrice() {
		return price;
	}

	public void setPrice(long price) {
		this.price = price;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	public int getDuration() {
		return duration;
	}

	public void setDuration(int duration) {
		this.duration = duration;
	}

	public boolean isState() {
		return state;
	}

	public void setState(boolean state) {
		this.state = state;
	}

	public Timestamp getReqDate() {
		return reqDate;
	}

	public void setReqDate(Timestamp reqDate) {
		this.reqDate = reqDate;
	}

	@Override
	public String toString() {
		return "ADRequest [adUniqueID=" + adUniqueID + ", memberUniqueID=" + memberUniqueID + ", tradeMark=" + tradeMark
				+ ", filePath=" + filePath + ", fileName=" + fileName + ", linkAddr=" + linkAddr + ", price=" + price
				+ ", type=" + type + ", duration=" + duration + ", state=" + state + ", reqDate=" + reqDate + "]";
	}
	
}
