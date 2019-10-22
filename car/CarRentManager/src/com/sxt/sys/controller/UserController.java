package com.sxt.sys.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sxt.sys.constast.SYS_Constast;
import com.sxt.sys.domain.Role;
import com.sxt.sys.domain.User;
import com.sxt.sys.service.LogInfoService;
import com.sxt.sys.service.RoleService;
import com.sxt.sys.service.UserService;
import com.sxt.sys.utils.DataGridView;
import com.sxt.sys.utils.tree.TreeNode;
import com.sxt.sys.vo.LogInfoVo;
import com.sxt.sys.vo.UserVo;

/**
 * 用户管理控制器
 * @author Administrator
 *
 */
@Controller
@RequestMapping("user")
public class UserController {


	@Autowired
	private UserService userService;
	
	@Autowired
	private LogInfoService logInfoService;
	
	@Autowired
	private RoleService roleService;
	
	
	/**
	 * 跳转到登陆页面
	 */
	@RequestMapping("toLogin")
	public String toLogin(){
		return "system/login";
	}
	/**
	 * 登陆
	 */
	@RequestMapping("login")
	public String login(UserVo userVo,HttpSession session,Model model,HttpServletRequest request){
		User user=userService.login(userVo);
		if(null!=user){
			session.setAttribute("user", user);
			//加入登陆日志
			LogInfoVo infoVo=new LogInfoVo();
			infoVo.setLogintime(new Date());
			infoVo.setLoginip(request.getRemoteAddr());
			infoVo.setLoginname("登陆账号:"+user.getLoginname()+" 真实姓名:"+user.getRealname());
			logInfoService.addLogInfo(infoVo);
			return "system/index";
		}else{
			model.addAttribute("error", "用户名或密码不正确");
			return "system/login";
		}
	}
	
	
	/****************用户管理开始******************/
	/**
	 * 跳转到用户管理的页面
	 */
	@RequestMapping("toUserManager")
	public String toUserManager(){
		return "system/userManager";
	}
	
	/**
	 * 加载用户列表数据
	 */
	@RequestMapping("loadUsers")
	@ResponseBody
	public DataGridView loadUsers(UserVo userVo){
		return this.userService.queryAllUsers(userVo);
	}
	
	
	/**
	 * 添加用户
	 */
	@RequestMapping("addUser")
	@ResponseBody
	public Map<String, Object> addUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "添加成功";
		try {
			//设置默认密码
			userVo.setPwd(SYS_Constast.USER_DEFAULT_PWD);
			userService.addUser(userVo);
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
	 * 修改用户
	 */
	@RequestMapping("updateUser")
	@ResponseBody
	public Map<String, Object> updateUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "修改成功";
		try {
			userService.updateUser(userVo);
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
	 * 删除用户
	 */
	@RequestMapping("deleteUser")
	@ResponseBody
	public Map<String, Object> deleteUser(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "删除成功";
		try {
			userService.deleteUser(userVo);
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
	 * 用户密码重置
	 */
	@RequestMapping("resetUserPwd")
	@ResponseBody
	public Map<String, Object> resetUserPwd(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "重置成功";
		try {
			userVo.setPwd(SYS_Constast.USER_DEFAULT_PWD);
			userService.updateUserPwd(userVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "重置失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}

	
	/****************用户管理结束******************/
	/****************用户分配角色开始*****************/
	@RequestMapping("loadselectRolesTree")
	@ResponseBody
	public List<TreeNode> loadselectRolesTree(UserVo userVo){
		//1,根据用户id查询sys_role_user表里面的角色
		List<Role> userRoles=this.roleService.queryRolesByUserId(userVo.getUserid());
		//2,查询所有角色
		List<Role> allRoles=this.roleService.queryAllRoles();
		List<TreeNode> nodes=new ArrayList<>();
		for (Role r : allRoles) {
			Boolean checked=false;//默认不选中
			for (Role r2 : userRoles) {
				if(r.getRoleid()==r2.getRoleid()){
					checked=true;
					break;
				}
			}
			//此时的角色没有层级关系所以pid=0
			nodes.add(new TreeNode(r.getRoleid(), 0, r.getRolename(), true, "../resources/css/icons/FUNC20001.gif", checked));
		}
		return nodes;
	}
	
	/**
	 * 保存用户我角色之间的关系
	 */
	@ResponseBody
	@RequestMapping("saveUserRoles")
	public Map<String, Object> saveUserRoles(UserVo userVo) {
		Map<String, Object> map = new HashMap<>();
		String status = "success";
		String msg = "分配成功";
		try {
			userService.saveUserRoles(userVo);
		} catch (Exception e) {
			e.printStackTrace();
			status = "error";
			msg = "分配失败";
		}
		map.put("status", status);
		map.put("msg", msg);
		return map;

	}
	
	/****************用户分配角色结束*****************/
}
