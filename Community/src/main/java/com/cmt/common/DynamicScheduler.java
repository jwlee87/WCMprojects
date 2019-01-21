package com.cmt.common;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.scheduling.Trigger;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.support.PeriodicTrigger;
import org.springframework.stereotype.Component;

@Component
public class DynamicScheduler<T> {
	
	///Field
	private Logger logger = LogManager.getLogger();
	private ThreadPoolTaskScheduler scheduler;
	private List<T> list;

	///Method
	
	public void stopScheduler() {
		scheduler.shutdown();
	}
	
	public void startScheduler() {
		scheduler = new ThreadPoolTaskScheduler();
		scheduler.initialize();
		// 스케줄러가 시작되는 부분
		scheduler.schedule(getRunnable(), getTrigger());
	}
	
	private Runnable getRunnable() {
		return () -> {
			// do something
			@SuppressWarnings("unchecked")
			List<HashMap<String, Object>> list = (List<HashMap<String, Object>>) getList();
			
			if(list == null) {
				logger.debug("list is null: "+new Date());
			} else {
				logger.debug("list is not null: "+new Date());
			}
			
		};
	}
	
	private Trigger getTrigger() {
		// 작업주기 설정
		return new PeriodicTrigger(10, TimeUnit.SECONDS);
	}
	
	public List<T> getList() {
		return list;
	}

	public void setList(List<T> list) {
		this.list = list;
	}
	
	
}
