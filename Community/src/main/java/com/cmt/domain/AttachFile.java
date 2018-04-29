package com.cmt.domain;

public class AttachFile {
	
	///Field
	private int fileUniqueID;
	private int boardUniqueID;
	private String fileName;
	private String filePath;
	
	///Constructor
	public AttachFile() {
	}

	///Method
	public int getFileUniqueID() {
		return fileUniqueID;
	}

	public void setFileUniqueID(int fileUniqueID) {
		this.fileUniqueID = fileUniqueID;
	}

	public int getBoardUniqueID() {
		return boardUniqueID;
	}

	public void setBoardUniqueID(int boardUniqueID) {
		this.boardUniqueID = boardUniqueID;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	@Override
	public String toString() {
		return "AttachFile [fileUniqueID=" + fileUniqueID + ", boardUniqueID=" + boardUniqueID + ", fileName="
				+ fileName + ", filePath=" + filePath + "]";
	}
	
}
