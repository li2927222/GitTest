<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShipBill.aspx.cs" Inherits="wx.Wb.ShipBill" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" charset="utf-8"/>
    <title>快递查询</title>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
    <script src="../CSS/lib/jquery-2.1.4.js"></script>
    <script src="../CSS/js/jquery-weui.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
       <script type="text/javascript">
    	$(window).load(function(){
    		$(".loading").addClass("loader-chanage")
    		$(".loading").fadeOut(300)
    	})
    </script>
   <script charset="utf-8"  lang="javascript" type="text/javascript">
        //接口调用注册
        wx.config({
      debug: false,
      appId: 'wxa18c540ba64d0254',
      timestamp: '1490236320',
      nonceStr: 'wangzhaohuanshigeshabi1',//生成签名的随机字符串
      signature: '<%=sigurate%>',
      jsApiList: [
        'chooseImage',
        'previewImage',
        'uploadImage',
        'scanQRCode'
      ]
        });

       wx.ready(function () {
           jQuery("#scanQRCode2").click(function () {
               // alert(1);
               billinfo.innerHTML = "";
               wx.scanQRCode({
                   needResult: 1,
                   desc: 'scanQRCode desc',
                   success: function (res) {
                       // alert(JSON.stringify(res));
                       // var jsonobj = eval('(' + res + ')');
                       if (res.errMsg == 'scanQRCode:ok') {
                          // alert(res.resultStr.split(',')[1]);
                           $('#bill').val(res.resultStr.split(',')[1]);
                           $.ajax({
                               type: "post",
                               url: '../API/Get_Shipbill.ashx',
                               data: {
                                   bill: res.resultStr.split(',')[1]
                               },
                               //  dataType: JSON,
                               async: true,
                               success: function (data) {
                                   var jsonobj = eval('(' + data + ')');
                                   var htmlstr = "";
                                   for (var i = jsonobj.Traces.length - 1; i >= 0; i--) {
                                       htmlstr = htmlstr + " <li class='list-group-item'><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptTime + "</p><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptStation + "</p></li>";
                                   }

                                   billinfo.innerHTML = htmlstr;

                               }
                           });
                       }
                     //  else { alert(res.errMsg) }
                   
                       
                   },
                   error: function (res) {
                       if (res.errMsg.indexOf('function_not_exist') > 0) {
                           alert('版本过低请升级')
                       }
                   }
               });
           })
       })
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
<body style="background-color:#ffffff;height:100%;" >  

     <div class="container-fluid" style="width:100%;padding:0 0; height: 211px;">
    <div class="panel panel-info" style="width:100%;padding:0 0">
    <div class="panel-heading" style="width:100%">
         <label  style="left:10px;" >快递单查询</label></div>    
    </div>
    <div class="panel-body" style="height:120px;top:-20px;width:100%">
    
              <div class="row" style="height:35px;width:100%;margin-top:2px;">  
    <div class="col-lg-6">
    <div class="input-group">
      <input id="bill" type="text" class="form-control" placeholder="快递查询（顺丰）..." />
      <span class="input-group-btn">
        <button id="billquery"  class="btn btn-default" type="button">查询</button>         
      </span>
       <span class="input-group-btn">      <button id="scanQRCode2"  class="btn btn-default">扫码查询</button></span>
    </div><!-- /input-group -->
  </div><!-- /.col-lg-6 -->
    </div>
           <div class="panel" style="height:100%;margin-top:10px;">
    <div class="panel-body">
          <div class="table-bordered"  >
      <ul class="list-group" id="billinfo">
          </ul>
      </div>
    </div></div>
        </div>
         </div>
        <script>
            $('#billquery').on('click', function () {
                billinfo.innerHTML = "";
                var bill = $('#bill').val();
                if (bill == "") {
                    alert("请输出单号！");
                }
                else {
                    $.ajax({
                        type: "post",
                        url: '../API/Get_Shipbill.ashx',
                        data: {
                            bill: bill
                        },
                        //  dataType: JSON,
                        async: true,
                        success: function (data) {
                            var jsonobj = eval('(' + data + ')');
                            var htmlstr = "";
                         //   alert(jsonobj.State);
                            switch(jsonobj.State)
                            {
                                case "0":
                                    htmlstr = jsonobj.Reason;
                                    break;
                                case "1": break;
                                case "2":
                                    for (var i = jsonobj.Traces.length - 1; i >= 0; i--) {
                                    htmlstr = htmlstr + " <li class='list-group-item'><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptTime + "</p><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptStation + "</p></li>";
                                } break;
                                case "3":
                                    for (var i = jsonobj.Traces.length - 1; i >= 0; i--) {
                                    htmlstr = htmlstr + " <li class='list-group-item'><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptTime + "</p><p class='list-group-item-text'>" + jsonobj.Traces[i].AcceptStation + "</p></li>";
                                } break;
                                default:break;
                            }                         
                            billinfo.innerHTML = htmlstr;

                        }
                    });
                }

            });
            $('#billquery').on('click', function () {
                //获取返回的


            })
    </script>
     
</body>
</html>
