<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="wx.Wb.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<title>山东首页</title>
<meta name="description" content=""/>
<meta name="keywords" content=""/>
<link href="../CSS/index/css/reset.css" rel="stylesheet"/>
<link href="../CSS/index/css/index.css" rel="stylesheet"/>
<link href="../CSS/index/css/font.css" rel="stylesheet"/>
<script src="../CSS/index/js/common.js"></script>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<link href="../CSS/index/css/swiper.css" rel="stylesheet"/>
</head>
<body>
<!-- banner区域开始 -->
 <div class="swiper-container">
        <div class="swiper-wrapper">
            <div class="swiper-slide"><a href="#"><img src="../CSS/index/images/banner14.jpg" alt=""/></a></div>
            <div class="swiper-slide"><a href="#"><img src="../CSS/index/images/banner13.jpg" alt=""/></a></div>
            <div class="swiper-slide"><a href="#"><img src="../CSS/index/images/banner15.jpg" alt=""/></a></div>
            <div class="swiper-slide"><a href="#"><img src="../CSS/index/images/banner3.jpg" alt=""/></a></div>
           
        </div>
        <!-- Add Pagination -->
        <div class="swiper-pagination"></div>
    </div> 

    <script src="../CSS/index/js/swiper.js"></script>
    <script>
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationClickable: true,
        loop:true,
        autoplay : 3000,
        speed:2000,
    });
    </script>
 
<!-- banner区域结束 -->

<!-- 产品分类展示区域开始 -->
<div class="pro wrapper">
    <div class="tit">
       <%-- <p>Product categories</p>
        <h2>产 | 品 | 分 | 类 </h2>--%>
    </div>
    <div class="content clearfix">
    <!-- 产品分类展示上边 -->
        <ul class="content1">
            <li id="001" class="pro1">
             <a href="#" onclick="Message(1)">
                    <p>商品选购</p>
                    <i class="iconfont">&#xe673;</i>
                </a>
            </li>
            <li id="002" class="pro1 pro2">
                <a href="#" onclick="Message(2)">
                    <p>订单查询</p>
                    <i class="iconfont">&#xe630;</i>
                </a>
            </li>
            <li id="003" class="pro1 pro3">
                <a href="#" onclick="Message(3)">
                    <p>账户查询</p>
                    <i class="iconfont">&#xe890;</i>
                </a>
            </li>
            <li id="004" class="pro1 pro4">
                <a onclick="Message(4)">
                    <p>新品上市</p>
                    <i class="iconfont">&#xece4;</i>
                </a>
            </li>
            <li class="pro1  pro5">
                 <a href="#"  onclick="Message(5)">
                    <p>回款上报</p>
                    <i class="iconfont">&#xe62d;</i>
                 </a>
            </li>
            <li class="pro1 pro6">
                <a href="#"  onclick="Message(6)">
                    <p>快递查询</p>
                    <i class="iconfont">&#xe6b5;</i>
                </a>
            </li>
        </ul>
    <!-- 产品分类展示下边-左 -->
      <%--  <ul class="content2 fl">
            <li class="pro7">
                <a href="smile.html">
                    <p>客户笑脸墙</p>
                    <i class="iconfont">&#xe63f;</i>
                </a>
            </li>
            <li class="pro7 pro8">
                <a href="goshow.html">
                    <p>晒家有礼</p>
                    <i class="iconfont">&#xe68e;</i>
                </a>
            </li>
        </ul>
    <!-- 产品分类展示下边-中 -->
        <ul class="content3 fl">
            <li class="pro7">
                <a href="search.html">
                    <p>查询门店</p>
                    <i class="iconfont">&#xe60f;</i>
                </a>
            </li>
        </ul>
    <!-- 产品分类展示下边-右 -->
        <ul class="content2 fl">
            <li class="pro7 pro9">
                <a href="../Wb/RtCashInfo.aspx">
                    <p>回款上报</p>
                    <i class="iconfont">&#xe61f;</i>
                </a>
            </li>
            <li class="pro7">
                <a href="coupons.html">
                    <p>优惠券</p>
                    <i class="iconfont">&#xe660;</i>
                </a>
            </li>
        </ul>--%>
    </div>
</div>
<%--    <div class="news">
    <div class="tit">
        <p> </p>
        <h2> </h2>
    </div>
    <!-- table标题 这里暂位子懒得改了 -->
    <div class="tab">
        <ul>
            <li class="tab1"> </li>
            <li class="tab2"> </li>
        </ul>
    </div>
        </div>--%>
<!-- 底部信息开始 -->
<footer>
        <ul class="wrapper">
            <li>
                <a href="./Default.aspx">
                    <i class="iconfont">&#xe60d;</i>
                    <p>首页</p>
                </a>
            </li>
  
            <li>
              <%--  <a href="#">
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
<script src="../CSS/index/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="../CSS/index/js/index.js"></script>
    <script>
        function Message(tmp)
        {    //实时获取权限
            $.ajax({
                type: "post",
                url: '../API/Get_Auth.ashx',
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert('网络传输错误！');
                },
                success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                    if (data.substr(tmp - 1, 1) == '1') {
                        switch (tmp) {
                            case 1:
                                window.location = './OrderModeSelect.aspx';
                                break;
                            case 2:
                                window.location = '../web/OrderM.aspx';
                                break;
                            case 3:
                                window.location = './AccQuery.aspx';
                                break;
                            case 4:
                                window.location = './AccQuery.aspx';
                                break;
                            case 5:
                                window.location = '../Wb/RtCashInfo.aspx';
                                break;
                            case 6:
                                window.location = './ShipBill.aspx';
                                break;
                            default:

                        }
                    } else { alert('功能未开放！'); }
                }
            })
        
        }
    </script>
</body>
</html>
