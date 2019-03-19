package com.cmt.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cmt.common.HttpUtil;
import com.cmt.service.MemberService;
import com.cmt.service.TsunamiApiService;
import com.google.gson.Gson;

/* Tsunami 인증서버
 * 앱에서 로그인시 요청하면 토큰 발급 api
 */
@Controller
@RequestMapping(value="/tsunami-api", produces="application/json;charset=UTF-8")
public class TsunamiController {
	
	///Field
	private Logger logger = LogManager.getLogger();

	@Autowired
	@Qualifier("memberServiceImpl")
	private MemberService memberService;
	private static final Gson gson = new Gson();
	
	@Autowired
	private TsunamiApiService tasi;
	
	@PostMapping("/auth")
	public @ResponseBody String auth(HttpServletRequest req) throws IOException {
		String json = req.getReader().readLine();
		if(json == null || json.equals("")) {
			json = "{\"msg\":\"controller :: request dose not have any parameters\", \"rst\":\"error\"}";
			return json;
		} else {
			if( HttpUtil.isJSONValid(json) && HttpUtil.isNotSingleString(json)) {
				try {
					//service logic
					return gson.toJson(tasi.getAuth(json));
				} catch (Exception e) {
					System.out.println("error");
					e.printStackTrace();
					json = "{\"msg\":\"controller :: \", \"rst\":\"error\"}";
					return json;
				}
			}else {
				System.out.println("false");
				json = "{\"msg\":\"controller :: invalid json format\", \"rst\":\"error\"}";
				return json;
			}
		}
	}

}
