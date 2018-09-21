<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="zhquery.aspx.cs" Inherits="wx.Wb.yjquery" %>

<!DOCTYPE html>
<html lang="zh-Hans">
	<head>
	    <meta name="renderer" content="webkit|ie-comp|ie-stand">
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	    <meta charset="utf-8">
	    <title>账户查询</title>
	    <meta name="viewport" content="width=device-width,initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
	    <meta http-equiv="Cache-Control" content="no-siteapp">
	    <meta name="apple-mobile-web-app-capable" content="yes">
	    <meta name="mobile-web-app-capable" content="yes">    
        <script src="../CSS/js/jquery-2.1.4.js"></script>
	    <link rel="stylesheet" type="text/css" href="../CSS/index/css/base.css"/>
        <link rel="stylesheet" type="text/css" href="../CSS/index/css/base1.css"/>
	    <link rel="stylesheet" type="text/css" href="../CSS/index/css/common.css"/>
	    <link rel="stylesheet" type="text/css" href="../CSS/index/css/style.css"/>
        <link rel="stylesheet" type="text/css" href="../CSS/index/css/style1.css"/>
            <link rel="stylesheet" type="text/css" href="../CSS/index/css/loaders.min.css"/>
            <script type="text/javascript">
    	$(window).load(function(){
    		$(".loading").addClass("loader-chanage")
    		$(".loading").fadeOut(300)
    	})
    </script>
	</head>
    <!--loading页开始-->
<div class="loading">
	<div class="loader">
        <div class="loader-inner pacman">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
	</div>
</div>
<!--loading页结束-->
    <body class="fx-center">
		<div class="warp ">
			<!--header star-->
			<div class="header2  box-s" id="header">
				<div class="left1  fl">
					<a href="javascript:history.go(-1)" class="back">
						<img src="../CSS/index/images/left.png"/>
					</a>
				</div>
				<div class="middle  fl">
					我的账户
				</div>
			</div>
			<!--header end-->
			<!--p-center star-->
			<div id="main" style="margin-top:15%">
				<div class="p-top p-top1 ">	
				</div>
				<div class="p-list p-listtwo ">
					<ul id="list">
                 							
					</ul>
				</div>
				<div class="p-list p-listtwo clearfloat">
					<ul>		
					</ul>
				</div>
			</div>
			
		</div>
        <script>
            $(document).ready(
            //提交ajax请求获取cus
            $.ajax({
                type: "post",
                url: '../API/Get_Account.ashx',
                data: {
                    cusid:'<%=cusid%>'
                },
                async: true,
                success: function (data) {
                    var jsonobj = eval('(' + data + ')');
                    var htmlstr = "";
                    var listhtml = document.getElementById("list");
                    if (data != "") {                   
                        htmlstr = htmlstr + "<li class='box-s'><p class='fl '>" + jsonobj.Cus_name + "</p><span class='back fr'></span></li>";//客户名
                        htmlstr = htmlstr + "<li class='box-s tit'><p class='fl icon222'>可拿货额</p><p class='fr number'>￥" + jsonobj.Effective_Balance + "</p></li>";//可拿货额
                        htmlstr = htmlstr + "	<li class='box-s'><p class='fl icon222 icon224'>我的押金</p><span class='back fr'></span><p class='list-number fr'>￥" + jsonobj.Yajin + "</p></li>";//押金
                        htmlstr = htmlstr + "	<li class='box-s'><p class='fl icon222 icon224'>账户余额</p><span class='back fr'></span><p class='list-number fr'>￥" + jsonobj.Balance + "</p></li>";//账户余额
                    }
                    listhtml.innerHTML = htmlstr;
                }
            })
            );

        </script>
	</body>
    
</html>


