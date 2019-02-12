package com.cmt.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cmt.service.MemberService;
import com.cmt.service.TsunamiApiService;
import com.google.gson.Gson;

/*게시판*/
@Controller
@RequestMapping(value="/tsunami-api", produces="application/json;charset=UTF-8")
public class TsunamiController {
	
	///Field
	private Logger logger = LogManager.getLogger();

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	
	@Autowired
	private TsunamiApiService tasi;
	
	@PostMapping("/auth")
	public @ResponseBody String auth(HttpServletRequest req, @RequestBody String json) throws Exception {
		Gson gson = new Gson();
		System.out.println(json);
		
		if(json.equals("")) {
			json = "{\"msg\":\"controller :: request dose not have any parameters\", \"rst\":\"error\"}";
			return json;
		}else {
			return gson.toJson(tasi.getAuth(json));
		}
	}

}
