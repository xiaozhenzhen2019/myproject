package com.sxt.bus.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.domain.Customer;
import com.sxt.bus.service.CustomerService;
import com.sxt.bus.utils.CustomerExportExcelUtils;
import com.sxt.bus.vo.CustomerVo;
import com.sxt.sys.utils.DataGridView;

@Controller
@RequestMapping("customer")
public class CustomerController {
	@Autowired
	private CustomerService customerService;
	/**
	 * 跳转到business/customerManager.jsp
	 */
	@RequestMapping("toCustomerManager")
	public String toCustomerManager(){
		return "business/customerManager";
	}
	/**
	 * 加载所有的客户
	 */
	@RequestMapping("loadCustomers")
	@ResponseBody
	public DataGridView loadCustomers(CustomerVo customerVo){
		return this.customerService.queryAllCustomers(customerVo);
	}
	
	
	/**
	 * 添加客户
	 */
	@RequestMapping("addCustomer")
	@ResponseBody
	public String addCustomer(CustomerVo customerVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="添加成功";
		try {
			customerService.addCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return "";
		
	}
	/**
	 * 修改客户
	 */
	@RequestMapping("updateCustomer")
	@ResponseBody
	public Map<String,Object> updateCustomer(CustomerVo customerVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="修改成功";
		try {
			customerService.updateCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	/**
	 * 删除客户
	 */
	@RequestMapping("deleteCustomer")
	@ResponseBody
	public Map<String,Object> deleteCustomer(CustomerVo customerVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="删除成功";
		try {
			customerService.deleteCustomer(customerVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	
	
	/**
	 * 导出客户数据
	 * 
	 */
	@RequestMapping("exportCustomer")
	public void exportCustomer(CustomerVo customerVo,HttpServletResponse response){
		//查询客户信息
		List<Customer> list=this.customerService.queryCustomers(customerVo);
		String fileName="客户数据.xls";
		CustomerExportExcelUtils.exportCustomer(list, response, fileName,"客户数据");
	}

	
}
