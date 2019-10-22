package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.News;
import com.sxt.sys.vo.NewsVo;

public interface NewsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(News record);

    int insertSelective(News record);

    News selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(News record);

    int updateByPrimaryKey(News record);
    
    /**
     * 全查询
     */
    List<News> queryAllNews(NewsVo newsVo);
}