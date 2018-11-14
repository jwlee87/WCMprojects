package com.cmt.controller;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.Period;
import java.util.HashMap;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class TestMainMethod {

	public TestMainMethod() {
		// TODO Auto-generated constructor stub
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Logger logger = LogManager.getLogger();
		HashMap<String, Object> paramMap = new HashMap<String, Object>();
		String strDateTime = (String)paramMap.get("dt");
		String strDate = strDateTime.substring(0, 4);
		String strTime = strDateTime.substring(4);
		logger.debug(strDate+", "+strTime);
		
		String strMon = strDate.substring(0, 2);
		String strDay = strDate.substring(2);
		String strHour = strTime.substring(0, 2);
		String strMin = strTime.substring(2);
		
		logger.debug(strMon+", "+strDay+", "+strHour+", "+strMin);
		
		int intMon = Integer.parseInt(strMon);
		int intDay = Integer.parseInt(strDay);
		int intHour = Integer.parseInt(strHour);
		int intMin = Integer.parseInt(strMin);
		logger.debug(intMon+", "+intDay+", "+intHour+", "+intMin);
		
		LocalDate startDate = LocalDate.now();
		LocalDate endDate = LocalDate.of(startDate.getYear(), intMon, intDay);
		Period period = Period.between(startDate, endDate);
		int gapMon = period.getMonths();
		int gapDay = period.getDays();
		
		LocalTime startTime = LocalTime.now();
		LocalTime endTime = LocalTime.of(intHour, intMin, 00);
		Duration duration = Duration.between(startTime, endTime);
		duration.getSeconds();

	}

}
