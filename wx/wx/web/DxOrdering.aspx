<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DxOrdering.aspx.cs" Inherits="wx.web.DxOrdering" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <title>经销订货</title>
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
               //if (s> 40)//实际为40google浏览器的上边距40
               //{ $("#nav-lf").animate({ "top": top }, 25) }
               //else { $("#nav-lf").animate({ "top": top+40 }, 25) };
           });
         //  alert($('#nav-lf').offset().top+'|'+top);
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
    </style>
</head>
<body style="width:4rem;">

 <div class="head-container1" style="background-color:#c4e3f3">
   <div class="head-left" style="width:100%;font-size:0.18rem;float:left; margin-top:0.12rem;font-family:STSong;"><label id="cusname" style="margin-left:0.3rem;" ></label></div>
  
 </div>
    <div class="nav-lf" id="nav-lf">
<ul id="nav" runat="server" style="top:0rem;">
  <li class="current"><a href="#st1">智能手机</a><b></b></li>
  <li><a href="#st2">物料</a><b>1</b></li>
  <li><a href="#st3">其他</a><b>3</b></li>
  
</ul>
 
</div>
  
 <div id="container" runat="server" class="container1" >

  <div class="section" id="st1" runat="server">

    
  </div>
  <div class="section" id="st2">   
  	
  </div>
  
  <div class="section" id="st3">
  
  	
  
      </div>
  
</div>
  <div class="cart" style="position:fixed;margin-top:4rem;">  
       <img id="preorder" src = '../image/ordcart.png' style='width:0.5rem;height:0.5rem; margin-bottom:0.3rem;margin-left:0.2rem';/>
  </div>
<footer class="footer3">
    <div class="" style="height:0.4rem;background-color:#ECECEC;font-size:0.15rem;padding:0 0">
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
      
              //location.reload(1);       
         var label1 = document.getElementById('cusname');
         label1.textContent='<%=cusnamestr%>';
         var label2 = document.getElementById('lowest_count');
         label2.textContent = '<%=lowestcount%>';
        //  var label2 = document.getElementById('cuscre');
            //label2.textContent = '<%=cuscre%>';
         var label3 = document.getElementById('cur_count');
         label3.textContent = '<%=cus_curstore%>';
          //alert('<%=cusnamestr%>');
          //循环给result肤质0，浏览器返回导致整个dom文档没有刷新
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
    //提交
    //循环拼接
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

                window.location = "../web/DxPreorder.aspx?cusid="+ '<%=cusidstr%>'+"&cusname="+'<%=cusnamestr%>';//添加成功跳转到购物车详情页面
            } else {

                $.toast("失败！", function () {
                    console.log('close');
                });
            }
            // alert(data);

        }
    });
    

    }
    else{
    
        alert("请选择商品");
    }
  

});
    //$(document).on("click", ".add", function () {
    //    var t = $(this).parent().find('input[class*=result]');
    //    t.val(parseInt(t.val()) + 1);
    //    setTotal();
    //});
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

        //  alert(data[id][0]+"|"+data[id][1]+"|"+data[id][2]+"|"+data[id][3]);
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
          
        window.location = "../web/DxPreorder.aspx?cusid=" + '<%=cusidstr%>'+"&cusname="+'<%=cusnamestr%>';     
    });
    function  describ()
    {
        alert("此额度由可拿货额、信用额度、已下订单货款综合计算。（当订单审核通过，用户可拿货额度才会改变）");
    }
</script> 
</body>
</html>

