package com.cmt.domain;

public class ServerList {
	
	///Field
	private int uniqueID;
	private int code;
	private String address;
	private int port;
	private boolean active;
	
	///Constructor
	public ServerList() {
	}

	///Method
	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	@Override
	public String toString() {
		return "ServerList [uniqueID=" + uniqueID + ", code=" + code + ", address=" + address + ", port=" + port
				+ ", active=" + active + "]";
	}
	
}
