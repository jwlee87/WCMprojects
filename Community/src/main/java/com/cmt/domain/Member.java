package com.cmt.domain;

public class Member {

	///Field
	private int uniqueID;
	private int infoLocate;
	private String tradeMark;
	private String password;
	private long point;
	private long lockPoint;
	private long coin;
	private long lockCoin;
	private String phone;
	private String eMail;
	private int _class;
	
	///Constructor
	public Member() {
	}

	///Method
	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public int getInfoLocate() {
		return infoLocate;
	}

	public void setInfoLocate(int infoLocate) {
		this.infoLocate = infoLocate;
	}

	public String getTradeMark() {
		return tradeMark;
	}

	public void setTradeMark(String tradeMark) {
		this.tradeMark = tradeMark;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public long getPoint() {
		return point;
	}

	public void setPoint(long point) {
		this.point = point;
	}

	public long getCoin() {
		return coin;
	}

	public void setCoin(long coin) {
		this.coin = coin;
	}

	public long getLockPoint() {
		return lockPoint;
	}

	public void setLockPoint(long lockPoint) {
		this.lockPoint = lockPoint;
	}

	public long getLockCoin() {
		return lockCoin;
	}

	public void setLockCoin(long lockCoin) {
		this.lockCoin = lockCoin;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String geteMail() {
		return eMail;
	}

	public void seteMail(String eMail) {
		this.eMail = eMail;
	}

	public int get_class() {
		return _class;
	}

	public void set_class(int _class) {
		this._class = _class;
	}

	@Override
	public String toString() {
		return "Member [uniqueID=" + uniqueID + ", infoLocate=" + infoLocate + ", tradeMark=" + tradeMark
				+ ", password=" + password + ", point=" + point + ", lockPoint=" + lockPoint + ", coin=" + coin
				+ ", lockCoin=" + lockCoin + ", phone=" + phone + ", eMail=" + eMail + ", _class="+_class+"]";
	}
	
}
