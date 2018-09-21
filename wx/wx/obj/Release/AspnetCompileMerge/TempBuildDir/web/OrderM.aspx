<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderM.aspx.cs" Inherits="wx.web.OrderM" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title>订单查询</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
<script>

</script>
    <script>
 
        $(document).ready(
          function () {
              $.ajax({
                  type: "post",
                  url: '../API/GetCus.ashx',
                  async: true,
                  success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                      var htmlstr = "";
                      var cusds = document.getElementById("select2");
                      if (data != "0") {
                          var str = new Array();
                          str = data.split("|");
                          var bankid = new Array();
                          var bankname = new Array();
                          cusid = str[0].split(",");
                          cusname = str[1].split(",");
                          //循环拼接语句向select3里添加html语句
                          for (var i = 0; i < cusid.length; i++) {
                              htmlstr = htmlstr + "<option value='" + cusid[i] + "' style='color:#888'>" + cusname[i] + "</option>";
                          }
                      }
                      cusds.innerHTML = htmlstr;
                      //   alert(htmlstr);
                  }
              });
              var cusds = localStorage.getItem("cus_id_storage");//XMLHttpRequest["back_cusid"];
              var cstate = document.getElementById("select1").value;
              var datefrom = $('#datefrom').val().replace(/-/g, "/");
              var dateto = $('#dateto').val().replace(/-/g, "/");
              // alert(datefrom+"|"+dateto+"|"+cusds+"|"+cstate);
              $.ajax({
                  type: "post",
                  url: '../API/Get_Cus_Order.ashx',
                  data: {
                      cus_id: cusds,
                      start_date: datefrom,
                      end_date: dateto,
                      state: cstate
                  },
                  async: true,
                  success: function (data) {
                      //alert(data);
                      var htmlstr = "";
                      var orderlines = document.getElementById("table1");
                      if (data != "") {
                          var str = new Array();
                          str = data.split("~");
                          var orderline = new Array();

                          //循环拼接语句向select3里添加html语句
                          for (var i = 0; i < str.length - 1; i++) {
                              var orderline1 = new Array();
                              orderline = str[i].split('|');
                              if (i > 0) {
                                  orderline1 = str[i - 1].split('|');
                                  if (orderline1[1] == orderline[1]) {//表示和前一单是同一个客户的,就在之前的基础上添加thead 和tbody，并给前一个table体封闭
                                      if (i == str.length - 2) {//最后一个和之前相同要封底、否则不封底
                                          htmlstr = htmlstr + "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3'  id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr></tbody>";
                                      } else { htmlstr = htmlstr + "<tr class='active'  id='" + orderline[5] + "'><td style='color:#1c8af3'   id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> "; }

                                  } else {
                                      if (i == str.length - 2) {//最后一个和之前相同要封底、否则不封底
                                          htmlstr = htmlstr + "</tbody><thead style='width:100%;overflow-x:auto'> <tr class='info'> <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                          "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                          "<tr class='active'  id='" + orderline[5] + "'><td style='color:#1c8af3'   id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td id='time'>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> </tbody>";
                                      } else {
                                          htmlstr = htmlstr + "</tbody><thead style='width:100%;overflow-x:auto'> <tr class='info' > <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                      "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                      "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3'  id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> ";
                                      }
                                  }

                              }
                              else if (i == 0) {//第一个 ==0
                                  htmlstr = htmlstr + "<thead style='width:100%;overflow-x:auto'> <tr class='info' > <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                      "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                      "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3' id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr>";
                              }


                          }
                      } 

                      orderlines.innerHTML = htmlstr;
                  }
              })
            //  alert(localStorage.getItem("cus_id_storage"));
              }

    );

    </script>
</head>
<body style="background-color:#ffffff;height:100%;" >  

     <div class="container-fluid" style="width:100%;padding:0 0; height: 211px;">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" style="width:100%">
         <label  style="left:10px;" >订单查询</label></div>    
    </div>
  
    <div class="panel-body" style="height:120px;top:-20px;width:100%">
              <div class="row" style="height:35px;width:100%;margin-top:2px;">   
                 <div  style="height:35px; width:49%;float:left;"> 
                     <div  style=" margin-left:15px; font-size:1.5rem;height:20px;width:25%;float:left;margin-top:5px;">
                      时间从
                         </div>
               <div  style="height:20px;width:60%;float:left;margin-top:5px;position:relative;">
                     <input type="date" id="datefrom" value="<%=DateTime.Now.ToString("yyyy-MM-dd")%>" class="form-control" />
                </div>
                    </div>
               <div  style="height:35px; width:49%;float:right;">
                   <div  style="margin-left:15px; font-size:1.5rem;height:20px;width:25%;float:left;margin-top:5px;">  
                     时间至</div>
                   <div  style="height:20px;width:60%;float:left;margin-top:5px;position:relative;">
                     <input type="date" id="dateto" value="<%=DateTime.Now.ToString("yyyy-MM-dd")%>" class="form-control" />
             </div>
                         </div>
              </div>
                  <div class="row" style="height:35px;width:100%; margin-top:10px;">        
        <div  style="height:35px; width:49%;float:left;"> 
            <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:25%;float:left;text-align:left;margin-top:5px;"><div style="margin-left:20%;width:auto;">状态</div></div>
 <div  style="height:20px;width:60%;float:left;margin-top:5px;position:relative;">
            <select id="select1" class=" form-control">
              <option>未处理</option>
              <option>待审核</option>
              <option>已制单</option>
              <option>已退回</option>
          </select>
     </div>
        </div>
                     <div  style="height:35px; width:49%;float:right;">
                   <div  style=" margin-left:15px;font-size:1.5rem;height:20px;width:25%;float:left;text-align:left;margin-top:5px;">  
                        <div style="margin-left:20%;width:auto;">客户</div></div>
                          <div  style="height:20px;width:60%;float:left;margin-top:5px;position:relative;">
                   <select id="select2" class=" form-control" >
                   
          </select>
                   </div>
               </div>
                </div>
   
         <div class="row" style="height:60px;width:100%; margin-top:5px;">   
             <div  style="height:35px;float:left;width:90%; margin-top:5px;">
                <div class="btn-group btn-group-sm" style="width:100%;"  ><button type="button" id="query" class="btn btn-success"  style="top:5px;left:16%;">查询</button></div>
               
                     </div>
          </div>
    </div>
    

        <div class="panel" style="height:100%;margin-top:10px;">
    <div class="panel-body">
          <div class="table-bordered" >
          <a href="#" class="list-group-item active" > 订单列表</a>
          <table id="table1" class="table table-hover table-bordered table-condensed" style="width:100%;overflow-x:auto">
          

          </table>
      </div>
    </div></div>
        
       </div>


 <script>
     $('#query').on('click', function () {
         //从接口获取数据
         //发送数据修改state
         var cstate = document.getElementById("select1").value;//XMLHttpRequest["back_cusid"];
         var cusds = document.getElementById("select2").value;
         var datefrom = $('#datefrom').val().replace(/-/g, "/");
         var dateto = $('#dateto').val().replace(/-/g, "/");
        // alert(datefrom+"|"+dateto+"|"+cusds+"|"+cstate);
         $.ajax({
             type: "post",
             url: '../API/Get_Cus_Order.ashx',
             data: {
                 cus_id: cusds,
                 start_date: datefrom,
                 end_date: dateto,
                 state:cstate
             },
             async: true,
             success: function (data) {
               //alert(data);
                 var htmlstr = "";
                 var orderlines = document.getElementById("table1");
                 if (data != "") {
                     var str = new Array();
                     str = data.split("~");
                     var orderline = new Array();

                     //循环拼接语句向select3里添加html语句
                     for (var i = 0; i < str.length - 1; i++) {
                         var orderline1 = new Array();
                         orderline = str[i].split('|');
                         if (i > 0) {
                             orderline1 = str[i - 1].split('|');
                             if (orderline1[1] == orderline[1]) {//表示和前一单是同一个客户的,就在之前的基础上添加thead 和tbody，并给前一个table体封闭
                                 if (i == str.length - 2) {//最后一个和之前相同要封底、否则不封底
                                     htmlstr = htmlstr + "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3'  id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr></tbody>";
                                 } else { htmlstr = htmlstr + "<tr class='active'  id='" + orderline[5] + "'><td style='color:#1c8af3'   id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> "; }

                             } else {
                                 if (i == str.length - 2) {//最后一个和之前相同要封底、否则不封底
                                     htmlstr = htmlstr + "</tbody><thead style='width:100%;overflow-x:auto'> <tr class='info'> <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                     "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                     "<tr class='active'  id='" + orderline[5] + "'><td style='color:#1c8af3'   id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td id='time'>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> </tbody>";
                                 } else {
                                     htmlstr = htmlstr + "</tbody><thead style='width:100%;overflow-x:auto'> <tr class='info' > <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                 "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                 "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3'  id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr> ";
                                 }
                             }
                         }
                         else if (i == 0) {//第一个 ==0
                             htmlstr = htmlstr + "<thead style='width:100%;overflow-x:auto'> <tr class='info' > <td>客户名称</td><td colspan='3'>" + orderline[1] + "</td> </tr>" +
                                 "<tr> <td>单号</td><td>时间</td><td>件数</td> <td>总额</td></tr></thead><tbody id='tbody1' style='width:100%;overflow-x:auto'>" +
                                 "<tr class='active' id='" + orderline[5] + "'><td style='color:#1c8af3' id='" + i + "' onclick='orderl(" + i + ")'>" + orderline[2] + "</td><td>" + orderline[0] + "</td> <td>" + orderline[3] + "</td><td>" + orderline[4] + "</td></tr>";
                         }


                     }
                 } else { htmlstr = "<tbody><tr><td>没有查询到数据!</td></tr></tbody>"; }

                 orderlines.innerHTML = htmlstr;
             }
         })
     }
    );

 </script>
 <script>
     function orderl(tmp) {
         var t = $('#' + tmp + '').parent().attr('id');
         var t1 = $('#' + tmp + '').text();
         var cus_id = document.getElementById("select2").value;
         if (window.localStorage)
         {
             // alert(t1);
             localStorage.setItem('cus_id_storage', cus_id);
             window.location = "../web/OrderDetail.aspx?order_id=" + t1 + "&order_from=" + t;
         }
    

     };
  
         //window.onbeforeunload = function()
         //{
         //    localStorage.clear();

         //}
   
 </script>
</body>
</html>
