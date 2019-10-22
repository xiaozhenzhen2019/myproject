<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>工作台</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/icon.css" />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>

<body>
	<div class="easyui-layout" style="width:100%;height:250px;">
		<div data-options="region:'center',title:'系统公告',iconCls:'icon-ok'" 
			style="height:100%;width:70%">
			 <table id="dg"> </table>
			</div>
		<div
			data-options="region:'east',title:'当前日历',iconCls:'icon-search'"
			style="height:100%;width:30%;">
			 <div class="easyui-calendar" data-options="border:false" style="width:100%;height:100%;"></div>
			</div>
	</div>
	  <div id="dlg" class="easyui-dialog" style="width:1000px;height: 600px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
               <div id="title" style="text-align: center;font-size: 25px;font-weight: bold;"></div>
            </div>
            <hr>
             <div style="margin-bottom:10px;text-align: right;" >
               <span id="opername"></span>
               <span id="createtime" style="margin-left: 30px"></span>
            </div>
            <hr>
            <div style="margin-bottom:10px;">
           		 <div id="content" ></div>
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">关闭</a>
    </div>
	
	<script type="text/javascript">
//加载数据
$("#dg").datagrid({
	border:0,
	url:'${pageContext.request.contextPath}/news/loadNews.action',
	singleSelect:true,  //是否支持单行选中
	method:'get',  //请求方式
	width:'100%',
	height:'100%',
	fitColumns:true,  //是否自动分配列
	rownumbers:true,  //是否显示行号
	pagination:true,  //是否启用分页
	columns:[[
	        {field:'title',title:'新闻标题',width:100,align:'center'},
	        {field:'createtime',title:'发布时间',width:100,align:'center'},
	        {field:'opername',title:'发布人',width:100,align:'center'},
	    ]],
	onDblClickRow:function(index,row){
		showNew(row);
	}
});

function showNew(row){
	 $('#dlg').dialog('open').dialog('center').dialog('setTitle','新闻内容');
	 $("#title").html(row.title);
	 $("#createtime").html("发布时间:"+row.createtime);
	 $("#opername").html("作者:"+row.opername);
	 $("#content").html(row.content);
}


</script>
</body>
</html>
