package com.sxt.bus.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.service.TjfxService;
import com.sxt.bus.vo.PieVo;

@Controller
@RequestMapping("tjfx")
public class TjfxController {
	
	@Autowired
	private TjfxService tjfxService;
	
	/**
	 * 跳转到统计客户的区域
	 */
	@RequestMapping("toCountCustomerArea")
	public String  toCountCustomerArea(Model model){
		return "business/countCustomerArea";
	}
	
	/**
	 * 统计客户的区域
	 */
	@RequestMapping("countCustomerArea")
	@ResponseBody
	public List<PieVo>  countCustomerArea(Model model){
		List<PieVo> list=tjfxService.countCustomerArea();
		return list;
	}
	
	
	
}
