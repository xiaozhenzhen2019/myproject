package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.News;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.NewsVo;

public interface NewsService {

	DataGridView queryAllNewss(NewsVo newsVo);

	void addNews(NewsVo newsVo);

	void updateNews(NewsVo newsVo);

	void deleteNews(NewsVo newsVo);

	News queryNewsById(Integer id);

	List<News> queryAllNews();

}
