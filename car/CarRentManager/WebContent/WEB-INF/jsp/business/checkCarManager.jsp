<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>汽车入库</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/datagrid-detailview.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
		<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 20px;width:100%; text-align: center;">
    		 <input class="easyui-searchbox" id="sbox" data-options="prompt:'请输入出租单号',searcher:doSearch" style="width:60%">
    	</div>
    	<br>
    	<div id="content">
    		<div class="easyui-panel" title="生成检查单" iconCls="icon-save">
    			<form id="frm"  novalidate style="margin:0;padding:20px 50px" method="post">
					  <table border="0"  width="100%" cellpadding="3" >
					  	 <tr>
					  	 	<td width="15%" align="center">检查单号:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-textbox" readonly="readonly" name="checkid"  required="true" style="width:80%" >
					  	 	</td>
					  	 	<td width="15%" align="center">检查日期:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-datebox" name="checkdate" required="true"  style="width:80%" >
					  	 	</td>
					  	 </tr>
					  	  <tr>
					  	 	<td width="15%" align="center">出租单号:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-textbox" readonly="readonly" name="rentid"  required="true" style="width:80%" >
					  	 	</td>
					  	 	<td width="15%" align="center">操作员:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-textbox" readonly="readonly" name="opername"  required="true" style="width:80%" >
					  	 	</td>
					  	 </tr>
					  	 <tr>
					  	 	<td width="15%" align="center">存在问题:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-textbox" name="problem"  required="true" style="width:80%" >
					  	 	</td>
					  	 	<td width="15%" align="center">赔付金额:</td>
					  	 	<td width="35%">
					  	 		<input class="easyui-textbox" name="paymoney"  required="true" style="width:80%" >
					  	 	</td>
					  	 </tr>
					  	  <tr>
					  	 	<td width="15%" align="center">问题描述:</td>
					  	 	<td width="85%" colspan="3">
					  	 		<input class="easyui-textbox" name="checkdesc"  required="true" style="width:90%;height: 100px" >
					  	 	</td>
					  	 </tr>
					  	 <tr>
					  	 	<td align="center" colspan="4">
					  	 	<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCheck()" style="width:90px">保存</a>
					  	 	</td>
					  	 </tr>
					  </table>				
    			</form>
    		</div>
    		<br>
    		<div class="easyui-layout" style="width: '100%';height: 200px" >
    			<div class="easyui-panel"  style="width: 33%;height: 200px;padding: 20px" data-options="region:'east',title:'客户信息',iconCls:'icon-user'">
    				<table align="center" width="100%">
    					<tr >
    						<td align="center">身份证号:</td>
    						<td><label id="c_identity"></label></td>
    					</tr>
    					<tr>
    						<td align="center">客户信息:</td>
    						<td><label id="c_custname"></label></td>
    					</tr>
    					<tr>
    						<td align="center">客户性别:</td>
    						<td><label id="c_sex"></label></td>
    					</tr>
    					<tr>
    						<td align="center">客户地址:</td>
    						<td><label id="c_address"></label></td>
    					</tr>
    					<tr>
    						<td align="center">客户电话:</td>
    						<td><label id="c_phone"></label></td>
    					</tr>
    					<tr>
    						<td align="center">客户职位:</td>
    						<td><label id="c_career"></label></td>
    					</tr>
    				</table>
    			</div>
    			<div class="easyui-panel"  style="width: 33%;height: 200px;padding: 20px"  data-options="region:'center',title:'车辆信息',iconCls:'icon-add'">
    				<table align="center" width="100%">
    					<tr>
    						<td align="center">车牌号:</td>
    						<td><label id="ca_carnumber"></label></td>
    					</tr>
    					<tr>
    						<td align="center">车辆类型:</td>
    						<td><label id="ca_cartype"></label></td>
    					</tr>
    					<tr>
    						<td align="center">颜色:</td>
    						<td><label id="ca_color"></label></td>
    					</tr>
    					<tr>
    						<td align="center">购买价格:</td>
    						<td><label id="ca_price"></label></td>
    					</tr>
    					<tr>
    						<td align="center">出租价格:</td>
    						<td><label id="ca_rentprice"></label></td>
    					</tr>
    					<tr>
    						<td align="center">押金:</td>
    						<td><label id="ca_deposit"></label></td>
    					</tr>
    					<tr>
    						<td align="center">描述:</td>
    						<td><label id="ca_description"></label></td>
    					</tr>
    					<tr>
    						<td align="center">图片:</td>
    						<td><img id="ca_carimg" width="200px" height="200px"></img></td>
    					</tr>
    				</table>
    			</div>
    			<div class="easyui-panel"  style="width: 33%;height: 200px;padding: 20px"  data-options="region:'west',title:'出租单信息',iconCls:'icon-save'">
    				<table align="center" width="100%">
    					<tr >
    						<td align="center">出租单号:</td>
    						<td><label id="r_rentid"></label></td>
    					</tr>
    					<tr>
    						<td align="center">出租价格:</td>
    						<td><label id="r_price"></label></td>
    					</tr>
    					<tr>
    						<td align="center">开始时间:</td>
    						<td><label id="r_begindate"></label></td>
    					</tr>
    					<tr>
    						<td align="center">结束时间:</td>
    						<td><label id="r_returndate"></label></td>
    					</tr>
    					<tr>
    						<td align="center">操作员:</td>
    						<td><label id="r_opername"></label></td>
    					</tr>
    				</table>
    			</div>
    		</div>
    	</div>
    <script type="text/javascript">
    
    	$(function(){
    		//隐藏div
    		$("#content").hide();
    	});
    
        function doSearch(value){
    		//alert(value);
    		//把身份证号传到后台查询客户信息 如果有，就显示下面的content 的div 并加载没有出租的汽车列表
    		$.post("${pageContext.request.contextPath}/check/queryRentByRentId.action",{rentid:value},function(data){
    			if(data==="true"){
    				$("#content").show();
    				//加载数据
    				initCheck();
    			}else{//如果没有，提示用户输入有误  并且把content隐藏
    				$("#content").hide();
    				 $.messager.show({
                         title: '提示',
                         msg: "您输入出租单号不存在或车辆已归还"
                     });
    			}
    		});
    	}
        //加载显示出来的所有数据
        function initCheck(){
        	var value=$("#sbox").val();
        	$.post("${pageContext.request.contextPath}/check/initCheck.action",{rentid:value},function(data){
    			//data 就是一个有四个key对应的四个对象
    			//加载检查单的初始信息
    			$("#frm").form("load",data.check);
    			//加载客户信息
    			var customer=data.customer;
    			$("#c_identity").html(customer.identity);
    			$("#c_custname").html(customer.custname);
    			$("#c_sex").html(customer.sex==1?'男':'女');
    			$("#c_address").html(customer.address);
    			$("#c_phone").html(customer.phone);
    			$("#c_career").html(customer.career);
    			//加载车辆信息
    			var car=data.car;
    			$("#ca_carnumber").html(car.carnumber);
    			$("#ca_cartype").html(car.cartype);
    			$("#ca_color").html(car.color);
    			$("#ca_price").html(car.price);
    			$("#ca_rentprice").html(car.rentprice);
    			$("#ca_deposit").html(car.deposit);
    			$("#ca_description").html(car.description);
    			$("#ca_carimg").attr({src:car.carimg});
    			//加载出租单信息
    			var rent=data.rent;
    			$("#r_rentid").html(rent.rentid);
    			$("#r_price").html(rent.price);
    			$("#r_begindate").html(rent.begindate);
    			$("#r_returndate").html(rent.returndate);
    			$("#r_opername").html(rent.opername);
    		},"json");
        };
        
        //保存
        function saveCheck(){
        	 $('#frm').form('submit',{
                 url: "${pageContext.request.contextPath}/check/addCheck.action",
                 onSubmit: function(){
                     return $(this).form('validate');
                 },
                 success: function(result){
                 	var res=eval('('+result+')');
                     $.messager.show({
                         title: '提示',
                         msg: res.msg
                     });
                     //隐藏div
                     $("#content").hide();
                     //清空搜索框架
                     $("#sbox").val("");
                 }
             });
        }
    </script>
</body>
</html>