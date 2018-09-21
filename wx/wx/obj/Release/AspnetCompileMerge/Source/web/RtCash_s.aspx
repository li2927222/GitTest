<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RtCash_s.aspx.cs" Inherits="wx.web.RtCash_s" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no"/>
    <meta charset="utf-8"/>
    <title>回款登记</title>
    <link rel="stylesheet" href="../CSS/lib/weui.min.css"/>
    <link rel="stylesheet" href="../CSS/css/jquery-weui.css"/>
    <link rel="stylesheet" href="../CSS/css/demos.css"/>
    <script src="../CSS/lib/jquery-2.1.4.js"></script>
    <script src="../CSS/js/jquery-weui.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <script src="https://res.wx.qq.com/open/js/jweixin-1.2.0.js"></script>
    <link rel="stylesheet" href="http://demo.open.weixin.qq.com/jssdk/css/style.css?ts=1420774989"/>
          <style type="text/css">
    input[type="date"]:before{
                content: attr(placeholder);
                color:#090 }  
    li{  list-style-type:none;}  
    .black_overlay{display:none;position:fixed;
               top:0%;left:0%;width:100%;height:100%;
               background-color:black;z-index:1001;
               -moz-opacity:0.8;opacity:.80;
               filter:alpha(opacity=80);}
    .white_content{display:none;position:fixed;
               top:5%;width:80%;height:auto;left:9%;
               padding:2px;border:0px solid orange;
               background-color:white;z-index:1002;
               overflow:auto;
}
</style>
    <script>
        $(document).ready(function () {
            //绑定click事件
            $('#saveid').bind("click", save);
            //一开始设定某些控件的默认style颜色属性
            var o = document.getElementById('dateid');
            o.onfocus = function () {
                o.removeAttribute('placeholder');
            };
            o.onblur = function () {
                if ($('#dateid').val() == "") {
                    this.setAttribute('placeholder', '-请选择-');
                } else { }
            };
           //初始化相关数据
           // <%%>外部代码方式空格被转化成换行，导致错误
           document.getElementById("select1").options[0].text = '<%=str2%>';
           document.getElementById("select1").options[0].value = '<%=str3%>';  
           document.getElementById("select2").options[0].text = '<%=str%>';
           document.getElementById("select2").options[0].value = '<%=str5%>';  
           document.getElementById("select3").options[0].value = '<%=str4%>';  
           document.getElementById("select3").options[0].text = '<%=str1%>';  
           var selectId = document.getElementById("select1").options[0].text = '<%=str2%>'; 
           var optionId1 = document.getElementById("select1").options[0].value = '<%=str3%>';
           $.ajax({
               type: "post",
               url: '../API/GetUserBank.ashx',
               data: {
                   optionId: optionId1

               },
               async: true,
               success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                   var htmlstr = "";
                   var bankds1 = document.getElementById("select3");
                   if (data != "0") {
                       var str = new Array();
                       str = data.split(",");
                       var bankid = new Array();
                       var bankname = new Array();
                       bankid = str[0].split("|");
                       bankname = str[1].split("|");
                       //循环拼接语句向select3里添加html语句
                       for (var i = 0; i < bankid.length-1; i++) {
                           htmlstr = htmlstr + "<option value='" + bankid[i] + "'>" + bankname[i] + "</option>";
                       }
                   }
                   bankds1.innerHTML = htmlstr;
                    //  alert(htmlstr);
               }

           });
       }
        );
        function Getnumid(tmp) {
            var selectId = $("#select1").find("option:selected").text();
            var optionId = $("#select1").find("option:selected").val();
            $.ajax({
                type: "post",
                url: '../API/GetUserBank.ashx',
                data: {
                    optionId: optionId
                },
                async: true,
                success: function (data) {//如果返回0表示返回无数据，则用户未绑定银行
                    var htmlstr = "<option value='0' style='color:#888'>- 请选择 -</option>";
                    var bankds = document.getElementById("select3");
                    if (data != "0") {
                        var str = new Array();
                        str = data.split(",");
                        var bankid = new Array();
                        var bankname = new Array();
                        bankid = str[0].split("|");
                        bankname = str[1].split("|");
                        for (var i = 0; i < bankid.length - 1; i++) {
                            htmlstr = htmlstr + "<option value='" + bankid[i] + "'>" + bankname[i] + "</option>";
                        }
                    }
                    bankds.innerHTML = htmlstr;
                }
            });
        };
    </script>

    <script>
        //接口调用注册
        wx.config({
      debug: false,
      appId: 'wwf427ba730248b6c9',
      timestamp: '<%=timestamp%>',
      nonceStr: 'wangzhaohuanshigeshabi',//生成签名的随机字符串
      signature: '<%=sigurate%>',
      jsApiList: [
        'chooseImage',
        'previewImage',
        'uploadImage',
        'downloadImage',
        'getLocalImgData'
      ]
        }); 
</script>
   <script src="../CSS/js/wxjdk.js"></script>
</head>

<body>
   <header class='title'>
      <h1>回款登记</h1>
    </header> 
 
       <div class="weui_cells weui_cells_form">
 
    <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535">选择 客户 </label></div>
      
        <div class="weui_cell weui_cell_select">
        <div class="weui_cell_bd weui_cell_primary">
          <select class="weui_select" name="select1" id="select1" style="color:#383535" onchange="Getnumid(this)">
             <%=getdata("select1")%>
          </select>
        </div>
      </div>
      
    </div>  
      <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535">汇出 账户</label></div>
        <div class="weui_cell weui_cell_select">
        <div class="weui_cell_bd weui_cell_primary">
        <%--    <asp:DropDownList ID="DropDownList1" runat="server"></asp:DropDownList>--%>
          <select class="weui_select" name="select2" id="select2" style="color:#383535;">
           <%=getdata("select2")%>
          </select>
        </div>
      </div>
          <div class="weui_cell"> <a href="../Wb/BankInfo.aspx?mark=add_rt"  ><label  class="weui_label" style="color:#088ded"">编辑</label></a></div>
    </div> 
    <div class="weui_cell">
        <div class="weui_cell_hd"><label  class="weui_label" style="color:#383535">汇入 账户  </label></div>
        <div class="weui_cell weui_cell_select">
        <div class="weui_cell_bd weui_cell_primary">
          <select class="weui_select" name="select3" id="select3" style="color:#383535"  >
             <%=getdata("select3")%>
          </select>
        </div>
      </div>
    </div> 
      <div class="weui_cell">
        <div class="weui_cell_hd"><label class="weui_label" style="color:#383535">货款</label></div>
        <div class="weui_cell_bd weui_cell_primary">
          <input class="weui_input" type="number"  id="amount" style="color:#383535"  placeholder="0.00" />
        </div>
    
      </div>
<%--       <div class="weui_cell">
           <div class="weui_cell weui_cell_switch">
        <div class="weui_cell_hd weui_cell_primary" style="color:#383535" >其它</div>
        <div class="weui_cell_ft">
          <input class="weui_switch" id="other" type="checkbox" onclick="getstr()" required="required"/>
        </div>
      </div>
           </div>--%>
       <div class="weui_cells" id="deposit">
      </div>
      <div class="weui_cell">
        <div class="weui_cell_hd"><label for="dateid" class="weui_label" style="color:#383535">日期</label></div>
        <div class="weui_cell_bd weui_cell_primary">
          <input class="weui_input" type="date" id="dateid" value="<%=DateTime.Now.ToString("yyyy-MM-dd")%>"  style="color:#383535"/>
        </div>
      </div>
    <div class="weui_cell">
      <div id="uploadPreview"></div>
        <div class="weui_cell_bd weui_cell_primary">
          <div class="weui_uploader" >         
            <div class="weui_uploader_bd">     
             <ul class="weui-uploader__files" id="imgUl">
                                </ul>
               <button class="weui_btn weui_btn_default" id="chooseImage" >图片</button>                   
            </div>                      
          </div>
        </div>
      </div>
    <div class="weui_cell">
    <div class="weui_cells weui_cells_form">
      <div class="weui_cell">
        <div class="weui_cell_bd weui_cell_primary">
          <textarea class="weui_textarea" id="tmemo" placeholder="备注" rows="3"  style="color:#383535"></textarea>
          <div class="weui_textarea_counter"><span>0</span>/200</div>
        </div>
      </div>
    </div>

                 </div>
                 <div class="weui_cell">
             <div class="weui_btn_area">
        <a class="weui_btn weui_btn_primary" id="saveid" href="javascript:;">提交</a>
      </div>          
        </div>
    </div>
    <div id="light" class="white_content">  
           <img  src="../image/no_pic.jpg"  style="overflow-x:inherit;height:auto;width:100%;height:100%" id="" onclick="document.getElementById('light').style.display='none';document.getElementById('fade').style.display='none'"/> 
   </div>
   <div id="fade" class="black_overlay">
    
</div>

     </body>

</html>
