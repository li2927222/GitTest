<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonInfo.aspx.cs" Inherits="wx.Wb.PersonInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<title>个人信息</title>
<meta name="description" content=""/>
<meta name="keywords" content=""/>
<link href="../CSS/index/css/reset.css" rel="stylesheet"/>
<link href="../CSS/index/css/index.css" rel="stylesheet"/>
<link href="../CSS/index/css/font.css" rel="stylesheet"/>
<link href="../CSS/index/css/personal.css" rel="stylesheet"/>
<script src="../CSS/index/js/common.js"></script>
<link href="../CSS/index/css/swiper.css" rel="stylesheet"/>
<script src="../CSS/lib/jquery-2.1.4.js"></script>
  <style type="text/css">
 .self{ width: 100%; margin-top: 3%;}
 .self dl{ width: 100%;}
 .self dl dt{ width: 90%; overflow: hidden; padding:4% 5%; background-color: #f7f7f7; }
 .self dl dt a{ width: 100%; display: block; overflow: hidden;}
 .self dl dt img{width: 6%; vertical-align: middle;}
 .self dl dt b{ color: #333; font-weight: normal; font-size: 1.594em; margin:0 3%;vertical-align: middle; }
 .self dl dt span{width: 4%; float: right;}
 .self dl dt span img{width: 100%;}
 .self dl dd{ width: 100%; border-top: solid 1px #c8c8c8;}
 .self dl dd ul{ width: 100%;display: table; overflow: hidden; background-color: #f7f7f7}
 .self dl dd ul li{ display: table-cell; width: 25%; text-align: center; padding: 5% 0;}
 .self dl dd ul li a{ width: 100%; display: block; height: 100%;}
 .self dl dd ul li img{ height: 50%;}
 .self dl dd ul li p{ font-size:1.55em; color: #666; padding-top: 4%;}
/*个人信息*/

  </style>
</head>
<body>
<div class="per wrapper">
   <section class="self">
        <dl>
				<dd>
						<ul>
							<li>
								<a>
									<img src="../CSS/index/images/order-icon01.png"/>
									<p>待发货</p>
								</a>
							</li>
							<li>
								<a>
									<img src="../CSS/index/images/order-icon03.png"/>
									<p>待付款</p>
								</a>
							</li>
							<li>
								<a>
									<img src="../CSS/index/images/order-icon02.png"/>
									<p>待收货</p>
								</a>
							</li>
							<li>
								<a>
									<img src="../CSS/index/images/order-icon04.png"/>
									<p>待评价</p>
								</a>
							</li>
						</ul>
				</dd>
			</dl>
         </section>
    	
    <div class="per-tit">
        <p>

        </p>
    </div>
    <ul class="per-info" id="ulist">
       
        <li id="1" onclick ="goto('1')">
            <a>
                  <i class="iconfont">&#xe65e;</i>
                <span>打款账户</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>       
        </li>
<%--        <li>
            <a>
                <i class="iconfont">&#xe6bd;</i>
                <span>积分商城</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>--%>
      <%--  <li id="2" onclick="goto('2')">
            <a>
                <i class="iconfont">&#xe640;</i>
                <span>收货地址</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
        <li>
            <a>
                <i class="iconfont">&#xe618;</i>
                <span>我的收藏</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>--%>
     
    </ul>
</div>

<footer>
        <ul class="wrapper">
            <li>
                <a href="../Wb/Default.aspx">
                    <i class="iconfont">&#xe60d;</i>
                    <p>首页</p>
                </a>
            </li>
       
            <li>
        <%--        <a href="./About.aspx">
                 <i class="iconfont">&#xe609;</i>
                    <p>关于维沃</p>
                </a>--%>
            </li>
            <li class="per">
                <a href="../Wb/PersonInfo.aspx">
                    <i class="iconfont">&#xe7af;</i>
                    <p>个人中心</p>
                </a>
            </li>
        </ul>
</footer>
<!-- 底部信息结束 -->
   <script>
        function goto(tmp) {
            var temp = $('#' + tmp + '').children('a').children('span').html();
            switch (temp)
            {
                case '打款账户':
                    window.location = "./BankAccount.aspx";
                    break;
                case '收货地址':
                    window.location = "./AddrM.aspx";
                    break;       
                default:break;
            }                        
        }
   </script>
</body>
</html>
