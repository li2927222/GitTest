<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Ordering.aspx.cs" Inherits="wx.web.Ordering" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>订货</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/style.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/index.css"/>
<script src="../CSS/js/jquery-2.1.4.js"></script>
<script src="../CSS/JS/jquery.nav.js" type="text/javascript"></script>
<script type="text/javascript" src="../CSS/js/Adaptive.js"></script>
   <script>
       $(document).ready(function() {
           $('#nav').onePageNav();
       });
       $(document).ready(function () {
           $(window).scroll(function () {
               var s=$('#nav-lf').offset().top+60;
               var top = $(window).scrollTop()+60;
               var left = $(window).scrollLeft() + 0;
               $("#nav-lf").animate({ "top": top }, 25) ;
           });
       });   
       function test()
       {
           alert($('#nav-lf').offset().top);
       }
    </script>
    <style>
   #cuscre:hover {
    background-color:#2f99e9;
}
       .btn-01{
    border-style:none;
   margin-left:0.05rem;
   margin-top:0.02rem;
    text-align:center;
    color:#fff;
    font:14px "Microsoft YaHei", Verdana, Geneva, sans-serif;
    cursor:pointer;
    border:1px #105bfb solid;
    -webkit-box-shadow:inset 0px 0px 1px #fff;
    -moz-box-shadow:inset 0px 0px 1px #fff;
    box-shadow:inset 0px 0px 1px #fff;/*内发光效果*/
    -webkit-border-radius:4px;
    -moz-border-radius:4px;
    border-radius:4px;/*边框圆角*/
    text-shadow:1px 1px 0px #b67f01;/*字体阴影效果*/
    background-color:#3877f8;
   
}
.btn-01:hover {
    background-color:#2f99e9;
}

    </style>
</head>
<body style="width:4rem;">

 <div class="head-container" style="background-color:#c4e3f3">
   <div class="head-left" style="width:3.0rem;font-size:0.18rem;float:left; margin-top:0.1rem;font-family:STSong;float:left;"><label id="cusname" style="margin-left:0.2rem;">
     </label>
   </div>
      <div style="margin-right:0.2rem;width:0.5rem;font-size:0.15rem;float:right;margin-top:0.1rem;">
 <div class="btn-01">返 回</div>
   </div>
 </div>

    <div class="nav-lf" id="nav-lf">
<ul id="nav" runat="server" style="top:0rem;">
  <li class="current"><a href="#st1">智能手机</a><b></b></li>
  <li><a href="#st2">物料</a><b>1</b></li>
  <li><a href="#st3">其他</a><b>3</b></li>
  
</ul>
 
</div>
  
 <div id="container" runat="server" class="container" >

  <div class="section" id="st1" runat="server">

    
  </div>
  <div class="section" id="st2">   
  	
  </div>
  
  <div class="section" id="st3">
  
  	
  
      </div>
  
</div>
  <div class="cart" style="position:fixed;margin-top:3.5rem;">
      
       <img id="preorder" src = '../image/ordcart.png' style='width:0.5rem;height:0.5rem; margin-bottom:0.3rem;margin-left:0.2rem';/>
  </div>
<footer class="footer">
    <div class="" style="height:0.6rem;background-color:#ECECEC;font-size:0.15rem;padding:0 0">
        <div style="height:0.2rem;margin-top:0rem;margin-top:0.1rem;"><p style="float:left;margin-left:0.2rem">可拿货额</p><label style="float :left;margin-left:0.5rem;color:crimson;" id="cuscre" onclick="describ()">5000</label></div>
        <div style="height:0.3rem;position:relative">
            <div style="float:left;position:absolute;margin-top:0.05rem;">  <p style="float:left;margin-left:0.2rem">最低库存  </p><label id="lowest_count" style="float:right;margin-left:0.5rem">20</label></div>         
            <div style="float:left ;position:relative;margin-left:2.2rem;margin-top:0.05rem;"> <p style="float:left">当前库存  </p><label id="cur_count" style="float:right;margin-left:0.5rem">10</label></div>          
        </div>
    </div>    
	<div class="ft-lt">
        <p>合计:<span id="total" class="total"></span><span class="nm">（<label class="share"></label>台)</span></p>
    </div>
    <div class="ft-rt">
        
    	<p > 加入购物车</p>
    </div>
</footer>



<script>

     $(document).ready(
         
      function () {
          $("input[class*=result]").each(
              function(i){
                  $(this).val(0);
              }
              );    
         var label1 = document.getElementById('cusname');
         label1.textContent='<%=cusnamestr%>';
         var label2 = document.getElementById('lowest_count');
         label2.textContent = '<%=lowestcount%>';
          var label2 = document.getElementById('cuscre');
          label2.textContent = '<%=cuscre%>';
         var label3 = document.getElementById('cur_count');
         label3.textContent = '<%=cus_curstore%>';
      }
          )
 </script>
<script type="text/javascript" charset="GB2312">
 var data = new Array();
$(function(){ 
     for(var i=0;i< <%=count%>;i++)
    { 
    data[i] = new Array();
    data[i][0] = '0';
    };
$('.ft-rt').on('click', function () {
    var mark=0;
    $("input[class*=result]").each(
        function(i){
            if($(this).val()!=0)
            {mark =1;};
        });
    if(mark == 1)
    {
        var prodata="";
    for(var i=0;i< <%=count%>;i++)
    { 
        if(data[i][0] !='0'){
            prodata = prodata+data[i][0]+","+data[i][1]+","+data[i][2]+","+data[i][3]+","+data[i][4]+"|";
        }
    };
    $.ajax({
        cache: true,
        type: "post",
       // dataType: "json",
        url: "../API/AddPreOrder.ashx",
        data:{preorder:prodata} ,
        async: true,
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            // alert(XMLHttpRequest.readyState + textStatus + errorThrown + XMLHttpRequest.responseText);
            alert("产品数量格式不正确，请检查！");
        },
        success: function (data) {
            if ($.trim(data) == "1") {

                window.location = "../web/Preorder.aspx?cusid="+ '<%=cusidstr%>'+"&cusname="+'<%=cusnamestr%>';//添加成功跳转到购物车详情页面
            } else {

                $.toast("失败！", function () {
                    console.log('close');
                });
            }
        }
    });
    

    }
    else{
    
        alert("请选择商品");
    }
  

});
    $(".add").click(function(){
        var t = $(this).parent().find('input[class*=result]');
        if (isNaN(t.val()) || t.val() == "") { t.val(0); }
        else { t.val(parseInt(t.val()) + 1); };
        var price = $(this).parent().parent().find('#price_1').html();
        var proid = $(this).parent().parent().find('.pro').attr('id');
        var id = $(this).parent().parent().find('.lt-lt').attr('id');
        var proname =  $(this).parent().parent().find('.pro').html();
        data[id][0] =parseInt(t.val()) ;
        data[id][1] = price;
        data[id][2] = proid;
        data[id][3] = '<%=cusidstr%>';
        data[id][4] = proname;
        //  alert(data[id][0]+"|"+data[id][1]+"|"+data[id][2]+"|"+data[id][3]);
        setTotal(); 
    });
 
    $(".minus").click(function(){ 
        var t = $(this).parent().find('input[class*=result]');
        if (isNaN(t.val()) || t.val() == "") {
            t.val(0);
        } else {
            t.val(parseInt(t.val()) - 1);
            if (parseInt(t.val()) < 0) {
                t.val(0);
            };
        };
        var price = $(this).parent().parent().find('#price_1').html();
        var proid = $(this).parent().parent().find('.pro').attr('id');
        var id = $(this).parent().parent().find('.lt-lt').attr('id');
        var proname =  $(this).parent().parent().find('.pro').html(); 
        data[id][0] =parseInt(t.val()) ;
        data[id][1] = price;
        data[id][2] = proid;
        data[id][3] = '<%=cusidstr%>';
        data[id][4] = proname;
        setTotal(); 


    });
 
function setTotal(){ 
var s=0;
var v=0;
var n=0;
        //<!--计算总额--> 
$(".lt-rt").each(function(){ 
s+=parseInt($(this).find('input[class*=result]').val())*parseFloat($(this).siblings().find('span[class*=price]').text()); 

    });

        //<!--计算-->
var nIn = $("li.current a").attr("href");
$(nIn+" input[type='text']").each(function() {
	if($(this).val()!=0){
		n++;
    }
    });

        //<!--计算总份数-->
$("input[type='text']").each(function(){
	v += parseInt($(this).val());
    });
if(n>0){
	$(".current b").html(n).show();		
    }else{
	$(".current b").hide();		
    }	
$(".share").html(v);
$("#total").html(s.toFixed(2)); 
    } 
setTotal(); 

});
    $('.cart').on('click', function () {          
        window.location = "../web/Preorder.aspx?cusid=" + '<%=cusidstr%>'+"&cusname="+'<%=cusnamestr%>';     
    });
    function  describ()
    {
        alert("此额度由可拿货额、信用额度、已下订单货款综合计算。（当订单审核通过，用户可拿货额度才会改变）");
    }
    $('.btn-01').on('click', function () {
        history.back();
    })
</script> 
</body>
</html>


