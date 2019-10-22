package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.Menu;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    
    /**
     * sys_menus表可用的数据
     * @param record
     * @return
     */
    List<Menu> queryAvailableMenus();
    
    /**
     * sys_menus表所有的数据
     * @param record
     * @return
     */
    List<Menu> queryAllMenus();

    
    /**
     * 查询id=id   pid=id的菜单数据
     * @param id
     * @return
     */
	List<Menu> queryAllMenusUseIdAndPid(Integer id);
	
	
	/**
	 * 根据角色编号查询菜单
	 */
	List<Menu> queryMenusByRoleId(Integer roleid);

	/**
	 * 根据用户id查询菜单
	 * @param userid
	 * @return
	 */
	List<Menu> queryMenusByUserId(Integer userid);
}