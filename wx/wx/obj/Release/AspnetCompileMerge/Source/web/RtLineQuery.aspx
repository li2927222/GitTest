<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtLineQuery.aspx.cs" Inherits="wx.web.RtLineQuery" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
   <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-wi  dth, initial-scale=1, user-scalable=no"/>
    <title></title>
    <link rel="stylesheet" href="../CSS/lib/weui.min.css"/>
    <link rel="stylesheet" href="../CSS/css/jquery-weui.css"/>
    <link rel="stylesheet" href="../CSS/css/demos.css"/>
        <script src="../CSS/lib/jquery-2.1.4.js"></script>
        <script src="../CSS/js/jquery-weui.js"></script>
    <script>
        $(document).on("click", "#searchid", function () {

            //  alert("暂时未开放");

        });
        $(document).ready(function () {
           var datefrom ='<%=datefrom%>'; 
            var dateto = '<%=dateto%>';
            var cus =  '<%=cus%>';
           $.ajax({
               type: "post",
               url: '../API/Rtcash_detail.ashx',
               data: {
                   datefrom: datefrom,
                   dateto: dateto,
                   cus:cus

               },
               async: true,
               success: function (data) {//返回明细
                   if (data != "") {
                       var htmlstr="";
                       var str = new Array();
                       str = data.split(",");  
                       //循环拼接语句向select3里添加html语句
                       for (var i = 0; i < str.length - 1; i++) {
                           htmlstr = htmlstr + "  <a href='javascript:void(0);'  class='weui_cell' onclick='RtCashDetail(" + str[i].split("|")[0] + "," + 10000 + i + ")';><div class='weui_cell '>"
                             + " <p><label style='color:#383535 ;font-size:x-small'> 时间：" +
                           str[i].split("|")[1]
                             + "</label></p><p><label  style='color:#383535 ;font-size:x-small'> 金额: " +
                          str[i].split("|")[2] +
                           "</label></p></div><div class='weui_cell_ft'><label  style='font-size:x-small'>状态：</label><label id='" + 10000 + i + "'  style='font-size:x-small'> "
                              + str[i].split("|")[3] + "</label></div></a>";
                       }
                       $('#form1').html(htmlstr);
                   }                
               }
           });
        });
        function RtCashDetail(tmp,tmp1)
        {
           
            // alert(tmp);这个值代表labelid就是传过去的rtcash_num值（回款编号）,并转到明细页面
          //  tmp = tmp.replace(/[^u0000-u00FF]/g, function ($0) { return escape($0).replace(/(%u)(w{4})/gi, "&#x$2;") });
         //   var label = document.getElementById(tmp);
            var value = tmp;
            var label1 = document.getElementById(tmp1);
             var value1 = label1.textContent;
            $.ajax({
                cache: true,
                type: "post",
                //dataType: "text",
                url: "../web/RtCash_detail.aspx",//处理程序
                data: {
                    rtid:value,
                    state:tmp1
                   
                 
                },// 
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("未查到到明细！");
                },
                success: function () {
                    //跳转到../API/RtCashResult.aspx
                    window.location = "../web/RtCash_detail.aspx?rtid=" + value + "&state=" + value1;
                }
            });
        }
    </script>
</head>
<body>
    
   <div class="weui_search_bar" id="search_bar">
      <div class="weui_search_outer">
        <div class="weui_search_inner">
          <i class="weui_icon_search"></i>
          <input type="search" class="weui_search_input" id="search_input" placeholder="搜索"/>
          <a href="javascript:" class="weui_icon_clear" id="search_clear"></a>
        </div>
        <label for="search_input" class="weui_search_text" id="search_text">
          <i class="weui_icon_search"></i>
          <span>搜索</span>
        </label>
      </div>
      <a href="javascript:" class="weui_search_cancel" id="search_cancel" >取消</a>
    </div>
       <div class="weui_cells_title">回款头行</div>

      <div class="weui_cells weui_cells_access" >
    
          <div id="form1">
      
        
         </div>
      </div>

</body>
</html>
