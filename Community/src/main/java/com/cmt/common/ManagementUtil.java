package com.cmt.common;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class ManagementUtil {

	public static Map<String, Object> convertObjectToMap (Object obj) {
		try {
			Field[] fields = obj.getClass().getDeclaredFields();
			Map<String, Object> resultMap = new HashMap<String, Object>();
			for(int i=0; i<fields.length; i++) {
				fields[i].setAccessible(true);
				resultMap.put(fields[i].getName(), fields[i].get(obj));
			}
			return resultMap;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static Object convertMapToObject (Map<String, Object> map, Object objClass) {
		String keyAttribute = null;
		String setMethodString = "set";
		String methodString = null;
		Iterator<String> itr = map.keySet().iterator();
		while(itr.hasNext()) {
			keyAttribute = (String) itr.next();
			methodString = setMethodString+keyAttribute.substring(0, 1).toUpperCase()+keyAttribute.substring(1);
			
			try {
				Method[] methods = objClass.getClass().getDeclaredMethods();
				
				for(int i=0; i<=methods.length-1; i++) {
					if(methodString.equals(methods[i].getName())) {
						methods[i].invoke(objClass, map.get(keyAttribute));
					}
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		return objClass;
	}

}
