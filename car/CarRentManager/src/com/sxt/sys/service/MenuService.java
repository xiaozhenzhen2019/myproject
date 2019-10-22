package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.Menu;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.MenuVo;

public interface MenuService {
	
	void addMenu(Menu menu);

	List<Menu> queryAvailableMenus();

	List<Menu> queryAllMenus();

	DataGridView loadMenus(MenuVo menuVo);

	void updateMenu(MenuVo menuVo);

	void deleteMenu(MenuVo menuVo);

	List<Menu> queryMenusByRoleId(Integer roleid);

	List<Menu> queryMenusByUserId(Integer userid);

}
