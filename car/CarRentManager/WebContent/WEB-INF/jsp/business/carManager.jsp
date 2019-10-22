<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>车辆管理</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/themes/default/easyui.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/icon.css" />
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/datagrid-detailview.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/easyui/1.5.4.2/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
	<div class="easyui-panel" title="搜索" iconCls="icon-search" style="padding: 10px;width:100%; text-align: center;">
    		 <form id="searchForm" method="post">
	    		车辆号牌:
	    		<input class="easyui-textbox"   name="carnumber"  style="width:35%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;车辆类型:
	    		<input class="easyui-textbox"  name="cartype" style="width:35%;">
	    		<br>
	    		<br>
	    		车辆颜色:
	    		<input class="easyui-textbox"  name="color" style="width:35%;">
	    		&nbsp;&nbsp;&nbsp;&nbsp;车辆描述:
	    		<input class="easyui-textbox"  name="description" style="width:35%;">
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
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newCar()">添加车辆</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editCar()">修改车辆</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyCar()">删除车辆</a>
    </div>
     <div class="easyui-panel" title="New Topic" style="width:100%;max-width:400px;padding:30px 60px;">
    <div id="dlg" class="easyui-dialog" style="width:60%;position: relative;" data-options="closed:true,modal:true,border:'thin',buttons:'#dlg-buttons'">
        <form id="fm" method="post" novalidate style="margin:0;padding:20px 50px">
            <div style="margin-bottom:10px">
                <input name="carnumber" id="carnumber" class="easyui-textbox" required="true" label="车辆号牌:" style="width:60%">
            </div>
            <div style="margin-bottom:10px">
                <input name="cartype" class="easyui-textbox" required="true" label="车辆类型:" style="width:60%">
            </div>
            <div style="margin-bottom:10px">
                <input name="color" class="easyui-textbox" required="true" label="车辆颜色:" style="width:60%">
            </div>
            <div style="margin-bottom:10px">
                <input name="price" class="easyui-numberbox" required="true" label="购买价格:" style="width:60%">
            </div>
            <div style="margin-bottom:10px">
                <input name="rentprice" class="easyui-numberbox" required="true" label="出租价格:" style="width:60%">
            </div>
              <div style="margin-bottom:10px">
                <input name="deposit" class="easyui-numberbox" required="true" label="出租押金:" style="width:60%">
            </div>
             <div style="margin-bottom:10px">
                <input name="description" class="easyui-textbox" required="true" label="车辆描述:" style="width:100%">
            	<input type="hidden" name="carimg" id="carimg">
            </div>
            <div style="margin-bottom:10px;position: absolute;top: 20px;left: 60%">
               <img alt="车辆图片" width="90%" id="mycarimg" style="border-radius:5px" height="100%" src="${pageContext.request.contextPath}/resources/images/defaultcarimg.jpg">
            </div>
             <div style="margin-bottom:10px">
				<label class="textbox-label">是否出租:</label>
				<input type="radio" value="1" name="isrenting">YES
				<input type="radio" value="0" name="isrenting">NO
            </div>
          </form>
          <!-- 图片上传的form -->
           <form id="uploadfm" method="post" novalidate style="margin:0;padding:20px 50px" enctype="multipart/form-data">
            <div style="margin-bottom:20px">
            	<input class="easyui-filebox" name="mf" label="车辆图片:" labelPosition="left" data-options="prompt:'请选择一个文件',iconCls:'icon-add',accept:'image/*'" style="width:70%">
       			<a href="#" class="easyui-linkbutton" style="width: 20%;margin-left: 8%" onclick="upoadCarImg()" iconCls="icon-add">上传</a>
       		</div>
       		</form>
       
    </div>
    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="saveCar()" style="width:90px">保存</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')" style="width:90px">取消</a>
    </div>
    <script type="text/javascript">
    	 //加载数据
    	 $("#dg").datagrid({
			title:'车辆列表',
			width:'99%',
			iconCls:'icon-save',
			url:'${pageContext.request.contextPath}/car/loadCars.action',
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
    	 
    	 
    	 /***
    	 上传图片
    	 	思路：1，使用Ajax上传，上传完成之后，服务器返回一个图片的地址
    	 		2，把这个地址设置到mycarimg这个图片标签上
    	 **/
    	function upoadCarImg(){
    		//$("#imgform")[0]是把jq对象转成js对象
			var formData = new FormData($("#uploadfm")[0]);
  			 $.ajax({
  				url:'${pageContext.request.contextPath }/car/uploadCarImg.action',
  				type:'POST',
  				data:formData,
  				async:false,
  				cache:false,
  				contentType:false,
  				processData:false,
  				success:function(path){
  					//alert(path);
  					$("#mycarimg").attr({src:path});
  					//给表单设置值 ，目地是当提交表单时把这个图片地址传到后台
  					$("#carimg").val(path);
  				},
  				error:function(rv){
  					alert(rv);
  				}
  			}); 
    	 }
    
        var url;
        function newCar(){
            $('#dlg').dialog('open').dialog('center').dialog('setTitle','添加车辆');
            //让车牌号输入框可以编辑
            $("#carnumber").textbox('textbox').attr({readonly:false});
            //清空表单的数据
            $('#fm').form('clear');
            //设置默认图片
            $("#mycarimg").attr({src:'${pageContext.request.contextPath}/resources/images/defaultcarimg.jpg'});
            url = '${pageContext.request.contextPath}/car/addCar.action';
        }
        function editCar(){
        	//得到当前用户的选中行的数据  
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $('#dlg').dialog('open').dialog('center').dialog('setTitle','修改车辆');
                //让车牌号输入框 不能编辑
                $("#carnumber").textbox('textbox').attr({readonly:true});
                //此时row 代表的是这一行数据的{json}对象
                //把row对象里面的数据装载到fm的表单里面  使用json里面的key和表单的name去对应
                $('#fm').form('load',row);
                //设置图片地址
                 $("#mycarimg").attr({src:row.carimg});
                url = '${pageContext.request.contextPath}/car/updateCar.action';
            }else{
            	  $.messager.show({
                      title: '提示',
                      msg: '请选中操作行'
                  });
            }
        }
        function saveCar(){
            $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                	var res=eval('('+result+')');
                    $('#dlg').dialog('close');        // close the dialog
                    $('#dg').datagrid('reload');    // reload the Car data
                    $.messager.show({
                        title: '提示',
                        msg: res.msg
                    });
                }
            });
        }
        function destroyCar(){
        	//得到选中行
            var row = $('#dg').datagrid('getSelected');
            if (row){
                $.messager.confirm('提示','你确定要删除【'+row.carnumber+'】的车辆信息吗?',function(r){
                    if (r){
                        $.post('${pageContext.request.contextPath}/car/deleteCar.action',{carnumber:row.carnumber},function(result){
                              $('#dg').datagrid('reload');    // reload the Car data
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
    			url:"${pageContext.request.contextPath}/car/loadCars.action?"+params
    		});
    		
    	}
    	function resetForm(){
    		$("#searchForm").form("clear");
    	}
    </script>
</body>
</html>