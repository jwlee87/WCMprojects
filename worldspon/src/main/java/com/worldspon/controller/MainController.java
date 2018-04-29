package com.worldspon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {

	///Field
	
	///Constructor
	public MainController() {
	}
	
	///Method
	
	//Company
	@RequestMapping(value="/company")
	public String companyIntro() throws Exception{
		return "company/index";
	}
	@RequestMapping(value="/company/ci")
	public void ciPage() throws Exception{	
	}
	@RequestMapping(value="/company/location")
	public void locationPage() throws Exception{	
	}
	
	//business
	@RequestMapping(value="/business")
	public String businessIntro() throws Exception{
		return "business/index";
	}
	@RequestMapping(value="/business/contents/app")
	public String businessContentsApp() throws Exception{
		return "business/contents/app";
	}
	@RequestMapping(value="/business/contents/game")
	public String businessContentsCoin() throws Exception{
		return "business/contents/game";
	}
	
	//costomer
	@RequestMapping(value="/customer")
	public String customer() throws Exception{
		return "customer/index";
	}
	
	//notice
	@RequestMapping(value="/notice")
	public String notice() throws Exception{
		return "notice/index";
	}
}
