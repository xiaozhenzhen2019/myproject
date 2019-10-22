<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>检查单管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;">
    		 <form id="searchForm" method="post">
	    		检查单号:
	    		<input class="easyui-textbox"   name="checkid"  style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;出租单号:
	    		<input class="easyui-textbox"  name="rentid" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;存在问题:
	    		<input class="easyui-textbox"  name="problem" style="width:25%;">
	    		<br>
	    		<br>
	    		开始时间:
	    		<input class="easyui-datebox"  name="startDate" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;结束时间:
	    		<input class="easyui-datebox"  name="endDate" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;问题描述:
	    		<input class="easyui-textbox"  name="checkdesc" style="width:25%;">
	    		<br>
	    		<br>
	    		 <div style="text-align: center;">
	    		 <a href="javascript:void(0)" iconCls="icon-search" class="easyui-linkbutton" onclick="doSearch()" style="width:80px">查询</a>
	             <a href="javascript:void(0)" iconCls="icon-cancel" class="easyui-linkbutton" onclick="resetForm()" style="width:80px">重置</a>
	    		 </div>
    		</form>
    	</div>
    	 <br>
    <table id="dg"> </table>
   
    <div id="toolbar">
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCheck()">修改检查单</a>
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
             <div style="margin-bottom:10px">
                <input name="checkid" id="checkid" class="easyui-textbox" required="true" label="检查单号:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="identity" id="identity" class="easyui-textbox" required="true" label="客户身份证:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="carnumber" id="carnumber" class="easyui-textbox" required="true" label="车 牌号:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="price" id="price" class="easyui-numberbox" required="true" label="出租价格:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="begindate" id="begindate" class="easyui-datebox" required="true" label="开始时间:" style="width:100%">
            </div>
              <div style="margin-bottom:10px">
                <input name="returndate" id="returndate" class="easyui-datebox" required="true" label="结束时间:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
                <input name="opername" id="opername" class="easyui-textbox" required="true" label="操作员:" style="width:100%">
            </div>
            <div style="margin-bottom:10px">
				<label class="textbox-label">出租状态:</label>
				<input type="radio" value="1" name="checkflag">已归还
				<input type="radio" value="0" name="checkflag">未归还
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCheck()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'检查单列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/check/loadChecks.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'checkid',title:'检查单号',width:100,align:'center'},
			        {field:'checkdate',title:'检查日期',width:100,align:'center'},
			        {field:'problem',title:'存在问题',width:100,align:'center'},
			        {field:'checkdesc',title:'问题描述',width:100,align:'center'},
			        {field:'paymoney',title:'赔付金额',width:100,align:'center'},
			        {field:'rentid',title:'出租单号',width:100,align:'center'},
			        {field:'opername',title:'操作员',width:100,align:'center'}
			    ]]
		});
        var url;
        function editCheck(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改检查单');
                //不能编辑
                $("#checkid").textbox('textbox').attr({readonly:true});
                $("#carnumber").textbox('textbox').attr({readonly:true});
                $("#identity").textbox('textbox').attr({readonly:true});
                $("#opername").textbox('textbox').attr({readonly:true});
                //此时row 代表的是这一行数据的{json}对象
                //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/check/updateCheck.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveCheck(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the Check data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyCheck(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.checkid+'】的检查单信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/check/deleteCheck.action',{checkid:row.checkid,carnumber:row.carnumber},function(result){
                              $('#dg').datagrid('reload');    // reload the Check data
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
    			url:"${pageContext.request.contextPath}/check/loadChecks.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    </script>
</body>
</html>