package com.cmt.appang.store;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface StoreServiceInterface {
	public HashMap<String, Object> payment(HttpServletRequest req);
}
