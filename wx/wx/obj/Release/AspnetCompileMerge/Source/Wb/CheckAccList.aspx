<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckAccList.aspx.cs" Inherits="wx.Wb.CheckAccList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>历史对账记录</title>
    <link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
    <script src="../CSS/js/jquery-2.1.4.js"></script>
    <script src="../CSS/js/bootstrap.js"></script>
    <script>
        $(document).ready(function ()
        {
            $.ajax({
                type: "post",
                url: '../API/Get_CheckList.ashx',
                data: {
                    cus_id: '<%=cus_id%>'
                },
                async: true,
                success: function (data) {
                    //alert(data);
                    var htmlstr = "";
                    var listhtml = document.getElementById("Detail_table");
                    if (data != "") {
                        var jsonobj = eval('(' + data + ')');
                        var htmlstr = "";
                        for (var i = 0; i < jsonobj.list.length ; i++) {
                            if (jsonobj.list[i].CheckMark == '1')
                            { htmlstr = htmlstr + '<tr style="height:20px;" onclick="goto(\'' + jsonobj.list[i].log_id + '\')" ><td  style="with:30%">' + jsonobj.list[i].log_id + '</td><td >' + jsonobj.list[i].Checkdate + '</td><td>' + jsonobj.list[i].CheckUser + '</td><td  style="color:red">已对账 </td></tr>'; }
                            else { htmlstr = htmlstr + '<tr style="height:20px;" onclick="goto(\'' + jsonobj.list[i].log_id + '\')" ><td  style="with:30%">' + jsonobj.list[i].log_id + '</td><td >' + jsonobj.list[i].Checkdate + '</td><td>' + jsonobj.list[i].CheckUser + '</td><td style="color:steelblue">未对账</td></tr>'; }
                          
                        }
                        listhtml.innerHTML = htmlstr;
                    } else {
                        var listhtml = document.getElementById("Detail_table");
                        listhtml.innerHTML = '<tr><td>暂无历史对账单</td></tr>';
                    };
                }
            });
        });
    </script>
</head>
<body style="background-color: #f2f2f2;margin-top:0px;">
    	<header style="position:fixed;top:0;left:0;height:36px;background-color:#428bca;width:100%">      
       <p style="margin-top:5px;font-size:20px;text-align:center"><%=cus_name%></p>      
	</header>
 <div class="panel-body" >       
       <div  class="table-responsive" style="margin-top:40px" >   
               <table class="table table-hover table-bordered" id="tableSort">
                <thead>             
                <tr class="bg-info">
                    <th type="string">流水号</th>   
                    <th type="date">对账时间</th>                     
                    <th type="string">对账人</th>     
                    <th type="string">单据状态</th>  
                </tr>
                </thead>        
                <tbody id="Detail_table" >
                </tbody>
            </table>
              </div>
       </div>              
    <script>
        function goto(tmp)
        {
         
          //  alert(tmp+'<%=cus_id%>'+'<%=cus_name%>');
            window.location = "./CheckAccount.aspx?cusid=" + '<%=cus_id%>' + "&cusname=" + '<%=cus_name%>'+"&log_id="+tmp;
        }
    </script>           
</body>
</html>
