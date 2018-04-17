<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户登录</title>
</head>
<body>
	<form action="user_login" method="post">
		<input type="text" name="user.userName" placeholder="用户名/身份证号码/手机号">
		<input type="password" name="user.userPassword">
		<input type="submit">
	</form>
</body>
</html>