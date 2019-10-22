package com.sxt.sys.vo;

import com.sxt.sys.domain.User;

public class UserVo extends User{
	
	//接收角色的数组
	private Integer [] roleids;
	
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

	public Integer[] getRoleids() {
		return roleids;
	}

	public void setRoleids(Integer[] roleids) {
		this.roleids = roleids;
	}

}
