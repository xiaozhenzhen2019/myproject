<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>新闻管理</title>
     <link href="${pageContext.request.contextPath}/resources/umeditor/themes/default/css/umeditor.css" type="text/css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/umeditor/umeditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/resources/umeditor/umeditor.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/umeditor/lang/zh-cn/zh-cn.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;">
    		 <form id="searchForm" method="post">
	    		新闻标题:
	    		<input class="easyui-textbox"  name="title" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;开始时间:
	    		<input class="easyui-textbox"  name="startDate" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;结束时间:
	    		<input class="easyui-textbox"  name="endDate" style="width:25%;">
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newNews()">添加新闻</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editNews()">修改新闻</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyNews()">删除新闻</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:1000px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
            	<input name="id" id="id" type="hidden">
            	<input name="opername"  type="hidden">
            	<input name="createtime" id="createtime" type="hidden">
                <input name="title" class="easyui-textbox" required="true" label="新闻标题:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
            <script type="text/plain" id="content" name="content" style="width:100%;height:340px;display: inline-block;">
   				 请输入新闻内容
			</script>
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveNews()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'新闻列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/news/loadNews.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			width:'100%',
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'id',title:'新闻编号',width:100,align:'center'},
			        {field:'title',title:'新闻标题',width:100,align:'center'},
			        {field:'content',title:'新闻内容',width:100,align:'center'},
			        {field:'createtime',title:'发布时间',width:100,align:'center'},
			        {field:'opername',title:'发布人',width:100,align:'center'},
			    ]]
		});
    
        var url;
        function newNews(){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加新闻');
            $('#fm').form('clear');
            url = '${pageContext.request.contextPath}/news/addNews.action';
        }
        function editNews(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改新闻');
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/news/updateNews.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveNews(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the News data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyNews(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.custname+'】的新闻信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/news/deleteNews.action',{id:row.id},function(result){
                              $('#dg').datagrid('reload');    // reload the News data
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
    			url:"${pageContext.request.contextPath}/news/loadNews.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    	
    	//初始化富文本编辑器
    	 //实例化编辑器
    	var um = UM.getEditor('content');
    	
    	
    </script>
</body>
</html>