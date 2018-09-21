<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cur_Inventory.aspx.cs" Inherits="wx.web.Cur_Inventory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <title>订单查询</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
</head>
<body>
     <div class="container-fluid" style="width:100%;padding:0 0; height: 211px;">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" style="width:100%">
         <label  style="left:10px;" >客户实时库存查询</label></div>    
    </div>
  
    <div class="panel-body" style="height:120px;top:-20px;width:100%">
        <div class="row" style="height:35px;width:100%; margin-top:10px;">        
                     <div  style="height:35px; width:49%;float:left ;">
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
          <a href="#" class="list-group-item active" > 库存列表</a>
          <table id="table1" class="table table-hover table-bordered table-condensed" style="width:100%;overflow-x:auto">
          

          </table>
      </div>
    </div></div>
        
       </div>

</body>
</html>
