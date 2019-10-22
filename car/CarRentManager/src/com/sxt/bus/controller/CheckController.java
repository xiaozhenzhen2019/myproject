package com.sxt.bus.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.constast.BUS_Constast;
import com.sxt.bus.domain.Rent;
import com.sxt.bus.service.CheckService;
import com.sxt.bus.service.RentService;
import com.sxt.bus.utils.StrUtils;
import com.sxt.bus.vo.CheckVo;
import com.sxt.sys.domain.User;
import com.sxt.sys.utils.DataGridView;

@Controller
@RequestMapping("check")
public class CheckController {
	
	@Autowired
	private RentService rentService;
	
	@Autowired
	private CheckService checkService;

	/**
	 * 跳转到检查单添加的页面
	 */
	@RequestMapping("toCheckCarManager")
	public String toCheckCarManager(){
		return "business/checkCarManager";
	}

	
	/**
	 * 根据出租单号查询 出租单信息
	 */
	@RequestMapping("queryRentByRentId")
	@ResponseBody
	public String queryRentByRentId(String rentid){
		Rent rent=rentService.queryRentByRentId(rentid);
		//如果rent为空。或者出租单的归还状态为YES  --说明这个出租单不存在或者已归还
		if(rent==null||rent.getRentflag()==BUS_Constast.CAR_RENTINGFLAG_YES){
			return "false";
		}else{
			return "true";
		}
	}
	
	@RequestMapping("initCheck")
	@ResponseBody
	public Map<String,Object> initCheck(String rentid,HttpSession session){
		Map<String, Object> map = this.checkService.initCheck(rentid);
		User user=(User) session.getAttribute("user");
		//组装检查单的初始数据
		CheckVo checkVo=new CheckVo();
		checkVo.setCheckid(StrUtils.createRandomStrUseTimeAndRandom4(BUS_Constast.BUS_JC_PREFIX));
		checkVo.setRentid(rentid);
		checkVo.setOpername(user.getRealname());
		map.put("check", checkVo);
		return map;
	}
	
	
	/**
	 * 添加检查单
	 * @param customerVo
	 * @return
	 */
	@RequestMapping("addCheck")
	@ResponseBody
	public Map<String,Object> addCheck(CheckVo checkVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="添加成功";
		try {
			checkService.addCheck(checkVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	
	/*************检查单管理开始**************/
	@RequestMapping("toCheckManager")
	public String toCheckManager(){
		return "business/checkManager";
	}
	
	
	/**
	 * 查询
	 */
	@RequestMapping("loadChecks")
	@ResponseBody
	public DataGridView loadChecks(CheckVo checkVo){
		return this.checkService.queryAllChecks(checkVo);
	}
	/*************检查单管理结束 **************/
	
	
}
