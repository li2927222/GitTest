<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AccQuery.aspx.cs" Inherits="wx.Wb.AccQuery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
<title>账户查询</title>
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

        </p>
    </div>
    <ul class="per-info" id="ulist">
        <li id ="1" onclick="goto('1')">
            <a>
                <i class="iconfont"  >&#xe64e;</i>
                <span>账户查询</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
    
           <li id="2" onclick="goto('2')">
            <a >
                <i class="iconfont" onclick ="goto()">&#xe64e;</i>
                <span>明细帐查询</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
            <li id="3" onclick="goto('3')">
            <a >
                <i class="iconfont" onclick ="goto()">&#xe64e;</i>
                <span>历史对账单</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>
                <li id="4" onclick="goto('4')">
            <a >
                <i class="iconfont" onclick ="goto()">&#xe64e;</i>
                <span>发票接收函</span>
                <i class="iconfont icon2">&#xe6ba;</i>
            </a>
        </li>

    </ul>
          <script>
        function goto(tmp) {
            var temp = $('#' + tmp + '').children('a').children('span').html();
            switch (temp)
            {
                case '账户查询':
                    window.location = "./Cus_choise.aspx?str=Acc";
                    break;
                case '明细帐查询':
                    window.location = "./Cus_choise.aspx?str=Detail";
                    break;
                case '历史对账单':
                    window.location = "./Cus_choise.aspx?str=CheckAcc";
                    break;
                case '发票接收函':
                    window.location = "./Cus_choise.aspx?str=CheckAcc";
                    break;
                default:break;
            }                        
        }
   </script>
        <script src="../CSS/lib/jquery-2.1.4.js"></script>
</div>
</body>
</html>
