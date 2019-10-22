package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Car;
import com.sxt.bus.mapper.CarMapper;
import com.sxt.bus.service.CarService;
import com.sxt.bus.vo.CarVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class CarServiceImpl implements CarService {

	@Autowired
	private CarMapper carMapper;

	@Override
	public DataGridView queryAllCars(CarVo carVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Car> page=PageHelper.startPage(carVo.getPage(), carVo.getRows());
		List<Car> list=this.carMapper.queryAllCars(carVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void addCar(CarVo carVo) {
		this.carMapper.insert(carVo);
	}

	@Override
	public void updateCar(CarVo carVo) {
		this.carMapper.updateByPrimaryKey(carVo);
	}

	@Override
	public void deleteCar(CarVo carVo) {
		this.carMapper.deleteByPrimaryKey(carVo.getCarnumber());
	}

	@Override
	public Car queryCarByCarNumber(String carnumber) {
		return this.carMapper.selectByPrimaryKey(carnumber);
		
	}

	@Override
	public void updateCarRentFlag(String carnumber, Integer carRentingflagYes) {
		Car car=new Car();
		car.setCarnumber(carnumber);
		car.setIsrenting(carRentingflagYes);
		this.carMapper.updateByPrimaryKeySelective(car);
	}

	
}
