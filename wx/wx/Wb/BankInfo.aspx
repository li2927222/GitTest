<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankInfo.aspx.cs" Inherits="wx.Wb.BankInfo" %>
<!DOCTYPE html>
<html><head>
		<meta http-equiv="Content-Type" content="text/html"; charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0 user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <title>添加账号</title>
        <link rel="stylesheet" type="text/css" href="../CSS/index/css/style1.css"/>
     <link rel="stylesheet" type="text/css" href="../CSS/index/css/base.css"/>
    <script src="../CSS/js/jquery-2.1.4.js"></script>
        <script type="text/javascript">
    	$(window).load(function(){
    	    $(".loading").addClass("loader-chanage");
    	    $(".loading").fadeOut(300);
    	})
    </script>
    <style type="text/css">
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
    padding: 5px 10px;
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
<div>
  	<header class="top-header fixed-header">
		<a class="icona" href="javascript:history.go(-1)">
				<img src="../CSS/index/images/left.png"/>
			</a>
		<h3>添加账号</h3>	
	</header>
    
<div style="margin-top:24%">
    <div class="address_main">
        <input type="hidden" id="accid" value="">
        <div class="line">
            <div  style="float:left;width:30%;position:relative">   <label style="height:40px; width:100%; border-bottom:1px solid #f0f0f0; line-height:44px; margin-top:1px;font-size:16px">支付方式</label></div>
           <div style="float:left;margin-left:10px;width:60%;">  <select  id="payway" name="payway">
            <option value="0" >- 请选择 -</option>
            <option value="1">银行卡</option>
            <option value="3">支付宝</option>
            <option value="4">现金打款</option>
                                                                </select><br>	</div>
      	
		</div>
        <div class="line">
            <input type="text" placeholder="账户名称" id="khmc" value="" >
        </div>
        <div class="line">
            <input type="text" placeholder="账户卡号" id="zhkh" >
        </div>
         <div class="line">
		   <div  style="float:left;width:30%;position:relative">   <label style="height:44px; width:100%; border-bottom:1px solid #f0f0f0; line-height:44px; margin-top:1px;font-size:16px">开户行</label></div>
           <div style="float:left;margin-left:10px;width:60%">  <select  id="khbank" name="khbank" >
                <%=Get_data("khbank") %>
           </select><br>	</div>
		 </div>
         <div class="line">
	     <input type="text" placeholder="详细开户行" id="bankdetail" value="">
		 </div>
       <div class="line">
            <div style="text-align:center;" id="deleteaddr"> <label style="color:#ff4f4f;font-size:1.6rem">删除账户</label></div>
       </div>
    </div>
    <div class="line">	
    <label style="height:44px; width:100%; border-bottom:1px solid #f0f0f0; line-height:44px; margin-top:10px;font-size:16px;margin-left:5px;">设置默认地址</label>
	<div class="piaochecked">               
                <input name="need_inv" id="Def_select" type="checkbox" style="height:20px;width:20px;" class="radioclass input" value="1">
              </div>		            
                   		
			</div>
    <div class="address_sub1"  id="save" >保存</div>
</div><br>
    </div>    
        
<div class="ord_win">
    <div class="ord_win_box">
        <div class="ord_win_tit">确认删除？</div>
        <div class="ord_btn clearfix">
            <a href="#" id="cancle" class="cancle f_left">取消</a>
            <a href="#" id="submit" class="submit f_right">确定</a>
        </div>
    </div>
</div>  
       <script>
           $(".piaochecked").on("click", function () {
               $(this).hasClass("on_check") ? $(this).removeClass("on_check") : $(this).addClass("on_check");
               // $(this).toggleClass( "on_check" );
           });
       </script>
        <script>
            $('#payway').change(function () {
                var accid = $('#accid').val();
                var khmc = $('#khmc').val();
                var zhkh = $('#zhkh').val();//账户卡号
                var payway = $('#payway').find("option:selected").html();
                var khbank = $('#khbank').find("option:selected").html();
                var bankdetail = $('#bankdetail').val();
                var Def_select = $(".piaochecked").hasClass("on_check");
                if (payway == '现金打款') {
                    //$('#khmc').val('');
                    //$('#zhkh').val('');
                    //$('#bankdetail').val('');
                 //   $('#khmc').removeAttr('readonly');
                    $('#zhkh').attr('readonly', 'readonly');
                    $('#zhkh').attr('style', 'background-color:lightgray');
                   // $('#khmc').attr('readonly', 'readonly');
                    //$('#khmc').attr('style', 'background-color:lightgray');
                    $('#khbank').attr('disabled', 'disabled');
                    $('#khbank').attr('style', 'background-color:lightgray');
                    $('#bankdetail').attr('readonly', 'readonly');
                    $('#bankdetail').attr('style', 'background-color:lightgray');
                }else if(payway=='支付宝')
                {
                    //$('#zhkh').val('');
                    //$('#bankdetail').val('');
                 //   $('#khmc').removeAttr('readonly');
                 //   $('#khmc').removeAttr('style');
                    $('#zhkh').attr('readonly', 'readonly');
                    $('#zhkh').attr('style', 'background-color:lightgray');
                    $('#khbank').attr('disabled', 'disabled');
                    $('#khbank').attr('style', 'background-color:lightgray');
                    $('#bankdetail').attr('readonly', 'readonly');
                    $('#bankdetail').attr('style', 'background-color:lightgray');

                }else if (payway == '银行卡')
                {
                    $('#zhkh').removeAttr('readonly');
                    $('#khbank').removeAttr('disabled');
                    $('#bankdetail').removeAttr('readonly');
                   // $('#khmc').removeAttr('readonly');
                    $('#zhkh').removeAttr('style');
                    $('#khbank').removeAttr('style');
                    $('#bankdetail').removeAttr('style');
                 //   $('#khmc').removeAttr('style');

                }
               // alert($('#khmc').attr('readonly'));             
            });
        </script>
        <script>
                	    $(document).ready(
                function () {                
                    var tmp = '<%=action_mark%>'
                    if (tmp == 'update') {
                        $.ajax({
                            type: "post",
                            url: '../API/BankManage.ashx',
                            data: {
                                mark: 'query',
                                accid: '<%=accid%>'
                            },
                            async: true,
                            success: function (data) {
                                var jsonobj = eval('(' + data + ')');
                                $('#accid').val(jsonobj.id);
                                $('#khmc').val(jsonobj.acc_name);
                                $('#zhkh').val(jsonobj.acc_num);
                                document.getElementById("payway").options[0].text = jsonobj.acc_kind;
                                document.getElementById("khbank").options[0].text = jsonobj.acc_bank;
                                $('#bankdetail').val(jsonobj.yhmc);
                                if (jsonobj.isNow == 'false') {
                                    $(".piaochecked").removeClass("on_check");
                                }
                                var khmc = $('#khmc').val();
                                var zhkh = $('#zhkh').val();//账户卡号
                                var payway = $('#payway').find("option:selected").html();
                                var khbank = $('#khbank').find("option:selected").html();
                                var bankdetail = $('#bankdetail').val();
                                var Def_select = $(".piaochecked").hasClass("on_check");
                                if (payway == '现金打款' || payway == '支付宝') {
                                    $('#zhkh').attr('readonly', 'readonly');
                                    $('#zhkh').attr('style', 'background-color:lightgray');
                                   // $('#khmc').attr('readonly', 'readonly');
                                 //   $('#khmc').attr('style', 'background-color:lightgray');
                                    $('#khbank').attr('disabled', 'disabled');
                                    $('#khbank').attr('style', 'background-color:lightgray');
                                    $('#bankdetail').attr('readonly', 'readonly');
                                    $('#bankdetail').attr('style', 'background-color:lightgray');
                                } else if ( payway == '银行卡') {
                                    $('#khmc').removeAttr('readonly');
                                    $('#khmc').removeAttr('style');
                                    $('#zhkh').removeAttr('readonly', 'readonly');
                                    $('#zhkh').removeAttr('style', 'background-color:lightgray');
                                    $('#khbank').removeAttr('disabled', 'disabled');
                                    $('#khbank').removeAttr('style', 'background-color:lightgray');
                                    $('#bankdetail').removeAttr('readonly', 'readonly');
                                    $('#bankdetail').removeAttr('style', 'background-color:lightgray');

                                } 
                            }
                        })
                    }
                });
    	    $('#save').on('click', function () {
    	        var tmp = '<%=action_mark%>';            
                 if(tmp == 'update')
                 {
                     var accid = $('#accid').val();
                     var khmc = $('#khmc').val();
                     var zhkh = $('#zhkh').val();//账户卡号
                     var payway = $('#payway').find("option:selected").html();
                     var khbank = $('#khbank').find("option:selected").html();
                     var bankdetail = $('#bankdetail').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     if (payway == '银行卡') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("账户名或账号卡号不能为空！");
                         }else {
                             $.ajax({
                                 type: "post",
                                 url: '../API/BankManage.ashx',
                                 data: {
                                     mark: 'update',
                                     accid: accid,
                                     khmc: khmc,
                                     zhkh: zhkh,
                                     payway: payway,
                                     khbank: khbank,
                                     bankdetail: bankdetail,
                                     Def_select: Def_select
                                 },
                                 async: true,
                                 success: function (data) {
                                     var jsonobj = eval('(' + data + ')');
                                     if (jsonobj.Mss.state == 'ok') {
                                         alert("保存成功！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                     else {
                                         alert("保存失败！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                 }
                             })
                         }
                     } else if (payway == '支付宝' || payway == '现金打款') {
                         if (khmc.toString().trim() == "") {
                             alert("账户名(姓名)不能为空！");
                         } else {
                             $.ajax({
                                 type: "post",
                                 url: '../API/BankManage.ashx',
                                 data: {
                                     mark: 'update',
                                     accid: accid,
                                     khmc: khmc,
                                     zhkh: '',
                                     payway: payway,
                                     khbank: '',
                                     bankdetail: bankdetail,
                                     Def_select: Def_select
                                 },
                                 async: true,
                                 success: function (data) {
                                     var jsonobj = eval('(' + data + ')');
                                     if (jsonobj.Mss.state == 'ok') {
                                         alert("保存成功！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                     else {
                                         alert("保存失败！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                 }
                             })
                         }
                     }
        

                 } else if (tmp == 'add') {
                  
                         var khmc = $('#khmc').val();
                         var zhkh = $('#zhkh').val();//账户卡号
                         var payway = $('#payway').find("option:selected").html();
                         var khbank = $('#khbank').find("option:selected").html();
                         var bankdetail = $('#bankdetail').val();
                         var Def_select = $(".piaochecked").hasClass("on_check");
                         if (payway == '银行卡') {
                             if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                                 alert("账户名或账号卡号不能为空！");
                             } else {
                                 $.ajax({
                                     type: "post",
                                     url: '../API/BankManage.ashx',
                                     data: {
                                         mark: 'add',
                                         khmc: khmc,
                                         zhkh: zhkh,
                                         payway: payway,
                                         khbank: khbank,
                                         bankdetail: bankdetail,
                                         Def_select: Def_select
                                     },
                                     async: true,
                                     success: function (data) {
                                         var jsonobj = eval('(' + data + ')');
                                         if (jsonobj.Mss.state == 'ok') {
                                             alert("保存成功！");
                                             window.location = "./BankAccount.aspx";
                                         }
                                         else {
                                             alert("保存失败！");
                                             window.location = "./BankAccount.aspx";
                                         }
                                     }
                                 })
                             }
                         }
                         else if (payway == '支付宝' || payway == '现金打款') {
                             if (khmc.toString().trim() == "") {
                                 alert("账户名(姓名)不能为空！");
                             } else {
                                 $.ajax({
                                     type: "post",
                                     url: '../API/BankManage.ashx',
                                     data: {
                                         mark: 'add',
                                         accid: accid,
                                         khmc: khmc,
                                         zhkh: '',
                                         payway: payway,
                                         khbank: '',
                                         bankdetail: bankdetail,
                                         Def_select: Def_select
                                     },
                                     async: true,
                                     success: function (data) {
                                         var jsonobj = eval('(' + data + ')');
                                         if (jsonobj.Mss.state == 'ok') {
                                             alert("保存成功！");
                                             window.location = "./BankAccount.aspx";
                                         }
                                         else {
                                             alert("保存失败！");
                                             window.location = "./BankAccount.aspx";
                                         }
                                     }
                                 })
                             }
                         } 
                 }
                 else if (tmp == 'add_rt') {
                     var khmc = $('#khmc').val();
                     var zhkh = $('#zhkh').val();//账户卡号
                     var payway = $('#payway').find("option:selected").html();
                     var khbank = $('#khbank').find("option:selected").html();
                     var bankdetail = $('#bankdetail').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     if (payway == '银行卡') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("账户名或账号卡号不能为空！");
                         } else {
                             $.ajax({
                                 type: "post",
                                 url: '../API/BankManage.ashx',
                                 data: {
                                     mark: 'add',
                                     khmc: khmc,
                                     zhkh: zhkh,
                                     payway: payway,
                                     khbank: khbank,
                                     bankdetail: bankdetail,
                                     Def_select: Def_select
                                 },
                                 async: true,
                                 success: function (data) {
                                     var jsonobj = eval('(' + data + ')');
                                     if (jsonobj.Mss.state == 'ok') {
                                         alert("保存成功！");
                                         //window.history.back();
                                         //window.location.reload();
                                         window.location = "../web/RtCash_s.aspx";
                                     }
                                     else {
                                         alert("保存失败！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                 }
                             })
                         }
                     } else if (payway == '支付宝' || payway == '现金打款') {
                         if (khmc.toString().trim() == "") {
                             alert("账户名(姓名)不能为空！");
                         } else {
                             $.ajax({
                                 type: "post",
                                 url: '../API/BankManage.ashx',
                                 data: {
                                     mark: 'add',
                                     accid: accid,
                                     khmc: khmc,
                                     zhkh: '',
                                     payway: payway,
                                     khbank: '',
                                     bankdetail: bankdetail,
                                     Def_select: Def_select
                                 },
                                 async: true,
                                 success: function (data) {
                                     var jsonobj = eval('(' + data + ')');
                                     if (jsonobj.Mss.state == 'ok') {
                                         alert("保存成功！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                     else {
                                         alert("保存失败！");
                                         window.location = "./BankAccount.aspx";
                                     }
                                 }
                             })
                         }
                     }
          
                 }
    	    });
            function deleteaddr() {

            };
        $('#deleteaddr').on('click', function () {
            $('.ord_win').show();
            that = $(this);
        })

        $('.cancle').on('click', function () {
            $('.ord_win').hide();

        })
        $('.submit').on('click', function () {
           //获取id，删除该地址
                $.ajax({
                    url: '../API/BankManage.ashx',
                    data: {
                        mark: 'delete',
                        accid: '<%=accid%>'
                    },
                    async: true,
                    success: function (data) {
                        var jsonobj = eval('(' + data + ')');
                        if (jsonobj.Mss.state == 'ok') {
                            alert("删除成功！");
                            window.location = "./BankAccount.aspx";
                        }
                        else {
                            alert("删除失败，请刷新后重新删除！");
                            window.location = "./BankAccount.aspx";
                        }
                    }
                })
        })
        </script>
</body>
</html>