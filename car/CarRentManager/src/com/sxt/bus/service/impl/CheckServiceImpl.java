package com.sxt.bus.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.constast.BUS_Constast;
import com.sxt.bus.domain.Car;
import com.sxt.bus.domain.Check;
import com.sxt.bus.domain.Customer;
import com.sxt.bus.domain.Rent;
import com.sxt.bus.mapper.CarMapper;
import com.sxt.bus.mapper.CheckMapper;
import com.sxt.bus.mapper.CustomerMapper;
import com.sxt.bus.mapper.RentMapper;
import com.sxt.bus.service.CheckService;
import com.sxt.bus.vo.CheckVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class CheckServiceImpl implements CheckService{

	@Autowired
	private RentMapper rentMapper;
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private CarMapper carMapper;
	
	@Autowired
	private CheckMapper checkMapper;
	
	@Override
	public Map<String, Object> initCheck(String rentid) {
		Map<String, Object> map=new HashMap<String, Object>();
		//取到出租单信息
		Rent rent=rentMapper.selectByPrimaryKey(rentid);
		//根据rent.carnumber取到车辆信息
		Car car=this.carMapper.selectByPrimaryKey(rent.getCarnumber());
		//根据rent.identity取到客户信息
		Customer customer=customerMapper.selectByPrimaryKey(rent.getIdentity());
		map.put("rent", rent);
		map.put("car", car);
		map.put("customer", customer);
		return map;
	}

	@Override
	public void addCheck(CheckVo checkVo) {
		this.checkMapper.insert(checkVo);
		//修改出租单的状态
		Rent record=this.rentMapper.selectByPrimaryKey(checkVo.getRentid());
		record.setRentflag(BUS_Constast.CAR_RENTINGFLAG_YES);
		this.rentMapper.updateByPrimaryKey(record);
		Car car=new Car();
		car.setCarnumber(record.getCarnumber());
		car.setIsrenting(BUS_Constast.CAR_RENTINGFLAG_NO);
		//修改汽车的状态
		this.carMapper.updateByPrimaryKeySelective(car);
	}

	@Override
	public DataGridView queryAllChecks(CheckVo checkVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Check> page=PageHelper.startPage(checkVo.getPage(), checkVo.getRows());
		List<Check> list=this.checkMapper.queryAllChecks(checkVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}
}
