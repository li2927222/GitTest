 $('#save').on('click', function () {
    	        var tmp = '<%=action_mark%>';            
                 if(tmp == 'update')
                 {
                     var accid = $('#accid').val();
                     var khmc = $('#khmc').val();
                     var zhkh = $('#zhkh').val();//�˻�����
                     var payway = $('#payway').find("option:selected").html();
                     var khbank = $('#khbank').find("option:selected").html();
                     var bankdetail = $('#bankdetail').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     if (payway == '���п�' || payway == '֧����') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("�˻������˺����Ʋ���Ϊ�գ�");
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
                                         alert("����ɹ���");
                                         window.location = "./BankAccount.aspx";
                                     }
                                     else {
                                         alert("����ʧ�ܣ�");
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
                                     alert("����ɹ���");
                                     window.location = "./BankAccount.aspx";
                                 }
                                 else {
                                     alert("����ʧ�ܣ�");
                                     window.location = "./BankAccount.aspx";
                                 }
                             }
                         })
                     }
        

                 } else if (tmp == 'add') {
                  
                         var khmc = $('#khmc').val();
                         var zhkh = $('#zhkh').val();//�˻�����
                         var payway = $('#payway').find("option:selected").html();
                         var khbank = $('#khbank').find("option:selected").html();
                         var bankdetail = $('#bankdetail').val();
                         var Def_select = $(".piaochecked").hasClass("on_check");
                         if (payway == '���п�' || payway == '֧����') {
                             if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                                 alert("�˻������˺����Ʋ���Ϊ�գ�");
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
                                         alert("����ɹ���");
                                         window.location = "./BankAccount.aspx";
                                     }
                                     else {
                                         alert("����ʧ�ܣ�");
                                         window.location = "./BankAccount.aspx";
                                     }
                                 }
                             })
                         }
                 }
                 else if (tmp == 'add_rt') {

                     var khmc = $('#khmc').val();
                     var zhkh = $('#zhkh').val();//�˻�����
                     var payway = $('#payway').find("option:selected").html();
                     var khbank = $('#khbank').find("option:selected").html();
                     var bankdetail = $('#bankdetail').val();
                     var Def_select = $(".piaochecked").hasClass("on_check");
                     if (payway == '���п�' || payway == '֧����') {
                         if (zhkh.toString().trim() == "" || khmc.toString().trim() == "") {
                             alert("�˻������˺����Ʋ���Ϊ�գ�");
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
                                         alert("����ɹ���");
                                         //window.history.back();
                                         //window.location.reload();
                                         window.location = "../web/RtCash_s.aspx";
                                     }
                                     else {
                                         alert("����ʧ�ܣ�");
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
                                 alert("����ɹ���");
                                 //window.history.back();
                                 //window.location.reload();
                                 window.location = "../web/RtCash_s.aspx";
                             }
                             else {
                                 alert("����ʧ�ܣ�");
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
           //��ȡid��ɾ���õ�ַ
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
                            alert("ɾ���ɹ���");
                            window.location = "./BankAccount.aspx";
                        }
                        else {
                            alert("ɾ��ʧ�ܣ���ˢ�º�����ɾ����");
                            window.location = "./BankAccount.aspx";
                        }
                    }
                })
        })