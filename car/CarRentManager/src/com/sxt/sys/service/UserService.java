package com.sxt.sys.service;

import com.sxt.sys.domain.User;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.UserVo;

public interface UserService {

	User login(UserVo userVo);

	DataGridView queryAllUsers(UserVo userVo);

	void addUser(UserVo userVo);

	void updateUser(UserVo userVo);

	void deleteUser(UserVo userVo);

	void updateUserPwd(UserVo userVo);

	void saveUserRoles(UserVo userVo);

}
