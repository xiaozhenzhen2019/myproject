package com.sxt.bus.vo;

public class PieVo {
	private String name;
	private Double y;
	private Boolean sliced=false;
	private Boolean selected=false;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getY() {
		return y;
	}
	public void setY(Double y) {
		this.y = y;
	}
	public Boolean getSliced() {
		return sliced;
	}
	public void setSliced(Boolean sliced) {
		this.sliced = sliced;
	}
	public Boolean getSelected() {
		return selected;
	}
	public void setSelected(Boolean selected) {
		this.selected = selected;
	}
	
	
	
}
