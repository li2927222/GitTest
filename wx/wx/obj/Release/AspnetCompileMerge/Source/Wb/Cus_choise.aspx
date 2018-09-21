<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cus_choise.aspx.cs" Inherits="wx.Wb.Cus_choise" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0">
<title>客户选择</title>
<meta name="description" content="">
<meta name="keywords" content="">
<link href="../CSS/index/css/reset.css" rel="stylesheet">
<link href="../CSS/index/css/personal.css" rel="stylesheet">
<link href="../CSS/index/css/font.css" rel="stylesheet">
<script src="../CSS/index/js/common.js"></script>
<script src="../CSS/lib/jquery-2.1.4.js"></script>
</head>
<body>
<div class="per1 wrapper">
    <div class="per-tit">
        <p>
          
        </p>
    </div>
    <ul class="per-info" id="cus_select">
    
     
    </ul>
</div>

<!-- 底部信息开始 -->
    <script>
        $(document).ready(
        //提交ajax请求获取cus
        $.ajax({
            type: "post",
            url: '../API/GetCus.ashx',
            async: true,
            success: function (data) {
                var htmlstr = "";
                var cusds = document.getElementById("cus_select");
                if (data != "0") {
                    var str = new Array();
                    str = data.split("|");
                    var cusid = new Array();
                    var cusname = new Array();               
                    cusid = str[0].split(",");
                    cusname = str[1].split(",");
                    for (var i = 1; i < cusid.length; i++) {
                       htmlstr = htmlstr + "<li id='" + cusid[i] + "' onclick='goto(" + cusid[i]+")'>  <a > <i class='iconfont'>客</i>  <span>"+cusname[i]+"</span> <i class='iconfont icon2'>&#xe6ba;</i> </a></li>";                    
                    }
                }
                cusds.innerHTML = htmlstr;
            }
        })
        );
      
        function goto(tmp) {
            var cus = '<%=str%>';
            var cusname = $('#'+tmp+'').children('a').children('span').html();
          //  alert(cusname);
            switch(cus)
            {
                case 'Acc':
                    window.location = "../Wb/zhquery.aspx?cusid=" + tmp + "&cusname=" + cusname;
                    break;
                case 'Detail':
                    window.location = "../web/Detail_Report.aspx?cusid=" + tmp + "&cusname=" + cusname;
                    break;
                case 'Order':
                    window.location = "../web/Ordering.aspx?cusid=" + tmp + "&cusname=" + cusname;
                    break;
                case 'CheckAcc':
                    window.location = "../Wb/CheckAccList.aspx?cusid=" + tmp + "&cusname=" + cusname;
                    break;
                default:break;
            }                        
        }
    </script>
</body>
</html>
