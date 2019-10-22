<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>角色管理</title>
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
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;text-align: center;">
    		 <form id="searchForm" method="post">
	    		角色名称:
	    		<input class="easyui-textbox"  name="rolename" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;角色备注:
	    		<input class="easyui-textbox"  name="roledesc" style="width:25%;">
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newRole()">添加角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editRole()">修改角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyRole()">删除角色</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-application" plain="true" onclick="selectRoleMenu()">分配菜单</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
                <input name="roleid" id="roleid" type="hidden">
            </div>
            <div style="margin-bottom:10px">
                <input name="rolename" class="easyui-textbox" required="true" label="角色名称:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="roledesc" class="easyui-textbox"  label="角色备注:" style="width:100%">
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRole()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <!-- 分配菜单的弹出框开始 -->
     <div id="dlg2" class="easyui-dialog" style="width:300px;height: 500px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg2-buttons'">
       <div class="ztree" id="treeMenus" data-options="border:false,fit:true">  </div>
    </div>
    <div id="dlg2-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRoleMenus()" style="width:90px">确认分配</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg2').dialog('close')" style="width:90px">取消</a>
    </div>
    <!-- 分配菜单的弹出框结束 -->
    
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'角色列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/role/loadRoles.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'roleid',title:'角色编号',width:100,align:'center'},
			        {field:'rolename',title:'角色名称',width:100,align:'center'},
			        {field:'roledesc',title:'角色备注',width:100,align:'center'}
			    ]]
		});
    
        var url;
        function newRole(){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加角色');
            $('#fm').form('clear');
            url = '${pageContext.request.contextPath}/role/addRole.action';
        }
        function editRole(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改角色');
                //此时row 代表的是这一行数据的{json}对象
                //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/role/updateRole.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveRole(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the Role data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyRole(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.rolename+'】的角色信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/role/deleteRole.action',{roleid:row.roleid},function(result){
                              $('#dg').datagrid('reload');    // reload the Role data
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
    			url:"${pageContext.request.contextPath}/role/loadRoles.action?"+params
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
    	function selectRoleMenu(){
    		//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg2').dialog('open').dialog('center').dialog('setTitle','分配菜单');
                //请求后台，返回一个json 使用这个json去初始化树
                $.post("${pageContext.request.contextPath}/role/loadselectMenusTree.action",{roleid:row.roleid},function(zNodes){
    				$.fn.zTree.init($("#treeMenus"), setting, zNodes);
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
    	function saveRoleMenus(){
    		//取到roleid
    		var roleid=$('#dg').datagrid('getSelected').roleid;
    		//得到menuids  所有选中的菜单id
    		var params="roleid="+roleid;  //user.action?roleid=1&
    		var treeObj = $.fn.zTree.getZTreeObj("treeMenus");
    		var nodes = treeObj.getCheckedNodes(true);
    		for(var i=0;i<nodes.length;i++){
				params+="&menuids="+nodes[i].id;    			
    		}
    		 $.post('${pageContext.request.contextPath}/role/saveRoleMenus.action?'+params,function(result){
                  $.messager.show({    
                      title: '提示',
                      msg: result.msg
                  });
            },'json');
    	}
    </script>
</body>
</html>