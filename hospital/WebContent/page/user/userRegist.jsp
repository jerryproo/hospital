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
<title>欢迎注册</title>
</head>
<body>

	
			<div  id="formDivId">
			<div class="layui-form-item">
				<label class="layui-form-label">用户名：</label>
				<input type="text" class="layui-text">
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">密码：</label> <label
					class="layui-form-label" id="label-userAge"></label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">确认密码：</label> <label
					class="layui-form-label" id="label-userSex"></label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">：</label> <label
					class="layui-form-label" id="label-userBackup"></label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">生日：</label>
				<button class="layui-btn layui-btn-primary" id="userHistoryBtn">点击查看</button>
			</div>
			<form class="layui-form" action="">
				<input type="hidden" id="ud_code" name="udCode">
				<input type="hidden" id="doct_id" name="udDoctId" value=${doctSessionId }>
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">身份证：</label>
					<div class="layui-input-block">
						<textarea name="udDesc" placeholder="面诊症状填写"
							class="layui-textarea"></textarea>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">真实姓名：</label>
						<div class="layui-input-block">
							<textarea name="udResult" placeholder="诊断结果填写"
								class="layui-textarea"></textarea>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">邮箱：</label>
						<div class="layui-input-block">
							<textarea name="udMedc" placeholder="药物和剂量填写"
								class="layui-textarea"></textarea>
						</div>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label">手机号：</label>
					<div class="layui-input-block">
						<input type="checkbox" name="udReview" lay-skin="switch" value="1">
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-input-block">
						<button class="layui-btn" lay-submit lay-filter="comitResult">立即提交</button>
						<button type="reset" class="layui-btn layui-btn-primary">重置</button>
					</div>
				</div>
			</form>
		</div>






<%-- 
<input type="text" value="${regMsg}" readonly="readonly">
	<form action="user_regist" method="post">
		用户名：<input type="text" name="user.userName" >
		密码：<input type="password" name="user.userPassword">
		确认密码：<input type="password" id="checkPassword">
		邮箱：<input type="text" name="user.userEmail">
		身份证：<input type="text" name="user.userIdcard">
		真实姓名：<input type="text" name="user.userRealname">
		手机号：<input type="text" name="user.userPhone">
		<!-- 微信号：<input type="text" name="user.userWechat"> -->
		<input type="submit">
	</form> --%>
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
</html>