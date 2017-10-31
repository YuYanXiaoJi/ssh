<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html >
<head>
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/style.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>Admin/css/font-awesome.min.css">
<link rel="apple-touch-icon-precomposed" href="images/icon/icon.png">
<link rel="shortcut icon" href="images/icon/favicon.ico">
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/echarts.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/worldcloud.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/jquery/jquery-3.2.1.min.js "></script>
</head>

<body class="user-select">
<section class="container-fluid">
  <header>
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false"> <span class="sr-only">切换导航</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
          <a class="navbar-brand" href="<%=basePath%>index.jsp" target="_blank">&nbsp;知了</a> </div>
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav navbar-right">
            <li class="dropdown" style="margin-right: 40px;">
              <a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
            	${sessionScope.admin}<span class="caret"></span></a>
              	<ul class="dropdown-menu dropdown-menu-left">
                	<li><a title="查看或修改个人信息" data-toggle="modal" data-target="#seeUserInfo">个人信息</a></li>
                	<li><a href="<%=basePath%>adminLoginOut.action" >退出登入</a></li>
              	</ul>
            </li>
         
          </ul>
        </div>
      </div>
    </nav>
  </header>
  <div class="row">
     <aside class="col-sm-3 col-md-2 col-lg-2 sidebar">
      <ul class="nav nav-sidebar">
        <li ><a href="<%=basePath%>Admin/index.jsp">报告</a></li>
      </ul>
      <ul class="nav nav-sidebar">
        <li><a href="<%=basePath%>adminGetSportAll.action">乡村</a></li>
        <li><a href="<%=basePath%>adminGetArticleAll.action">见闻</a></li>
        <li><a href="<%=basePath%>adminGetQuestionAll.action">秉烛夜谈</a></li>
        <li><a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">用户</a>
          <ul class="dropdown-menu" aria-labelledby="userMenu">
            <li><a href="<%=basePath%>adminGetUserAll.action">管理用户</a></li>
          </ul>
        </li>
        <li>
       	   <a class="dropdown-toggle" id="userMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">特别策划</a>
        	<ul class="dropdown-menu" aria-labelledby="userMenu">
            	<li><a href="<%=basePath%>getSpecialSchemeAll.action">管理活动</a></li>
            	<li><a href="javascript:">管理报名</a></li>
          	</ul>
        </li>
      </ul>
   </aside>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-lg-10 col-md-offset-2 main" id="main">
      <h1 class="page-header">今日信息总览</h1>
      <div class="row placeholders">
        <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日新增见闻</h4>
          <span class="text-muted"><span id="article"></span>&nbsp;条</span>
        </div>
        <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日新增评论</h4>
          <span class="text-muted"><span id="comment"></span>&nbsp;条</span>
       </div>
        <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日新增提问</h4>
          <span class="text-muted"><span id="question"></span>&nbsp;条</span>
       </div>
       <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日新增回答</h4>
          <span class="text-muted"><span id="answer"></span>&nbsp;条</span>
       </div>
        <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日登入量</h4>
          <span class="text-muted"><span id="login"></span>&nbsp;条</span>
        </div>
         <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日注册量</h4>
          <span class="text-muted"><span id="register"></span>&nbsp;条</span>
        </div>
        <div class="col-xs-6 col-sm-3 placeholder">
          <h4>今日访问量</h4>
          <span class="text-muted"><span id="pageView"></span>&nbsp;条</span> 
       </div>
      </div>
      <h1 class="page-header">状态</h1>
      <div class="table-responsive">
        <table class="table table-striped table-hover">
          <tbody>
            <tr>
              <td>登录者: <span>${sessionScope.admin}</span>，这是您第 <span id="loginCount"></span> 次登录</td>
            </tr>
            <tr>
              <td>上次登录时间:&nbsp;&nbsp;<span id="loginTime"></span></td>
            </tr>
          </tbody>
        </table>
      </div>
      <h1 class="page-header">报表数据</h1>
      <div class="table-responsive">
      <!-- 下面是的管理数据 -->
      	<table class="table table-striped table-hover">
          <tbody>
            <tr>
        	 	<td ><div style="margin-left:-15%;height: 400;width: 1266"; id="historyPageView"></div></td>
        	</tr>
        	<tr>
        		<td ><div style="float:left;height:400;width:1266" id="categoryProportion"></div></td>
        	</tr>
        	<tr>
        		<td ><div style=" margin-left: -15%;background-color:#f9f9f9; height:400;width:1266" id="historyWordCloud"></div></td>
        	</tr>
        	<tr>
        		<td><div style=" height:400;width:1266" id="schemeUser"></div></td>
        	</tr>
        	 
      	  </tbody>
      	</table>
      </div>
     
    </div>
  </div>
</section>
<!--个人信息模态框-->
<div class="modal fade" id="seeUserInfo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <form  id="form" method="post">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title" >个人信息</h4>
        </div>
        <div class="modal-body">
          <table class="table" style="margin-bottom:0px;">
            <thead>
              <tr> </tr>
            </thead>
            <tbody>
              <tr>
                <td wdith="20%">
                	<span>姓名:</span>
                	<span class="message"></span>			
                </td><!--真实名字就暂存在background字段中  -->	<!--must  必须输入的选项  -->
                <td width="80%"><input type="text"   class="must form-control" id="truename" maxlength="10" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>用户名:</span>
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="text"  class="must form-control" id="username" maxlength="10" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>电话:</span>
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="text"   class="must form-control" id="usertel" maxlength="13" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>旧密码:</span>
                	<span class="message"></span>
                </td>
                <td width="80%">
                	<input type="password"  class="form-control" id="oldPassword" maxlength="18" autocomplete="off" />
                </td>
             
              </tr>
              <tr>
                <td wdith="20%">
                	<span >新密码:</span>	
                	<span class="message"></span>
                </td>
                <td width="80%"><input type="password" id="newPassword" class="form-control"   maxlength="18" autocomplete="off" /></td>
              </tr>
              <tr>
                <td wdith="20%">
                	<span>确认密码:</span>
                	<span class="message"></span>
                </td>
                <td width="80%">
                	<input type="password" id="confirmPassword" class="form-control"  maxlength="18" autocomplete="off" />
                </td>
              </tr>
            </tbody>
            <tfoot>
              <tr></tr>
            </tfoot>
          </table>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary">提交</button>
        </div>
      </div>
    </form>
  </div>
</div>

<script src="<%=basePath%>Admin/js/bootstrap.min.js"></script> 
<script src="<%=basePath%>Admin/js/admin-scripts.js"></script>

<!-- 判断是否session outtime -->
<script type="text/javascript">
//是否session已经过期
	$(function(){
		if('${sessionScope.admin}' == '') {
			window.location.href = '<%=basePath%>User/Login.jsp';
			return false;
		}
	});
</script>

<!-- 景点类别报表 -->
<script type="text/javascript">
	
    var myChart2 = echarts.init($('#categoryProportion')[0]);
	
	var data1 = [];//大类别表
	var data2 = [];//具体景点表
	var dataName = [];
	var url = '<%=basePath%>getPageViewPie.action';
	$.ajax({
		async:false,
		type:'post',
		url:url,
		datatype:'json',
		success:function(dataJson) {
			dataJson = JSON.parse(dataJson);
			for(var i = 0; i < dataJson.length; i++) {
				 dataName.push(dataJson[i].name);
				 if(i < 5){
				 	data1.push({
				 		name:dataJson[i].name,
				 		value:dataJson[i].value
				 	});
				 }else {
				 	data2.push({
				 		name:dataJson[i].name,
				 		value:dataJson[i].value
				 	});
				 }
			}
			 
		}
	});
	
	
	var option = {
	 title: {
	 			x:'center',
		        text: '',
		       // subtext:''
		    },
    tooltip : {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
    },
    legend: {
        orient : 'vertical',
        x : 'left',
        //data:['直达','营销广告','搜索引擎','邮件营销','联盟广告','视频广告','百度','谷歌','必应','其他','1','2','3','4','5','6','7','8','9']
    	data:dataName
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataView : {show: true, readOnly: false},
            magicType : {
                show: true, 
                type: ['pie', 'funnel']
            },
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : false,
    series : [
        {
            name:'访问来源',
            type:'pie',
            selectedMode: 'single',
            radius : [0, 70],
            
            // for funnel
            x: '20%',
            width: '40%',
            funnelAlign: 'right',
            max: 1548,
            
            itemStyle : {
                normal : {
                    label : {
                        position : 'inner'
                    },
                    labelLine : {
                        show : false
                    }
                }
            },
            data: data1
        },
        {
            name:'访问量占比',
            type:'pie',
            radius : [100, 140],
            
            // for funnel
            x: '60%',
            width: '35%',
            funnelAlign: 'left',
            max: 1048,
            
            data:  data2
        }
    ]
};

	myChart2.setOption(option);                   

</script>

<!-- 活动用户报名表 -->
<script type="text/javascript">
	var myChart4 = echarts.init($('#schemeUser')[0]);
	var data4Man = [], data4Female = [], dataProvince = [];
	var url4 = '<%=basePath%>getSchemeUser.action';
	 $.ajax({
		async:false,
		type:'post',
		url:url4,
		datatype:'json',
		success:function(data){
			data = JSON.parse(data);
			for (var i = 0; i < data[0].length; i++) {
				if (data[0][i].sex == '男') {
					data4Man.push([
						data[0][i].province,
						data[0][i].age
					]);
				}else {
					data4Female.push([
						data[0][i].province,
						data[0][i].age
					]);
				}
			}
			dataProvince = data[1];
		}
	}); 
	
	var option4 = {
    title : {
        text: '特别策划主要受众',
        subtext: '年龄-城市  用户画像'
    },
    tooltip : {
        trigger: 'axis',
        showDelay : 0,
      	axisPointer:{
            show: true,
            type : 'cross',
            lineStyle: {
                type : 'dashed',
                width : 1
            }
        },
        formatter : "{a}<br>{b}{c}岁"
 
         
    },
    legend: {
        data:['女性','男性']
    },
    toolbox: {
        show : true,
        feature : {
            mark : {show: true},
            dataZoom : {show: true},
            dataView : {show: true, readOnly: true},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
   xAxis: [{
        type: 'category',
        axisTick: {
            show: false
        },

        data:dataProvince
    }],
    yAxis : [
        {
            type : 'value',
            scale:true,
            axisLabel : {
                formatter: '{value} 岁'
            }
        }
    ],
    series : [
        {
            name:'女性',
            type:'scatter',
            data: data4Female 
            ,
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        },
        {
            name:'男性',
            type:'scatter',
            data: data4Man
             ,
            markPoint : {
                data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                ]
            },
            markLine : {
                data : [
                    {type : 'average', name: '平均值'}
                ]
            }
        }
    ]
};
                    
	
 myChart4.setOption(option4);                   

</script>

<!-- 热门关键字的搜索yun  -->
<script type="text/javascript">
	  // 基于准备好的dom，初始化echarts实例
        var myChart3 = echarts.init($('#historyWordCloud')[0]);
        
		function createRandomItemStyle() {
		 return {
		        normal: {
		            color: 'rgb(' + [
		                Math.round(Math.random() * 160),
		                Math.round(Math.random() * 160),
		                Math.round(Math.random() * 160)
		            ].join(',') + ')'
		        }
		    };
		}
		
		var data = [];
		var url = '<%=basePath%>getTagCloud.action';
		$.ajax({
			async:false,
			type:'post',
			url:url,
			datatype:'json',
			success:function(data2){
				data2 = JSON.parse(data2);
				for(var i = 0; i < data2.length; i++) {
					data.push({
        			 	name: data2[i].tagName,
				     	value: data2[i].value*5,
				     	textStyle:createRandomItemStyle() 
				     });
				}	
			}
		});

		var option = {
		    title: {
		        text: '热门标签和搜索',
		        subtext:'字符云'
		    },
		    tooltip: {
		        show: true
		    },
		    series: [{
		        /* name: 'Google Trends', */
		         tooltip:{
                	 trigger: 'item',
                    formatter: "{b}   {c}次"
                	},
		        type: 'wordCloud',
		        size: ['80%', '80%'],
		        textRotation : [0, 45, 90, -45],
		        textPadding: 0,
		        autoSize: {
		            enable: true,
		            minSize: 14  
		        },
		        data: data  	 

		  }]
	  };
        // 使用刚指定的配置项和数据显示图表。
        myChart3.setOption(option);
 
</script>

<!--绘图    每日访问量-->
<script type="text/javascript">
	/*历史访问量  */
   var myChart = echarts.init($('#historyPageView')[0]);
    // 指定图表的配置项和数据
        var option = {
    title : {
        text : '每日访问量',  
    },
    tooltip : {    //hover 回调
        trigger: 'item',
        formatter : function (params) {
            var date = new Date(params.value[0]);
            data = date.getFullYear() + '-'
                   + (date.getMonth() + 1) + '-'
                   + date.getDate();
            return data + '<br/>'
                   + params.value[1] + ' 次';
        }
    }, 
    toolbox: {   //工具栏
        show : true,
         color : ['#1e90ff','#22bb22','#4b0082','#d2691e'], 
        feature : {
            dataView : {show: true, readOnly: false},
            magicType : {show: true, type: ['line', 'bar']},
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    dataZoom: {   //局域缩放
        show: true,
        backgroundColor:'white',
        fillerColor: 'rgba(38,143,26,0.6)',
        start : 10
    },
    legend : {
        data : ['访问量']
    },
    grid: {
        y2: 80
    },
    xAxis : [
        {
            type : 'time',
            splitNumber:15  //分段
        }
    ],
    yAxis : [
        {
            type : 'value'
            
        }
    ],
    series : [
        {
            name: '访问量',
            type: 'line',
            showAllSymbol: true,
            markPoint:{
          		  data : [
                    {type : 'max', name: '最大值'},
                    {type : 'min', name: '最小值'}
                   
                ],
                 tooltip : {   
                       show:false
                    },
                 itemStyle : {
                 	normal:{
                 		color:'#008acd'
                 	}
                 }
             },
             markLine : {
            	 tooltip:{
                	 trigger: 'item',
                    formatter: "平均值{c}"
                	},
                 itemStyle : {
                    normal: {
                        color:'#008acd',
                        borderWidth:3 //又是出不来效果 
                    	}
                	},   
                  data : [
                    {type : 'average', name: '平均值'}
                	]
             },
            itemStyle:{
            	normal:{
            		color:'#2ec7c9'
            	}
            },
            symbolSize: function (value){
                return Math.round(value[1]/2);
            },
            data: (function () {
                var url = '<%=basePath%>getPageViewAll.action';
                var d = [];	
                $.ajax({
                	async: false,
				  	type : "post",
				  	url : url,
				 	datatype : "json",
				  	success:function(data){
				  		data = JSON.parse(data);
				  		for(var i = 0; i < data.length; i++) {
	 				  		d.push([
	                			//new Date(2017, 08, 18, 02, 28),
	                        	 new Date(Number(data[i].n), Number(data[i].y)-1, Number(data[i].r)),
	                        	(Math.random()*5).toFixed(0)+Number(2) 
	                        	//data[i].pageViewCount.toFixed(0)
	                			]);
				   		 }
				  		}
               		 });
                return d; 
            })()
        }
    ]
};
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
 
</script>


<!--用户detail  和今日汇总   登入者等信息  -->
<script type="text/javascript">

	//退出登入
	$(function(){
		$('#loginOut').click(function(){
			if(confirm('是否确认退出？')) {
				var url = '<%=basePath%>cancealAdminLogin.action';
				$.post(url);
				window.location.href = '<%=basePath%>User/Login.jsp';
			}
		});
	});
	
	//得到登入者登入次数和时间  今日基本信息
	$(function(){
		var url = '<%=basePath%>getAdminDetail.action';
		$.post(url,function(data){
			$('#loginCount').text(data.admin.greatCount);
			//var time = Number(data.admin.registerDate.month)+Number(1)+'月'+data.admin.registerDate.date+'日'+'  '+data.admin.registerDate.hours+':'+data.admin.registerDate.minutes+':'+data.admin.registerDate.seconds;
			var time = data.loginTime;
			$('#loginTime').text(time);
			//赋值今日基本汇总
			$('#login').text(data.statistics.loginCount);
			$('#answer').text(data.statistics.answerCount);
			$('#question').text(data.statistics.questionCount);
			$('#register').text(data.statistics.registerCount);
			$('#comment').text(data.statistics.commentCount);
			$('#article').text(data.statistics.articleCount);
			$('#pageView').text(data.statistics.pageViewCount);
			
		}
		,'json');
	});


    //一下为修改基本信息部分
	//当模态框show的时候调用事件  得到基本信息
	var password;
	var userId ;
	var loginTime;
	var loginCount;
	$('#seeUserInfo').on('show.bs.modal',function(){
			var url = '<%=basePath%>getAdminDetail.action';
			$.post(url,function(data){
				if(('sta' in data)) {
					window.location.href = '<%=basePath%>User/Login.jsp';
				}else {
					userId = data.admin.id;
					password = data.admin.password;
					loginTime = data.loginTime;
					loginCount = data.admin.greatCount;
					$('#truename').val(data.admin.background);
					$('#username').val(data.admin.username);
					$('#usertel').val(data.admin.individualSignature);
				}
			}
			,'json');
		}
	);
	//清空
	$('#seeUserInfo').on('hidden.bs.modal',function(){
		$('.modal-content input').each(function(){
			$(this).val('');
			$(this).parent().prev().children('.message').text('');
		});
	});
 
	//若进行detail-update
	$('.btn-primary').click(function(){
		var flag = 1;
		$('td .must').each(function(){/* 对于必须输入的选项而言 */
			if($.trim($(this).val()) == '') {
				flag = 0;
				$(this).parent().prev().children('.message').text('请输入');
				$(this).parent().prev().children('.message').css('color', 'red');
			}
		});
		/* 如果输入了旧密码真确    保存新密码   */
		if($.trim($('#oldPassword').val()) == password) {
			if($.trim($('#newPassword').val()) != '' && ($.trim($('#newPassword').val()) == $.trim($('#confirmPassword').val()))) {
				 password = $.trim($('#newPassword').val());
			}else {
				flag = 0;//新密码和确认密码输入有问题
			}
		} 
		if(flag == 1) {  //更改个人信息
			//$('#form').submit();
			var url = '<%=basePath%>adminDetailUpdate.action?user.managerOrNot=true&user.id='+ userId + '&user.individualSignature='
					+ $.trim($('#usertel').val()) + '&user.password=' + password     + '&user.greatCount=' +loginCount +
					'&user.username=' + $.trim($('#username').val());
			var trueName = 	$.trim($('#truename').val());
			var ar = {'trueName':trueName, 'loginTime':loginTime };
			var args = JSON.stringify(ar);
			$.post(url,{json:args});	
			$('#seeUserInfo').modal('hide');				
		}
	});
	
	//如果是修改密码了
	$(function(){
		$('#oldPassword').blur(function(){
			if($.trim($(this).val()) != password) {
				$(this).parent().prev().children('.message').text('输入错误');
				$(this).parent().prev().children('.message').css('color', 'red');
			}else {
				$(this).parent().prev().children('.message').text('输入正确');
				$(this).parent().prev().children('.message').css('color', 'green');
			}
		});
		//检查确认密码是不是对
		$('#confirmPassword').blur(function(){
			if($.trim($(this).val()) != $.trim($('#newPassword').val())) {
				$(this).parent().prev().children('.message').text('不一致');
				$(this).parent().prev().children('.message').css('color', 'red');
			}else if($.trim($(this).val()) != '') {
				$(this).parent().prev().children('.message').text('输入正确');
				$(this).parent().prev().children('.message').css('color', 'green');
			}
		});
		
	});
	
	
</script>
</body>
</html>

