package com.sxt.sys.utils;

import java.util.List;

/**
 * 按easyui的表格要求的数据形式去封装对象
 *
 */
public class DataGridView {
	
	private Long total;
	
	private List<?>   rows;

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}
	
	

}
