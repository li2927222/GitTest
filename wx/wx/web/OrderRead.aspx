<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderRead.aspx.cs" Inherits="wx.web.OrderRead" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>订货使用说明</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
</head>
<body>
    <div style="width:100%;">
      <h2>订货使用说明</h2>
        <h4>2016/12/19<span class="label label-default">微垣</span></h4>
   
   <div class="panel panel-default">
       <div class="panel-body">
          <div class="list-group">
              <div class="list-group-item">
           <h4 class="list-group-item-heading">上海微垣企业号二维码</h4>
      
             <div style="width:40%;float:left;margin-left:10px;margin-top:20px;margin-bottom:20px;">
                 <p class="list-group-item-text ">
                    关注上海微垣电子有限公司企业号后，打开订单，常规（非热销分货部分）手机订货和订单查询功能（所有订单，包含常规订单和分货订单）.

                 </p>
             </div>
               <div style="float:left;width:40%;position:relative;margin-left:10px;margin-top:5px;">
                     <img src="../image/weiyuan.jpg" style="height:177px; width:178px; margin-right:5%;margin-top:5px;" />
               </div>

        
              </div>
          </div>

       </div>

   </div>
        <div class="panel panel-default">
            <div class="list-group">          
               <h4 class="list-group-item-heading">下单页面：</h4>
                   <div class="list-group-item">

                    <p class="list-group-item-text">客户自行选择产品，产品有库存数量提示，根据实际情况订货。订货页面左下方有<font style="color:#ff0000">购物车标记 </font><img src="../image/a.jpg" style="height:25px;width:25px;"/>，可以查看购物车。</p>
                   </div>
                   <div class="list-group-item">

                    <p class="list-group-item-text">
                      页面底部有<font style="color:#ff0000">可拿货额度（根据客户的账款和信用额度综合计算出的结果），</font>客户最低库存（一般根据过去销量情况评估出的最低保障量），客户自己的库存（根据客户各个门店综合累加出的结果，当天凌晨的量）。</p>
                   </div>
             
                   <h4 class="list-group-item-heading">购物车界面：</h4>
                           <div class="list-group-item">
                        <p class="list-group-item-text">
                    客户选好手机商品和数量点击确认，进入购物车页面，该页面包含客户选择的商品以及数量，根据每个商品的在库量以及过去的周转情况自行调节可拿的量，可返回订货页面添加新的商品。用户订单确定，点击确认订货。
                   </p>
                   </div>
                  <div class="list-group-item">
                  <p class="list-group-item-text">
                      <font style="color:#ff0000"> 后台会根据实际的可拿货额、过去一个月的周转以及商品的在库量计算提醒客户是否下单成功。</font>如果没有成功提示，<font style="color:#0094ff">请根据提示对此订单修改后再提交</font>。 
                       </p>
                  </div>
                 <h4 class="list-group-item-heading">订单查询：</h4>
                    <div class="list-group-item">
                  <p class="list-group-item-text">
                      根据日期，订单状态，管理的客户查询实际的订单。订单包含：未处理（公司财务暂时没有处理）、待审核（财务正在处理）、已制单、已退回；如果退回，用户会接收到退回的消息和原因。
                      注意事项：确认订货提交后，财务会根据实际情况审核订单，审核通过生成发货单。客户可到订单查询，查询订单情况。
                       </p>
                  </div>
           </div>

        </div>
        <div class="panel panel-info">
            <div class="list-group">
               <h4 class="list-group-item-heading">常见问题</h4>
                <div class="list-group-item">
                    <p class="list-group-item-text">
                      某客户：我昨天刚打款为什么定不了货？
                    </p>
                    <p class="list-group-item-text">
                    答：请查看回款记录，<font style="color:#ff0000">状态是否是已入账或者查看可拿货额是否更新</font>，正常情况当回款被审核通过，可拿货额增加，客户的账户才有相应货款。
                    </p>
                </div>
                <div class="list-group-item">
                <p class="list-group-item-text">
                    某客户：我回款提交成功了，回款状态是已审核，说明财务已经审核了，按理我应该能定（XXXX）金额的货，为什么提示可用额度不够？
                       </p>
                <p class="list-group-item-text">
                    答：订单页面的可用额度 = 客户真实账款 – 当前订单的账款。所以请到订单查询界面查看订单，是否有通过业务下的订单，如果有，这部分货款实际上也是要占用货款的，那么实际上能拿货的货款就减少了。
                       </p>
                </div>
                     <div class="list-group-item">
                <p class="list-group-item-text">
                    某客户：为什么没有查到某某订单？
                       </p>
                <p class="list-group-item-text">
                    答：请选择相应的时间范围和状态，然后点击查询，可查看相关的订单。
                       </p>
                </div>
        </div>

   </div>
        </div>
<%--   <div class="weui_cells_form">
       <div class="weui_cells_title">
           使用说明：
1、通过扫码关注，关注后可以查看自己的余额、押金；
2、通过微信端填写代替短信；
3、回款登记使用：然后填写相应的回款信息、上传图片凭证（可以不传）。
                （如果没有编辑支付方式，请先编辑支付方式。）
4、本应用利用微信的安全机制，请妥善保管微信密码。
后期逐步开放订单功能。

       </div>

   </div>--%>
</body>
</html>