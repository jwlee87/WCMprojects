package com.cmt.domain;

import java.sql.Timestamp;
import java.util.List;

public class Board {
	
	///Field
	private int boardUniqueID;
	private int memberUniqueID;
	private String tradeMark;
	private String title;
	private String contents;
	private Timestamp writeDate;
	private int viewCount;
	private int replyCount;
	
	private boolean newData;
	private boolean admin;
	
	private String dateFormat;
	
	//첨부파일 정보 보드 도메인에 담기
	private List<AttachFile> attachFileList; 
	//댓글리스트 보드 도메인에 담기
	private List<Comment> commentList;
	
	
	
	// developing
	
	///Constructor
	public Board() {
	}
	
	///Method
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public boolean isNewData() {
		return newData;
	}

	public void setNewData(boolean newData) {
		this.newData = newData;
	}

	public boolean isAdmin() {
		return admin;
	}

	public void setAdmin(boolean admin) {
		this.admin = admin;
	}

	public String getDateFormat() {
		return dateFormat;
	}

	public void setDateFormat(String dateFormat) {
		this.dateFormat = dateFormat;
	}

	public int getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	
	public List<AttachFile> getAttachFileList() {
		return attachFileList;
	}

	public void setAttachFileList(List<AttachFile> attachFileList) {
		this.attachFileList = attachFileList;
	}

	public List<Comment> getCommentList() {
		return commentList;
	}

	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}

	@Override
	public String toString() {
		return "Board [boardUniqueID=" + boardUniqueID + ", memberUniqueID=" + memberUniqueID + ", tradeMark="
				+ tradeMark + ", title=" + title + ", contents=" + contents + ", writeDate=" + writeDate
				+ ", viewCount=" + viewCount + ", newData=" + newData + ", admin=" + admin + ", dateFormat="
				+ dateFormat + ", replyCount=" + replyCount + "]";
	}
	
}
