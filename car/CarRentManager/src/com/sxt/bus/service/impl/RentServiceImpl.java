package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.bus.domain.Rent;
import com.sxt.bus.mapper.RentMapper;
import com.sxt.bus.service.RentService;
import com.sxt.bus.vo.RentVo;
import com.sxt.sys.utils.DataGridView;

@Service
public class RentServiceImpl implements RentService{

	@Autowired
	private RentMapper rentMapper;

	@Override
	public void addRent(RentVo rentVo) {
		this.rentMapper.insert(rentVo);
	}

	@Override
	public DataGridView queryAllRents(RentVo rentVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Rent> page=PageHelper.startPage(rentVo.getPage(), rentVo.getRows());
		List<Rent> list=this.rentMapper.queryAllRents(rentVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void updateRent(RentVo rentVo) {
		rentMapper.updateByPrimaryKey(rentVo);
	}

	@Override
	public void deleteRent(RentVo rentVo) {
		this.rentMapper.deleteByPrimaryKey(rentVo.getRentid());
	}

	@Override
	public Rent queryRentByRentId(String rentid) {
		return this.rentMapper.selectByPrimaryKey(rentid);
	}
}
