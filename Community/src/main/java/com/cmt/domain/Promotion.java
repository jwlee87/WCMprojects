package com.cmt.domain;

public class Promotion {
	
	//Field
	private int uniqueID;
	private int userUniqueID;
	private int unityPromotionCount;
	private int promotionLevel;
	
	///Constructor
	public Promotion() {
	}
	
	///Method
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

	public int getUnityPromotionCount() {
		return unityPromotionCount;
	}

	public void setUnityPromotionCount(int unityPromotionCount) {
		this.unityPromotionCount = unityPromotionCount;
	}

	public int getPromotionLevel() {
		return promotionLevel;
	}

	public void setPromotionLevel(int promotionLevel) {
		this.promotionLevel = promotionLevel;
	}

	@Override
	public String toString() {
		return "Promotion [uniqueID=" + uniqueID + ", userUniqueID=" + userUniqueID + ", unityPromotionCount="
				+ unityPromotionCount + ", promotionLevel=" + promotionLevel + "]";
	}
	
	
}
