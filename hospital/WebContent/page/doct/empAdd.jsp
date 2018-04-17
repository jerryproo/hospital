<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
html .layui-layer-demo{background-color:#eee;}
.layui-layer-demo .layui-layer-title{border:none; background-color:#2f4056; color:#fff;}
.layui-input{width:190px;}
</style>
<title>就诊信息系统</title>
</head>
<body>
	<div>
		<form class="layui-form" action="">
			<div class="layui-form-item">
				<label class="layui-form-label">姓&nbsp;&nbsp;名：</label> 
					<div class="layui-input-inline">
						<input class="layui-input" value="${doct.doctNum}" name="doctName">
					</div>
					<div class="layui-form-mid layui-word-aux"></div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">部门：</label>
					<div class="layui-input-block">
						<select name="deptNo" lay-verify="required">
							<c:forEach items="${depts}" var="dept" varStatus="vs">
								<option value="${dept.deptNo}"
								>${dept.deptName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
				<label class="layui-form-label">职&nbsp;&nbsp;位：</label>
				<div class="layui-input-block">
					<select name="doctJob" lay-verify="required"  lay-filter="chooseJob">
						<option value="doct"
						>医生</option>
						<option value="nurse"
						>护士</option>
						<option value="mgr"
						>管理员</option>
						<option value="medc"
						>药师</option>
					</select>
				</div>
				</div>
			</div>
			<div class="layui-form-item" id="timeInput">
				<div class="layui-inline">
					<label class="layui-form-label">小时诊断：</label>
					<div class="layui-input-block">
						<input class="layui-input" lay-verify="mynum"
							value="${doct.doctNum}" name="doctNum">
					</div>
				</div>
			</div>

			<div class="layui-form-item">
				<label class="layui-form-label">简&nbsp;&nbsp;介：</label>
				<div class="layui-input-block">
					<textarea name="doctPro" placeholder="请输入内容" class="layui-textarea">${doct.doctPro }</textarea>
				</div>
			</div>
			  <div class="layui-form-item">
			    <label class="layui-form-label">性&nbsp;&nbsp;别：</label>
			    <div class="layui-input-block">
			      男：<input type="radio" name="doctSex" value="M" title="男">
			     女： <input type="radio" name="doctSex" value="F" title="女" checked>
			    </div>
			  </div>
			    <div class="layui-form-item">
			    <label class="layui-form-label">生&nbsp;&nbsp;日：</label>
			    <div class="layui-input-block">
			        <input type="text" class="layui-input" name="doctBirthday" id="birthDay">
			    </div>
			  </div>
			<div class="layui-form-item">
				<div class="layui-input-block">
					<button class="layui-btn" lay-submit lay-filter="empAdd">立即提交</button>
					<button type="reset" class="layui-btn layui-btn-primary">重置</button>
				</div>
			</div>
		</form>
	</div>
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script>

	layui.use(['form','layer','laydate'], function() {
		var form = layui.form,
		layer=layui.layer,
		laydate=layui.laydate,
		$=layui.$;
		var index=parent.layer.getFrameIndex(window.name);
		//监听提交
		form.on('submit(empAdd)', function(data) {		
			$.ajax({
				url:'doct_empAdd',
				data:{
					data:JSON.stringify(data.field)
				},
				type:'POST',
				dataType:'JSON',
				success:function(msga){
				 		if(msga=='success'){
						parent.layer.msg("提交成功.")				 			
						parent.layer.close(index);
				 		}
				},
				error:function(){
					layui.use('layer', function() {
						layer.msg('提交错误.');
						});
				}
				
			})
			return false;
		});
		//执行laydate实例
		laydate.render({
		    elem: '#birthDay' //指定元素
		  });
		form.on('select(chooseJob)', function(data){
			  if(data.value=="doct"){
					$("#timeInput").slideDown();
					 $("#timeInput").removeAttr("disabled","disabled");
			  }else{
				  $("#timeInput").slideUp();
				  $("#timeInput").attr("disabled","disabled");
			  }
			});
		form.verify({
		    mynum: [
		        /^0$|^[1-9]+\d*$/,
		        '请填写整数'
		    ]
		});
	});
</script>
</html>