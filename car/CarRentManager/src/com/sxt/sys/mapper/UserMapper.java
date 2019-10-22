package com.sxt.sys.mapper;

import java.util.List;

import com.sxt.sys.domain.User;

public interface UserMapper {
    int deleteByPrimaryKey(Integer userid);

    int insert(User record);

    int insertSelective(User record);

    User selectByPrimaryKey(Integer userid);

    int updateByPrimaryKeySelective(User record);

    int updateByPrimaryKey(User record);
    
    User login(User user);
    
    /**
     * 全查询
     */
    List<User> queryAllUsers(User user);

    /**
     * 根据用户id删除sys_role_user里面的数据
     * @param userid
     */
	void deleteRolesByUserId(Integer userid);

	/**
	 * 向sys_role_user里面添加数据
	 * @param userid
	 * @param roleid
	 */
	void saveUserRoles(Integer userid, Integer roleid);
}