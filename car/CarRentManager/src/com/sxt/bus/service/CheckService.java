package com.sxt.bus.service;

import java.util.Map;

import com.sxt.bus.vo.CheckVo;
import com.sxt.sys.utils.DataGridView;

public interface CheckService {

	Map<String, Object> initCheck(String rentid);

	void addCheck(CheckVo checkVo);

	DataGridView queryAllChecks(CheckVo checkVo);

}
