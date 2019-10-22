<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>菜单管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
 	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/zTree/js/jquery.ztree.core.js"></script>
 	
  </head>
  
  <body style="margin: 0px;padding: 0px">
  	<div class="easyui-layout" style="width: 100%;height: 100%">
  		<div class="easyui-panel" style="width: 20%;height: 100%" data-options="region:'west',title:'菜单树',iconCls:'icon-save'">
			<div class="ztree" id="treeMenus" data-options="border:false,fit:true">  </div>
  		</div>
  		<div class="easyui-panel" style="width: 80%;height: 100%" data-options="region:'center',title:'菜单列表',iconCls:'icon-user'">
  			<table id="dg"></table>
  			 <div id="toolbar">
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newMenu()">添加菜单</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editMenu()">修改菜单</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyMenu()">删除菜单</a>
		    </div>
		  	<!-- 弹出框开始 -->
		  	 <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
		        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
		            <div style="margin-bottom:10px">
		                <input name="id" id="id" type="hidden" >
		           		<input class="easyui-combotree" name="pid" id="pid" data-options="url:'${pageContext.request.contextPath}/menu/loadAvailableMenus.action',method:'get',label:'父级菜单:'" style="width:100%">
		            </div>
		            <div style="margin-bottom:10px">
		                <input name="name" class="easyui-textbox" required="true" label="菜单名称:" style="width:100%">
		            </div>
		            <div style="margin-bottom:10px">
		                <input name="href" class="easyui-textbox" label="菜单地址:" style="width:100%">
		            </div>
		            <div style="margin-bottom:10px">
		                <input name="target" class="easyui-textbox" label="TARGET:" style="width:100%">
		            </div>
		            <div style="margin-bottom:10px">
		                <input name="icon" class="easyui-textbox"  label="菜单图标:" style="width:100%">
		            </div>
		            <div style="margin-bottom:10px">
		                <input name="tabicon" class="easyui-textbox" label="TAB图标:" style="width:100%">
		            </div>
		             <div style="margin-bottom:10px">
						<label class="textbox-label">是否展开:</label>
						<input type="radio" value="1" name="open">是
						<input type="radio" value="0" name="open">否
		            </div>
		            <div style="margin-bottom:10px">
						<label class="textbox-label">是否父节点:</label>
						<input type="radio" value="1" name="parent">是
						<input type="radio" value="0" name="parent">否
		            </div>
		            <div style="margin-bottom:10px">
						<label class="textbox-label">是否可用:</label>
						<input type="radio" value="1" name="available">是
						<input type="radio" value="0" name="available">否
		            </div>
		        </form>
		    </div>
		    <div id="dlg-buttons">
		        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveMenu()" style="width:90px">保存</a>
		        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
		    </div>
  			<!-- 弹出框结束-->
  		</div>
  	</div>
  </body>
  
  <script type="text/javascript">
  	//加载左边的菜单树
  	//event代表的是回调事件onClick
    	//treeId:存放这个树型菜单的DIV的ID
    	//treeNode:指当前被点击的节点的json对象
		function zTreeOnClick(event, treeId, treeNode) {
			$("#dg").datagrid({
				url:"${pageContext.request.contextPath}/menu/loadMenus.action?id="+treeNode.id
			});
		};
		var setting = {
			data: {
				simpleData: {
					enable: true
				}
			},
			callback: {
				//当点击树节点的时候触发的js事件
				onClick: zTreeOnClick
			}
		};
		
		function initTree(){
			$.post("${pageContext.request.contextPath}/menu/loadMenuManagerLeftTree.action",function(zNodes){
				$.fn.zTree.init($("#treeMenus"), setting, zNodes);
			});
		}
			//文档加载事件
		$(document).ready(function(){
			initTree();
		});
			
		/****
		加载右边的菜单列表
		*/
		 //加载数据
   	 $("#dg").datagrid({
			url:'${pageContext.request.contextPath}/menu/loadMenus.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			height:'100%',
			width:'100%',
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'id',title:'菜单ID',align:'center'},
			        {field:'pid',title:'父ID',align:'center'},
			        {field:'name',title:'菜单名称',align:'left'},
			        {field:'href',title:'地址',align:'left'},
			        {field:'open',title:'是否打开',align:'center',formatter:function(value,row,index){
			        	return value==1?'<font color=blue>是</font>':'<font color=red>否</font>';
			        }},
			        {field:'parent',title:'是否父节点',align:'center',formatter:function(value,row,index){
			        	return value==1?'<font color=blue>是</font>':'<font color=red>否</font>';
			        }},
			        {field:'target',title:'TARGET',align:'center'},
			       /*  {field:'icon',title:'图标',align:'center'}, */
			         {field:'icon',title:'图标样式',align:'left',formatter:function(value,row,index){
			        	var v=value.substr(1,value.length);
			        	return "<img src='"+v+"' />"+"-"+value;
			        }}, 
			        {field:'tabicon',title:'TAB图标',align:'center'}
			    ]]
		});
		
		
   	 var url;
     function newMenu(){
         $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加菜单');
         $('#fm').form('clear');
         url = '${pageContext.request.contextPath}/menu/addMenu.action';
     }
     function editMenu(){
     	//得到当前用户的选中行的数据  
         var row = $('#dg').datagrid('getSelected');
         if (row){
             $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改菜单');
             //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
             $('#fm').form('load',row);
             url = '${pageContext.request.contextPath}/menu/updateMenu.action';
         }else{
         	  $.messager.show({
                   title: '提示',
                   msg: '请选中操作行'
               });
         }
     }
     function saveMenu(){
         $('#fm').form('submit',{
             url: url,
             onSubmit: function(){
                 return $(this).form('validate');
             },
             success: function(result){
             	var res=eval('('+result+')');
                 $('#dlg').dialog('close');        // close the dialog
                 $('#dg').datagrid('reload');    // reload the Menu data
                 //刷新左边的菜单树
                 initTree();
                 $.messager.show({
                     title: '提示',
                     msg: res.msg
                 });
             }
         });
     }
     function destroyMenu(){
     	//得到选中行
         var row = $('#dg').datagrid('getSelected');
         if (row){
             $.messager.confirm('提示','你确定要删除【'+row.name+'】的菜单信息吗?',function(r){
                 if (r){
                     $.post('${pageContext.request.contextPath}/menu/deleteMenu.action',{id:row.id},function(result){
                           $('#dg').datagrid('reload');    // reload the Menu data
                           //刷新左边的菜单树
                           initTree();
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
			
		
  </script>
</html>
