package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.domain.Menu;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.MenuService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.tree.ComboTreeBuilder;
import com.sxt.sys.utils.tree.ComboTreeNode;
import com.sxt.sys.utils.tree.TreeNode;
import com.sxt.sys.vo.MenuVo;

@Controller
@RequestMapping("menu")
public class MenuController {
	@Autowired
	private MenuService menuService;
	/**
	 * 加载所有菜单，返回一个json的集合数据给index.jsp的左边的菜单导航用
	 */
	@RequestMapping("loadIndexLeftTree")
	@ResponseBody
	public List<TreeNode> loadIndexLeftTree(HttpSession session){
		//查询所有可用的菜单
		//List<Menu> allAvailable=this.menuService.queryAvailableMenus();
		//最后RBAC讲完之后，应该是根据用户的ID查询用户的角色，再根据角色查询关的菜单
		User user = (User) session.getAttribute("user");
		//根据用户编号查询菜单信息
		List<Menu> currentUserMenus=this.menuService.queryMenusByUserId(user.getUserid());
		List<TreeNode> nodes=new ArrayList<>();
		for (Menu m : currentUserMenus) {
			Boolean open=m.getOpen()==1?true:false;
			Boolean isParent=m.getParent()==1?true:false;
			nodes.add(new TreeNode(m.getId(), m.getPid(), m.getName(), open, isParent, m.getHref(), 
					m.getIcon(), m.getTabicon()));
		}
		return nodes;
	}
	
	
	
	
	/******菜单管理功能开始****/
	/**
	 * 跳转到菜单管理的页面
	 */
	@RequestMapping("toMenuManager")
	public String toMenuManager(){
		return "system/menuManager";
	}
	
	/**
	 *  加载所有菜单，返回一个json的集合数据给menuManager.jsp的左边的菜单导航用
	 * @return
	 */
	@RequestMapping("loadMenuManagerLeftTree")
	@ResponseBody
	public List<TreeNode> loadMenuManagerLeftTree(){
		//查询所有菜单
		List<Menu> allAvailable=this.menuService.queryAllMenus();
		List<TreeNode> nodes=new ArrayList<>();
		for (Menu m : allAvailable) {
			Boolean open=m.getOpen()==1?true:false;
			Boolean isParent=m.getParent()==1?true:false;
			nodes.add(new TreeNode(m.getId(), m.getPid(), m.getName(), open, isParent, m.getHref(), 
					m.getIcon().substring(1, m.getIcon().length()), m.getTabicon()));
		}
		return nodes;
	}
	
	
	/**
	 * 加载所以菜单数据
	 */
	@RequestMapping("loadMenus")
	@ResponseBody
	public DataGridView loadMenus(MenuVo menuVo){
		return this.menuService.loadMenus(menuVo);
	}
	
	
	/**
	 * 加载添加菜单弹出框里面的下拉树里内容
	 */
	@RequestMapping("loadAvailableMenus")
	@ResponseBody
	public List<ComboTreeNode> loadAvailableMenus(){
		//查询所有可用的菜单
		List<Menu> allAvailable=this.menuService.queryAvailableMenus();
		List<ComboTreeNode> nodes=new ArrayList<>();
		for (Menu m : allAvailable) {
			nodes.add(new ComboTreeNode(m.getId(), m.getPid(), m.getName()));
		}
		//构造easyui需要的节点数据
		List<ComboTreeNode> reNodes=ComboTreeBuilder.bulid(nodes, 0);
		return reNodes;
	}
	
	
	/**
	 * 添加菜单的方法
	 */
	@RequestMapping("addMenu")
	@ResponseBody
	public Map<String,Object> addMenu(MenuVo menuVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="添加成功";
		try {
			menuService.addMenu(menuVo);
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
	 * 修改菜单的方法
	 */
	@RequestMapping("updateMenu")
	@ResponseBody
	public Map<String,Object> updateMenu(MenuVo menuVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="修改成功";
		try {
			menuService.updateMenu(menuVo);
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
	 * 删除菜单的方法
	 */
	@RequestMapping("deleteMenu")
	@ResponseBody
	public Map<String,Object> deleteMenu(MenuVo menuVo){
		Map<String,Object> map=new HashMap<>();
		String status="success";
		String msg="删除成功";
		try {
			menuService.deleteMenu(menuVo);
		} catch (Exception e) {
			e.printStackTrace();
			 status="error";
			 msg="删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}
	
	/******菜单管理功能结束****/
	
	
	
	
	
	
	
	
}
