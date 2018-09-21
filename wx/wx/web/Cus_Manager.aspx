<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cus_Manager.aspx.cs" Inherits="wx.web.Cus_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <title>客户管理</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.min.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
   <script>
       $(document).ready(
             function () {
                 //请求当前客户所能看到的bank。
               
                 $.ajax({
                     type: "post",
                     url: '../API/GetEcCus.ashx',
                     async: true,
                     success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                         var htmlstr = "";
                         var cusds = document.getElementById("select1");
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
                 })
             }
       );
   </script>
</head>
<body style="height:100%;">
     <div class="container-fluid" style="width:100%;padding:0 0; height: 211px;">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading">
         <label  style="left:10px;width:60%;" >客户管理</label></div>    
    </div>
            <div class="panel-body" style="height:80px;top:-20px;border:1px solid #a1d5cd">
                <div class="row" style="height:35px;width:100%;margin-top:15px;">   
                 <div  style="height:35px; width:49%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:35px;width:30%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">客户</div>
                         </div>
                       <select id="select1" class=" form-control" style="position:relative; top:0px;float:right;width:60%;">
                         
                       </select>
                   </div>
               <div  style="height:35px; width:49%;float:right;" >
                
                     <div class="btn-group btn-group-sm" style="width:100%;"  ><button type="button" id="query" class="btn btn-success"  style="top:5px;left:25%;">查询</button></div>
             
               </div>
              </div>
                
    </div>
         <div class="panel-info" style="height:100%;min-height:350px; border:1px solid #a1d5cd"> 
                     <div class="row" style="height:35px;width:100%;margin-top:15px;">   
                 <div  style="height:35px; width:98%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:35px;width:35%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">客户名称</div>
                         </div>
                      <label id="cus_name" style="position:relative;height:35px; top:6px;float:right;width:55%;"></label>
                   </div>         
              </div>
                     <div class="row" style="height:35px;width:100%;margin-top:15px;">   
                 <div  style="height:35px; width:98%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:35px;width:35%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">状态</div>
                         </div>
                      <label id="cus_state"  style="position:relative; top:6px;float:right;width:55%;height:35px;"></label>
                   </div>         
              </div>
                     <div class="row" style="height:35px;width:100%;margin-top:15px;">   
                 <div  style="height:35px; width:98%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:35px;width:35%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">上次操作人</div>
                         </div>
                      <label  id="last_update_people" style="position:relative; top:6px;float:right;width:55%;height:35px;"></label>
                   </div>         
              </div>
                 <div class="row" style="height:35px;width:100%;margin-top:15px;">   
                 <div  style="height:35px; width:98%;float:left;"> 
                     <div  style=" margin-left:15px;font-size:1.5rem;height:35px;width:35%;float:left;text-align:left;margin-top:5px;">
                         <div style="margin-left:20%;width:auto;">上次操作时间</div>
                         </div>
                      <label id="last_update_time" style="position:relative; top:6px;float:right;width:55%;height:35px;"></label>
                   </div>         
              </div>
             <div class="row" style="height:40px;width:100%;margin-top:10%;">
                  <div class="btn-group btn-group-lg" style="width:30%;float:left;margin-left:2%;">
             <input id="submit" type="button" class="btn btn-success" value="停用"/>
            </div>
                 <div class="btn-group btn-group-lg" style="width:30%;float:left;position:relative;">
             <input id="submit1" type="button" class="btn btn-success" value="启用"/>

                 </div>
             </div>
        
         </div>
         </div>
    <script>
        $('#submit').on('click', function () {
            var cusds = document.getElementById("select1").value;
            if (cusds == "0") {
                alert("请先选择客户！");
            } else {
                $.ajax({
                    type: "post",
                    url: '../API/Updt_Cus_state.ashx',
                    data: {
                        cus_id: cusds,
                        mark: 0
                    },
                    async: true,
                    success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行                                   
                        if ($.trim(data) == "1") {
                            alert("停用成功！");
                            window.location = "../web/Cus_Manager.aspx?cusid="
                        } else {
                            alert("网络错误！");
                        }
                    }
                });
            }
           
        });
        $('#submit1').on('click', function () {
            var cusds = document.getElementById("select1").value;
            if (cusds == "0") {
                alert("请先选择客户！");
            } else {
                $.ajax({
                    type: "post",
                    url: '../API/Updt_Cus_state.ashx',
                    data: {
                        cus_id: cusds,
                        mark:1
                    },
                    async: true,
                    success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行                                   
                        if ($.trim(data) == "1") {
                            alert("启用成功！");
                            window.location = "../web/Cus_Manager.aspx?cusid="
                        } else {
                            alert("网络错误！");
                        }
                    }
                });
            }

        });

        $('#query').on('click', function () {
            //从接口获取数据
            //发送数据修改state
            var cusds = document.getElementById("select1").value;

            $.ajax({
                type: "post",
                url: '../API/Get_Cus_Stateinfo.ashx',
                data: { cus_id: cusds },
                async: true,
                success: function (data) {           
                    var str = new Array();
                    str = data.split("|");
                    //给对应的label
                    var label1 = document.getElementById('cus_name');
                    label1.textContent = str[0];
                    var label2 = document.getElementById('cus_state');
                    label2.textContent = str[1];
                    var label3 = document.getElementById('last_update_people');
                    label3.textContent = str[2];
                    var label4 = document.getElementById('last_update_time');
                    label4.textContent = str[3];
                }
            })
        }
     );
    </script>
</body>
</html>
