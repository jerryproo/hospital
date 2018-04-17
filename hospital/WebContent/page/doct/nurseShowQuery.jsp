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
.layui-table-cell {  
            height: auto;  
            line-height: 50px;  
           font-size:20px;
        }  

</style>
<title>就诊信息系统</title>
</head>
<body>
	
    <table id="userQuery" lay-filter="userQuery" ></table>
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
<script type="text/html" id="doctName">
{{ d.doct.doctName}}
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

{{#if (d.udStatus==1){ }}
<button class="layui-btn "><i class="iconfont">&#xe651;</i>请在此等候</button>
{{# } }}
{{#if (d.udStatus==2){ }}
<button class="layui-btn layui-btn-normal"><i class="iconfont" >&#xe650;</i>请前往科室就诊</button>
{{# } }}

</script>
<script>
        layui.use(['table','laypage'], function() {
            var table = layui.table;
            var deptNo = ${dept.deptNo};
            //第一个实例
            table.render({
            	id:'userQuery'
             ,  elem: '#userQuery'
			  , height:'full-20'
              , text: {
            	    none: '暂无相关数据' //默认：无数据。注：该属性为 layui 2.2.5 开始新增
              }
              ,url: 'doct_nurseShowQuery?dept.deptNo='+deptNo //数据接口
              ,cols: [[ //表头
                {field: '', title: '序号', width:'10%', sort: true, templet:'#queryNo'}
                ,{field: 'udNo', title: '排队序号', width: '10%'}
                ,{field: '', title: '姓名', width:'15%', templet:'#userRealName'}
                ,{field: '', title: '性别', width:'10%' , templet:'#userSex'} 
                ,{field: '', title: '签到时间', width: '20%', templet:'#comDate'}
                ,{field: '', title: '就诊医师', width: '15%' , templet:'#doctName'}
                ,{field: '', title: '状态', width: '20%',templet:'#udStatus'}
              ]],
              });
              
            
        window.setInterval(function(){
         table.reload('userQuery', {
            	url: 'doct_nurseShowQuery'
            	,where: {
					'dept.deptNo':deptNo            		
            	} 
                , height:'full-20'
              	 , text: {
               	    none: '暂无排队信息' 
                 }
                ,done: function(){
               	   layer.msg("排队信更新 成功.")
                }
            	}); 
        },10000);

            
        });
        
</script>
</html>