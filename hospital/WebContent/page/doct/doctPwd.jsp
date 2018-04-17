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
<link rel="stylesheet" href="layui/css/layui.css">
<title>change doct pwd</title>
</head>
<body>

	<div>
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<input type="hidden" name="doct.doctId" value="${doctSessionId }">
				<label class="layui-form-label">当前密码：</label>
				<div class="layui-input-inline">
					<input type="password" name="doct.doctPassword" required
						lay-verify="required" placeholder="请输入密码" autocomplete="off"
						class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">辅助文字</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">新的密码：</label>
				<div class="layui-input-inline">
					<input type="password" name="doctNewPwd" required
						lay-verify="required" placeholder="请输入密码" autocomplete="off"
						class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">辅助文字</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">确认密码：</label>
				<div class="layui-input-inline">
					<input type="password" name="doctNewPwd" required
						lay-verify="required" placeholder="请输入密码" autocomplete="off"
						class="layui-input">
				</div>
				<div class="layui-form-mid layui-word-aux">辅助文字</div>
			</div>
	</div>
	<div class="layui-form-item">
		<div class="layui-input-block">
			<button class="layui-btn" lay-submit lay-filter="changePwd">立即提交</button>
			<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		</div>
	</div>
	</form>
	</div>
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script>
	layui.use('element', function() {
		var element = layui.element;

	});

	layui.use('form', function() {
		var form = layui.form;
		//监听提交
		form.on('submit(changePwd)', function(data) {
			layer.msg(JSON.stringify(data.field));
			return false;
		});
	});
</script>
</html>