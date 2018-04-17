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
 .layui-layer-demo{background-color:#eee;}
.layui-layer-demo .layui-layer-title{border:none; background-color:#2f4056; color:#fff;}
footer{position:fixed;bottom:0;}
#selectValueDivId{display:none;}
</style>
<title>就诊信息系统</title>

</head>
<body>

	<blockquote class="layui-elem-quote quoteBox">
		<form class="layui-form">
			<div class="layui-inline">
				<div class="layui-input-inline" style="width:110px">
				<select name="searchType" lay-verify="required"  lay-filter="searchType" id="searchTypeId">
						<option value="name"
						>姓名</option>
						<option value="job"
						>身份</option>
						<option value="deptNo"
						>部门</option>
						<option value="status"
						>在职状态</option>
					</select>
						</div>
					<div class="layui-input-inline">
					<input type="text" class="layui-input searchVal" name="searchInfo" id="searchInfoId"
						placeholder="请输入搜索的内容" />
					<span id="selectValueDivId" disabled="disabled" class="layui-disabled"> <select name="searchInfoa"  class=" layui-disabled"  disabled  lay-filter="searchInfo" id="searchTypeId" >
						</span>
					</select>
				</div>
				<button class="layui-btn search_btn" lay-submit onclick="return false"lay-filter="searchEmp"><i class="iconfont">&#xe623;</i>搜索</button>
			</div>
			<div class="layui-inline">
				<a class="layui-btn layui-btn-normal addNews_btn" data-type="addEmp">添加员工</a>
				<a class="layui-btn layui-btn-danger layui-btn-normal delAll_btn" data-type="getCheckData">批量禁用</a>
			</div>
		</form>
	</blockquote>
	<table id="empQuery"  lay-filter="empQuery"></table>
<footer>
    <div  id="page"></div></footer>
</body>
<script src="js/jquery.min.js"></script>
<script src="js/myJs.js"></script>
<script type="text/javascript" src="layui/layui.js"></script>
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
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">禁用</a>
</script>

<script>

        layui.use(['table','element','form','layer','laypage'], function() {
            var table = layui.table
            ,form = layui.form
            ,layer=layui.layer
            ,laypage=layui.laypage;
            var $=layui.$;
            var doctId = ${doctSessionId};
            var limit=1;
            var searchInfo = null;
            var searchType = null;
            $("span *").attr("disabled","disabled"); 
            console.log($("span *"));
            //第一个实例
            table.render({
            	id:'empQuery'
              ,elem: '#empQuery'
              ,height: 'full-20'
              , cellMinWidth: 80
              , limit : limit
              ,url: 'doct_showEmpQuery?page.limit='+limit //数据接口
              ,page: false
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
             , done:function(res,curr,cnt){
            	 console.log(curr   +'one');
            	  console.log(res);
            //分页
            laypage.render({
            	  elem: 'page'
         		  ,count: cnt
         		  ,limit:limit//数据总数，从服务端得到
         		  ,jump: function(obj, first){
         		    console.log(obj);
         		    //首次不执行
         		    if(!first){
         		      table.reload('empQuery', {
         	            	url: 'doct_showEmpQuery'
         	            	,where: {
         						'page.curr':obj.curr
         						,'page.limit':limit
         						,searchInfo:searchInfo,
         						searchType:searchType
         	            	} 
         	                , height:'full-20'
         	              	 , text: {
         	               	    none: '无信息' 
         	                 }
         	                ,done: function(){
         	                }
         	            	});  
	         		 }
         		  }
              });
              }
            });
            //监听工具条
            table.on('tool(empQuery)', function(obj){
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
             }
            });
            
            //搜索
    		form.on('submit(searchEmp)', function(data) {	
			   table.reload('empQuery', {
      	            	url: 'doct_searchEmp'
      	            	,where: {
      	            		data:JSON.stringify(data.field)
          					,'page.limit':limit
      	            	} 
      	                , height:'full-20'
      	              	 , text: {
      	               	    none: '无信息' 
      	                 }
      	                ,done: function(res){
		    			searchInfo =JSON.stringify(data.field.searchInfo);
		    			searchType =JSON.stringify(data.field.searchType);
      	                	cnt = res.count;
      	                	 laypage.render({
      	                 	  elem: 'page'
      	              		  ,count: cnt
      	              		  ,limit:limit//数据总数，从服务端得到
      	              		  ,jump: function(obj, first){
		    					console.log(searchInfo);
      	              		    console.log(obj);
      	              		    //首次不执行
      	              		    if(!first){
      	              		      table.reload('empQuery', {
      	              	            	url: 'doct_showEmpQuery'
      	              	            	,where: {
      	              						'page.curr':obj.curr
      	              						,'page.limit':limit
      	              						,searchInfo:searchInfo,
      	              						searchType:searchType
      	              	            	} 
      	              	                , height:'full-20'
      	              	              	 , text: {
      	              	               	    none: '无信息' 
      	              	                 }
      	              	                ,done: function(){
      	              	                }
      	              	            	});  
      	     	         		 }
      	              		  }
      	                   });
      	                }
      	            	});  
    			return false;
    		});
            
            var active = {
            	    getCheckData: function(){ //获取选中数据
		            	      var checkStatus = table.checkStatus('empQuery')
		            	      ,data = checkStatus.data;
		            	    var dataJson = JSON.stringify(data);
		            	    if(data != ''){
		            	    	$.ajax({
		            	    		url:'doct_delEmpQuery',
		            	    		type:'POST',
		            	    		data:{
										data:dataJson
		            	    		},
		            	    		dataType:'JSON',
		            	    		success:function(msg){
		            	    			parent.layer.msg(msg);
		            	    		}
		            	    	});
		            	    }else{
		            	    	parent.layer.msg("请选择需要禁用的用户.");
		            	    }
            	    }
            	    ,addEmp: function(){ //添加员工
            	   parent.layer_show(500, 700, '添加员工', 'doct_toEmpAdd'); 
            	    }
            	  };
            	  
            	  $('.layui-btn').on('click', function(){
            	    var type = $(this).data('type');
            	    active[type] ? active[type].call(this) : '';
            	  });
            	  
            	  form.on('select(searchType)', function(data){
            		 // console.log(data.elem); //得到select原始DOM对象
            		  console.log(data.value); //得到被选中的值
            		  //console.log(data.othis); //得到美化后的DOM对象
            		  console.log(searchType);
            		  console.log(searchInfo);
            		  
            		  
            		});      
            		      
            	  
        });
//选择下拉框修改搜索条件
        function changeText(obj){
        	var searchType = '${searchType}';
        	var textValue ='${searchInfo}';
        	var selected=$("#searchTypeId").val();
        	console.log(selected);
        	if(selected=="name"){
        		$("#searchInfoId").css("display",'inline');
        		$("#selectValueDivId").css("display",'none');
        		$("#searchInfoId").removeAttr("disabled","disabled");
        		$("#selectValueDivId").attr("disabled","disabled");
        		$("#selectValueDivId").empty();
        	}else if (selected == "deptNo"){
        		$("#selectValueDivId").empty();
        		$.ajax({
        			type : 'post',
        			url : 'doct_showDeptAll',
        			dataType: "json",
        			success : function(data) {	
        				  $.each(data, function (n, value) {
        					  $("#searchTypeId").get(0).add(new Option(value.deptNo,value.deptName));
        					  var lastOption= $("select option:last");//取到当前的最后一个option
        					  if(textValue==lastOption.val()){//如果从后台传过来的选项和当前的最后一个相同则选中
        						  lastOption.attr("selected","selected");
        						  }
        					  layui.use('form',function(){
        						  layui.form().render('select');
        						  });
        		           });
        			}	
        		})
        		$("#searchInfoId").css("display",'none');
        		$("#searchInfoId").attr("disabled","disabled");
        		$("#selectValueDivId").removeAttr("disabled","disabled");
        		$("#selectValueDivId").css("display",'inline');
        		
        	}
        	else{
        	}
        	}
</script>
</html>