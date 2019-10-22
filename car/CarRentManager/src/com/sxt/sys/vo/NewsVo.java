package com.sxt.sys.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.sxt.sys.domain.News;

public class NewsVo extends News{

	//分页使用
	private Integer page;
	private Integer rows;
	
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date startDate;
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private Date endDate;
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
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
