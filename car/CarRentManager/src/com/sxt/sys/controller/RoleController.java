package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.domain.Menu;
import com.sxt.sys.service.MenuService;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.tree.TreeNode;
import com.sxt.sys.vo.RoleVo;

@Controller
@RequestMapping("role")
public class RoleController {
	@Autowired
	private RoleService roleService;
	@Autowired
	private MenuService menuService;

	/**
	 * 跳转到system/roleManager.jsp
	 */
	@RequestMapping("toRoleManager")
	public String toRoleManager() {
		return "system/roleManager";
	}

	/**
	 * 加载所有的角色
	 */
	@RequestMapping("loadRoles")
	@ResponseBody
	public DataGridView loadRoles(RoleVo roleVo) {
		return this.roleService.queryAllRoles(roleVo);
	}

	/**
	 * 添加角色
	 */
	@RequestMapping("addRole")
	@ResponseBody
	public Map<String, Object> addRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "添加成功";
		try {
			roleService.addRole(roleVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "添加失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}

	/**
	 * 修改角色
	 */
	@RequestMapping("updateRole")
	@ResponseBody
	public Map<String, Object> updateRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "修改成功";
		try {
			roleService.updateRole(roleVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "修改失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}

	/**
	 * 删除角色
	 */
	@RequestMapping("deleteRole")
	@ResponseBody
	public Map<String, Object> deleteRole(RoleVo roleVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			roleService.deleteRole(roleVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "删除失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}

	/**
	 * 加载分配菜单的树
	 */
	@RequestMapping("loadselectMenusTree")
	@ResponseBody
	public List<TreeNode> loadselectMenusTree(RoleVo roleVo) {

		List<TreeNode> nodes = new ArrayList<>();
		// 1,先根据roleid查询这个角色之前有的菜单集合
		List<Menu> rolemenus = this.menuService.queryMenusByRoleId(roleVo
				.getRoleid());
//		List<Menu> rolemenus = new ArrayList<>();
		// 2,查询当前可用的所有菜单集合
		List<Menu> availableMenus = this.menuService.queryAvailableMenus();
		for (Menu menu : availableMenus) {
			Boolean checked = false;
			for (Menu m2 : rolemenus) {
				if (menu.getId() == m2.getId()) {
					checked = true;
					break;
				}
			}
			nodes.add(new TreeNode(menu.getId(), menu.getPid(), menu.getName(),
					menu.getOpen() == 1 ? true : false, menu.getIcon(), checked));
		}
		return nodes;

	}
	
	/**8
	 * 保存角色和菜单之间的关系
	 */
	@RequestMapping("saveRoleMenus")
	@ResponseBody
	public Map<String,Object> saveRoleMenus(RoleVo roleVo){
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "分配成功";
		try {
			roleService.saveRoleMenus(roleVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "分配失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;
	}

}
