package com.sxt.sys.vo;

import com.sxt.sys.domain.Role;

public class RoleVo extends Role {
	
	//接收菜单的数组
	private Integer [] menuids;
	
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

	public Integer[] getMenuids() {
		return menuids;
	}

	public void setMenuids(Integer[] menuids) {
		this.menuids = menuids;
	}

}
