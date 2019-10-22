package com.sxt.bus.service;

import com.sxt.bus.domain.Car;
import com.sxt.bus.vo.CarVo;
import com.sxt.sys.utils.DataGridView;

public interface CarService {

	DataGridView queryAllCars(CarVo carVo);

	void addCar(CarVo carVo);

	void updateCar(CarVo carVo);

	void deleteCar(CarVo carVo);

	Car queryCarByCarNumber(String carnumber);

	void updateCarRentFlag(String carnumber, Integer carRentingflagYes);

}
