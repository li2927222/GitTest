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
                     if (payway == '银行卡' || payway == '支付宝') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("账户名或账号名称不能为空！");
                         } else {
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
                     } else {
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
        

                 } else if (tmp == 'add') {
                  
                         var khmc = $('#khmc').val();
                         var zhkh = $('#zhkh').val();//账户卡号
                         var payway = $('#payway').find("option:selected").html();
                         var khbank = $('#khbank').find("option:selected").html();
                         var bankdetail = $('#bankdetail').val();
                         var Def_select = $(".piaochecked").hasClass("on_check");
                         if (payway == '银行卡' || payway == '支付宝') {
                             if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                                 alert("账户名或账号名称不能为空！");
                             } else {
                   
                             }
                         }
                         else {
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
                 else if (tmp == 'add_rt') {

                     var khmc = $('#khmc').val();
                     var zhkh = $('#zhkh').val();//账户卡号
                     var payway = $('#payway').find("option:selected").html();
                     var khbank = $('#khbank').find("option:selected").html();
                     var bankdetail = $('#bankdetail').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     if (payway == '银行卡' || payway == '支付宝') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("账户名或账号名称不能为空！");
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
                     }
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