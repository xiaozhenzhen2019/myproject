<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>用户管理</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/zTree/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/zTree/js/jquery.ztree.excheck.min.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;">
    		 <form id="searchForm" method="post">
	    		身份证号:
	    		<input class="easyui-textbox"   name="identity"  style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;用户姓名:
	    		<input class="easyui-textbox"  name="realname" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;登陆名称:
	    		<input class="easyui-textbox"  name="loginname" style="width:25%;">
	    		<br>
	    		<br>
	    		用户电话:
	    		<input class="easyui-textbox"  name="phone" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;用户职位:
	    		<input class="easyui-textbox"  name="position" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;用户地址:
	    		<input class="easyui-textbox"  name="address" style="width:25%;">
	    		<br>
	    		<br>
	    		 <div style="text-align: center;">
	    		 <a href="javascript:void(0)" iconCls="icon-search" class="easyui-linkbutton" onclick="doSearch()" style="width:80px">查询</a>
	             <a href="javascript:void(0)" iconCls="icon-cancel" class="easyui-linkbutton" onclick="resetForm()" style="width:80px">重置</a>
	    		 </div>
    		</form>
    	</div>
    	
    <table id="dg"> </table>
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">添加用户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">修改用户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyUser()">删除用户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="resetUserPwd()">重置密码</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-application" plain="true" onclick="selectUserRole()">分配角色</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
            	<input type="hidden" name="userid">
            	<input type="hidden" name="pwd">
                <input name="loginname" id="loginname" class="easyui-textbox" required="true" label="登陆名:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="realname" class="easyui-textbox" required="true" label="真实姓名:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="identity" class="easyui-textbox" required="true" label="身份证号:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="address" class="easyui-textbox" required="true" label="用户地址:" style="width:100%">
            </div>
             <div style="margin-bottom:10px">
                <input name="phone" class="easyui-textbox" required="true" label="用户电话:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="position" class="easyui-textbox" required="true" label="用户职位:" style="width:100%">
            </div>
             <div style="margin-bottom:10px">
				<label class="textbox-label">用户性别:</label>
				<input type="radio" value="1" name="sex">男
				<input type="radio" value="0" name="sex">女
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUser()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
      <!-- 分配角色的弹出框开始 -->
     <div id="dlg2" class="easyui-dialog" style="width:300px;height: 500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
       <div class="ztree" id="treeRoles" data-options="border:false,fit:true">  </div>
    </div>
    <div id="dlg2-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveUserRoles()" style="width:90px">确认分配</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')" style="width:90px">取消</a>
    </div>
    <!-- 分配角色的弹出框结束 -->
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'用户列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/user/loadUsers.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'userid',title:'用户编号',width:100,align:'center'},
			        {field:'identity',title:'身份证号',width:100,align:'center'},
			        {field:'loginname',title:'登陆名',width:100,align:'center'},
			        {field:'realname',title:'真实姓名',width:100,align:'center'},
			        {field:'sex',title:'性别',width:100,align:'center',formatter:function(value,row,index){
			        	return value==1?'男':'女';
			        }},
			        {field:'address',title:'地址',width:100,align:'center'},
			        {field:'phone',title:'电话',width:100,align:'center'},
			        {field:'pwd',title:'密码',width:100,align:'center',formatter:function(value){
			        	return "******";
			        }},
			        {field:'position',title:'职位',width:100,align:'center'},
			    ]]
		});
    
        var url;
        function newUser(){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加用户');
            $('#fm').form('clear');
            url = '${pageContext.request.contextPath}/user/addUser.action';
        }
        function editUser(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改用户');
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/user/updateUser.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveUser(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the User data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyUser(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.realname+'】的用户信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/user/deleteUser.action',{userid:row.userid},function(result){
                              $('#dg').datagrid('reload');    // reload the User data
                              $.messager.show({    // show error message
                                  title: '提示',
                                  msg: result.msg
                              });
                        },'json');
                    }
                });
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        //重置密码
        function resetUserPwd(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要重置【'+row.realname+'】的用户密码吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/user/resetUserPwd.action',{userid:row.userid},function(result){
                              $('#dg').datagrid('reload');    // reload the User data
                              $.messager.show({    // show error message
                                  title: '提示',
                                  msg: result.msg
                              });
                        },'json');
                    }
                });
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        
        function doSearch(){
    		var params=$("#searchForm").serialize();
    		//alert(params);
    		$("#dg").datagrid({
    			url:"${pageContext.request.contextPath}/user/loadUsers.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    	
    	
    	/***
    	复选树的配置
    	
    	****/
    	var setting = {
    			//启用复选框
    			check: {
    				enable: true
    			},
    			data: {
    				simpleData: {
    					enable: true
    				}
    			}
    		};
    	
    	/**
    	打开分配菜单的弹出框
    	**/
    	function selectUserRole(){
    		//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg2').dialog('open').dialog('center').dialog('setTitle','分配菜单');
                //请求后台，返回一个json 使用这个json去初始化树
                $.post("${pageContext.request.contextPath}/user/loadselectRolesTree.action",{userid:row.userid},function(zNodes){
    				$.fn.zTree.init($("#treeRoles"), setting, zNodes);
    			});
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
    	}
    	/*
    	确认分配
    	**/
    	function saveUserRoles(){
    		//取到userid
    		var userid=$('#dg').datagrid('getSelected').userid;
    		//得到roleids  所有选中的角色id
    		var params="userid="+userid;  
    		var treeObj = $.fn.zTree.getZTreeObj("treeRoles");
    		var nodes = treeObj.getCheckedNodes(true);
    		for(var i=0;i<nodes.length;i++){
				params+="&roleids="+nodes[i].id;    			
    		}
    		 $.post('${pageContext.request.contextPath}/user/saveUserRoles.action?'+params,function(result){
                  $.messager.show({    
                      title: '提示',
                      msg: result.msg
                  });
            },'json');
    	}
    </script>
</body>
</html>