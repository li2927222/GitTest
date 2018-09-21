<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtCashQuery.aspx.cs" Inherits="wx.web.RtCashQuery" %>

<!DOCTYPE html>

<html xmlns:html5="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <link rel="stylesheet" href="../CSS/lib/weui.min.css"/>
    <link rel="stylesheet" href="../CSS/css/jquery-weui.css"/>
    <link rel="stylesheet" href="../CSS/css/demos.css"/>
    <script src="../CSS/lib/jquery-2.1.4.js"></script>
     <script src="/CSS//js/jquery-weui.js"></script>
    <script>
        $(document).ready(function () {
            var myDate = new Date();
            var a = myDate.getDate();
               var month = myDate.getMonth().toString();
               if (month >= 9) {
                   tmp = myDate.getFullYear().toString() + "-" + (myDate.getMonth()+1) + "-01";
               } else if (month > 0) {
                   month = "0" + month;
                   tmp = myDate.getFullYear().toString() + "-0" + (myDate.getMonth()+1) + "-01";
               } else {

                   tmp = myDate.getFullYear().toString() + "-01" + "-01";
               }

               datefrom.value = tmp;
        });//开始日期永远为5号，如果今天小于等于5号则开始日期为上个月5号，否则开始日期为本月5号
        //确认
        $(document).on("click", "#queryid", function () {

            var datefrom = $('#datefrom').val();//日期从
            var dateto = $('#dateto').val();//日期到
            var cus = $("#select1").find("option:selected").val();//客户编号
                    //跳转到../API/RtCashResult.aspx
                    window.location = "../web/RtLineQuery.aspx?datefrom=" + datefrom + "&dateto=" + dateto + "&cus=" + cus;
        });
    </script>
     <script> 
    </script>
</head>
<body>
 
<header class='demos-header'>
      <h1 class="demos-title">回款查询</h1>
    </header> 
       <div class="weui_cells weui_cells_form">
      <div class="weui_cell">
        <div class="weui_cell_hd"><label for="datefrom" class="weui_label" style="color:#383535">日期从</label></div>
        <div class="weui_cell_bd weui_cell_primary"> 
           <input class="weui_input" id="datefrom" type="date"  style="color:#383535" readonly ="readonly"/>
        </div>
      </div>

        <div class="weui_cell">
        <div class="weui_cell_hd"><label for="dateto" class="weui_label" style="color:#383535">日期到</label></div>
        <div class="weui_cell_bd weui_cell_primary">
        <input class="weui_input" id="dateto" type="date" value="<%=DateTime.Now.ToString("yyyy-MM-dd")%>" style="color:#383535" />
        </div>
      </div>
    <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535">选择 客户 </label></div>
      
        <div class="weui_cell weui_cell_select">
        <div class="weui_cell_bd weui_cell_primary">
          <select class="weui_select" name="select1"  id="select1" style="color:#383535">
         <%=getdata("select1") %>
          </select>
        </div>
      </div> 
    </div>  
     
    <div class="weui_cell">
          <div class="weui_btn_area">
        <a class="weui_btn weui_btn_primary" id="queryid" href="javascript:;">查询</a>
      </div>          
        </div>
    </div>
  
</body>
</html>
