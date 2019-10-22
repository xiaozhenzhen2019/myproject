package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.Role;

public interface RoleMapper {
    int deleteByPrimaryKey(Integer roleid);

    int insert(Role record);

    int insertSelective(Role record);

    Role selectByPrimaryKey(Integer roleid);

    int updateByPrimaryKeySelective(Role record);

    int updateByPrimaryKey(Role record);
    
    List<Role> queryAllRoles(Role record);

	void saveRoleMenus(Integer rid, Integer mid);

	void deleteRoleMenuByRoleId(Integer roleid);

	List<Role> queryRolesByUserId(Integer userid);

}