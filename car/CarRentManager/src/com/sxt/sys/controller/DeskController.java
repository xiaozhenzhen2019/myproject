package com.sxt.sys.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("desk")
public class DeskController {
	
	@RequestMapping("toDeskManager")
	public String toDeskManager(){
		return "system/deskManager";
	}

}
