package com.sxt.bus.constast;

public interface BUS_Constast {
	
	/**
	 * 出租单和检查单的前缀
	 */
	String BUS_CZ_PREFIX="CZ";
	String BUS_JC_PREFIX="JC";
	
	/**
	 * 车辆的归还和出租状态
	 */
	Integer CAR_RENTINGFLAG_YES=1;//已归还     已出租
	Integer CAR_RENTINGFLAG_NO=0;//未归还       未出租
	
	
}
