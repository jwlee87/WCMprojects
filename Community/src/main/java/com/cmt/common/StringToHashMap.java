package com.cmt.common;

import java.util.HashMap;

public class StringToHashMap {

	public static void main(String[] args) throws Exception {
		
		String body1 = "code=100&message=ok&ap=10084";
		String body = "code=100&message=ok&ap=10084&coco=hahaha&yoyo=cancle";
		
		stringToHashMap(body, "&");

	}
	
	public static HashMap<String, Object> stringToHashMap(String body, String separator) throws Exception {
		HashMap<String, Object> returnMap = new HashMap<String, Object>();
		String[] paramArray = body.split(separator);
		if(paramArray.length != 0) {
			for(String param : paramArray) {
				String[] innerArray = param.split("=");
				if(innerArray.length == 2) {
					returnMap.put(innerArray[0], innerArray[1]);
				}
			}
		}
		return returnMap;
	}

}
