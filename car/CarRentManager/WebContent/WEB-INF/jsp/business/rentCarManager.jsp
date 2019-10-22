<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>汽车出租</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/datagrid-detailview.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
		<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 20px;width:100%; text-align: center;">
    		 <input class="easyui-searchbox" id="sbox" data-options="prompt:'请输入客户身份证号',searcher:doSearch" style="width:60%">
    	</div>
    	<br>
    <div id="content">
	    <table id="dg" > </table>
	    <div id="toolbar">
	        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newRent()">车辆出租</a>
	    </div>
    </div>
    <div id="dlg" class="easyui-dialog" style="width:50%;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
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
    	//隐藏content的div
    	$("#content").hide();
    	function initCar(){
    	//加载数据
       	 $("#dg").datagrid({
   			title:'车辆列表',
   			width:'99%',
   			iconCls:'icon-save',
   			url:'${pageContext.request.contextPath}/car/loadCars.action?isrenting=0',
   			singleSelect:true,  //是否支持单行选中
   			method:'get',  //请求方式
   			fitColumns:true,  //是否自动分配列
   			toolbar:'#toolbar',   //工具条的div  toolbar
   			rownumbers:true,  //是否显示行号
   			pagination:true,  //是否启用分页
   			columns:[[
   			        {field:'carnumber',title:'车牌号',width:100,align:'center'},
   			        {field:'cartype',title:'类型',width:100,align:'center'},
   			        {field:'color',title:'颜色',width:100,align:'center'},
   			        {field:'price',title:'购买价格',width:100,align:'center'},
   			        {field:'rentprice',title:'出租价格',width:100,align:'center'},
   			        {field:'deposit',title:'出租押金',width:100,align:'center'},
   			        {field:'isrenting',title:'是否出租',width:100,align:'center',formatter:function(value,row,index){
   			        	return value==1?'YES':'NO';
   			        }},
   			        {field:'description',title:'描述',width:100,align:'center'},
   			        {field:'carimg',title:'图片地址',width:100,align:'center',hidden:'true'}
   			    ]]
   			,
   			view:detailview,
     			detailFormatter:function(index,row){    
     				var html="<table width=100%>";
     				html+="<tr><td><img width=200  height=150 src='"+row.carimg+"' title='车辆图片' alt='暂无图片'> </img></td></tr>";
     				html+="</table>";
     		        return html;    
     		    }
   		});
    	}
    	 
    	
        var url;
        function newRent(){ 
        	var row = $('#dg').datagrid('getSelected');
        	if(row){
        		 $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加出租单');
                 $("#rentid").textbox('textbox').attr({readonly:true});
                 $("#carnumber").textbox('textbox').attr({readonly:true});
                 $("#identity").textbox('textbox').attr({readonly:true});
                 $("#opername").textbox('textbox').attr({readonly:true});
                 //清空表单的数据
                 $('#fm').form('clear');
                 // row代表就是这一行的json对象
                 //使用ajax请求后台，后台返回一个 RentVo的json对象
                 $.post("${pageContext.request.contextPath}/rent/initRent.action",{
                	 identity:$("#sbox").val(),
                	 carnumber:row.carnumber,
                	 rentprice:row.rentprice
                 },function(json){
                	  $('#fm').form('load',json);
                 },"json");
               
                 url = '${pageContext.request.contextPath}/rent/addRent.action';
        	}else{
        		$.messager.show({
                    title: '提示',
                    msg: "请选中操作行"
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
        
        function doSearch(value){
    		//alert(value);
    		//把身份证号传到后台查询客户信息 如果有，就显示下面的content 的div 并加载没有出租的汽车列表
    		$.post("${pageContext.request.contextPath}/rent/queryCustomerByIdentity.action",{identity:value},function(data){
    			if(data==="true"){
    				$("#content").show();
    				initCar();
    			}else{//如果没有，提示用户输入有误  并且把content隐藏
    				$("#content").hide();
    				 $.messager.show({
                         title: '提示',
                         msg: "您输入身份证号不存在，请重新输入"
                     });
    			}
    		});
    		
    	}
    </script>
</body>
</html>