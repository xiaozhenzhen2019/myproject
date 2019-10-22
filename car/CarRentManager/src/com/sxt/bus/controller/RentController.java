package com.sxt.bus.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.bus.constast.BUS_Constast;
import com.sxt.bus.domain.Customer;
import com.sxt.bus.domain.Rent;
import com.sxt.bus.service.CarService;
import com.sxt.bus.service.CustomerService;
import com.sxt.bus.service.RentService;
import com.sxt.bus.utils.RentExportExcelUtils;
import com.sxt.bus.utils.StrUtils;
import com.sxt.bus.vo.RentVo;
import com.sxt.sys.domain.User;
import com.sxt.sys.utils.DataGridView;

@RequestMapping("rent")
@Controller
public class RentController {
	
	@Autowired
	private CustomerService customerService;
	@Autowired
	private RentService rentService;
	@Autowired
	private CarService carService;
	/**
	 * 跳转到汽车出租 的页面
	 * @return
	 */
	@RequestMapping("toRentCarManager")
	public String toRentCarManager(){
		return "business/rentCarManager";
	}
	
	/**
	 * 根据客户的身份证号查询客户信息
	 */
	@RequestMapping("queryCustomerByIdentity")
	@ResponseBody
	public String queryCustomerByIdentity(String identity){
		Customer customer=customerService.queryCustomerByIdentity(identity);
		if(customer!=null){
			return "true";
		}else{
			return "false";
		}
	}
	
	
	/**
	 * 添加出租单时会表单里面的数据进行初始化
	 * @param identity
	 * @param carnumber
	 * @param rentprice
	 * @param session
	 * @return
	 */
	@RequestMapping("initRent")
	@ResponseBody
	public RentVo initRent(String identity,String carnumber,Double rentprice,HttpSession session){
		User user=(User) session.getAttribute("user");
		RentVo vo=new RentVo();
		vo.setIdentity(identity);//客户身份证
		vo.setCarnumber(carnumber);//选择的车牌号
		vo.setPrice(rentprice);//出租价格
		vo.setRentid(StrUtils.createRandomStrUseTimeAndRandom4(BUS_Constast.BUS_CZ_PREFIX));//系统生成的出租单号
		vo.setOpername(user.getRealname());//操作员
		vo.setRentflag(BUS_Constast.CAR_RENTINGFLAG_NO);//未归还
		return vo;
	}
	
	/**
	 * 添加出租单
	 * @param rentVo
	 * @return
	 */
	@RequestMapping("addRent")
	@ResponseBody
	public Map<String,Object> addRent(RentVo rentVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="添加成功";
		try {
			rentService.addRent(rentVo);
			//修改汽车的出租状态为YES1
			carService.updateCarRentFlag(rentVo.getCarnumber(),BUS_Constast.CAR_RENTINGFLAG_YES);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	
	
	
	/*************出租单管理开始***************************/
	/**
	 * 跳转到出租单管理页面
	 */
	@RequestMapping("toRentManager")
	public String toRentManager(){
		return "business/rentManager";
	}

	
	/**
	 * 查询所有出租单信息
	 */
	@RequestMapping("loadRents")
	@ResponseBody
	public DataGridView loadRents(RentVo rentVo){
		return this.rentService.queryAllRents(rentVo);
	}
	
	
	/**
	 * 修改出租单
	 */
	@RequestMapping("updateRent")
	@ResponseBody
	public Map<String,Object> updateRent(RentVo rentVo){
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "修改成功";
		try {
			rentService.updateRent(rentVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	
	/**
	 * 删除出租单信息
	 */
	@RequestMapping("deleteRent")
	@ResponseBody
	public Map<String,Object>  deleteRent(RentVo rentVo){
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			rentService.deleteRent(rentVo);
			//修改汽车状态
			this.carService.updateCarRentFlag(rentVo.getCarnumber(), BUS_Constast.CAR_RENTINGFLAG_NO);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	
	/*************出租单管理结束***************************/
	
	
	/***
	 * 导出出租单信息
	 */
	@RequestMapping("exportRent")
	public void exportRent(RentVo rentVo,HttpServletResponse response){
		//根据rentid查询出租单信息
		Rent rent = this.rentService.queryRentByRentId(rentVo.getRentid());
		//查询客户信息
		Customer customer=this.customerService.queryCustomerByIdentity(rent.getIdentity());
		String fileName=customer.getCustname()+"-出租单信息.xls";
		String title=customer.getCustname()+"的出租单信息";
		RentExportExcelUtils.exportRent(rent, customer, fileName, title, response);
	}
	
}
