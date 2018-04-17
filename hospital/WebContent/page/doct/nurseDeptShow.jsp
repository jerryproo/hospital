<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/myCss.css" type="text/css" />
<link rel="stylesheet" href="layui/css/layui.css">
<style type="text/css">
html .layui-layer-demo{background-color:#eee;}
.layui-layer-demo .layui-layer-title{border:none; background-color:#2f4056; color:#fff;}
    .layui-col-md4{
    font-size: 2em;
     cursor: pointer ;/*变成手型*/
    }
    .middle-css{
   padding: 10px; line-height: 50px; text-align: center; background-color: #79C48C; color: #fff;
    }
    .grid-demo-bg1{background-color: #63BA79;} .grid-demo-bg2{background-color: #49A761;} .grid-demo-bg3{background-color: #38814A;}
</style>
<title>就诊信息系统</title>

</head>
<body>


<div class="layui-row layui-col-space10">
<c:forEach items="${depts}" var="dept" varStatus="vs">
<div class="layui-col-md4">
<div 
<c:if test="${vs.count mod 2==1}">class="middle-css"</c:if>
<c:if test="${vs.count mod 2==0}">class="middle-css grid-demo-bg1"</c:if>
 style="height:150px;">
 <i class="iconfont">${dept.deptIcon}</i>
 <input type="hidden" value="${dept.deptNo}" class="hidden-deptNo">
 <input type="hidden" value="${dept.deptName}" class="hidden-deptName">
 ${dept.deptName }</div>
</div>
</c:forEach>
</div>


</body>
<script src="js/jquery.min.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript">
	layui.use('layer',function(){
	var layer =layui.layer;
    $(".middle-css").click(function(e){
    	//console.log(e.target.nodeName);
    	var deptNo=$(this).find("input:first").val();
    	var deptName=$(this).find("input:last").val();
        var index = parent.layer.open({
            type: 2,
            area:['2048px','768px'],
            content: 'doct_toNurseShowQuery?dept.deptNo='+deptNo,
            maxmin: true,
            title:deptName+'排队信息'
          });
          parent.layer.full(index); 
    })
	
			
		})
</script>
</html>