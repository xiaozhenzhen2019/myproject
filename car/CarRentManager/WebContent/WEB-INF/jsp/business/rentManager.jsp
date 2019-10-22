<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>出租单管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;">
    		 <form id="searchForm" method="post">
	    		出租单号:
	    		<input class="easyui-textbox"   name="rentid"  style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;身份证号:
	    		<input class="easyui-textbox"  name="identity" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;车辆号牌:
	    		<input class="easyui-textbox"  name="carnumber" style="width:25%;">
	    		<br>
	    		<br>
	    		起租时间:
	    		<input class="easyui-datebox"  name="begindate" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;还车时间:
	    		<input class="easyui-datebox"  name="returndate" style="width:25%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;还车状态:
	    		<input type="radio" value="1" name="rentflag">已归还
				<input type="radio" value="0" name="rentflag">未归还
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editRent()">修改出租单</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyRent()">删除出租单</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-page-excel" plain="true" onclick="exportRent()">导出出租单信息</a>
    
    </div>
    
    <div id="dlg" class="easyui-dialog" style="width:400px" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
             <div style="margin-bottom:10px">
                <input name="rentid" id="rentid" class="easyui-textbox" required="true" label="出租单号:" style="width:100%">
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
				<input type="radio" value="1" name="rentflag">已归还
				<input type="radio" value="0" name="rentflag">未归还
            </div>
        </form>
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveRent()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'出租单列表',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/rent/loadRents.action',
			singleSelect:true,  //是否支持单行选中
			method:'get',  //请求方式
			fitColumns:true,  //是否自动分配列
			toolbar:'#toolbar',   //工具条的div  toolbar
			rownumbers:true,  //是否显示行号
			pagination:true,  //是否启用分页
			columns:[[
			        {field:'rentid',title:'出租单号',width:100,align:'center'},
			        {field:'identity',title:'身份证号',width:100,align:'center'},
			        {field:'carnumber',title:'车辆号牌',width:100,align:'center'},
			        {field:'price',title:'出租价格',width:100,align:'center'},
			        {field:'begindate',title:'起租时间',width:100,align:'center'},
			        {field:'returndate',title:'结束时间',width:100,align:'center'},
			        {field:'rentflag',title:'归还状态',width:100,align:'center',formatter:function(value,row,index){
			        	return value==1?'已归还':'未归还';
			        }}
			    ]]
		});
        var url;
        function editRent(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改出租单');
                //不能编辑
                $("#rentid").textbox('textbox').attr({readonly:true});
                $("#carnumber").textbox('textbox').attr({readonly:true});
                $("#identity").textbox('textbox').attr({readonly:true});
                $("#opername").textbox('textbox').attr({readonly:true});
                //此时row 代表的是这一行数据的{json}对象
                //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
                $('#fm').form('load',row);
                url = '${pageContext.request.contextPath}/rent/updateRent.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveRent(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the Rent data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyRent(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.rentid+'】的出租单信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/rent/deleteRent.action',{rentid:row.rentid,carnumber:row.carnumber},function(result){
                              $('#dg').datagrid('reload');    // reload the Rent data
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
    			url:"${pageContext.request.contextPath}/rent/loadRents.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    	
    	function exportRent(){
    		//得到选中行
            var row = $('#dg').datagrid('getSelected');
    		if(row){
    			window.location.href="${pageContext.request.contextPath}/rent/exportRent.action?rentid="+row.rentid;
    		}else{
    			 $.messager.show({
                     title: '提示',
                     msg: '请选中操作行'
                 });
    		}
    	}
    </script>
</body>
</html>