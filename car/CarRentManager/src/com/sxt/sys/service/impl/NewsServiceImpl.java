package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.News;
import com.sxt.sys.mapper.NewsMapper;
import com.sxt.sys.service.NewsService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.NewsVo;

@Service
public class NewsServiceImpl implements NewsService {

	@Autowired
	private NewsMapper newsMapper;

	@Override
	public DataGridView queryAllNewss(NewsVo newsVo) {
		DataGridView dataGridView=new DataGridView();
		Page<News> page=PageHelper.startPage(newsVo.getPage(), newsVo.getRows());
		List<News> list=this.newsMapper.queryAllNews(newsVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void addNews(NewsVo newsVo) {
		this.newsMapper.insert(newsVo);
	}

	@Override
	public void updateNews(NewsVo newsVo) {
		this.newsMapper.updateByPrimaryKey(newsVo);
	}

	@Override
	public void deleteNews(NewsVo newsVo) {
		this.newsMapper.deleteByPrimaryKey(newsVo.getId());
	}

	@Override
	public News queryNewsById(Integer id) {
		return this.newsMapper.selectByPrimaryKey(id);
	}

	@Override
	public List<News> queryAllNews() {
		return this.newsMapper.queryAllNews(new NewsVo());
	}
	
}
