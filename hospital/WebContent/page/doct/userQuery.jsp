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
@font-face {
  font-family: 'iconfont';  /* project id 584839 */
  src: url('//at.alicdn.com/t/font_584839_mzyi2ggcan4mfgvi.eot');
  src: url('//at.alicdn.com/t/font_584839_mzyi2ggcan4mfgvi.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_584839_mzyi2ggcan4mfgvi.woff') format('woff'),
  url('//at.alicdn.com/t/font_584839_mzyi2ggcan4mfgvi.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_584839_mzyi2ggcan4mfgvi.svg#iconfont') format('svg');
}
.iconfont{
    font-family:"iconfont" !important;
    font-size:16px;font-style:normal;
    -webkit-font-smoothing: antialiased;
    -webkit-text-stroke-width: 0.2px;
    -moz-osx-font-smoothing: grayscale;}
</style>
<title>就诊信息系统</title>

</head>
<body>

	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form">
			<div class="layui-inline">
				<div class="layui-input-inline">
					<input type="text" class="layui-input searchVal"
						placeholder="请输入搜索的内容" />
				</div>
				<button class="layui-btn search_btn" data-type="reload" lay-filter="searchEmp"><i class="iconfont">&#xe623;</i>搜索</button>
				<button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
				<button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
				<button class="layui-btn" data-type="isAll">验证是否全选</button>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn">添加文章</a>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn">批量删除</a>
			</div>
		</form>
	</blockquote>
	<table id="userQuery" lay-data="{id: 'idTest'}" lay-filter="userQuery"></table>
    
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.all.js"></script>
<script src="js/myJs.js"></script>
<script type="text/html" id="doctSex">

{{# if(d.doctSex=='M' ){ }}
  男
{{# }else if(d.doctSex=='F'){ }}
女
{{# }else{ }}
--
{{# } }}
</script>
<script type="text/html" id="doctAge">
{{# var date = new Date(); }}
{{#var age = Math.floor((date-d.doctBirthday)/365/24/60/60/1000+1)}}
{{age}}
</script>
<script type="text/html" id="doctJob">
{{#if(d.doctJob=='doct'){ }}
医生
{{# }else if (d.doctJob=='nurse') {}}
护士
{{# } else if (d.doctJob=='mgr') {}}
管理员
{{# }else {}}
--
{{#}}}
</script>
<script type="text/html" id="doctDeptName">
{{d.dept.deptName}}
</script>
<script type="text/html" id="doctNum">
{{# if (d.doctJob=='doct'){}}
{{d.doctNum}}
{{#}else{}}
--
{{#}}}
</script>
<script type="text/html" id="doctStatus">
{{#if (d.doctStatus==1){ }}
在职
{{# } else if (d.doctStatus==0){ }}
离职
{{# } }}
</script>
<script type="text/html" id="doctInPosition">
{{# if (d.doctJob=='doct'){}}
{{#if (d.doctInposition==0){ }}
准备接诊
{{#} else if (d.doctInposition==1){ }}
接诊中
{{#} else if (d.doctInposition==2){ }}
暂不接诊
{{# }else{ }}
--
{{#}}}
{{# }else{ }}
--
{{#}}}
</script>
<script type="text/html" id="bar">
  <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="detail">查看</a>
  <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>

<script>

        layui.use(['table','element','form'], function() {
            var table = layui.table
            ,form = layui.form;
            var doctId = ${doctSessionId};
            //第一个实例
            table.render({
              elem: '#userQuery'
              ,height: 'full-100'
              , cellMinWidth: 80
              ,url: 'doct_showuserQuery' //数据接口
              ,page: { //支持传入 laypage 组件的所有参数（某些参数除外，如：jump/elem） - 详见文档
                  layout: ['limit', 'count', 'prev', 'page', 'next', 'skip'] //自定义分页布局
              //,curr: 5 //设定初始在第 5 页
              ,groups: 5 //只显示 1 个连续页码
              ,first: false //不显示首页
              ,last: false //不显示尾页
            }
              ,cols: [[ //表头
            	  {type:'numbers'}
            	 ,{type:'checkbox'}
                ,{field: 'doctId', title: 'ID', width:80, sort: true}
                ,{field: 'doctName', title: '姓名', width:150}
                ,{field: '', title: '性别', width:80 , templet:'#doctSex'} 
                ,{field: '', title: '年龄', width: 80 , templet:'#doctAge'}
                ,{field: '', title: '身份', width: 80 , templet:'#doctJob'}
                ,{field: '', title: '部门', width: 120, sort: true,templet:'#doctDeptName'}
                ,{field: '', title: '小时接诊数', width: 150, sort: true,templet:'#doctNum'}
                ,{field: '', title: '在职状态', width: 120,templet:'#doctStatus'}
                ,{field: '', title: '工作状态', width: 120,templet:'#doctInPosition'}
                ,{field: '', title: '操作', width: 200,sort: true,templet:'#bar'}
              ]]
            });
            //监听表格复选框选择
            table.on('checkbox(userQuery)', function(obj){
              console.log(obj)
            });
            //监听工具条
            table.on('tool(userQuery)', function(obj){
              var data = obj.data;
              var doctId = JSON.stringify(data.doctId);
              if(obj.event === 'detail'){
            	  parent.layer_show(400, 500, '信息编辑', 'doct_toSingleEmpShow?doct.doctId='
      					+ doctId); 
              } else if(obj.event === 'del'){
                parent.layer.confirm('确认禁用该用户吗？', function(index){
                	$.ajax({
                		url:'doct_delEmpById',
                		data:{
                			'doct.doctId':doctId
                		},
                		type:'POST',
                		success:function(msg){
                			if(msg=='success'){
			                  //obj.del();
							  parent.layer.close(index);
                			}else{
                				parent.layer.msg("操作失败.")
                			}
                		}
                	});
                });
              } else if(obj.event === 'edit'){//编辑医生信息
            		parent.layer_show(800, 600, '信息编辑', 'doct_toSingleEmpEdit?doct.doctId='
        					+ doctId); 
/*                 parent.layer.alert('编辑行：<br>'+ JSON.stringify(data.doctId))
 */              }
            });
            //搜索
    		form.on('submit(searchEmp)', function(data) {		
    			$.ajax({
    				url:'doct_searchEmp',
    				data:{
    					data:JSON.stringify(data.field)
    				},
    				type:'POST',
    				dataType:'JSON',
    				success:function(msga){
    				 	console.log(msga);
    				},
    				error:function(){
    					layui.use('layer', function() {
    						layer.msg('提交错误，请检查');
    						});
    				}
    				
    			})
    			return false;
    		});
            var $ = layui.$, active = {
            
            	    getCheckData: function(){ //获取选中数据
            	      var checkStatus = table.checkStatus('userQuery')
            	      ,data = checkStatus.data;
            	    console.log(111);
            	      layer.alert(JSON.stringify(data));
            	    }
            
            	    ,getCheckLength: function(){ //获取选中数目
            	      var checkStatus = table.checkStatus('idTest')
            	      ,data = checkStatus.data;
            	      layer.msg('选中了：'+ data.length + ' 个');
            	    }
            	    ,isAll: function(){ //验证是否全选
            	      var checkStatus = table.checkStatus('idTest');
            	      layer.msg(checkStatus.isAll ? '全选': '未全选')
            	    }
            	  };
            	  
            	  $('.demoTable .layui-btn').on('click', function(){
            	    var type = $(this).data('type');
            	    active[type] ? active[type].call(this) : '';
            	  });
        });

        
</script>
</html>