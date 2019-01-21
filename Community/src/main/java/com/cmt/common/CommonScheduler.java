package com.cmt.common;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;

public class CommonScheduler {

	///Field
	private Logger logger = LogManager.getLogger();
	
	
	@Scheduled(cron="0/5 * * * * *")
	public void scheduleRun() throws ParseException {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		logger.debug(list);
		
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date endTime = sdf.parse(sdf.format(calendar.getTime()));
		long calDate = 0;
		
		int sequence = 1;
		
		for(HashMap<String, Object> tempMap : list) {
			Iterator<String> keys = tempMap.keySet().iterator();
			while(keys.hasNext()) {
				Date beginTime = sdf.parse((String)tempMap.get("beginTime"));
				calDate = (beginTime.getTime() - endTime.getTime()) / ( 60*1000 );
			}
			sequence++;
		}
		logger.debug("스케쥴 실행  list: "+list+", sequence: "+sequence+", 시간차이: "+calDate);
		
	}

}
