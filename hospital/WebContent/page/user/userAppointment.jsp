<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
.section{padding:60px 0;background:#fff;}
.s-title{font-size:38px;color:#333;text-align:center;}.s-content{width:1000px;margin:40px auto 0}
.iconfont{font-size:20px;}
#laydate .layui-laydate-main{width:372px;height:313px;}
#laydate .layui-laydate-content td,#test-n1 .layui-laydate-content th{width:50px;}
.right-label{height:50px;width:100%;}
.bg-grey{background-color:#f2f2f2}
.font-size2{font-size:2em;}
.font-right{    margin: 110px;}
</style>
<title>用户挂号</title>
</head>
<body>
	<div class="layui-header layui-bg-gray">
				<ul class="layui-nav  kit-nav layui-bg-gray" >
					<li class="layui-nav-item "><a href="page/user/userIndex.jsp" style="color:black;"><i
						class="iconfont" >&#xe612;</i>回到主页</a></li>
				</ul>
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
		  <h2 class="s-title" style="margin-bottom: 40px;" id="font-title"><img src="images/logo.png" width="50px" >${date } ${dept.deptName}挂号信息
		  <c:if test="${doctTitle=='COMMON' }"> (普通号)</c:if>
		  <c:if test="${doctTitle=='PROFESSION' }"> (专家号)</c:if>
		  </h2>
	  <div class="layui-row">
	  	<div class="layui-col-md4" style="text-align:center;">
			<div id="laydate"></div>
	  	</div>
	  	<div class="layui-col-md7" id="right-all">
	  	<c:forEach items="${countList }" var="count">
			 <div class="bg-grey" style="height:50px;  padding: 20px;">
			 <label class="layui-inline" ><i class="font-size2">${count.timestamp }</i><span class="font-right"> 总可挂号人数：<i class="font-size2">${countno }</i> 剩余可挂号人数：<i  class="font-size2">${countno-count.count }</i></span></label>
			 <button class="layui-btn layui-btn-normal" onclick="appoint(${count.id})">立即挂号</button>
			</div>
		</c:forEach>
	  	</div>
	  		<div class="layui-col-md1" class="bg-grey" id="changeDoctTitle"style="height:360px;font-size:2em;text-align:center;padding-top:3%;cursor:pointer;float:right;background-color:#f2f2f2;">
				切<br>换<br>到<br>专<br>家<br>号
	  	</div>
	   </div>
	  </div>


</body>

<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
<script>
	var dateChoosen ='${date}';//首次要赋值 否则直接挂下一天的号会取不到日期
	var doctTitle = '${doctTitle}';//首次进入默认为普通号  将后台传过来的值赋给全局变量中
	layui.use(['laydate','layer','form','element'],function(){
		var laydate= layui.laydate
		,element = layui.element
		,$ = layui.$
		,deptName = ' ${dept.deptName}'
		,dateFirst=  '${date}';
		var dateFresh = laydate.render({
			  elem: '#laydate'
			  ,position: 'static'
			  ,value: dateFirst //首次进入页面会显示下一天
			  ,change: function(value, date){//点击日期更新右侧显示挂号信息
				var deptNo = '${dept.deptNo}';
				getAppointNum(value,deptNo,deptName,doctTitle);
			  }
			});
		
		
			$("#changeDoctTitle").mouseenter(function(){
				$(this).css("color","white");
				$(this).css("background-color","#5FB878");
			}).mouseleave(function(){
				$(this).css("color","black");
				$(this).css("background-color","#f2f2f2");
			}).click(function(){
				var deptNo = '${dept.deptNo}'
					,deptName = ' ${dept.deptName}';
				if(doctTitle == 'COMMON'){
					doctTitle ='PROFESSION';
					getAppointNum(dateChoosen,deptNo,deptName,doctTitle);//先访问 后改变  ！！当前页面显示的 是切换到普通号
					$("#changeDoctTitle").html('切<br>换<br>到<br>普<br>通<br>号');
				}else if (doctTitle=='PROFESSION'){
					doctTitle = 'COMMON';
					getAppointNum(dateChoosen,deptNo,deptName,doctTitle);
					$("#changeDoctTitle").html('切<br>换<br>到<br>专<br>家<br>号');
				}
			})
	})
	
	//将ajax访问后台抽调出来
	function getAppointNum(value,deptNo,deptName,doctTitle){
		//$("#changeDoctTitle").css("display","none");//在点击日期的时候 使得右侧栏也隐藏 避免出现闪烁
		$("#right-all").html('');//点击就把当前显示 的删除
		
		$.ajax({
			type : 'post',
			url : 'user_usertoAppoint',
			data : {
				date :value,
				'dept.deptNo' : deptNo,
				'doctTitle':doctTitle
			},
			dataType:'JSON',
			success : function(info) {
			dateChoosen = info.datein;//每次会把date一起返回给前台  格式yyyy-MM-dd
			var status = info.status;
			if(status =='noInfo'){
				layui.use('layer', function(){
					  if(info.doctTitle != 'PROFESSION'){
						  $("#right-all").html("<div style='margin: 17%;font-size: 2em; color: #c2c2c2;'><center>该日期暂未安排值班</center></div>");
					  }else {
						  $("#right-all").html("<div style='margin: 17%;font-size: 2em; color: #c2c2c2;'><center>暂无专家号信息</center></div>");
					  }
					  $("#right-all").css('cursor','not-allowed');
					  }); 
			}else if(status =='dateIllegal'){
				layui.use('layer', function(){
					  $("#right-all").html("<div style='margin: 17%;font-size: 2em; color: #c2c2c2;'><center>不能选择今天及以前的日期</center></div>")
					  }); 
					  $("#right-all").css('cursor','not-allowed');
			}
			else{
				 var list=info.countList; 
				 var addli='';
				 $.each(list, function (n, value) {
					addli=addli+'<div class="bg-grey" style="height:50px;  padding: 20px;">'+
					'<label class="layui-inline" ><i class="font-size2">'+value.timestamp+' </i><span class="font-right"> 总可挂号人数：<i class="font-size2">'+info.countno+
					'</i> 剩余可挂号人数：<i  class="font-size2">'+(info.countno-value.count)+'</i></span></label>'+
					'<button class="layui-btn layui-btn-normal" onclick="appoint('+value.id+')">立即挂号</button></div>'			 
					});
					$("#right-all").append(addli);
					$("#changeDoctTitle").css("display","inline");//在点击日期的时候 使得右侧栏也隐藏 避免出现闪烁
					 $("#right-all").css('cursor','default');
			}
				 	var title = doctTitle == 'COMMON'? '普通号':'专家号';
				 	$("#font-title").html('<img src="images/logo.png" width="50px" >'+dateChoosen+deptName+'挂号信息('+title+')');
			}
		});
	}
	
	

		function appoint(rangeNo){
			var userId='${user.userId}';
			var deptNo='${dept.deptNo}';
			$.ajax({
				url:'user_userAppoint',
				data:{
					rangeNo:rangeNo,
					'user.userId':userId,
					'dept.deptNo':deptNo,
					date:dateChoosen,
					doctTitle:doctTitle
				},
				type:'post',
				success:function(info){
					if(info=='success'){
						layui.use('layer', function(){
							  var layer = layui.layer;
							  layer.msg('挂号成功~');//页面修改之后要把这里返回的时候改变页面的值
							  dateFresh.call();
							  }); 
					}else if(info=='arranged'){
						layui.use('layer', function(){
							  var layer = layui.layer;
							  layer.msg('您已经挂过该天该科室号了');
							  }); 
					}else if(info=='noseat'){
						layui.use('layer', function(){
							  var layer = layui.layer;
							  layer.msg('该天该时段已无可挂号数，请刷新页面');
							  }); 
					}
				}
				
			})
		}




</script>
</html>