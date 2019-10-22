package com.sxt.sys.service;

import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LogInfoVo;

public interface LogInfoService {

	void addLogInfo(LogInfoVo infoVo);

	DataGridView queryAllLogInfo(LogInfoVo infoVo);

	void deleteLogInfo(LogInfoVo infoVo);

}
