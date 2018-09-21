<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Deliveryaddr.aspx.cs" Inherits="wx.Wb.Deliveryaddr" %>
<!DOCTYPE html>
<html><head>
		<meta http-equiv="Content-Type" content="text/html"; charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0 user-scalable=no">
        <meta name="format-detection" content="telephone=no">
        <title>添加地址</title>
    <!-- 从官方下载的文件放在项目的 jquery-mobile 目录中 -->  
        <link rel="stylesheet" type="text/css" href="../CSS/index/css/style1.css"/>
     <link rel="stylesheet" type="text/css" href="../CSS/index/css/base.css"/>
    <script src="../CSS/js/jquery-2.1.4.js"></script>
        <script type="text/javascript">
    	$(window).load(function(){
    	    $(".loading").addClass("loader-chanage");
    	    $(".loading").fadeOut(300);
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
    <body>
<div>
  	<header class="top-header fixed-header">
		<a class="icona" href="./BankAccount.aspx">
				<img src="../CSS/index/images/left.png"/>
			</a>
		<h3>添加地址</h3>	
	</header>
    
<div style="margin-top:15%">
    <div class="address_main">
        <input type="hidden" id="addressid" value="">
		<input type="hidden" id="spuid" value="3074">
        <div class="line"><input type="text" placeholder="收件人" id="realname" value=""></div>
        <div class="line"><input type="text" placeholder="联系电话" id="mobile" value=""></div>
        <div class="line">
		<!-- sel-provance -->
        <select id="s_province" name="s_province"></select><br>		
		</div>
         <div class="line">
		  <select id="s_city" name="s_city" ></select><br><!-- sel -->
		 </div>
         <div class="line">
		 <!-- sel-area -->
		 <select id="s_county" name="s_county"></select><br>
		 </div>
            <script type="text/javascript" src="../CSS/index/js/area.js"></script>
            <script type="text/javascript">_init_area();</script>
	 	 
        <div class="line"><input type="text" placeholder="详细地址" id="address" value=""></div>
       <div class="line">
            <div style="text-align:center;" onclick="deleteaddr()"> <label style="color:#ff4f4f;font-size:1.6rem">删除地址</label></div>
       </div>
    </div>
    <div class="line">	
                       <label style="font-size:1rem">设置默认地址</label>
					<div class="piaochecked">
                     
                <input name="need_inv" id="Def_select" type="checkbox" style="height:20px;width:20px;" class="radioclass input" value="1">
              </div>		            
                   		
			</div>
    <div style="height:44px; margin:14px 10px; background:#ff4f4f; border-radius:4px; text-align:center; font-size:16px; line-height:44px; color:#fff;"  id="save" >保存</div>
</div><br>
    </div>     
</body>
    	<script type="text/javascript">
    	    $(".piaochecked").on("click", function () {
    	        $(this).hasClass("on_check") ? $(this).removeClass("on_check") : $(this).addClass("on_check");
    	        //或者这么写
    	        // $(this).toggleClass( "on_check" );
    	    });
    	    $(document).ready(
                function () {
                    var tmp = '<%=action_mark%>'
                    if (tmp == 'update') {
                        $.ajax({
                            type: "post",
                            url: '../API/AddrManage.ashx',
                            data: {
                                mark: 'query',
                                addressid: '<%=addrid%>'
                            },
                            async: true,
                            success: function (data) {
                                var jsonobj = eval('(' + data + ')');
                                $('#addressid').val(jsonobj.id);
                                $('#realname').val(jsonobj.Name);
                                $('#mobile').val(jsonobj.Telephone);
                              //  $('#s_province').val(jsonobj.Province);
                                document.getElementById("s_province").options[0].value = jsonobj.Province;
                                document.getElementById("s_city").options[0].text = jsonobj.City;
                                document.getElementById("s_county").options[0].text = jsonobj.County;
                                document.getElementById("s_province").options[0].text = jsonobj.Province;
                               //  $('#s_city').val(jsonobj.City);
                               //    $('#s_county').val(jsonobj.County);
                                $('#address').val(jsonobj.address);
                                if (jsonobj.checkdefault == 'false') {
                                    $(".piaochecked").removeClass("on_check");
                                 //   alert($(".piaochecked").hasClass("on_check"));
                                }
                              
                            }
                        })
                    }
                });
    	    $('#save').on('click', function () {
                 var tmp = '<%=action_mark%>'
                 
                 if(tmp == 'update')
                 {
                     var addressid = $('#addressid').val();
                     var realname = $('#realname').val();
                     var mobile = $('#mobile').val();
                     var s_province = $('#s_province').find("option:selected").val();
                     var s_city = $('#s_city').find("option:selected").val();
                     var s_county = $('#s_county').find("option:selected").val();
                     var address = $('#address').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     $.ajax({
                         type: "post",
                         url: '../API/AddrManage.ashx',
                         data: {
                             mark: 'update',
                             addressid:addressid,
                             realname: realname,
                             mobile: mobile,
                             s_city: s_city,
                             s_province: s_province,
                             s_county: s_county,
                             address: address,
                             Def_select: Def_select
                         },
                         async: true,
                         success: function (data) {
                             var jsonobj = eval('(' + data + ')');
                             if (jsonobj.Mss.state == 'ok')
                             {
                                 alert("保存成功！");
                                 window.location = "./AddrM.aspx";
                             }
                             else {
                                 alert("保存失败！");
                                 window.location = "./AddrM.aspx";
                             }
                         }
                     })

                 } else if (tmp == 'add')
                 {
                     var realname = $('#realname').val();
                     var mobile = $('#mobile').val();
                     var s_province = $('#s_province').find("option:selected").val();
                     var s_city = $('#s_city').find("option:selected").val();
                     var s_county = $('#s_county').find("option:selected").val();
                     var address = $('#address').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
              
                     $.ajax({
                         type: "post",
                         url: '../API/AddrManage.ashx',
                         data: {
                             mark: 'add',
                             realname: realname,
                             mobile: mobile,
                             s_city: s_city,
                             s_province: s_province,
                             s_county: s_county,
                             address: address,
                             Def_select: Def_select
                         },
                         async: true,
                         success: function (data) {
                             var jsonobj = eval('(' + data + ')');
                             if (jsonobj.Mss.state == 'ok')
                             {
                                 alert("保存成功！");
                                 window.location = "./AddrM.aspx";
                             }
                             else {
                                 alert("保存失败！");
                                 window.location = "./AddrM.aspx";
                             }
                         }
                     })
                 }
                    
    	    });
    	    function deleteaddr()
    	    {
                //获取id，删除该地址
    	        $.ajax({
    	            url: '../API/AddrManage.ashx',
                    data: {
                       mark: 'delete',
                       addressid: '<%=addrid%>'
                          },
    	            async: true,
    	            success: function (data) {
    	                var jsonobj = eval('(' + data + ')');
    	                if (jsonobj.Mss.state == 'ok')
    	                {
    	                    alert("删除成功！");
    	                    window.location = "./AddrM.aspx";
    	                }
    	                else {
    	                    alert("删除失败，请刷新后重新删除！");
    	                    window.location = "./AddrM.aspx";
                        }
    	            }
    	        })
    	    }
	</script>
</html>