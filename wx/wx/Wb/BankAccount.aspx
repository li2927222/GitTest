<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankAccount.aspx.cs" Inherits="wx.Wb.BankAccount" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
         <meta name="format-detection" content="telephone=no" />
    <title>账户管理</title>
    <link rel="stylesheet" type="text/css" href="../CSS/index/css/loaders.min.css"/>
    <link rel="stylesheet" type="text/css" href="../CSS/index/css/base.css"/>
    <link rel="stylesheet" type="text/css" href="../CSS/index/css/style1.css"/>
     <script src="../CSS/index/js/jquery-1.9.1.min.js" type="text/javascript" charset="utf-8"></script>
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
<body>

	<header class="top-header fixed-header">
		<a class="icona" href="./PersonInfo.aspx">
				<img src="../CSS/index/images/left.png"/>
			</a>
		<h3>账户信息</h3>
			
			<a class="text-top" id ="newid">
				添加
			</a>
	</header>
	
	<div id="listhtml" class="contaniner fixed-conta">
	
   
        <dl  class='address'> 		</dl>
            	
            
	</div>
    <script>
                $(document).ready(
            //提交ajax请求获取cus
            $.ajax({
                type: "post",
                url: '../API/Get_bankAcc.ashx',
                async: true,
                success: function (data) {
                    var htmlstr = "";
                    var listhtml = document.getElementById("listhtml");
                    if(data!="")
                    {
                        var jsonobj = eval('(' + data + ')');
                        for (var i = jsonobj.list.length - 1; i >= 0; i--) {
                            if (jsonobj.list[i].isNow == 'True') {
                                htmlstr = htmlstr + "<dl id='" + jsonobj.list[i].id + "' onclick=RtCashDetail(this) class='address'> 	<a><dt><p>" + jsonobj.list[i].acc_bank + "</p><p>" + jsonobj.list[i].acc_name + "</p><span>" + jsonobj.list[i].acc_num + "</span><small>默认</small></dt><dd>" + jsonobj.list[i].acc_kind + "  " + jsonobj.list[i].yhmx + "</dd></a></dl>";
                            } else {
                                htmlstr = htmlstr + "<dl id='" + jsonobj.list[i].id + "' onclick=RtCashDetail(this) class='address'> 	<a><dt><p>" + jsonobj.list[i].acc_bank + "</p><p>" + jsonobj.list[i].acc_name + "</p><span>" + jsonobj.list[i].acc_num + "</span></dt><dd>" + jsonobj.list[i].acc_kind + "  " + jsonobj.list[i].yhmx + "</dd></a></dl>";
                            }
                        }
                    } 
                  listhtml.innerHTML = htmlstr;
                }
            }));
                function RtCashDetail(tmp) {             
                    window.location = "../Wb/BankInfo.aspx?mark=update&id=" + tmp.id;
                };
               // $(document).on("click", "#newid", function () {
                //    window.location = "../Wb/BankInfo.aspx?mark=add";//新增界面
               // });
                $("#newid").click(function () {
                    window.location = "../Wb/BankInfo.aspx?mark=add";//新增界面
                });
    </script>
    </body>
    
    </html>
