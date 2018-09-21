<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail_Reports.aspx.cs" Inherits="wx.web.Detail_Reports" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>发退货明细列表</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/index/css/loaders.min.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
    <script>
        //向接口发送数据绑定页面  
        $(document).ready(
               function () {
                   $.ajax({
                       type: "post",
                       url: '../API/Get_Detail_Reports.ashx',
                       data: {
                           bill_id: '<%=bill_id%>'                     
                       },
                       async: true,
                       success: function (data) {//如果返回0接收成功，跳转到明细，否则提示没有这单
                           if ($.trim(data) != "")
                           {//循环输出
                               var htmlstr = "";
                               var lines = document.getElementById("tbody1");
                               var str = new Array();
                               var str0 = data.split('.total_price');
                               str = str0[0].split(",,");
                               var orderline = new Array();     
                               //循环拼接语句向select3里添加html语句
                               for (var i = 0; i < str.length - 1; i++) {
                                   orderline = str[i].split("|");
                                   htmlstr = htmlstr + "<tr><td>"+orderline[0]+"</td><td>"+orderline[1]+"</td><td>"+orderline[2]+"</td><td>"+orderline[3]+"</td></tr>";
                               }
                               lines.innerHTML = htmlstr;
                               //计算tr里的内容赋值给tfoot
                               var tableObject = $('#table1'); //获取id为tableSort的table对象                             
                               var tbBody = tableObject.children('tbody'); //获取table对象下的tbody
                               var tbBodyTr = tbBody.find('tr'); //获取tbody下的tr
                               //循环单元格计算总数量和总金额
                               var tmpxj = 0;
                               var tmpzje = 0;
                               tbBodyTr.each(function () {
                                   var tds = $(this).find('td');
                                   tmpxj =tmpxj+parseFloat($(tds[2]).html());
        
                            //       alert($(tds[0]).html() + '|' + $(tds[1]).html() + '|' + $(tds[2]).html() + '|' + parseFloat($(tds[3]).html()));
                               });
                               document.getElementById("total_qty").innerHTML = tmpxj;
                               document.getElementById("total_mny").innerHTML = str0[1];
                               //$('total_qty').html(tmpxj);
                              // $('total_mny').html(tmpzje);
                           } else
                           {
                               alert("没有此单详细");
                           }
                       }
                   });
               })
    </script>
</head>
<body style="height:100%;">
   <div class="container-fluid" style="width:100%;padding:0 0; height:100%">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" >
         <img alt="Brand" src="../image/back.png" onclick="back()" style="margin-top:0px;"/>  单据详情    
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
                  <td>总额</td>
              </tr>
          </thead>
          <tbody id="tbody1">     
          </tbody>
           <tfoot>
               <tr>
                   <td colspan="2">合计</td>
                   <td style="color:#ff0000" id="total_qty"></td>
                   <td style="color:#ff0000" id="total_mny"></td>
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
   
  </script>
</body>
</html>
