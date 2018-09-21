<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtCashInfo.aspx.cs" Inherits="wx.Wb.RtCashInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<title>回款登记</title>
<meta name="description" content=""/>
<meta name="keywords" content=""/>
<link href="../CSS/index/css/reset.css" rel="stylesheet"/>
<link href="../CSS/index/css/index.css" rel="stylesheet"/>
<link href="../CSS/index/css/font.css" rel="stylesheet"/>
<link href="../CSS/index/css/personal.css" rel="stylesheet"/>
<script src="../CSS/index/js/common.js"></script>
<link href="../CSS/index/css/swiper.css" rel="stylesheet"/>
</head>
<body>
   <div class="per wrapper">
    <div class="per-tit">
        <p>
          <%--  <img src="images/face.png" alt="">
            <span>阿狸的世界你不懂<br><small>欢迎来到亿尚家居微商城</small></span>--%>
        </p>
    </div>
    <ul class="per-info">
<%--        <li>
            <a href="../web/RtCash_s.aspx">
                <i class="iconfont">&#xe64e;</i>
                <span>回款上报</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
    
        <li>
            <a href="../web/RtCashQuery.aspx">
                <i class="iconfont">&#xe65d;</i>
                <span>回款查询</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>--%>
         <li id ="1" onclick="goto('1')">
            <a>
                <i class="iconfont"  >&#xe64e;</i>
                <span>回款上报</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
            <li id ="2" onclick="goto('2')">
            <a>
                <i class="iconfont"  >&#xe65d;</i>
                <span>回款查询</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
    </ul>
</div>
          <script>
        function goto(tmp) {
            var temp = $('#' + tmp + '').children('a').children('span').html();
            switch (temp)
            {
                case '回款上报':
                    window.location = "../web/RtCash_s.aspx";
                    break;
                case '回款查询':
                    window.location = "../web/RtCashQuery.aspx";
                    break;
                //case '历史对账单':
                //    window.location = "./Cus_choise.aspx?str=CheckAcc";
                //    break;
                default:break;
            }                        
        }
   </script>
        <script src="../CSS/lib/jquery-2.1.4.js"></script>
</body>
</html>
