package com.sxt.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.sxt.sys.domain.User;
import com.sxt.sys.mapper.UserMapper;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.vo.UserVo;

@Service
public class UserServiceImpl implements UserService{

	@Autowired
	private UserMapper userMapper;

	@Override
	public User login(UserVo userVo) {
		return userMapper.login(userVo);
	}

	@Override
	public DataGridView queryAllUsers(UserVo userVo) {
		DataGridView dataGridView=new DataGridView();
		Page<Object> page = PageHelper.startPage(userVo.getPage(), userVo.getRows());
		List<User> list=this.userMapper.queryAllUsers(userVo);
		dataGridView.setTotal(page.getTotal());
		dataGridView.setRows(list);
		return dataGridView;
	}

	@Override
	public void addUser(UserVo userVo) {
		
		this.userMapper.insert(userVo);
	}

	@Override
	public void updateUser(UserVo userVo) {
		this.userMapper.updateByPrimaryKey(userVo);
		
	}
	@Override
	public void deleteUser(UserVo userVo) {
		this.userMapper.deleteByPrimaryKey(userVo.getUserid());
	}

	@Override
	public void updateUserPwd(UserVo userVo) {
		this.userMapper.updateByPrimaryKeySelective(userVo);
	}

	@Override
	public void saveUserRoles(UserVo userVo) {
		Integer userid=userVo.getUserid();
		//删除当前用户下的所有角色
		this.userMapper.deleteRolesByUserId(userVo.getUserid());
		//重新添加角色
		Integer [] roleids=userVo.getRoleids();
		if(roleids!=null){
			for (Integer roleid : roleids) {
				//把数据插入到sys_role_user
				this.userMapper.saveUserRoles(userid,roleid);
			}
		}
		
	}
	
}
