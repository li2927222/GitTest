<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Readme.aspx.cs" Inherits="wx.web.Readme" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>回款使用说明</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/bootstrap-theme.min.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/js/bootstrap.js"></script>
<script src="../CSS/js/bootstrap.min.js"></script>
 
</head>
<body>
    <div style="width:100%;">
      <h2>使用说明<%=code %></h2>
        <h4>2017/07/01  <span class="label label-default">南京威沃企业号二维码</span></h4>
   
   <div class="panel panel-default">
       <div class="panel-body">
          <div class="list-group">
              <div class="list-group-item">
           <h4 class="list-group-item-heading">南京威沃企业号二维码</h4>
      
             <div style="width:40%;float:left;margin-left:10px;margin-top:20px;margin-bottom:20px;">
                 <p class="list-group-item-text ">
                     关注南京威沃电子有限公司企业号后，打开账户查询，查看可拿货额查询里的应收余额以及押金查询（客户押金指窜货低价保证金，柜台形象押金指柜台押金和形象制作押金）里的金额数额是否正确，如有出入请联系财务，联系方式：13951681297。
                 </p>
             </div>
               <div style="float:left;width:40%;position:relative;margin-left:10px;margin-top:5px;">
                     <img src="../image/南京威沃.png" style="height:177px; width:178px; margin-right:5%;margin-top:5px;" />
               </div>

        
              </div>
          </div>

       </div>

   </div>
        <div class="panel panel-default">
            <div class="list-group">
               <h4 class="list-group-item-heading">使用说明</h4>
           <%--     <div class="list-group-item">

                    <p class="list-group-item-text">一、因部分客户名称极其相似，业务没有填写完整，<font style="color:#ff0000">操作前请仔细核对客户与对应的联系人是否正确以及标颜色部分。</font>有问题立即联系修改，电话（仅近期微信端推广使用）。</p>
                </div>--%>
                   <div class="list-group-item">

                    <p class="list-group-item-text">
                       一、因部分客户提供的手机号和微信号不统一，及部分客户提供的微信号不存在等原因，所有客户<font style="color:#ff0000">以表格登记的正确手机号对应的微信</font>关注南京威沃企业号。</p>
                   </div>
                        <div class="list-group-item">
                        <p class="list-group-item-text">
                       二、关注南京威沃电子有限公司企业号后，进入<font style="color:#ff0000">客户回款</font>应用，点击<font style="color:#ff0000">账户查询</font>，查看<font style="color:#ff0000">可拿货额查询里的应收余额以及押金查询</font>（客户押金指窜货低价保证金，柜台形象押金指柜台押金和形象制作押金）里的押金数额是否正确。
                   </p>
                            </div>
                  <div class="list-group-item">
                   <p class="list-group-item-text">
                       三、点击个人中心编辑支付方式，进入<font style="color:#ff0000">打款账户</font>，录入常用付款账户信息。选择首选，以后登记回款时会默认该付款方信息。编辑完点击<font style="color:#ff0000">保存</font>。
                       </p>
                        </div>
           </div>

        </div>
        <div class="panel panel-info">
            <div class="list-group">
               <h4 class="list-group-item-heading">注意事项</h4>
                <div class="list-group-item">
                    <p class="list-group-item-text">
                        1、<%--<font style="color:#ff0000">进入平台后，不要试单</font>。--%>客户实际打款后，点击回款，回款登记。</p> <p class="list-group-item-text">                   
                        2、汇入账户已绑定，客户无需修改，向已该账户内汇款，变更需要直接联系公司财务。</p> <p class="list-group-item-text">                                       
                        3、<font style="color:#ff0000">如果支付的回款含有保证金或者押金</font>，点击其他按钮，录入保证金（低价窜货）或者押金（柜台形象）金额,不可将此部分写入货款，<font style="color:#ff0000">（注意：货款仅指正常采购回款）</font>其他操作不变。</p> <p class="list-group-item-text">
                        4、如果联系人管理多个客户，请根据实际情况逐一填写相应客户回款情况。</p> <p class="list-group-item-text">
                        5、<font style="color:#ff0000">为保证回款及时入账，请尽量上传回款成功凭证。</font>
                    </p>

                </div>
                <div class="list-group-item">
                     <p class="list-group-item-text">1、回款登记信息提交后，正常一小时(限工作日工作时间)后可点击回款查询查看已提交回款信息的状态，
                       </p> <p class="list-group-item-text">
                        2、若状态为未处理，说明财务尚未提取数据，此时客户可以点击这条信息，选择撤销，撤销后对应的回款登记信息状态变为废除，财务将不会再接收到这条信息。</p> <p class="list-group-item-text">
                        3、若回款登记信息状态为退回，说明财务未收到相应的货款，这条信息被财务退回给客户了。客户首先要检查登记的打款信息是否正确，如果正确，请联系财务仔细核对。如果确实是提交信息有误，请重新填写一份正确信息再提交。</p> <p class="list-group-item-text">
                        4、请勿重复提交同一笔打款信息。</p>
                </div>
        </div>
   </div>
        </div>
</body>
</html>
