package com.cmt.domain;

public class RewardList {
	
	//Field
	private int uniqueID;
	private int memberUniqueID;
	private String rewardKey;
	private int quantity;
	private String campaignKey;
	private String campaignName;
	private String campaignType;
	private String appKey;
	private String appName;
	private String timeStamp;
	private String adid;
	private int company;
	
	//Constructor
	public RewardList() {
	}
	
	//Method
	public int getUniqueID() {
		return uniqueID;
	}

	public void setUniqueID(int uniqueID) {
		this.uniqueID = uniqueID;
	}

	public int getMemberUniqueID() {
		return memberUniqueID;
	}

	public void setMemberUniqueID(int memberUniqueID) {
		this.memberUniqueID = memberUniqueID;
	}

	public String getRewardKey() {
		return rewardKey;
	}

	public void setRewardKey(String rewardKey) {
		this.rewardKey = rewardKey;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getCampaignKey() {
		return campaignKey;
	}

	public void setCampaignKey(String campaignKey) {
		this.campaignKey = campaignKey;
	}

	public String getCampaignName() {
		return campaignName;
	}

	public void setCampaignName(String campaignName) {
		this.campaignName = campaignName;
	}

	public String getCampaignType() {
		return campaignType;
	}

	public void setCampaignType(String campaignType) {
		this.campaignType = campaignType;
	}

	public String getAppKey() {
		return appKey;
	}

	public void setAppKey(String appKey) {
		this.appKey = appKey;
	}

	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(String timeStamp) {
		this.timeStamp = timeStamp;
	}

	public String getAdid() {
		return adid;
	}

	public void setAdid(String adid) {
		this.adid = adid;
	}

	public int getCompany() {
		return company;
	}

	public void setCompany(int company) {
		this.company = company;
	}

	@Override
	public String toString() {
		return "Reward [uniqueID=" + uniqueID + ", memberUniqueID=" + memberUniqueID + ", rewardKey=" + rewardKey
				+ ", quantity=" + quantity + ", campaignKey=" + campaignKey + ", campaignName=" + campaignName
				+ ", campaignType=" + campaignType + ", appKey=" + appKey + ", appName=" + appName + ", timeStamp="
				+ timeStamp + ", adid=" + adid + ", company=" + company + "]";
	}

}
