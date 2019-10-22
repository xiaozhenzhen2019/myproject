package com.sxt.bus.mapper;

import java.util.List;

import com.sxt.bus.domain.Car;

public interface CarMapper {
    int deleteByPrimaryKey(String carnumber);

    int insert(Car record);

    int insertSelective(Car record);

    Car selectByPrimaryKey(String carnumber);

    int updateByPrimaryKeySelective(Car record);

    int updateByPrimaryKey(Car record);
    
    /**
     * 查询
     */
    List<Car> queryAllCars(Car car);
}