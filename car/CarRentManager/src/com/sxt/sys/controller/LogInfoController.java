package com.sxt.sys.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.service.LogInfoService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LogInfoVo;

@Controller
@RequestMapping("logInfo")
public class LogInfoController {
	
	@Autowired
	private LogInfoService infoService;
	
	/**
	 * 跳转到日志管理的页面
	 */
	@RequestMapping("toLogInfoManager")
	public String toLogInfoManager(){
		return "system/logInfoManager";
	}
	
	
	/**
	 * 加载日志数据 返回一个easyui的datagrid可以解析的json
	 */
	@RequestMapping("loadLogInfos")
	@ResponseBody
	public DataGridView loadLogInfos(LogInfoVo infoVo){
		return infoService.queryAllLogInfo(infoVo);
	}
	
	
	/**
	 * 删除日志
	 */
	@RequestMapping("deleteLogInfo")
	@ResponseBody
	public Map<String,Object> deleteLogInfo(LogInfoVo infoVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="删除成功";
		try {
			infoService.deleteLogInfo(infoVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
}
