package com.sxt.bus.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sxt.bus.mapper.TjfxMapper;
import com.sxt.bus.service.TjfxService;
import com.sxt.bus.vo.PieVo;

@Service
public class TjfxServiceImpl implements TjfxService{
	
	
	@Autowired
	private TjfxMapper tjfxMapper;
	

	@Override
	public List<PieVo> countCustomerArea() {
		return tjfxMapper.countCustomerArea();
	}

}
