package com.sxt.sys.service;

import java.util.List;

import com.sxt.sys.domain.Role;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.RoleVo;

public interface RoleService {

	DataGridView queryAllRoles(RoleVo roleVo);

	void addRole(RoleVo roleVo);

	void updateRole(RoleVo roleVo);

	void deleteRole(RoleVo roleVo);

	void saveRoleMenus(RoleVo roleVo);

	List<Role> queryRolesByUserId(Integer userid);

	List<Role> queryAllRoles();

}
