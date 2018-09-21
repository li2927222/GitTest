<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail_Report_Cuschoise.aspx.cs" Inherits="wx.web.Detail_Report_Cuschoise" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <title>客户选择</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
</head>
<body>
      <div class="container-fluid" style="width:100%;padding:0 0; height: 211px;">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" style="width:100%">
         <label  style="left:10px;" >客户选择</label></div>    
    </div>
         <div  style="height:auto;width:80%;margin-left:10%;margin-top:30%">
              <div class="list-group list-group-item-success active">
         <div id="select2">          
                  <ul class="list-group list-group-item-success active table-bordered">
                  <li class="list-group-item disabled">
                  客户选择
                 </li>      
        </ul>                     
   </div>
</div>
          </div>
          </div>
    <script>
        function goto(tmp)
        {
            $('input:radio[name='+tmp+']')[0].checked = true;
            var cusname = $('#' + tmp).text();
            var cus_id = $('#' + tmp).parent().attr('id');
            var cus_state = $('#' + tmp).attr('name');
            //跳转到订单页面
            if(cus_state=="已停用")
            {
                alert("当前客户已经被停用，请联系对用业务。");
            } else {
                window.location = "../web/Detail_Report.aspx?cusid=" + cus_id + "&cusname=" + cusname;
        }
   
        }
    </script>
    <script charset="utf-8">
        $(document).ready(
            //初次登陆清空所有的radio
          $('input:radio:checked').each(function(i,val){    
                  $("input:radio[name='"+val.name+"']:checked").attr('checked',false);            
          })
            );
        //提交ajax请求获取cus
        $.ajax({
            type: "post",
            url: '../API/GetCus.ashx',
            async: true,
            success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                var htmlstr = "<ul class='list-group list-group-item-success active table-bordered'> <li class='list-group-item disabled'> 客户选择</li>";
                var cusds = document.getElementById("select2");
                if (data != "0") {
                    var str = new Array();
                    str = data.split("|");
                    var bankid = new Array();
                    var bankname = new Array();
                    var cstate = new Array();
                    cusid = str[0].split(",");
                    cusname = str[1].split(",");
                    cstate = str[2].split(",");
                    //循环拼接语句向select3里添加html语句
                    for (var i = 1; i < cusid.length; i++) {
                        if (cstate[i] == "已停用") {
                            htmlstr = htmlstr + "<li class='list-group-item' style='color:#808080' id='" + cusid[i] + "' onclick='goto(" + i + ")'> <input type='radio' name='" + i + "'/><label id='" + i + "' name='"+cstate[i]+"'>" + cusname[i] + "</label></li>";
                        }
                        else { htmlstr = htmlstr + "<li class='list-group-item' id='" + cusid[i] + "' onclick='goto(" + i + ")'> <input type='radio' name='" + i + "'/><label id='" + i + "' name='"+cstate[i]+"'>" + cusname[i] + "</label></li>"; }
              
                    }
                }
                cusds.innerHTML = htmlstr+"</ul>";
          
            }
        });
    </script>
</body>
</html>
