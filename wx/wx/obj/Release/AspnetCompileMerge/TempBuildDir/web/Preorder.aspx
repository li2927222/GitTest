<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Preorder.aspx.cs" Inherits="wx.web.Preorder" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>订单详情</title>
<meta http-equiv="Access-Control-Allow-Origin" content="*"/><%--跨域--%>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
<script src="../CSS/lib/jquery-2.1.4.js"></script>
<link rel="stylesheet" type="text/css" href="../CSS/css/style.css"/>
<link rel="stylesheet" type="text/css" href="../CSS/css/index.css"/>
<script src="../CSS/JS/jquery.nav.js" type="text/javascript"></script>
   <style type="text/css">

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
<script>
    $(document).ready(
        function () {
            var label1 = document.getElementById('cusname');
            label1.textContent = '<%=cusname%>';
            var label2 = document.getElementById('lowest_count');
            label2.textContent = '<%=lowestcount%>';
            var label2 = document.getElementById('cuscre');
            label2.textContent = '<%=cuscre%>';
            var label3 = document.getElementById('cur_count');
            label3.textContent = '<%=cus_curstore%>';
            //给提交按钮绑定事件
            $('#saveid').bind("click", save);
        });  
 </script>
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
 <div id="container" style="margin-bottom:0rem;">

  <div class="section" id="st1" runat="server" style="margin-bottom:1.6rem;">
  	<div class="prt1-lt">
       
    	<div class="lt-lt">     
            <p>商品111</p>
            <p class="pr">¥<span class="price">60.00</span></p>
    	</div>
   <%--     <div class="lt-ct">               
        </div>--%>
        <div class="lt-rt">
            <p class="">现存量</p> <p class="">现存量2</p>
        	<input type="button" class="minus"  value="-"/>
        	<input type="text" class="result" value="0"/>
        	<input type="button" class="add" value="+"/>
           
        </div>
     <div class="lt-rt1">
           <img src="../image/delete.png"/>    
    </div>
    </div>
  </div>
    
  
</div>
<div class="ord_win">
    <div class="ord_win_box">
        <div class="ord_win_tit">确定删除该商品？</div>
        <div class="ord_btn clearfix">
            <a href="#" class="cancle f_left">取消</a>
            <a href="#" class="submit f_right">确定</a>
        </div>
    </div>
</div>

<%--<footer class="footer1">
	<div class="ft-lt" style="font-size:0.2rem">
        <p>合计:<span id="total" class="total">元</span><span class="nm">（<label class="share"></label>台)</span></p>
    </div>
    <div class="ft-rt" style="font-size:0.2rem">
    	<p>确认订货</p>
    </div>
</footer>--%>
<footer class="footer2">
    <div style="height:0.4rem;background-color:#ECECEC;font-size:0.15rem;padding:0 0">
     <textarea  id="tmemo" placeholder="备注(收货门店)" rows="2"  style="color:#383535;margin-left:0.2rem;width:3.6rem;"></textarea>
    </div>
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
    <div class="ft-rt" >
    <a id="saveid" href="javascript:;" >      
      <p>确认订货</p> 
    </a>
    </div>
  
</footer>

<script type="text/javascript" src="../CSS/js/Adaptive.js"></script>
    <script>
$(function(){
	$('#nav').onePageNav();
});

</script>
    <script>
        var that;
        var proid = "";
        $('.lt-rt1').on('click', function () {
           proid = $(this).parent().find('.pro').attr('id');
       //     alert(proid);
            $('.ord_win').show(); 
            that = $(this);
           // alert(that.parent().parent().find('.pro').attr('id'));
        })

        $('.cancle').on('click', function () {
            $('.ord_win').hide();
   
        })
        $('.submit').on('click', function () {//触发动作删除购物车里对应的产品       
       //     alert(proid);
            $.ajax({
                cache: true,
                type: "post",
                url: "../API/UpdatePreOrder.ashx",
                data: {
                    cus_id: '<%=cusid%>',
                    pro_id: proid,
                    num: '0',
                    mark: "delete"
                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // alert(XMLHttpRequest.readyState + textStatus + errorThrown + XMLHttpRequest.responseText);
                },
                success: function (data) {
                    if ($.trim(data) == "1") {
                        that.parent().remove();
                        setTotal();
                        $('.ord_win').hide();
                    } else {
                        //网络好像出现问题~
                    }
                }
            });
        });

        function save1()
        {

        }
        function save()
        {    
            //执行这个点击事件的同时解绑，折在这个点击事件绑定之前都是无法点击的。
            $('#saveid').unbind("click", save);
            $('#saveid').bind("click", save1);
            // alert(1);
            //判断至少为四台
            var tnum = 0;
            $(".lt-rt").each(function () {
                tnum += parseInt($(this).find('input[class*=result]').val());

            });
           // if (tnum >0)
            //{ alert("单笔订单不能少于4台！");}
            //else {
                $.ajax({
                cache: true,
                type: "post",
                url: "../API/OrderSubmit.ashx",
                data: {
                    cus_id: '<%=cusid%>',
                    t_memo: $('#tmemo').val()//备注

                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    // alert(XMLHttpRequest.readyState + textStatus + errorThrown + XMLHttpRequest.responseText);
                },
                success: function (data) {
                    var temp = $.trim(data);
                    var str = new Array();
                    str= temp.split(':');
                    if (str[0].toString() == "0") {
                          alert("成功生成订单,等待系统校验");
                         window.location = "../web/Ordering.aspx?cusid=" + '<%=cusid%>' +"&cusname="+'<%=cusname%>';                                  
                    } else if (str[0].toString() == "1") {
                        //订单金额超出可拿货额   
                        alert("订单金额超出可拿货额 ");
                        $('#saveid').bind("click", save);
                    } else if (str[0].toString() == "2") {//订单中单品数量超过仓库库存    
                      //  alert(str[1].toString());
                        var str1 = new Array();
                        var str2 = new Array();
                      //  var str3 = new Array();
                        var strtmp = '商品超库存: ';
                        str1 = str[1].split('/');
                        var i = 0;
                        while (str1[i] !=null)
                        {
                            str2 = str1[i].split(',');
                            if (i == 0)
                            { strtmp = strtmp + ' \n\r' + "手机：" + str2[1].toString() + "当前库存为：" + str2[3].toString() + ",当前订单量为：" + str2[2].toString() ; }
                            else
                            { strtmp = strtmp + ' \n\r' + "手机：" + str2[0].toString() + "当前库存为：" + str2[2].toString() + ",当前订单量为：" + str2[1].toString(); }
                         
                            i++;
                        }                                          
                        alert(strtmp);
                        $('#saveid').bind("click", save);
                    }
                    else if (str[0].toString() == "3") {//订单中单品数量超过周转上限   
                        var str1 = new Array();
                        var str2 = new Array();
                        //  var str3 = new Array();
                        var strtmp = '商品超周转: ';
                        str1 = str[1].split('/');
                        var i = 0;
                        while (str1[i] != null) {
                            str2 = str1[i].split(',');
                            if (i == 0)
                            { strtmp = strtmp + ' \n\r' + "手机：" + str2[1].toString() + "当前可拿量为：" + str2[3].toString() + ",当前订单量为：" + str2[2].toString(); }
                            else
                            { strtmp = strtmp + ' \n\r' + "手机：" + str2[0].toString() + "当前可拿量为：" + str2[2].toString() + ",当前订单量为：" + str2[1].toString() ; }

                            i++;
                        }
                        alert(strtmp);
                       $('#saveid').bind("click", save);
                    } else {
                        //未知错误
                        alert("未知错误");
                        $('#saveid').bind("click", save);
                    }
                }
            });
            } //}
    </script>
<script> 
    function setTotal() {
        var s = 0;
        var v = 0;
        var n = 0;
        //<!--计算总额--> 
        $(".lt-rt").each(function () {
            s += parseInt($(this).find('input[class*=result]').val()) * parseFloat($(this).siblings().find('span[class*=price]').text());

        });
        //<!--计算-->
        var nIn = $("li.current a").attr("href");
        $(nIn + " input[type='text']").each(function () {
            if ($(this).val() != 0) {
                n++;
            }
        });

        //<!--计算总份数-->
        $("input[type='text']").each(function () {
            v += parseInt($(this).val());
        });
        if (n > 0) {
            $(".current b").html(n).show();
        } else {
            $(".current b").hide();
        }
        $(".share").html(v);
        $("#total").html(s.toFixed(2));
    };
    $(function () {
        
        $(".result").focus(function () { $(this).attr("data-oval", $(this).val()); }).blur(
            function () {
                var proid = $(this).parent().parent().find('.pro').attr('id');//产品id
                var oldVal = ($(this).attr("data-oval")); //获取原值
                var newVal = ($(this).val()); //获取当前值
                var re = /^[0-9]*[1-9][0-9]*$/;
                if (oldVal != newVal) {//不同则更新数据库
                    //如果newval为空，则赋值1；
                    if (!re.test(newVal))
                    {
                        alert("请输入数字！");
                        $(this).val(1);
                        setTotal();
                     //   newVal = $(this).val();
                    } else {
                        //正常的数字直接更新
                $.ajax({            
                type: "post",
                url: "../API/UpdatePreOrder.ashx",
                data: {
                    cus_id: '<%=cusid%>',
                    pro_id: proid,
                    num: parseInt(newVal),
                    mark: "add"
                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    setTotal();
                    alert("网络忙碌，请重新修改");
                },
                success: function (data) {
                    if ($.trim(data) == "1") {
                        //成功之后更新总和并且
                        setTotal();
                    } else {
                        setTotal();
                        alert("网络出现故障，请检查网络重新下单~");
                    }
                }
                  });

                    }  
                }
            }
            );
        $(".add").click(function () {//增加购物车产品数量
            var t = $(this).parent().find('input[class*=result]');
            //   alert(t.val());
            //网速不好会导致这里加了，实际后台没加
            if (isNaN(t.val()) || t.val() == "") { t.val(0); }
            else { t.val(parseInt(t.val())); };
            var proid = $(this).parent().parent().find('.pro').attr('id');
            var num = (parseInt(t.val()) + 1);
            $.ajax({
                cache: true,
                type: "post",
                url: "../API/UpdatePreOrder.ashx",
                data: {
                    cus_id: '<%=cusid%>',
                    pro_id: proid,
                    num: num,
                    mark: "add"
                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    setTotal();
                    alert("网络忙碌，请重新修改");
                },
                success: function (data) {
                    if ($.trim(data) == "1") {
                        if (isNaN(t.val()) || t.val() == "") { t.val(0); }
                        else { t.val(parseInt(t.val()) + 1); };
                        setTotal();
                    } else {
                        //t.val(parseInt(t.val()) - 1);
                        setTotal();
                    }
                }
            });

        });

        $(".minus").click(function () { //减少购物车产品数量
            var t = $(this).parent().find('input[class*=result]');
            if (isNaN(t.val()) || t.val() == "") {
                t.val(1);
            } else {
                t.val(parseInt(t.val()));
                if (parseInt(t.val()) < 1) {
                    t.val(1);
                };
            };
            var proid = $(this).parent().parent().find('.pro').attr('id');
            var num = parseInt(t.val()) - 1;
            if (num > 0) {//当前num为1是不能继续减，继续减页面为1,此时减去后num为0，不更新
                   $.ajax({
                cache: true,
                type: "post",
                url: "../API/UpdatePreOrder.ashx",
                data: {
                    cus_id: '<%=cusid%>',
                    pro_id: proid,
                    num: num,
                    mark: "minus"
                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    setTotal();
                     alert("网络忙碌，请重新修改");
                },
                success: function (data) {
                    if ($.trim(data) == "1") {
                        if (isNaN(t.val()) || t.val() == "") {
                            t.val(1);
                        } else {
                            t.val(parseInt(t.val()) - 1);
                            if (parseInt(t.val()) < 1) {
                                t.val(1);
                            };
                        };
                        setTotal();
                    } else {//操作失败网络问题
                        //t.val(parseInt(t.val()) + 1);
                        setTotal();
                    }
                }
            });
            }
         


        })


        setTotal();

    });
    $('.btn-01').on('click', function () {
        history.back();
    })
</script> 
</body>
</html>
