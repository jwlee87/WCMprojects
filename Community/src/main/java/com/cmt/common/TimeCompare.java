package com.cmt.common;

import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;

import com.cmt.dao.BoardDao;
import com.cmt.domain.AttachFile;
import com.cmt.domain.Board;
import com.cmt.domain.Page;

public class TimeCompare {

	///Filed
	private long nowDate;
	private long writeDate;
	private boolean newThing = false;
	
	private Logger logger = LogManager.getLogger();
	
	///Constructor
	public TimeCompare() {
	}
	
	///Method
	public boolean newCheck(String inputDate, int interval) {
		Date curDate = new Date();
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		Date wd;
		
		try {
			wd = df.parse(inputDate);
			this.nowDate = curDate.getTime();
			this.writeDate = wd.getTime();
			
			// 차이를 시간으로 계산 360000 밀리세컨드 = 1시간
			long gap = (nowDate - writeDate) / 3600000;
			
			// 24시간 이하 새글
			newThing=false;
			if(gap < interval) newThing=true;
			
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return newThing;
	}
	
	public void listLoop(List<Board> list, Page page) throws Exception {
		SimpleDateFormat df = new SimpleDateFormat("yy-MM-dd");
		
		for(Board board: list) {
			Timestamp wd = board.getWriteDate();
			board.setNewData(false);
			if(newCheck(wd.toString(), page.getInterval()))	board.setNewData(true);
			board.setDateFormat(df.format(board.getWriteDate()));
		}
	}
}
