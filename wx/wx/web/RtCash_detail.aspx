<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtCash_detail.aspx.cs" Inherits="wx.web.RtCash_detail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <meta http-equiv="Access-Control-Allow-Origin" content="*"/>
   <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-wi  dth, initial-scale=1, user-scalable=no"/>

    <title></title>
    <link rel="stylesheet" href="../CSS/lib/weui.min.css"/>
    <link rel="stylesheet" href="../CSS/css/jquery-weui.css"/>
    <link rel="stylesheet" href="../CSS/css/demos.css"/>
    <script src="../CSS/lib/jquery-2.1.4.js"></script>
    <script src="../CSS/js/jquery-weui.js"></script>
    <script src="../CSS/js/swiper.js"></script>
    <script>
        $(document).on("click", "#giveup", function () {
            $.ajax({
                cache: true,
                type: "post",
  
                url: "../API/RtCashGiveup.ashx",//处理程序
                data: {
                    RtCash_num: '<%=rtid%>'
                
                },// 你的formid
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(XMLHttpRequest.readyState + textStatus + errorThrown + XMLHttpRequest.responseText);
                },
                success: function (data) {
                    if (data.text == "0") {
                        $.toast("撤销失败（可能原因：网络或者该回款已经处理或被锁定）！", function () {
                            console.log('close');
                            //停留在当前页面
                        });
                    } else {
                        $.toast("撤销成功！", function () {
                            $("#giveup").css({ visibility: "hidden" });
                            console.log('close');//保存完了跳转新页面
                            window.location.reload();
                        });
                    }
                }
            });
        });
    </script>
</head>
<body>
      <header class='demos-header'>
      <h1 class="demos-title">回款明细</h1>
    </header> 
       <div class="weui_cells weui_cells_form">
    <div class="weui_cell">
        <div class="weui_cell_hd"><label   class="weui_label"  style="color:#383535">客户 </label></div>     
        <div class="weui_cell_bd weui_cell_primary">
      <label id ="label2" runat="server" style="color:#7b7878"></label>
        </div>    
    </div>  
      <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535"> 汇出账户 </label></div>       
        <div class="weui_cell_bd weui_cell_primary">
      <label id ="label3" runat="server" style="color:#7b7878"></label>
        </div>    
      </div>   
      <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535">汇入账户 </label></div>
       
        <div class="weui_cell_bd weui_cell_primary">
      <label id ="label4" runat="server" style="color:#7b7878"></label>
        </div>      
    </div> 
      <div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label" style="color:#383535">总金额金额</label></div>
        <div class="weui_cell_bd weui_cell_primary">
        <label id ="label5" runat="server" style="color:#7b7878"></label>
        </div>
    
      </div>
      <div class="weui_cell">
        <div class="weui_cell_hd"><label for="dateid" class="weui_label" style="color:#383535" >日期</label></div>
        <div class="weui_cell_bd weui_cell_primary">
          <label id ="label6" runat="server" style="color:#7b7878"></label>
        </div>
      </div>

   <div class="weui_cell">
    <div class="weui_cells weui_cells_form">
      <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
          <textarea class="weui_textarea" id="tmemo" placeholder="备注" rows="3"  runat="server" style="color:#7b7878" readonly="readonly"></textarea>
          <div class="weui_textarea_counter"><span>0</span>/200</div>
        </div>
      </div>
    </div>
                 </div>
                 <div class="weui_cell" >
             <div class="weui_btn_area">
        <a class="weui_btn weui_btn_primary" runat="server" id="giveup" href="javascript:;" style="color:#D5D5D6" visible="false">撤 销</a>
      </div>          
        </div>
    </div>
</body>
</html>
