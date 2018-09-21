<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderDetail.aspx.cs" Inherits="wx.web.OrderDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title>订单明细</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/swiper.min.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.min.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
<script src="../CSS/js/bootstrap.min.js"></script>
    <script>
        //向接口发送数据绑定页面
        var arr1 = new Array();
        $(document).ready(
               function () {
                   var order_id ='<%=order_id%>';
                   var order_from = '<%=order_from%>';
                   $.ajax({
                       type: "post",
                       url: '../API/Get_Order_Detail.ashx',
                       data: {
                           order_id: order_id,
                           order_from: order_from
                       },
                       async: true,
                       success: function (data) {//如果返回0接收成功，跳转到明细，否则提示没有这单
                           if ($.trim(data) !="")
                           {//循环输出
                               var htmlstr = "";
                               var orderlines = document.getElementById("tbody1");
                               var str = new Array();
                               str = data.split("~");
                               var orderline = new Array();     
                               
                               //循环拼接语句向select3里添加html语句
                               for (var i = 0; i < str.length - 1; i++) {
                                   orderline = str[i].split("|");
                                   htmlstr = htmlstr + "<tr><td>" + orderline[0] + "</td><td>" + orderline[2] + "</td><td>" + orderline[1] + "</td><td>" + orderline[3] + "</td></tr>";
                                   if (orderline[4] == '' || orderline == null) {
                                       
                                   } else {
                                       arr1[i] = '\n' + orderline[4];
                                   }
                               }
                               orderlines.innerHTML = htmlstr;
                           } else
                           {
                               alert("没有此单详细");
                           }
                           

                       }//erro直接pass.......

                   });
                   //  alert(localStorage.getItem("cus_id_storage"));

                   var state = $("#state").text();
                   if (state != '作废') {
                       $("#btn1").css('display','none');
                   }
               })




    </script>
</head>
<body style="height:100%;">
   <div class="container-fluid" style="width:100%;padding:0 0; height:100%">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" >
         <img alt="Brand" src="../image/back.png" onclick="back()" style="margin-top:0px;"/>  订单详情    
    </div>
    <div class="panel-body ">
        <div style="float:left;width:88%;">
                 <div class="row" style="height:40px;font-size:10px;margin-top:20px;">
                <div  style="height:20px; width:49%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:30%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">单号</div>
                         </div>
                              <label runat="server" id="sheet_id"  style="position:relative;font-size:1.5rem; top:0px;float:right;width:60%;height:20px; border-bottom:1px solid #808080;text-align:center">111111111111</label>
                     
                 </div>
               <div  style="height:40px; width:49%;float:right;">
                   <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:30%;float:left;text-align:left;margin-top:5px;">  
                        <div style="margin-left:20%;width:auto;">订单状态</div></div>
                  <label runat="server" id="state" style="position:relative;font-size:1.5rem; top:0px;width:60%;float:left; height:20px; text-align:center;border-bottom:1px solid #808080;color:#ff0000">未处理</label>
               </div>
                 </div>
              <div class="row" style="height:40px;font-size:10px;margin-top:5px;">
                       <div  style="height:20px; width:49%;float:left;"> 
                         <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:30%;float:left;text-align:left;margin-top:5px;">
                             <div style="margin-left:20%;width:auto;">制单时间</div>
                             </div>
                         <label runat="server" id="dtime"  style="position:relative;font-size:1.5rem; top:0px;float:right;width:60%;height:20px; border-bottom:1px solid #808080;text-align:center"></label>
                      </div>
                       <div  style="height:40px; width:49%;float:right;">
                           <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:30%;float:left;text-align:left;margin-top:5px;">  
                                <div style="margin-left:20%;width:auto;">总额</div></div>
                           <label runat="server" id="total" style="position:relative;font-size:1.5rem; top:0px;width:60%;float:left; height:20px; text-align:center;border-bottom:1px solid #f6421a">222.00</label>
                       </div>   
               </div>
                <div class="btn-group btn-group-sm" style="width:100%;"  ><button type="button" id="btn1" class="btn btn-success"  style="top:5px;left:16%;">查询</button></div>
                 </div>
       
             
    
    </div>
        <div class="panel" style="height:100%">
<div class="panel-body" style="margin-top:10px;">   
         <div class="table-bordered" >
          <a href="#" class="list-group-item active"  > 详细列表</a>
          <table id="table1" class="table table-hover table-bordered table-condensed" style="width:100%;overflow-x:auto">
          <thead>
              <tr>
                  <td>名称</td>
                  <td>单价</td>
                  <td>数量</td>
                  <td>金额</td>
              </tr>
          </thead>
          <tbody id="tbody1">     
          </tbody>
           <tfoot>
               <tr>
                   <td colspan="2">合计</td>
                   <td style="color:#ff0000" id="total_qty" runat="server"></td>
                   <td style="color:#ff0000" id="total_mny" runat="server"></td>
               </tr>
           </tfoot>
          </table>
      </div>
     </div></div>
        
        </div>
        </div>
 
  <script>
      function back()
      {
          history.back();
      }
      $('#btn1').click(function () {
          if (arr1 == "" || arr1 == null) {
              alert('人工退回,请联系管理员');
          } else {
              alert('系统校验未通过:' + arr1);
          }
          
      });
  </script>
</body>
</html>
