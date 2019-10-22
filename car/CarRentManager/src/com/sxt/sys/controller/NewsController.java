package com.sxt.sys.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.domain.News;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.NewsService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.NewsVo;

@Controller
@RequestMapping("news")
public class NewsController {
	@Autowired
	private NewsService newsService;
	/**
	 * 跳转到system/newsManager.jsp
	 */
	@RequestMapping("toNewsManager")
	public String toNewsManager(){
		return "system/newsManager";
	}
	/**
	 * 加载所有的新闻
	 */
	@RequestMapping("loadNews")
	@ResponseBody
	public DataGridView loadNews(NewsVo newsVo){
		return this.newsService.queryAllNewss(newsVo);
	}
	
	
	/**
	 * 添加新闻
	 */
	@RequestMapping("addNews")
	@ResponseBody
	public Map<String,Object> addNews(NewsVo newsVo,HttpSession session){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="添加成功";
		try {
			newsVo.setCreatetime(new Date());
			User user=(User) session.getAttribute("user");
			newsVo.setOpername(user.getRealname());
			newsService.addNews(newsVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	/**
	 * 修改新闻
	 */
	@RequestMapping("updateNews")
	@ResponseBody
	public Map<String,Object> updateNews(NewsVo newsVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="修改成功";
		try {
			newsService.updateNews(newsVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	/**
	 * 删除新闻
	 */
	@RequestMapping("deleteNews")
	@ResponseBody
	public Map<String,Object> deleteNews(NewsVo newsVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="删除成功";
		try {
			newsService.deleteNews(newsVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
		
	}
	
	
	/**
	 * 加载工作台的l新闻
	 */
	@RequestMapping("deskInitloadNews")
	public String deskInitloadNews(Model model){
		List<News> news=this.newsService.queryAllNews();
		model.addAttribute("news", news);
		return "system/deskNews";
	}
	
}
