package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.Menu;
import com.sxt.sys.mapper.MenuMapper;
import com.sxt.sys.service.MenuService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.MenuVo;

@Service
public class MeunServiceImpl implements MenuService{

	@Autowired
	private MenuMapper menuMapper;
	@Override
	public void addMenu(Menu menu) {
		menuMapper.insert(menu);
	}
	@Override
	public List<Menu> queryAvailableMenus() {
		return this.menuMapper.queryAvailableMenus();
	}
	@Override
	public List<Menu> queryAllMenus() {
		return this.menuMapper.queryAllMenus();
	}
	@Override
	public DataGridView loadMenus(MenuVo menuVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Object> page = PageHelper.startPage(menuVo.getPage(), menuVo.getRows());
		List<Menu>  list=null;
		//判断。如果menusVo里面有id则 就点击菜单管理左边的树请求过来的
		if(menuVo!=null&&menuVo.getId()!=null){
			list=this.menuMapper.queryAllMenusUseIdAndPid(menuVo.getId());
		}else{
			list=this.menuMapper.queryAllMenus();
		}
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}
	@Override
	public void updateMenu(MenuVo menuVo) {
		this.menuMapper.updateByPrimaryKey(menuVo);
	}
	@Override
	public void deleteMenu(MenuVo menuVo) {
		this.menuMapper.deleteByPrimaryKey(menuVo.getId());
	}
	@Override
	public List<Menu> queryMenusByRoleId(Integer roleid) {
		return this.menuMapper.queryMenusByRoleId(roleid);
	}
	@Override
	public List<Menu> queryMenusByUserId(Integer userid) {
		return this.menuMapper.queryMenusByUserId(userid);
	}

}
