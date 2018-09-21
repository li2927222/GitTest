<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddrM.aspx.cs" Inherits="wx.Wb.AddrM" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
         <meta name="format-detection" content="telephone=no" />
    <title>地址管理</title>
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
		<a class="icona" href="javascript:history.go(-1)">
				<img src="../CSS/index/images/left.png"/>
			</a>
		<h3>收货地址</h3>
			
			<a class="text-top" href="./Deliveryaddr.aspx?mark=add">
				添加
			</a>
	</header>
	<div class="contaniner fixed-conta" id="dlist">
<%--        <dl id='' class='address'><dt><p>瑾晨</p><span>13035059860</span><small>默认</small></dt><dd>安徽省合肥市XXXXXXXX</dd></dl>--%>         
	</div>
    <script>
        $(document).ready(
            function ()
            {
                $.ajax({
                    type: "post",
                    url: '../API/Get_Addrlist.ashx',
                    async: true,
                    success: function (data) {
                        var jsonobj = eval('(' + data + ')');
                        var htmlstr = "";
                        var listhtml = document.getElementById("dlist");

                        for (var i = jsonobj.list.length - 1; i >= 0; i--) {
                            var id = jsonobj.list[i].id;
                            if (jsonobj.list[i].checkdefault=='true')
                            {
                                htmlstr = htmlstr + "<dl id='" + jsonobj.list[i].id + "' class='address' onclick='goto(this)'><dt><p>" + jsonobj.list[i].Name + "</p><span>" + jsonobj.list[i].Telephone + "</span><small>默认</small></dt><dd>" + jsonobj.list[i].Province + jsonobj.list[i].City + jsonobj.list[i].County + jsonobj.list[i].address + "</dd></dl>";
                            } else {
                                htmlstr = htmlstr + "<dl id='" + jsonobj.list[i].id + "' class='address' onclick='goto(this)'><dt><p>" + jsonobj.list[i].Name + "</p><span>" + jsonobj.list[i].Telephone + "</span></dt><dd>" + jsonobj.list[i].Province + jsonobj.list[i].City + jsonobj.list[i].County + jsonobj.list[i].address + "</dd></dl>";
                            }             
                        }
                        listhtml.innerHTML = htmlstr;
                    }
                })
            });

        function goto(tmp)
        {
       //  $(this).attr('id');只能用在当前this已经定义的事件里 eg:$(":button").click(  function(){  $(this).parent().parent().remove();  }   );
           
          window.location = "../Wb/Deliveryaddr.aspx?mark=update&id="+tmp.id;
        }
    </script>
    </body>
    </html>