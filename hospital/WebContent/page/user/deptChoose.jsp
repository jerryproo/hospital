<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/myCss.css" type="text/css" />
<link rel="stylesheet" href="layui/css/layui.css">
<style type="text/css">
 .layui-col-md4{
    font-size: 2em;
     cursor: pointer ;/*变成手型*/
    }
    .middle-css{
   padding: 10px; line-height: 50px; text-align: center; background-color: #79C48C; color: #fff;
    }
    .grid-demo-bg1{background-color: #63BA79;} .grid-demo-bg2{background-color: #49A761;} .grid-demo-bg3{background-color: #38814A;}
</style>
</head>
<body>
<div>
	<div class="layui-row layui-col-space10">
	<c:forEach items="${deptAll}" var="dept">
	<div class="layui-col-md4 layui-col-sm6 layui-col-xs6"  onClick="toChooseDate('${dept.deptNo}',${user.userId})" style="display:block">
		<div 
		<c:if test="${vs.count mod 2==1}">class="middle-css"</c:if>
		<c:if test="${vs.count mod 2==0}">class="middle-css grid-demo-bg1"</c:if>
		 style="height:100px;">
		 <i class="iconfont" style="font-size:20px;">${dept.deptIcon}</i>
		 <input type="hidden" value="${dept.deptNo}" class="hidden-deptNo">
		 <input type="hidden" value="${dept.deptName}" class="hidden-deptName">
		 ${dept.deptName }</div>
		</div>
	<%-- <div class="layui-col-md6 layui-col-xs6 layui-col-xs6" style="text-align:center">
		<button class="layui-btn layui-btn-primary" style="border:0" id="${dept.deptNo }" onClick="toChooseDate('${dept.deptNo}',${user.userId})">${dept.deptName }</button>
		</div> --%>
	</c:forEach>
	</div>
	</div>
</body>
<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script src="js/myJs.js"></script>
<script >
	function toChooseDate(deptno,userId){
		layui.use('layer',function(){
			var layer=layui.layer;
			parent.toChooseDate(deptno,userId);
		})
	}
</script>

</html>