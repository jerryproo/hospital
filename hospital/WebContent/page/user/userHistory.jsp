<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

</style>
<title>就诊信息系统</title>
</head>
<body>
	
    <table id="query" lay-filter="query"></table>
    <div id="laypage"></div>
    
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.all.js"></script>

<script type="text/html" id="queryNo">
{{ d.LAY_TABLE_INDEX + 1}}
</script>
<script type="text/html" id="userId">
{{d.user.userId}}
</script>
<script type="text/html" id="userRealName">
{{d.user.userRealName}}
</script>
<script type="text/html" id="userSex">
{{# if(d.user.userSex=='M' ){ }}
  男
{{# }else if(d.user.userSex=='F'){ }}
女
{{# }else{ }}
--
{{# } }}
</script>
<script type="text/html" id="userAge">
{{# var date = new Date(); }}
{{#var age = Math.floor((date-d.user.userBirthday)/365/24/60/60/1000+1)}}
{{age}}
</script>
<script type="text/html" id="comDate">
{{# var date = new Date(d.udComdate); }}
{{# var month = date.getMonth()+1}}
{{# var comDate =   date.getFullYear() + '/' +month + '/' + date.getDate() +' ' + date.getHours() +':' + date.getMinutes()}}
{{comDate=='NaN/NaN/NaN NaN:NaN'? '未知' : comDate}}
</script>
<script type="text/html" id="preDate">
{{# var date = new Date(d.udPredate); }}
{{# var month = date.getMonth()+1}}
{{# var preDate =   date.getFullYear() + '/' +month + '/' + date.getDate() +' ' + date.getHours() +':' + date.getMinutes()}}
{{preDate=='NaN/NaN/NaN NaN:NaN'? '未知' : preDate}}
</script>
<script type="text/html" id="udStatus">
{{#if (d.udStatus==0){ }}
已挂号，待签到 
{{# } }}
{{#if (d.udStatus==1){ }}
已签到，待接诊
{{# } }}
{{#if (d.udStatus==2){ }}
接诊中 
{{# } }}
{{#if (d.udStatus==3){ }}
接诊完毕
{{# } }}
{{#if (d.udStatus==4){ }}
结束 
{{# } }}
</script>
<script>
        layui.use(['table','laypage'], function() {
            var table = layui.table;
            var doctId = ${userSessionId};
            //第一个实例
            table.render({
              elem: '#query'
              ,height: 500
              ,url: 'doct_userHistory?user.userId='+userId //数据接口
              ,cols: [[ //表头
                {field: '', title: '序号', width:80, sort: true, fixed: 'left',templet:'#queryNo'}
                ,{field: '', title: '预约时间', width: 200, sort: true,templet:'#preDate'}
                ,{field: '', title: '签到时间', width: 200, sort: true,templet:'#comDate'}
                ,{field: '', title: '就诊时间', width: 200, sort: true,templet:'#startDate'}
                ,{field: '', title: '结束时间', width: 200, sort: true,templet:'#endDate'}
                ,{field: '', title: '挂号科室', width: 200, sort: true,templet:'#deptName'}
                ,{field: '', title: '就诊医师', width: 200, sort: true,templet:'#doctName'}
                ,{field: '', title: '建议复诊', width: 200, sort: true,templet:'#reviewStatus'}
                ,{field: '', title: '就诊状态', width: 200,templet:'#udStatus'}
              ]]
            });
       /*      //执行一个laypage实例
            laypage.render({
              elem: 'laypage' //注意，这里的 test1 是 ID，不用加 # 号
              ,count: 50 //数据总数，从服务端得到
            }); */
        });

        
</script>
</html>