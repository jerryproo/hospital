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
<title>就诊信息系统</title>
</head>
<body class="layui-layout-body">
	<!-- <iframe align="top" src="page/doct/doctHead.jsp" width="100%"></iframe> -->

<div class="layui-layout layui-layout-admin">
	<div class="layui-header ">
    <div class="layui-logo">新时代医生分诊系统 医生端</div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
   
    <ul class="layui-nav layui-layout-right">
      <li class="layui-nav-item">
        <a href="javascript:;">
          <img src="https://tvax3.sinaimg.cn/crop.0.0.1010.1010.180/005Jre6Mly8fi68p4e49lj30s20s2427" class="layui-nav-img">
${doct.doctName}医生
        </a>
        <dl class="layui-nav-child">
          <dd><a href="javascript:showMyInfo(${doctSessionId});">基本资料</a></dd>
          <dd><a href="javascript:toChangePwd();">修改密码</a></dd>
        </dl>
      </li>
      <li class="layui-nav-item"><a href="">退出登陆</a></li>
    </ul>
  </div>

  <div class="layui-side layui-bg-black">
    <div class="layui-side-scroll">
      <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
      <ul class="layui-nav layui-nav-tree"  lay-filter="test">
        <li class="layui-nav-item layui-nav-itemed">
          <a class="" href="javascript:;">开始接诊</a>
        </li>
        <li class="layui-nav-item"><a href="doct_showQuery?doct.doctId=${doctSessionId }" target="layui-body">排队信息</a></li>
        <li class="layui-nav-item">
          <a href="javascript:;">解决方案</a>
          <dl class="layui-nav-child">
            <dd><a href="javascript:;">列表一</a></dd>
            <dd><a href="javascript:;">列表二</a></dd>
            <dd><a href="">超链接</a></dd>
          </dl>
        </li>
        <li class="layui-nav-item"><a href="">发布商品</a></li>
      </ul>
    </div>
  </div>

  <div class="layui-body" id="layui-body">
    <!-- 内容主体区域 -->
			<div style="padding: 15px;">
				<center> 
					<button class="layui-btn layui-btn-fluid" onclick="confirmScan(this)">扫码完成</button>	
				</center>
				<div style="display:none" id="formDivId">
				<form class="layui-form" action="">
					<div class="layui-form-item">
						<label class="layui-form-label">输入框</label>
						<div class="layui-input-block">
							<input type="text" name="title" required lay-verify="required"
								placeholder="请输入标题" autocomplete="off" class="layui-input">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">密码框</label>
						<div class="layui-input-inline">
							<input type="password" name="password" required
								lay-verify="required" placeholder="请输入密码" autocomplete="off"
								class="layui-input">
						</div>
						<div class="layui-form-mid layui-word-aux">辅助文字</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">选择框</label>
						<div class="layui-input-block">
							<select name="city" lay-verify="required">
								<option value=""></option>
								<option value="0">北京</option>
								<option value="1">上海</option>
								<option value="2">广州</option>
								<option value="3">深圳</option>
								<option value="4">杭州</option>
							</select>
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">复选框</label>
						<div class="layui-input-block">
							<input type="checkbox" name="like[write]" title="写作"> <input
								type="checkbox" name="like[read]" title="阅读" checked> <input
								type="checkbox" name="like[dai]" title="发呆">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">开关</label>
						<div class="layui-input-block">
							<input type="checkbox" name="switch" lay-skin="switch">
						</div>
					</div>
					<div class="layui-form-item">
						<label class="layui-form-label">单选框</label>
						<div class="layui-input-block">
							<input type="radio" name="sex" value="男" title="男"> <input
								type="radio" name="sex" value="女" title="女" checked>
						</div>
					</div>
					<div class="layui-form-item layui-form-text">
						<label class="layui-form-label">文本域</label>
						<div class="layui-input-block">
							<textarea name="desc" placeholder="请输入内容" class="layui-textarea"></textarea>
						</div>
					</div>
					<div class="layui-form-item">
						<div class="layui-input-block">
							<button class="layui-btn" lay-submit lay-filter="formDemo">立即提交</button>
							<button type="reset" class="layui-btn layui-btn-primary">重置</button>
						</div>
					</div>
				</form>
				</div>
			</div>
		</div>

  <div class="layui-footer">
    <!-- 底部固定区域 -->
    <center>    copyright @ wangzw</center>
    
  </div>
	
	</div>
	<!-- <iframe align="bottom" src="page/doct/doctFoot.jsp" width="100%" height="2%"></iframe> -->
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script>
	function confirmScan(obj){
		
		$("#formDivId").css("display","block");
		$(obj).css("display","none");
		
	}
	function showMyInfo(doctId)
	{
	layui.use('layer', function(){
		  var layer = layui.layer;
		  layer_show(800,600,'基本资料','doct_showDoctInfo?doct.doctId='+doctId);
		});
	};
	function toChangePwd(){
		layui.use('layer', function(){
			  var layer = layui.layer;
			  layer_show(500,400,'修改密码','page/doct/doctPwd.jsp');
			});
	}
	

	
layui.use('element', function(){
	  var element = layui.element;

	});

layui.use('form', function(){
  var form = layui.form;
  //监听提交
  form.on('submit(formDemo)', function(data){
    layer.msg(JSON.stringify(data.field));
    return false;
  });
});

</script>
</html>