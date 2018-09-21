<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CheckAccount.aspx.cs" Inherits="wx.Wb.CheckAccount" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="width=device-width,initial-scale=1.0, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>本期账款明细</title>
    <link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
    <script src="../CSS/js/jquery-2.1.4.js"></script>
    <script src="../CSS/js/bootstrap.js"></script>
    <script src="../CSS/index/js/watermark.js"></script>
        <style>
        body { padding-bottom: 70px; }
       .foot {
            height:0px;
            }
       
.ord_win{
    width: 100%;
    height: 100%;
    position: fixed;
    top:0;
    left:0;
    background: rgba(0, 0, 0, 0.6);
    z-index: 9999;
    display:none;

}
.ord_win_box{
    width: 80%;
    padding: 0 10px;
    border-radius: 4px;
    background-color: #fff;
    position: absolute;
    top:50%;
    left:50%;
    transform:translate(-50%, -50%);
    -webkit-transform:translate(-50%, -50%);
}

.ord_win .ord_win_tit{
    border-bottom:1px solid #ccc;
    line-height: 6rem;
    text-align: center;
    font-size: 1.5rem;
}
.ord_btn{
    width: 100%;    
    font-size: 1rem;
     padding: 6px 0;
}

.ord_btn  a{
    line-height: 3rem;
    width: 47%;
    text-align: center;
    border-radius: 1px;
}
.ord_win .cancle{
    margin-left: 0.32rem;
    border: 1px solid #ccc;
} 
.ord_win .submit{
    margin-right:0.08rem;
    background: #d8505c;
    color: #fff;
    border: 1px solid #d8505c;
}
.f_left{
    float: left;
}
.f_right{
    float: right;
}
.divleft {
    float:left;position:relative;width:40%;margin-top:10px;height:60%;
            }
.divright {
         float:left;margin-left:0px;width:60%   }
 .btn01 {
            height:80%; margin:4px 10px; background:#ff0000; border-radius:4px; text-align:center; font-size:12px; line-height:44px; color:#fff;}
    </style>
    <script>
        $(document).ready(//初始化页面即查询的数据，一般只给2个月内的数据
       function () {
           $.ajax({
               type: "post",
               url: '../API/Get_CheckAccount.ashx',
               data: {
                   cus_id: '<%=cus_id%>',
                   log_id:'<%=log_id%>'
                    
               },
               async: true,
               success: function (data) {
                   //alert(data);
                   var htmlstr = "";
                   var listhtml = document.getElementById("Detail_table");
                   var depositehtml = document.getElementById("Deposite_table");
                        if (data != "") {
                       var data1 = data.split('||')[0];
                       var data2 = data.split('||')[1];
                       depositehtml.innerHTML = '  <tr style="height:20px;" ><td  style="width:30%"><%=cus_name%></td><td><%=DateTime.Now.ToShortDateString()%></td><td>'+data2+'</td></tr>';
                       var jsonobj = eval('(' + data1 + ')');
                       if (jsonobj.list[0].Checkmark == '1') {
                           //移除class,添加新的class.移除点击按钮事件
                           $('#foot1').removeAttr('style');
                           $('#foot1').addClass('foot');
                           $('#foot1').empty();
                           // $('#save').unbind('click');
                           watermark({ watermark_txt: "确认对账!" });
                       }
                       var htmlstr = "";
                       for (var i = 0; i < jsonobj.list.length ; i++) {
                           htmlstr = htmlstr + '<tr style="height:20px;" ><td  style="width:30%">' + jsonobj.list[i].billdate + '</td><td >' + jsonobj.list[i].mm + '</td><td style="color:steelblue">' + jsonobj.list[i].balance + '</td><td>' + jsonobj.list[i].cdigets + '</td></tr>';
                       }
                       listhtml.innerHTML = htmlstr;
                   
                  
                   } else {
                       var listhtml = document.getElementById("Detail_table");
                       listhtml.innerHTML = '<tr><td>暂无待定对账单</td></tr>';
                   };
                 
               }
           })});
    </script>

</head>
            <!--loading页开始-->
<div class="loading">
	<div class="loader">
        <div class="loader-inner pacman">
          <div></div>
          <div></div>
          <div></div>
          <div></div>
          <div></div>
        </div>
	</div>
</div>
<!--loading页结束-->
<body style="background-color: #f2f2f2;margin-top:0px">
    	<header style="position:fixed;top:0;left:0;height:36px;background-color:#428bca;width:100%">
       
<%--      <a href="#" class="list-group-item active" > 明细账列表</a>--%>
                <p style="margin-top:5px;font-size:20px;text-align:center"><%=cus_name%></p>
           
	</header>
    <div style="height:80%;">

 <div class="panel-body" >
    
          <div  class="table-responsive" style="margin-top:40px" >   
               <table class="table table-hover table-bordered" id="tabledeposite">
                <thead>             
                <tr class="bg-info">
                     <th type="string">客户</th> 
                    <th type="date">截止时间</th>
                    <th type="number" >押金金额</th>                                                 
                </tr>
                </thead>        
                <tbody id="Deposite_table" >
            <%--    <tr style="height:20px;" ><td  style="width:30%"></td><td><%=DateTime.Now.ToShortDateString()%></td><td></td></tr>--%>
                </tbody>
            </table>
              </div> 
       <div class="bg-info">流水明细</div>
       <div  class="table-responsive" style="margin-top:0px" > 
               <table class="table table-hover table-bordered" id="tableSort">
                <thead>             
                <tr class="bg-info">
                    <th type="date">时间</th>
                    <th type="number" >本期发生额</th>
                    <th type="number">余额</th>
                    <th type="string">摘要</th>             
                </tr>
                </thead>        
                <tbody id="Detail_table" >
                </tbody>
            </table>
              </div>
       </div>  
    </div>
       
    <footer id="foot1" style="position:fixed;bottom:0;width:100%;background:#fff;height:10%;">
    <div class="divleft"><label  id="quetion" style="width:90%; font-size:12px;color:dodgerblue">如账单有疑问请联系负责业务员!</label></div> 
    <div class="divright"><div class="btn01"  id="save">确认</div></div>
    </footer>  
        <div class="ord_win">
    <div class="ord_win_box">
        <div class="ord_win_tit">确认账单无误？</div>
        <div class="ord_btn clearfix">
            <a href="#" id="cancle" class="cancle f_left">取消</a>
            <a href="#" id="submit" class="submit f_right">确定</a>
        </div>
    </div>
</div> 
    <script>
        $('#save').on('click', function () {      
            $('.ord_win').show();
            that = $(this);
        })

        $('#cancle').on('click', function () {
            $('.ord_win').hide();

        })
        $('#submit').on('click', function () {
                    $.ajax({
                type: "post",
                url: '../API/Update_CheckAccount.ashx',
                data: {
                    cus_id: '<%=cus_id%>',
                    log_id: '<%=log_id%>'
                },
                async: true,
                success: function (data) {
                    if (data == 'ok')
                    {
                        alert("提交成功！");
                        location.reload();
                    }
                    else {
                        alert("提交失败！");
                        location.reload();
                    }
                }
            })

        })
    </script>

</body>
</html>
