<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Detail_Report.aspx.cs" Inherits="wx.web.Detail_Report" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="utf-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width"/>
    <title>明细帐流水</title>
    <link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
    <link rel="stylesheet" type="text/css" href="../CSS/index/css/loaders.min.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
      <script type="text/javascript">
    	$(window).load(function(){
    	    $(".loading").addClass("loader-chanage");
    	    $(".loading").fadeOut(400);
    	})
    </script>
    <style>
        body { padding-bottom: 70px; }
    </style>
   
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
<body>
 
        <div class="panel-body" >
          <a href="#" class="list-group-item active" > 明细账列表</a>
              <table class="table table-hover"  style="width:100%; background-color: #d9edf7;"> 
                  <thead style=" background-color: #d9edf7;"><tr >
                        <td colspan='2'>客户名称</td>
                        <td colspan='4' id="cus_name"></td>
                  </tr></thead></table>   
             
       <div  class="table-responsive" >   
               <table class="table table-hover table-bordered" id="tableSort">
                <thead>             
                <tr class="bg-info">
                    <th type="date">时间</th>
                    <th type ="string" >单据类型</th>
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
</body>
   <script type="text/javascript">
        $(document).ready(//初始化页面即查询的数据，一般只给2个月内的数据
         function () {
             $.ajax({
                 type: "post",
                 url: '../API/Get_Ar_Detail.ashx',
                 data: {
                     cus_id: '<%=cusidstr%>'
                    
                 },
                 async: true,
                 success: function (data) {
                     //alert(data);
                     var htmlstr = "";
                     var detaillines = document.getElementById("Detail_table");
                     if (data != "") {
                         var str = new Array();
                         str = data.split(",,");
                         var detailline = new Array();
                         //循环拼接语句向select3里添加html语句
                         for (var i = 0; i < str.length - 1; i++) {
                             detailline = str[i].split('|');
                             if (detailline[1] == '发退货单')
                             { htmlstr = htmlstr + '<tr style="height:20px;" ><td>' + detailline[0] + '</td><td style="color:steelblue" id=' + detailline[5] + '>' + detailline[1] + '</td><td>' + detailline[2] + '</td><td>' + detailline[3] + '</td><td>' + detailline[4] + '</td></tr>'; }
                             else { htmlstr = htmlstr + '<tr style="height:20px;" ><td>' + detailline[0] + '</td><td id=' + detailline[5] + '>' + detailline[1] + '</td><td>' + detailline[2] + '</td><td>' + detailline[3] + '</td><td>' + detailline[4] + '</td></tr>'; }

                         }
                         detaillines.innerHTML = htmlstr;
                         var tableObject = $('#tableSort'); //获取id为tableSort的table对象
                         var tbHead = tableObject.children('thead'); //获取table对象下的thead
                         var tbHeadTh = tbHead.find('tr th'); //获取thead下的tr下的th
                         var tbBody = tableObject.children('tbody'); //获取table对象下的tbody
                         var tbBodyTr = tbBody.find('tr'); //获取tbody下的tr
                         //给表体中的发货单增加点击事件
                         tbBodyTr.each(function () {
                             $(this).click(function () {
                                 //如果是发货单就增加点击事件
                                 var tds = $(this).find('td');
                                 var tmp = $(tds[1]).attr("id");
                                 // var tmp = $(this).attr('id');
                                 var req = /.*?[A-Za-z]/;//南京都带宁？
                                 if (req.test(tmp)) {
                                     //  alert($(this).html());
                                     //跳转到明细
                                     window.location = "../web/Detail_Reports.aspx?bill_id=" + tmp;
                                 }
                             });
                         })

                         var sortIndex = -1;
                         //增加排序图标
                         var ascChar = "▲";
                         var descChar = "▼";
                         tbHeadTh.each(function () {//遍历thead的tr下的th
                             var thisIndex = tbHeadTh.index($(this)); //获取th所在的列号           
                             //给排序标题加“升序、降序” 小图标显示
                             var th = $(this);
                             if (th.html() == '时间') {
                                 th.html(th.html() + ascChar);
                             }
                         })
                         tbHeadTh.each(function () {//遍历thead的tr下的th
                             var th = $(this);
                             //  if (th.html() == '时间')
                             // {
                             var thisIndex = tbHeadTh.index($(this)); //获取th所在的列号
                             var th = $(this);
                             var req = /.*?时间/;

                             if (req.test(th.html())) {
                                 $(this).click(function () {//给当前表头th增加点击事件
                                     var dataType = $(this).attr("type");//点击时获取当前th的type属性值
                                     var th = $(this);
                                     if (th.html().indexOf(ascChar) == -1 && th.html().indexOf(descChar) == -1) {
                                         th.html(th.html() + ascChar);
                                     }
                                     else if (th.html().indexOf(ascChar) != -1) {
                                         th.html(th.html().replace(ascChar, descChar));
                                     }
                                     else if (th.html().indexOf(descChar) != -1) {
                                         th.html(th.html().replace(descChar, ascChar));
                                     }
                                     checkColumnValue(thisIndex, dataType);
                                 });
                             }

                         });
                         //对表格排序
                         function checkColumnValue(index, type) {
                             var trsValue = new Array();

                             tbBodyTr.each(function () {
                                 var tds = $(this).find('td');
                                 //获取行号为index列的某一行的单元格内容与该单元格所在行的行内容添加到数组trsValue中
                                 trsValue.push(type + ".separator" + $(tds[index]).html() + ".separator" + $(this).html() + ".separator" + $(this).attr("id"));
                                 $(this).html("");
                             });

                             var len = trsValue.length;

                             if (index == sortIndex) {
                                 //如果已经排序了则直接倒序
                                 trsValue.reverse();
                             } else {
                                 for (var i = 0; i < len; i++) {
                                     //split() 方法用于把一个字符串分割成字符串数组
                                     //获取每行分割后数组的第一个值,即此列的数组类型,定义了字符串\数字\Ip
                                     type = trsValue[i].split(".separator")[0];
                                     for (var j = i + 1; j < len; j++) {
                                         //获取每行分割后数组的第二个值,即文本值
                                         value1 = trsValue[i].split(".separator")[1];
                                         //获取下一行分割后数组的第二个值,即文本值
                                         value2 = trsValue[j].split(".separator")[1];
                                         //接下来将该列的单据号换位子,单据号
                                         id1 = trsValue[i].split(".separator")[2];
                                         id2 = trsValue[i].split(".separator")[2];

                                         //接下来是数字\字符串等的比较
                                         if (type == "number") {
                                             value1 = value1 == "" ? 0 : value1;
                                             value2 = value2 == "" ? 0 : value2;
                                             if (parseFloat(value1) > parseFloat(value2)) {
                                                 var temp = trsValue[j];
                                                 trsValue[j] = trsValue[i];
                                                 trsValue[i] = temp;
                                             }
                                         } else if (type = "date") {
                                             if (datecomppare(value1, value2)) {//该方法不兼容谷歌浏览器
                                                 var temp = trsValue[j];
                                                 trsValue[j] = trsValue[i];
                                                 trsValue[i] = temp;
                                             }
                                         } else {//字符串无所谓了
                                             if (value1.localeCompare(value2) > 0) {//该方法不兼容谷歌浏览器
                                                 var temp = trsValue[j];
                                                 trsValue[j] = trsValue[i];
                                                 trsValue[i] = temp;
                                             }
                                         }
                                     }
                                 }
                             }
                             for (var i = 0; i < len; i++) {
                                 $("tbody tr:eq(" + i + ")").html(trsValue[i].split(".separator")[2]);
                             }

                             sortIndex = index;
                         }
                         //2017-01-1这种日期比较
                         function datecomppare(date1, date2) {
                             var num = 0;
                             var beginDate = new Date(date1.replace(/-/g, "/"));
                             var endDate = new Date(date2.replace(/-/g, "/"));
                             if (beginDate >= endDate) { num = 0; }
                             return num;
                         }
                         var width = (window.innerWidth > 0) ? window.innerWidth : screen.width;
                         //alert(width);
                         $('#tableSort').width = width * 2;
                         $('#tableSort').width(width * 2);
                         $('#cus_name').html('<%=cusname%>');
                         //$('#tableSort th:first-child').width(width * 0.1);      
                     }
                     else {
                         var htmlstr = "<tr style='height:20px;' ><td>暂无历史往来</td></tr>";
                         var detaillines = document.getElementById("Detail_table");
                         detaillines.innerHTML = htmlstr;
                     }
                 }
             });
            
         }
       );
    </script>
</html>
