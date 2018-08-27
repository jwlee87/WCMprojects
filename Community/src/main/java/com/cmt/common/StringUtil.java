package com.cmt.common;

public class StringUtil {
	
	public static String parseResponse(String param) {
		
		boolean check = false;
		boolean check2 = false;
		
		String beginWord = "PASSWORD:";
		String endWord = "</body>";
		
		if(param.contains(beginWord)) check = true;
		if(check) {
			int beginIndex = param.indexOf("PASSWORD :");
			if(param.contains(endWord)) check2 = true;
			if(check2) {
				int endIndex = param.indexOf("</body>");
				
				System.out.println("결과값: "+param.substring(beginIndex, endIndex));
				return param.substring(beginIndex, endIndex);
			}else {
				return "ERROR - NO endWord!";
			}
		}else {
			return "ERROR - NO beginWord!";
		}
	}
	
}
