package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.LogInfo;
import com.sxt.sys.mapper.LogInfoMapper;
import com.sxt.sys.service.LogInfoService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.LogInfoVo;
@Service
public class LogInfoServiceImpl implements LogInfoService{

	@Autowired
	private LogInfoMapper logInfoMapper;

	@Override
	public void addLogInfo(LogInfoVo infoVo) {
		this.logInfoMapper.insert(infoVo);
	}

	@Override
	public DataGridView queryAllLogInfo(LogInfoVo infoVo) {
		Page<Object> page=PageHelper.startPage(infoVo.getPage(), infoVo.getRows());
		List<LogInfo> list = this.logInfoMapper.queryAllLonInfos(infoVo);
		DataGridView dataGridView=new DataGridView();
		dataGridView.setRows(list);
		dataGridView.setTotal(page.getTotal());
		return dataGridView;
	}

	@Override
	public void deleteLogInfo(LogInfoVo infoVo) {
		this.logInfoMapper.deleteByPrimaryKey(infoVo.getId());
	}
	
	
}
