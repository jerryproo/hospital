<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="layui/css/layui.css">
<title>doctInfo</title>
</head>
<body>
	<div>
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">姓名：</label> <label
					class="layui-form-label" name="doctName">${doct.doctName }</label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">部门：</label> <label
					class="layui-form-label" name="deptName">${doct.dept.deptName}</label>
			</div>
			<c:if test="${doct.doctJob=='doct' }">
			<div class="layui-form-item">
				<label class="layui-form-label">诊断人数：</label> <label
					class="layui-form-label">${doct.doctNum }人</label>
			</div>
			</c:if>
			<div class="layui-form-item">
				<label class="layui-form-label">简介：</label>
				<div class="layui-input-block">
					<textarea name="doctPro" placeholder="请输入内容" class="layui-textarea">${doct.doctPro }</textarea>
					<input type="hidden" name="doctId" value="${doct.doctId }">
				</div>
			</div>

			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="updateDoct">立即提交</button>
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
		form.on('submit(updateDoct)', function(data) {
			console.log(JSON.stringify(data.field));
			$.ajax({
				url : 'doct_updateDoct',
				data : {
					data : JSON.stringify(data.field)
				},
				type : 'POST',
				dataType : 'JSON',
				success : function(msga) {
					layui.use('layer', function() {
						var msg = msga == 'success' ? '提交成功！' : '提交失败.';
						var index=parent.layer.getFrameIndex(window.name);
						parent.layer.close(index);
						parent.layer.msg(msg);
					});
					//将当前的输入框隐藏准备接下一个人	
				},
				error : function() {
					layui.use('layer', function() {
						layer.msg('提交错误.');
					});
				}

			});
			return false;
		});
	});
</script>
</html>