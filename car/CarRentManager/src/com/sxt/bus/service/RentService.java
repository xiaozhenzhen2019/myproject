package com.sxt.bus.service;

import com.sxt.bus.domain.Rent;
import com.sxt.bus.vo.RentVo;
import com.sxt.sys.utils.DataGridView;

public interface RentService {

	void addRent(RentVo rentVo);

	DataGridView queryAllRents(RentVo rentVo);

	void updateRent(RentVo rentVo);

	void deleteRent(RentVo rentVo);

	Rent queryRentByRentId(String rentid);

}
