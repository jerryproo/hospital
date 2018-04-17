<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/myCss.css" type="text/css" />
<link rel="stylesheet" href="layui/css/layui.css">
<link rel="stylesheet" href="layui/css/layui.css" media="all">
<!--  <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css"> -->
<link rel="stylesheet" href="css/app.css" media="all">
<link rel="stylesheet" href="css/light.css" media="all">
<title>就诊信息系统</title>
</head>

<body class="kit-theme">
	<div class="layui-layout layui-layout-admin kit-layout-admin">
		<div class="layui-header">
			<div class="layui-logo"><img src="images/logo.png" width="30px">新时代医院分诊系统</div>
			<div class="layui-logo kit-logo-mobile">K</div>

			<ul class="layui-nav layui-layout-right kit-nav">

				<li class="layui-nav-item"><a href="javascript:;"> <c:if
							test="${doctSessionJob =='mgr'}">管理员:</c:if> <c:if
							test="${doctSessionJob =='doct'}">医生:</c:if> <c:if
							test="${doctSessionJob =='nurse'}">护士:</c:if>${doct.doctName }
				</a>
					<dl class="layui-nav-child">
						<dd>
							<a href="javascript:showMyInfo(${doctSessionId});">基本资料</a>
						</dd>
						<dd>
							<a href="javascript:toChangePwd();">修改密码</a>
						</dd>
					</dl></li>
				<li class="layui-nav-item"><a href="doct_logout"><i
						class="fa fa-sign-out" aria-hidden="true"></i>退出登陆</a></li>
			</ul>
		</div>

		<div class="layui-side layui-bg-black kit-side">
			<div class="layui-side-scroll">
				<div class="kit-side-fold">
					<i class="fa fa-navicon" aria-hidden="true"></i>
				</div>
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul class="layui-nav layui-nav-tree" lay-filter="kitNavbar"
					kit-navbar>
					<c:forEach items="${grants}" var="grant" varStatus="vs">
						<li class="layui-nav-item"><a href="javascript:;"
							data-url="${grant.grantAction}?doct.doctId=${doctSessionId}"
							data-icon="fa-user" data-title=" ${grant.grantName }" kit-target
							data-id='${vs.count}'> <i class="layui-icon"
								aria-hidden="false">${grant.grantIcon}</i> <span>
									${grant.grantName }</span></a></li>
					</c:forEach>

				</ul>
			</div>
		</div>
		<div class="layui-body" id="container">
			<!-- 内容主体区域 -->
			<div style="padding: 15px;">主体内容加载中,请稍等...</div>
		</div>

		<div class="layui-footer">
			<!-- 底部固定区域 -->
			@2018
		</div>
	</div>
	<!--   <script type="text/javascript">
        var cnzz_protocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        document.write(unescape("%3Cspan id='cnzz_stat_icon_1264021086'%3E%3C/span%3E%3Cscript src='" + cnzz_protocol + "s22.cnzz.com/z_stat.php%3Fid%3D1264021086%26show%3Dpic1' type='text/javascript'%3E%3C/script%3E"));
    </script> -->
	<script src="layui/layui.js"></script>
	<script src="js/myJs.js"></script>
	<script>
		var message;
		layui.config({
			base : 'layui/build/js/'
		}).use([ 'app', 'message' ], function() {
			var app = layui.app, $ = layui.jquery, layer = layui.layer;
			//将message设置为全局以便子页面调用
			message = layui.message;
			//主入口
			app.set({
				type : 'iframe'
			}).init();
			$('#pay').on('click', function() {
				layer.open({
					title : false,
					type : 1,
					content : '<img src="/build/images/pay.png" />',
					area : [ '500px', '250px' ],
					shadeClose : true
				});
			});
		});

		function showMyInfo(doctId) {
			layui.use('layer', function() {
				var layer = layui.layer;
				layer_show(800, 600, '基本资料', 'doct_showDoctInfo?doct.doctId='
						+ doctId);
			});
		};
		function toChangePwd() {
			layui.use('layer', function() {
				var layer = layui.layer;
				layer_show(500, 400, '修改密码', 'page/doct/doctPwd.jsp');
			});
		}
	</script>
</body>
</html>