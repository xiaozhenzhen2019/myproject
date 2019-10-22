<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>客户管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;">
    		 <form id="searchForm" method="post">
	    		身份证号:
	    		<input class="easyui-textbox"   name="identity"  style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;客户姓名:
	    		<input class="easyui-textbox"  name="custname" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;客户地址:
	    		<input class="easyui-textbox"  name="address" style="width:25%;">
	    		<br>
	    		<br>
	    		客户电话:
	    		<input class="easyui-textbox"  name="phone" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;客户职位:
	    		<input class="easyui-textbox"  name="career" style="width:25%;">
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newCustomer()">添加客户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCustomer()">修改客户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyCustomer()">删除客户</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-page-excel" plain="true" onclick="exportCustomer()">导出客户</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px;height:200px;padding:10px;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
                <input name="identity" id="identity" class="easyui-textbox" required="true" label="身份证号:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="custname" class="easyui-textbox" required="true" label="客户姓名:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="phone" class="easyui-textbox" required="true" label="客户电话:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="address" class="easyui-textbox" required="true" label="客户地址:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="career" class="easyui-textbox" required="true" label="客户职位:" style="width:100%">
            </div>
             <div style="margin-bottom:10px">
				<label class="textbox-label">客户性别:</label>
				<input type="radio" value="1" name="sex">男
				<input type="radio" value="0" name="sex">女
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCustomer()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'客户列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/customer/loadCustomers.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'identity',title:'身份证号',width:100,align:'center'},
			        {field:'custname',title:'客户姓名',width:100,align:'center'},
			        {field:'sex',title:'性别',width:100,align:'center',formatter:function(value,row,index){
			        	return value==1?'男':'女';
			        }},
			        {field:'address',title:'地址',width:100,align:'center'},
			        {field:'phone',title:'电话',width:100,align:'center'},
			        {field:'career',title:'职位',width:100,align:'center'},
			    ]]
		});
    
        var url;
        function newCustomer(){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加客户');
            //让身份证输入框可以编辑
            $("#identity").textbox('textbox').attr({readonly:false});
            $('#fm').form('clear');
            url = '${pageContext.request.contextPath}/customer/addCustomer.action';
        }
        function editCustomer(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改客户');
                //让身份证输入框 不能编辑
                $("#identity").textbox('textbox').attr({readonly:true});
                //此时row 代表的是这一行数据的{json}对象
                //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/customer/updateCustomer.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveCustomer(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the Customer data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyCustomer(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.custname+'】的客户信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/customer/deleteCustomer.action',{identity:row.identity},function(result){
                              $('#dg').datagrid('reload');    // reload the Customer data
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
    			url:"${pageContext.request.contextPath}/customer/loadCustomers.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    	function exportCustomer(){
    		var params=$("#searchForm").serialize();
    		window.location.href="${pageContext.request.contextPath}/customer/exportCustomer.action?"+params;
    	}
    </script>
</body>
</html>