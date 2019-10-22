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

<title>My JSP 'countCustomerArea.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/jquery-1.8.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/highcharts/highcharts.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/highcharts/modules/exporting.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/highcharts/modules/export-data.js"></script>

</head>

<body>
	<div id="container"
		style="min-width: 310px; height: 400px; max-width: 600px; margin: 0 auto"></div>

	<script type="text/javascript">
		$(function(){
			$.post("${pageContext.request.contextPath}/tjfx/countCustomerArea.action",function(data){
				Highcharts.chart('container', {
				    chart: {
				        plotBackgroundColor: null,
				        plotBorderWidth: null,
				        plotShadow: false,
				        type: 'pie'
				    },
				    title: {
				        text: '汽车出租系统客户区域分布图'
				    },
				    tooltip: {
				        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
				    },
				    plotOptions: {
				        pie: {
				            allowPointSelect: true,
				            cursor: 'pointer',
				            dataLabels: {
				                enabled: true,
				                format: '<b>{point.name}</b>: {point.percentage:.1f} %',
				                style: {
				                    color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
				                }
				            }
				        }
				    },
				    series: [{
				        name: '百分比',
				        colorByPoint: true,
				        data: data
				    }]
				});
			},"json");
		});
	</script>
</body>
</html>
