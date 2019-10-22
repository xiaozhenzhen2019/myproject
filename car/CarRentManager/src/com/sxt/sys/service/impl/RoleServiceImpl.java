package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.Role;
import com.sxt.sys.mapper.RoleMapper;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.RoleVo;
@Service
public class RoleServiceImpl implements RoleService{

	@Autowired
	private RoleMapper roleMapper;

	@Override
	public DataGridView queryAllRoles(RoleVo roleVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Object> page = PageHelper.startPage(roleVo.getPage(), roleVo.getRows());
		List<Role> list=this.roleMapper.queryAllRoles(roleVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void addRole(RoleVo roleVo) {
		this.roleMapper.insert(roleVo);
	}

	@Override
	public void updateRole(RoleVo roleVo) {
		this.roleMapper.updateByPrimaryKey(roleVo);
	}

	@Override
	public void deleteRole(RoleVo roleVo) {
		this.roleMapper.deleteByPrimaryKey(roleVo.getRoleid());
		
	}

	/**
	 * 保存角色菜单之间的关系
	 */
	@Override
	public void saveRoleMenus(RoleVo roleVo) {
		Integer roleid=roleVo.getRoleid();
		//删除之前的分配的菜单   [因为不删除的话下次再分配 会有主键重复]
		this.roleMapper.deleteRoleMenuByRoleId(roleid);
		//取到菜单id的数组
		Integer[] menuids=roleVo.getMenuids();
		if(menuids!=null){
			for (int i = 0; i < menuids.length; i++) {
				this.roleMapper.saveRoleMenus(roleid,menuids[i]);
			}
		}
	}

	@Override
	public List<Role> queryRolesByUserId(Integer userid) {
		return this.roleMapper.queryRolesByUserId(userid);
	}

	@Override
	public List<Role> queryAllRoles() {
		return roleMapper.queryAllRoles(new Role());
	}
	
}
