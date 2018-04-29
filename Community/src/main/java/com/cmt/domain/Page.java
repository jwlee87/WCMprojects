package com.cmt.domain;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

public class Page {
	
	///Field
	private Logger logger = LogManager.getLogger();
	
	private int noticeRows;
	private int defaultRows;
	private int countRows;
	private int currentPageNo;
	private int begin;
	private int end;
	
	private int interval;
	
	private String searchTarget;
	private String searchKeyword;
	
	///Constructor
	public Page() {
		this.currentPageNo = 1;
		init();
		logger.debug(this);
	}
	
	public Page(int currentPageNo) {
		if(currentPageNo == 0) this.currentPageNo = 1;
		this.currentPageNo = currentPageNo;
		init();
		logger.debug(this);
	}
	
	public Page(int currentPageNo, int countRows) {
		if(currentPageNo == 0) this.currentPageNo = 1;
		this.currentPageNo = currentPageNo;
		this.countRows =  countRows;
		init();
		logger.debug(this);
	}
	
	
	public Page(int currentPageNo, int interval, int noticeRows, int defaultRows) {
		if(currentPageNo == 0) this.currentPageNo = 1;
		this.currentPageNo = currentPageNo;
		this.interval =  interval;
		this.noticeRows = noticeRows;
		this.defaultRows = defaultRows;
		this.countRows= defaultRows-noticeRows;
		init();
	}
	
	public Page(int currentPageNo, String searchTarget, String searchKeyword) {
		if(currentPageNo == 0) this.currentPageNo = 1;
		this.currentPageNo = currentPageNo;
		this.searchTarget = searchTarget;
		this.searchKeyword = searchKeyword;
		init();
		logger.debug(this);
	}
	
	public void init() {
		this.begin = (currentPageNo-1)*countRows+1;
		this.end = currentPageNo*countRows;
	}

	public int getCountRows() {
		return countRows;
	}

	public void setCountRows(int countRows) {
		this.countRows = countRows;
	}

	public int getCurrentPageNo() {
		return currentPageNo;
	}

	public void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public int getBegin() {
		return begin;
	}

	public void setBegin(int begin) {
		this.begin = begin;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public String getSearchTarget() {
		return searchTarget;
	}

	public void setSearchTarget(String searchTarget) {
		this.searchTarget = searchTarget;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public Logger getLogger() {
		return logger;
	}

	public void setLogger(Logger logger) {
		this.logger = logger;
	}

	public int getInterval() {
		return interval;
	}

	public void setInterval(int interval) {
		this.interval = interval;
	}

	@Override
	public String toString() {
		return "Page [logger=" + logger + ", countRows=" + countRows + ", currentPageNo=" + currentPageNo + ", begin="
				+ begin + ", end=" + end + ", interval=" + interval + ", searchTarget=" + searchTarget
				+ ", searchKeyword=" + searchKeyword + "]";
	}
	

}
