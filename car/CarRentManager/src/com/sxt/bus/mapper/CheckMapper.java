package com.sxt.bus.mapper;

import java.util.List;

import com.sxt.bus.domain.Check;
import com.sxt.bus.vo.CheckVo;

public interface CheckMapper {
    int deleteByPrimaryKey(String checkid);

    int insert(Check record);

    int insertSelective(Check record);

    Check selectByPrimaryKey(String checkid);

    int updateByPrimaryKeySelective(Check record);

    int updateByPrimaryKey(Check record);
    
    /**
     * 全查询
     */
    List<Check> queryAllChecks(CheckVo checkVo);
}