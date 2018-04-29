package com.cmt.domain;

import java.sql.Timestamp;

public class Comment {
	
	private int commentUniqueID;
	private int boardUniqueID;
	private int memberUniqueID;
	private String tradeMark;
	private String comment;
	private Timestamp writeDate;
	
	private String dateFormat;;
	
	public int getCommentUniqueID() {
		return commentUniqueID;
	}
	public void setCommentUniqueID(int commentUniqueID) {
		this.commentUniqueID = commentUniqueID;
	}
	public int getBoardUniqueID() {
		return boardUniqueID;
	}
	public void setBoardUniqueID(int boardUniqueID) {
		this.boardUniqueID = boardUniqueID;
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
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	
	public Timestamp getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}
	
	public String getDateFormat() {
		return dateFormat;
	}
	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}
	
	@Override
	public String toString() {
		return "Comment [commentUniqueID=" + commentUniqueID + ", boardUniqueID=" + boardUniqueID + ", memberUniqueID="
				+ memberUniqueID + ", tradeMark=" + tradeMark + ", comment=" + comment + ", writeDate=" + writeDate
				+ ", dateFormat=" + dateFormat + "]";
	}
	
}
