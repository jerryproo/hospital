<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/myCss.css" type="text/css" />
<link rel="stylesheet" href="layui/css/layui.css">
<style type="text/css">
.section{padding:100px 0;background:#fff}
.text-center{text-align:center}
.main-desc{margin:40px 0 24px;color:#333;font-size:20px;text-align:center}
.col-3 .desc-detail{margin:0 auto;text-align:left;display:inline-block}
.pure-text{color:#64686f;font-size:14px;line-height:30px}
.s-title{font-size:38px;color:#333}.s-content{width:1000px;margin:40px auto 0}
.col-3 .col-item{width:28%;float:left;margin-top:10px;cursor:pointer;}
.s-content{width:1000px;margin:40px auto 0}.col-3 .col-item{width:28%;float:left;margin-top:10px}.
.iconfont{    font-size: 100px;}
</style>
<title>欢迎登录新时代医院分诊系统</title>
</head>
<body>
	<div class="layui-header layui-bg-gray">
			<ul class="layui-nav layui-layout-right kit-nav layui-bg-gray" >
				<li class="layui-nav-item"><a href="javascript:;"style="color:black;"> ${userSessionName}
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:showMyInfo(${userSessionId});">基本资料</a>
						</dd>
						<dd>
							<a href="javascript:toChangePwd();">修改密码</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item "><a href="user_logout" style="color:black;"><i
						class="fa fa-sign-out" ></i>退出登陆</a></li>
			</ul>
		</div>


<div class="section text-center">
  <h2 class="s-title"><img src="images/logo.png" width="50px">新时代医院分诊系统</h2>
  <div class="s-content col-3 clearfix">
  <div class="col-item" data-type="userAppoint">
  <i class="iconfont"  style="font-size: 100px;">&#xe699;</i>
  <p class="main-desc">立即挂号</p>
  </div>
  <div class="col-item" style="width:43.5%;" data-type="userHistory">
  <i class="iconfont"  style="font-size: 100px;">&#xe667;</i>
  <p class="main-desc" >挂号历史</p>
  </div>

  </div>
</div>
	
	<!-- 
	this is index
	<input type="button" id="userToAppointId" onclick="userToAppoint()" value="我要挂号">
	<input type="button" id="userHistoryId" value="我的挂号历史">
	<input type="button" id="userInfoId" value="我的信息管理">
	<iframe align="bottom" src="page/user/userFoot.jsp" width="100%" height="2%"></iframe> -->
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script>
layui.use(['element','layer'], function(){
	  var element = layui.element
	  ,$=layui.$,
	  layer=layui.layer;
	  $(".iconfont").mouseenter(function(){
		 $(this).css("color","#1E9FFF");
	  }).mouseleave(function(){
		  $(this).css("color","black");
	  });
	  $(".col-item").click(function(){
		  var type = $(this).data('type');
		  active[type]?active[type].call(this):'';
	  });
	var active={
		userAppoint:function(){
			var userId= '${userSessionId}';
				  layer_show(800,600,'请选择要挂号的科室','user_showDeptAll?user.userId='+userId);
		},userHistory:function(){
			var userId= '${userSessionId}';
			openPost('user_toUserHistory',{'user.userId':userId}); 	
		}		
	}
	});
	function userToAppoint(){
		
	}
	function toChooseDate(deptno,userId){
			openPost('user_toChooseDate',{"dept.deptNo":deptno,'user.userId':userId}); 		
	}

</script>
</html>