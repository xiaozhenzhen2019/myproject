<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>日志管理</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/zTree/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/wu.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/zTree/js/jquery.ztree.core.js"></script>


  </head>
  <body>
    	<div class="easyui-panel" title="日志搜索" iconCls="icon-search" style="padding: 10px;text-align: center;">
    		 <form id="searchForm" method="post">
	    		用户登陆名:
	    		<input class="easyui-textbox"  id="loginname" name="loginname" data-options="prompt:'请输入登陆名或真实姓名'" style="width:20%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;开始时间:
	    		<input class="easyui-datetimebox" id="startDate" name="startDate" style="width:20%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;结束时间:
	    		<input class="easyui-datetimebox" id="endDate" name="endDate" style="width:20%;">
	    		<br>
	    		<br>
	    		 <a href="javascript:void(0)" iconCls="icon-search" class="easyui-linkbutton" onclick="doSearch()" style="width:80px">查询</a>
	             <a href="javascript:void(0)" iconCls="icon-cancel" class="easyui-linkbutton" onclick="resetForm()" style="width:80px">重置</a>
    		</form>
    	</div>
    	<!-- 数据表格 -->
    	<br>
    	<table id="dg"></table>
    	<div id="tb">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove',plain:true" onclick="destoryLogInfo()">删除日志</a>
		</div>
  </body>
  <script type="text/javascript">
//初始化数据
	$("#dg").datagrid({
		title:'日志列表',
		iconCls:'icon-save',
		url:'${pageContext.request.contextPath}/logInfo/loadLogInfos.action',
		singleSelect:true,  //是否支持单行选中
		method:'get',  //请求方式
		fitColumns:true,  //是否自动分配列
		toolbar:'#tb',   //工具条的div  id
		rownumbers:true,  //是否显示行号
		pagination:true,  //是否启用分页
		columns:[[
		        {field:'id',title:'日志 ID',width:100,align:'center'},
		        {field:'loginname',title:'登陆用户',width:100,align:'center'},
		        {field:'loginip',title:'登陆IP',width:100,align:'center'},
		        {field:'logintime',title:'登陆时间',width:100,align:'center'}
		    ]]
	});
	
	function doSearch(){
		var params=$("#searchForm").serialize();
		//alert(params);
		$("#dg").datagrid({
			url:"${pageContext.request.contextPath}/logInfo/loadLogInfos.action?"+params
		});
		
	}
	function resetForm(){
		$("#searchForm").form("clear");
	}
	
	function destoryLogInfo(){
		//得到选中行
		 var row = $('#dg').datagrid('getSelected');
         if (row){
             $.messager.confirm('提示','你确定要删除这条日志吗?',function(r){
                 if (r){
                     $.post('${pageContext.request.contextPath}/logInfo/deleteLogInfo.action',{id:row.id},function(result){
                         if (result.status==="success"){
                             $('#dg').datagrid('reload');   
                         } else {
                             $.messager.show({    // show error message
                                 title: '提示',
                                 msg: result.msg
                             });
                         }
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
