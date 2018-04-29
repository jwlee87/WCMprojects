package com.cmt.domain;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

public class Tab {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	private int countTabs;
	
	private int currentTab;
	private int totalCount;
	
	private int totalTabs;
	
	private int startTab;
	private int endTab;
	
	private boolean prev;
	private boolean next;
	
	private String keyword;
	
	///Constructor
	public Tab() {
	}
	
	public Tab(int currentTab, int totalCount) {
		
		this.currentTab = currentTab;
		
		this.totalCount = totalCount;
		this.totalTabs = totalCount / countTabs;
		init();
	}
	
	public Tab(int currentTab, int totalCount, int countTabs) {
		
		this.countTabs = countTabs;
		this.currentTab = currentTab;
		
		this.totalCount = totalCount;
		this.totalTabs = totalCount / countTabs;
		init();
	}
	
	private void init() {
		
		if(totalCount % countTabs > 0) {
			totalTabs++;
		}
		
		if(totalTabs < currentTab) {
			currentTab = totalTabs;
		}
		
		this.startTab = ((currentTab-1)/countTabs)*countTabs+1;
		this.endTab = startTab+countTabs+1;
		
		if(endTab > totalTabs) {
			endTab = totalTabs;
		}
		
		if(startTab > 1) {
			prev = false;
		}
		
		if(currentTab > 1) {
			prev = true;
		}
		
		if(currentTab < totalTabs) {
			next = true;
		}
		
		if(endTab < totalTabs) {
			next = false;
		}
		
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public int getCountTabs() {
		return countTabs;
	}

	public void setCountTabs(int countTabs) {
		this.countTabs = countTabs;
	}

	public int getCurrentTab() {
		return currentTab;
	}

	public void setCurrentTab(int currentTab) {
		this.currentTab = currentTab;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getTotalTabs() {
		return totalTabs;
	}

	public void setTotalTabs(int totalTabs) {
		this.totalTabs = totalTabs;
	}

	public int getStartTab() {
		return startTab;
	}

	public void setStartTab(int startTab) {
		this.startTab = startTab;
	}

	public int getEndTab() {
		return endTab;
	}

	public void setEndTab(int endTab) {
		this.endTab = endTab;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "Tab [logger=" + logger + ", countTabs=" + countTabs + ", currentTab=" + currentTab + ", totalCount="
				+ totalCount + ", totalTabs=" + totalTabs + ", startTab=" + startTab + ", endTab=" + endTab + ", prev="
				+ prev + ", next=" + next + ", keyword=" + keyword + "]";
	}
	
	
}
