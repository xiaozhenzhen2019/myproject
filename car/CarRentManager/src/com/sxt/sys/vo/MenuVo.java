package com.sxt.sys.vo;

import com.sxt.sys.domain.Menu;

public class MenuVo extends Menu {
	// 分页使用
	private Integer page;
	private Integer rows;

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

}
