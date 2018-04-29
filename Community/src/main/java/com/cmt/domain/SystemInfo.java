package com.cmt.domain;

public class SystemInfo {
	
	///Field
	private int uniqueID;
	private long totalCoin;
	private long pointMinSend;
	private long coinPrice;
	private long enrollmentTime;
	private int exchangeUpdate;
	private int p2pChangeDelete;
	private double promotionOnedayPay;
	
	///Constructor
	public SystemInfo() {
	}

	///Method
	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public long getTotalCoin() {
		return totalCoin;
	}

	public void setTotalCoin(long totalCoin) {
		this.totalCoin = totalCoin;
	}

	public long getPointMinSend() {
		return pointMinSend;
	}

	public void setPointMinSend(long pointMinSend) {
		this.pointMinSend = pointMinSend;
	}

	public long getCoinPrice() {
		return coinPrice;
	}

	public void setCoinPrice(long coinPrice) {
		this.coinPrice = coinPrice;
	}

	public long getEnrollmentTime() {
		return enrollmentTime;
	}

	public void setEnrollmentTime(long enrollmentTime) {
		this.enrollmentTime = enrollmentTime;
	}

	public int getExchangeUpdate() {
		return exchangeUpdate;
	}

	public void setExchangeUpdate(int exchangeUpdate) {
		this.exchangeUpdate = exchangeUpdate;
	}

	public int getP2pChangeDelete() {
		return p2pChangeDelete;
	}

	public void setP2pChangeDelete(int p2pChangeDelete) {
		this.p2pChangeDelete = p2pChangeDelete;
	}

	public double getPromotionOnedayPay() {
		return promotionOnedayPay;
	}

	public void setPromotionOnedayPay(double promotionOnedayPay) {
		this.promotionOnedayPay = promotionOnedayPay;
	}

	@Override
	public String toString() {
		return "SystemInfo [uniqueID=" + uniqueID + ", totalCoin=" + totalCoin + ", pointMinSend=" + pointMinSend
				+ ", coinPrice=" + coinPrice + ", enrollmentTime=" + enrollmentTime + ", exchangeUpdate="
				+ exchangeUpdate + ", p2pChangeDelete=" + p2pChangeDelete + ", promotionOnedayPay=" + promotionOnedayPay
				+ "]";
	}
	
}
