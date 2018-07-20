package com.cmt.zombie;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ZombieController {
	
	@Autowired
	ZombieServiceInterface zsi;
	
	@RequestMapping("/game/{gameName}/{menu}")
	public ModelAndView result(@PathVariable String gameName, @PathVariable String menu, HttpServletRequest req) {
		return zsi.zombie(gameName, menu, req);
	}

}
