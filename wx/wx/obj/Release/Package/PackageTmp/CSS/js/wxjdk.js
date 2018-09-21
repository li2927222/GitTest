/*
 * 注意：
 * 1. 所有的JS接口只能在公众号绑定的域名下调用，公众号开发者需要先登录微信公众平台进入“公众号设置”的“功能设置”里填写“JS接口安全域名”。
 * 2. 如果发现在 Android 不能分享自定义内容，请到官网下载最新的包覆盖安装，Android 自定义分享接口需升级至 6.0.2.58 版本及以上。
 * 3. 完整 JS-SDK 文档地址：http://mp.weixin.qq.com/wiki/7/aaa137b55fb2e0456bf8dd9148dd613f.html
 *
 * 如有问题请通过以下渠道反馈：
 * 邮箱地址：weixin-open@qq.com
 * 邮件主题：【微信JS-SDK反馈】具体问题
 * 邮件内容说明：用简明的语言描述问题所在，并交代清楚遇到该问题的场景，可附上截屏图片，微信团队会尽快处理你的反馈。
 */
var imglist = {
    index: [],
    localId: [],
    serverId: [],//服务器端地址
    delmart: [],//删除标记
    Localimg: []//用于存储base64数据，此数据仅在 iOS WKWebview 下提供使用
};//用来存储需要随单据记录到数据库的数据
var imgnum = 0;
var u = navigator.userAgent, app = navigator.appVersion;
var isAndroid = u.indexOf('Android') > -1 || u.indexOf('Linux') > -1; //g
var isIOS = u.indexOf('iPhone') > -1; //
wx.ready(function () {
    // 1 判断当前版本是否支持指定 JS 接口，支持批量判断
    //document.querySelector('#checkJsApi').onclick = function () {
    //    wx.checkJsApi({
    //        jsApiList: [
    //              'chooseImage',
    //    'previewImage',
    //    'uploadImage',
    //    'downloadImage'
    //        ],
    //        success: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 2. 分享接口
    //// 2.1 监听“分享给朋友”，按钮点击、自定义分享内容及分享结果接口
    //document.querySelector('#onMenuShareAppMessage').onclick = function () {
    //    wx.onMenuShareAppMessage({
    //        title: '互联网之子',
    //        desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
    //        link: 'http://movie.douban.com/subject/25785114/',
    //        imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
    //        trigger: function (res) {
    //            // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
    //            alert('用户点击发送给朋友');
    //        },
    //        success: function (res) {
    //            alert('已分享');
    //        },
    //        cancel: function (res) {
    //            alert('已取消');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //    alert('已注册获取“发送给朋友”状态事件');
    //};

    //// 2.2 监听“分享到朋友圈”按钮点击、自定义分享内容及分享结果接口
    //document.querySelector('#onMenuShareTimeline').onclick = function () {
    //    wx.onMenuShareTimeline({
    //        title: '互联网之子',
    //        link: 'http://movie.douban.com/subject/25785114/',
    //        imgUrl: 'http://demo.open.weixin.qq.com/jssdk/images/p2166127561.jpg',
    //        trigger: function (res) {
    //            // 不要尝试在trigger中使用ajax异步请求修改本次分享的内容，因为客户端分享操作是一个同步操作，这时候使用ajax的回包会还没有返回
    //            alert('用户点击分享到朋友圈');
    //        },
    //        success: function (res) {
    //            alert('已分享');
    //        },
    //        cancel: function (res) {
    //            alert('已取消');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //    alert('已注册获取“分享到朋友圈”状态事件');
    //};

    //// 2.3 监听“分享到QQ”按钮点击、自定义分享内容及分享结果接口
    //document.querySelector('#onMenuShareQQ').onclick = function () {
    //    wx.onMenuShareQQ({
    //        title: '互联网之子',
    //        desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
    //        link: 'http://movie.douban.com/subject/25785114/',
    //        imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
    //        trigger: function (res) {
    //            alert('用户点击分享到QQ');
    //        },
    //        complete: function (res) {
    //            alert(JSON.stringify(res));
    //        },
    //        success: function (res) {
    //            alert('已分享');
    //        },
    //        cancel: function (res) {
    //            alert('已取消');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //    alert('已注册获取“分享到 QQ”状态事件');
    //};

    //// 2.4 监听“分享到微博”按钮点击、自定义分享内容及分享结果接口
    //document.querySelector('#onMenuShareWeibo').onclick = function () {
    //    wx.onMenuShareWeibo({
    //        title: '互联网之子',
    //        desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
    //        link: 'http://movie.douban.com/subject/25785114/',
    //        imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
    //        trigger: function (res) {
    //            alert('用户点击分享到微博');
    //        },
    //        complete: function (res) {
    //            alert(JSON.stringify(res));
    //        },
    //        success: function (res) {
    //            alert('已分享');
    //        },
    //        cancel: function (res) {
    //            alert('已取消');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //    alert('已注册获取“分享到微博”状态事件');
    //};

    //// 2.5 监听“分享到QZone”按钮点击、自定义分享内容及分享接口
    //document.querySelector('#onMenuShareQZone').onclick = function () {
    //    wx.onMenuShareQZone({
    //        title: '互联网之子',
    //        desc: '在长大的过程中，我才慢慢发现，我身边的所有事，别人跟我说的所有事，那些所谓本来如此，注定如此的事，它们其实没有非得如此，事情是可以改变的。更重要的是，有些事既然错了，那就该做出改变。',
    //        link: 'http://movie.douban.com/subject/25785114/',
    //        imgUrl: 'http://img3.douban.com/view/movie_poster_cover/spst/public/p2166127561.jpg',
    //        trigger: function (res) {
    //            alert('用户点击分享到QZone');
    //        },
    //        complete: function (res) {
    //            alert(JSON.stringify(res));
    //        },
    //        success: function (res) {
    //            alert('已分享');
    //        },
    //        cancel: function (res) {
    //            alert('已取消');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //    alert('已注册获取“分享到QZone”状态事件');
    //};


    //// 3 智能接口
    //var voice = {
    //    localId: '',
    //    serverId: ''
    //};
    //// 3.1 识别音频并返回识别结果
    //document.querySelector('#translateVoice').onclick = function () {
    //    if (voice.localId == '') {
    //        alert('请先使用 startRecord 接口录制一段声音');
    //        return;
    //    }
    //    wx.translateVoice({
    //        localId: voice.localId,
    //        complete: function (res) {
    //            if (res.hasOwnProperty('translateResult')) {
    //                alert('识别结果：' + res.translateResult);
    //            } else {
    //                alert('无法识别');
    //            }
    //        }
    //    });
    //};

    //// 4 音频接口
    //// 4.2 开始录音
    //document.querySelector('#startRecord').onclick = function () {
    //    wx.startRecord({
    //        cancel: function () {
    //            alert('用户拒绝授权录音');
    //        }
    //    });
    //};

    //// 4.3 停止录音
    //document.querySelector('#stopRecord').onclick = function () {
    //    wx.stopRecord({
    //        success: function (res) {
    //            voice.localId = res.localId;
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 4.4 监听录音自动停止
    //wx.onVoiceRecordEnd({
    //    complete: function (res) {
    //        voice.localId = res.localId;
    //        alert('录音时间已超过一分钟');
    //    }
    //});

    //// 4.5 播放音频
    //document.querySelector('#playVoice').onclick = function () {
    //    if (voice.localId == '') {
    //        alert('请先使用 startRecord 接口录制一段声音');
    //        return;
    //    }
    //    wx.playVoice({
    //        localId: voice.localId
    //    });
    //};

    //// 4.6 暂停播放音频
    //document.querySelector('#pauseVoice').onclick = function () {
    //    wx.pauseVoice({
    //        localId: voice.localId
    //    });
    //};

    //// 4.7 停止播放音频
    //document.querySelector('#stopVoice').onclick = function () {
    //    wx.stopVoice({
    //        localId: voice.localId
    //    });
    //};

    //// 4.8 监听录音播放停止
    //wx.onVoicePlayEnd({
    //    complete: function (res) {
    //        alert('录音（' + res.localId + '）播放结束');
    //    }
    //});

    //// 4.8 上传语音
    //document.querySelector('#uploadVoice').onclick = function () {
    //    if (voice.localId == '') {
    //        alert('请先使用 startRecord 接口录制一段声音');
    //        return;
    //    }
    //    wx.uploadVoice({
    //        localId: voice.localId,
    //        success: function (res) {
    //            alert('上传语音成功，serverId 为' + res.serverId);
    //            voice.serverId = res.serverId;
    //        }
    //    });
    //};

    //// 4.9 下载语音
    //document.querySelector('#downloadVoice').onclick = function () {
    //    if (voice.serverId == '') {
    //        alert('请先使用 uploadVoice 上传声音');
    //        return;
    //    }
    //    wx.downloadVoice({
    //        serverId: voice.serverId,
    //        success: function (res) {
    //            alert('下载语音成功，localId 为' + res.localId);
    //            voice.localId = res.localId;
    //        }
    //    });
    //};

    // 5 图片接口
    // 5.1 拍照、本地选图
    var images = {

        localId: [],
        serverId: []
    };

    //上传的图片编号，用这个来区别索引的
    document.querySelector('#chooseImage').onclick = function () {    
        wx.chooseImage({
            sizeType: ['original', 'compressed'], // 可以指定是原图还是压缩图，默认二者都有
            sourceType: ['album', 'camera'],
            success: function (res) {
                images.localId = res.localIds;
                for (var k = 0; k < images.localId.length; k++) {
                    imglist.localId.push(images.localId[k]);
                    imglist.index.push(imgnum);
                    imglist.delmart.push("0");
                    imgnum++;
                }
                // imgnum = imgnum - 1;//虽然这个会多1，但是如果再次选则则会从这里开始，如果不再次选择图片这多1也不影响
               
                //   imglist.localId =res.localIds;//按默认的相同的顺序赋值

                // var tmpaddstr = tmpadd.innerHTML;     
                //此接口仅在 iOS WKWebview 下提供，用于兼容 iOS WKWebview 不支持 localId 直接显示图片的问题。
                //根据imglist里的数据生成相应的base64位子图片。
                //这里需要先判断当前系统是否为ios并且是否为WKWebview，如果不是返回可能为空
                var lihtml = document.getElementById("imgUl").innerHTML;

                var imgi = 0;
                for (var i = 0; i < images.localId.length; i++) {
                    var localdata = null;

                    wx.getLocalImgData({
                        localId: images.localId[i], // 图片的localID
                        success: function (res) {
                       
                            localdata = res.localData;
                            imglist.Localimg[i] = localdata; // localData是图片的base64数据，可以用img标签显示;                        
                            //根据判断localimg是否为空，如果空则继续用images.localid 否则用base64位数据           
                            //这里的i是整体循环结束后的值，可能异步优先级外循环较高
                            var imgj = 0;
                            for (var j = 0; j < imglist.localId.length; j++) {
                                if (imglist.localId[j] == images.localId[imgi]) {
                                    imgj = imglist.index[j];
                                }
                            }
                        //    alert(imgj);
                            //判断如果返回值为空，表示并不是ios WKWebview系统，任然用对应的localid
                            if (isAndroid) {
                                lihtml = lihtml + "<li id='test1' style='width:81px;heght:81px;position:relative;float:left;'><img  id='" + 'img' + imgj + "'  src= '" + images.localId[imgi]
                                + "'  style='width:80px;height:80px;position:relative;' onclick='imgop(this)' /> <button id='test' style='width:16px;heght:10px;' onclick='picremove(this)'>X</button></li>";
                                //这里每获取一次本地图片就要重新获取其他html片段重新加载           
                            }
                            else {
                                lihtml = lihtml + "<li id='test1' style='width:81px;heght:81px;position:relative;float:left;'><img  id='" + 'img' + imgj + "'  src= '" + localdata
                               + "'  style='width:80px;height:80px;position:relative;' onclick='imgop(this)' /> <button id='test' style='width:16px;heght:10px;' onclick='picremove(this)'>X</button></li>";
                                //这里每获取一次本地图片就要重新获取其他html片段重新加载    
                            }
                            $('#imgUl').html(lihtml);

                            //    alert(localdata);
                            // alert(localdata + '||' + images.localId[imgi]);
                            imgi++;
                        },
                        fail: function () {
                            alert(1);
                        }
                    });
                }
                // alert(images.localId.length + '|' + imgnum + images.localId[0] + '||' + imglist.Localimg.length);
                if (images.localId.length == 0) {
                    alert('请先选择图片');
                    return;
                }
                var i = 0, length = images.localId.length;
                images.serverId = [];
                function upload() {
                    wx.uploadImage({
                        localId: images.localId[i],
                        success: function (res) {
                            i++;
                            images.serverId.push(res.serverId);
                            imglist.serverId.push(res.serverId);
                            //   alert('已上传：' + i + '/' + length + "|" + res.serverId + "|" + images.serverId[0] + "|" + imglist.serverId[0] + "|"+ imglist.serverId[1]);//alert在所有上传结束后再执行的。这里应该能捕捉到serverid.alert的优先级外部高于此函数，内部低于此函数
                            //下面代码的优先级不造    
                            //每次upload一次，imglist会增加相应的serverid,同时生成相应的界面代码，但是会打断upload

                            if (i < length) {
                                upload();
                            }
                            // alert(imglist.localId.length + "|" + imglist.serverId.length + "|" + images.serverId.length + "|" + imglist.serverId[0] + "|" + i);

                        },
                        fail: function (res) {
                            alert(JSON.stringify(res));
                        }
                    });
                }
                upload();
                //按理这部分优先级应该在选择成功并且上传成功后执行。
                //实验证明下面优先级是在选择成功后上传成功前执行


            },
            fail: function (res) {
                alert(JSON.stringify(res));
            }
        });//这里选择完图片默认直接上传
        //下面优先级比上诉的要高，放在外面导致无法捕捉选择的图片。
    };
  
    //// 5.2 图片预览
    //document.querySelector('#previewImage').onclick = function () {
    //    wx.previewImage({
    //        current: 'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
    //        urls: [
    //          'http://img3.douban.com/view/photo/photo/public/p2152117150.jpg',
    //          'http://img5.douban.com/view/photo/photo/public/p1353993776.jpg',
    //          'http://img3.douban.com/view/photo/photo/public/p2152134700.jpg'
    //        ]
    //    });
    //};

    //// 5.3 上传图片
    //document.querySelector('#uploadImage').onclick = function () {
    //    if (images.localId.length == 0) {
    //        alert('请先使用 chooseImage 接口选择图片');
    //        return;
    //    }
    //    var i = 0, length = images.localId.length;
    //    images.serverId = [];
    //    function upload() {
    //        wx.uploadImage({
    //            localId: images.localId[i],
    //            success: function (res) {
    //                i++;
    //                //alert('已上传：' + i + '/' + length);
    //                images.serverId.push(res.serverId);
    //                if (i < length) {
    //                    upload();
    //                }
    //            },
    //            fail: function (res) {
    //                alert(JSON.stringify(res));
    //            }
    //        });
    //    }
    //    upload();
    //};

    //// 5.4 下载图片
    document.querySelector('#downloadImage').onclick = function () {
        if (images.serverId.length === 0) {
            alert('请先使用 uploadImage 上传图片');
            return;
        }
        var i = 0, length = images.serverId.length;
        images.localId = [];
        function download() {
            wx.downloadImage({
                serverId: images.serverId[i],
                success: function (res) {
                    i++;
                    alert('已下载：' + i + '/' + length);
                    images.localId.push(res.localId);
                    if (i < length) {
                        download();
                    }
                }
            });
        }
        download();
    };

    //// 6 设备信息接口
    //// 6.1 获取当前网络状态
    //document.querySelector('#getNetworkType').onclick = function () {
    //    wx.getNetworkType({
    //        success: function (res) {
    //            alert(res.networkType);
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 7 地理位置接口
    //// 7.1 查看地理位置
    //document.querySelector('#openLocation').onclick = function () {
    //    wx.openLocation({
    //        latitude: 23.099994,
    //        longitude: 113.324520,
    //        name: 'TIT 创意园',
    //        address: '广州市海珠区新港中路 397 号',
    //        scale: 14,
    //        infoUrl: 'http://weixin.qq.com'
    //    });
    //};

    //// 7.2 获取当前地理位置
    //document.querySelector('#getLocation').onclick = function () {
    //    wx.getLocation({
    //        success: function (res) {
    //            alert(JSON.stringify(res));
    //        },
    //        cancel: function (res) {
    //            alert('用户拒绝授权获取地理位置');
    //        }
    //    });
    //};

    //// 8 界面操作接口
    //// 8.1 隐藏右上角菜单
    //document.querySelector('#hideOptionMenu').onclick = function () {
    //    wx.hideOptionMenu();
    //};

    //// 8.2 显示右上角菜单
    //document.querySelector('#showOptionMenu').onclick = function () {
    //    wx.showOptionMenu();
    //};

    //// 8.3 批量隐藏菜单项
    //document.querySelector('#hideMenuItems').onclick = function () {
    //    wx.hideMenuItems({
    //        menuList: [
    //          'menuItem:readMode', // 阅读模式
    //          'menuItem:share:timeline', // 分享到朋友圈
    //          'menuItem:copyUrl' // 复制链接
    //        ],
    //        success: function (res) {
    //            alert('已隐藏“阅读模式”，“分享到朋友圈”，“复制链接”等按钮');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 8.4 批量显示菜单项
    //document.querySelector('#showMenuItems').onclick = function () {
    //    wx.showMenuItems({
    //        menuList: [
    //          'menuItem:readMode', // 阅读模式
    //          'menuItem:share:timeline', // 分享到朋友圈
    //          'menuItem:copyUrl' // 复制链接
    //        ],
    //        success: function (res) {
    //            alert('已显示“阅读模式”，“分享到朋友圈”，“复制链接”等按钮');
    //        },
    //        fail: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 8.5 隐藏所有非基本菜单项
    //document.querySelector('#hideAllNonBaseMenuItem').onclick = function () {
    //    wx.hideAllNonBaseMenuItem({
    //        success: function () {
    //            alert('已隐藏所有非基本菜单项');
    //        }
    //    });
    //};

    //// 8.6 显示所有被隐藏的非基本菜单项
    //document.querySelector('#showAllNonBaseMenuItem').onclick = function () {
    //    wx.showAllNonBaseMenuItem({
    //        success: function () {
    //            alert('已显示所有非基本菜单项');
    //        }
    //    });
    //};

    //// 8.7 关闭当前窗口
    //document.querySelector('#closeWindow').onclick = function () {
    //    wx.closeWindow();
    //};

    //// 9 微信原生接口
    //// 9.1.1 扫描二维码并返回结果
    //document.querySelector('#scanQRCode0').onclick = function () {
    //    wx.scanQRCode();
    //};
    //// 9.1.2 扫描二维码并返回结果
    //document.querySelector('#scanQRCode1').onclick = function () {
    //    wx.scanQRCode({
    //        needResult: 1,
    //        desc: 'scanQRCode desc',
    //        success: function (res) {
    //            alert(JSON.stringify(res));
    //        }
    //    });
    //};

    //// 10 微信支付接口
    //// 10.1 发起一个支付请求
    //document.querySelector('#chooseWXPay').onclick = function () {
    //    // 注意：此 Demo 使用 2.7 版本支付接口实现，建议使用此接口时参考微信支付相关最新文档。
    //    wx.chooseWXPay({
    //        timestamp: 1414723227,
    //        nonceStr: 'noncestr',
    //        package: 'addition=action_id%3dgaby1234%26limit_pay%3d&bank_type=WX&body=innertest&fee_type=1&input_charset=GBK&notify_url=http%3A%2F%2F120.204.206.246%2Fcgi-bin%2Fmmsupport-bin%2Fnotifypay&out_trade_no=1414723227818375338&partner=1900000109&spbill_create_ip=127.0.0.1&total_fee=1&sign=432B647FE95C7BF73BCD177CEECBEF8D',
    //        signType: 'SHA1', // 注意：新版支付接口使用 MD5 加密
    //        paySign: 'bd5b1933cda6e9548862944836a9b52e8c9a2b69'
    //    });
    //};

    //// 11.3  跳转微信商品页
    //document.querySelector('#openProductSpecificView').onclick = function () {
    //    wx.openProductSpecificView({
    //        productId: 'pDF3iY_m2M7EQ5EKKKWd95kAxfNw',
    //        extInfo: '123'
    //    });
    //};

    //// 12 微信卡券接口
    //// 12.1 添加卡券
    //document.querySelector('#addCard').onclick = function () {
    //    wx.addCard({
    //        cardList: [
    //          {
    //              cardId: 'pDF3iY9tv9zCGCj4jTXFOo1DxHdo',
    //              cardExt: '{"code": "", "openid": "", "timestamp": "1418301401", "signature":"ad9cf9463610bc8752c95084716581d52cd33aa0"}'
    //          },
    //          {
    //              cardId: 'pDF3iY9tv9zCGCj4jTXFOo1DxHdo',
    //              cardExt: '{"code": "", "openid": "", "timestamp": "1418301401", "signature":"ad9cf9463610bc8752c95084716581d52cd33aa0"}'
    //          }
    //        ],
    //        success: function (res) {
    //            alert('已添加卡券：' + JSON.stringify(res.cardList));
    //        },
    //        cancel: function (res) {
    //            alert(JSON.stringify(res))
    //        }
    //    });
    //};

    //var codes = [];
    //// 12.2 选择卡券
    //document.querySelector('#chooseCard').onclick = function () {
    //    wx.chooseCard({
    //        cardSign: '6caa49f4a5af3d64ac247e1f563e5b5eb94619ad',
    //        timestamp: 1437997723,
    //        nonceStr: 'k0hGdSXKZEj3Min5',
    //        success: function (res) {
    //            res.cardList = JSON.parse(res.cardList);
    //            encrypt_code = res.cardList[0]['encrypt_code'];
    //            alert('已选择卡券：' + JSON.stringify(res.cardList));
    //            decryptCode(encrypt_code, function (code) {
    //                codes.push(code);
    //            });
    //        },
    //        cancel: function (res) {
    //            alert(JSON.stringify(res))
    //        }
    //    });
    //};

    //// 12.3 查看卡券
    //document.querySelector('#openCard').onclick = function () {
    //    if (codes.length < 1) {
    //        alert('请先使用 chooseCard 接口选择卡券。');
    //        return false;
    //    }
    //    var cardList = [];
    //    for (var i = 0; i < codes.length; i++) {
    //        cardList.push({
    //            cardId: 'pDF3iY9tv9zCGCj4jTXFOo1DxHdo',
    //            code: codes[i]
    //        });
    //    }
    //    wx.openCard({
    //        cardList: cardList,
    //        cancel: function (res) {
    //            alert(JSON.stringify(res))
    //        }
    //    });
    //};

    //var shareData = {
    //    title: '微信JS-SDK Demo',
    //    desc: '微信JS-SDK,帮助第三方为用户提供更优质的移动web服务',
    //    link: 'http://demo.open.weixin.qq.com/jssdk/',
    //    imgUrl: 'http://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRt8Qia4lv7k3M9J1SKqKCImxJCt7j9rHYicKDI45jRPBxdzdyREWnk0ia0N5TMnMfth7SdxtzMvVgXg/0'
    //};
    //wx.onMenuShareAppMessage(shareData);
    //wx.onMenuShareTimeline(shareData);

    function decryptCode(code, callback) {
        $.getJSON('/jssdk/decrypt_code.php?code=' + encodeURI(code), function (res) {
            if (res.errcode == 0) {
                codes.push(res.code);
            }
        });
    }
});

wx.error(function (res) {
    alert(res.errMsg);
});
function picremove(t) {
    // alert($(t).parent().attr('id'));
    //将此父级元素下兄弟元素的img的id获取截取字段，对imglist的对应的标记为删除
    var tmp = $(t).parent().find('img').attr('id');
    var tmp1 = tmp.substr(3, 1);

    for (var i = 0; i < imglist.index.length; i++) {
        if (imglist.index[i] == tmp1) {
            imglist.delmart[i] = "1";//标记被删除的        
        }
    }
    $(t).parent().empty();

}
function imgop(t) {
    var tmp = 'img' + t;
    var imgcont = document.getElementById("light");
    var imgscr = $(t).attr('src');
    // alert(imgscr);
    imgcont.innerHTML = "  <img  src='" + imgscr
        + "'style='overflow-x:inherit;width:100%;height:100%'  onclick='openimg()'/>";
    document.getElementById('light').style.display = 'block'; document.getElementById('fade').style.display = 'block';
};
function openimg() {
    document.getElementById('light').style.display = 'none'; document.getElementById('fade').style.display = 'none'
};
function getstr() {
    var htmlstr0 = "";
    if ($("#other").prop("checked") == true) {
        htmlstr0 = htmlstr0 + "<div class='weui_cell'><div class='weui_cell_hd'><label class='weui_label' style='color:#383535'>保证金</label></div>"
+ "<div class='weui_cell_bd weui_cell_primary'><input class='weui_input' type='number'  id='amount1' style='color:#383535'  placeholder='0.00' />"
+ " </div></div>"
+ "<div class='weui_cell'><div class='weui_cell_hd'><label class='weui_label' style='color:#383535'>柜台押金</label></div>"
+ "<div class='weui_cell_bd weui_cell_primary'><input class='weui_input' type='number'  id='amount2' style='color:#383535'  placeholder='0.00' />"
+ " </div></div>"
    + "<div class='weui_cell'><div class='weui_cell_hd'><label class='weui_label' style='color:#383535'>形象押金</label></div>"
+ "<div class='weui_cell_bd weui_cell_primary'><input class='weui_input' type='number'  id='amount3' style='color:#383535'  placeholder='0.00' />"
+ " </div></div>";
        deposit.innerHTML = htmlstr0;
    } else { deposit.innerHTML = htmlstr0; }
};//其它选项
function save1() {
    //$('#saveid').unbind("click",save1);
    //save();

}
function save() {
    var amount = $('#amount').val();//金额
    var date = $('#dateid').val();//日期
    var tmemo = $('#tmemo').val();//备注
    var cus = $("#select1").find("option:selected").val();
    var khzh = $("#select2").find("option:selected").val();//拼接的值
    var gszh = $("#select3").find("option:selected").val();
    var khzh0 = $("#select2").find("option:selected").text();
    var serverurl = [];
    var pic_num = 0;
    for (var i = 0; i < imglist.serverId.length;i++)
    {
        if(imglist.delmart[i]!="1")
        {//1是删除标记，0是初始化标记
            serverurl.push(imglist.serverId[i]);
            pic_num++;
        }
    }
    //alert(pic_num+imglist.delmart.join('|').toString()+  serverurl.join("|").toString());
    //执行这个点击事件的同时解绑，折在这个点击事件绑定之前都是无法点击的。
    $('#saveid').unbind("click", save);
    $('#saveid').bind("click", save1);
    //if ($("#other").prop("checked") == true) {
    //    var amount1 = $('#amount1').val();
    //    var amount2 = $('#amount2').val();//
    //    var amount3 = $('#amount3').val();
    //    if (cus == "0" || khzh == "0" || gszh == "0" || (amount1 == "" && amount2 == "" && amount3 == "") ) {
    //            $.toptip('必输项未选择或者为零！', 'warning');
    //            $('#saveid').bind("click", save);

    //    } else {
    //        $.ajax({
    //           // traditional: true,
    //            type: "post",
    //           // dataType: "json",
    //            url: "../API/RtCashEdit_s.ashx",//处理程序
    //            data: {
    //                mark: 0,
    //                amount: amount,
    //                date: date,
    //                tmemo: tmemo,
    //                cus: cus,
    //                khzh: khzh,
    //                khzh0: khzh0,
    //                gszh: gszh,
    //                pic_num:pic_num,
    //                serverurl: serverurl.join("|").toString(),//后台获取，可以直接写入字段或者分开写入子表
    //                amount1: amount1,
    //                amount2: amount2,
    //                amount3: amount3 
    //            },
    //            async: true,
    //            error: function (XMLHttpRequest, textStatus, errorThrown) {
    //              //  alert(XMLHttpRequest.readyState + textStatus + errorThrown + XMLHttpRequest.responseText);
    //            },
    //            success: function (data) {
    //                if ($.trim(data) == "suc") {
    //                    $('#saveid').unbind("click", save);
    //                    $.toast("提交成功！", function () {
    //                        console.log('close');
    //                        window.location.reload();
    //                    });
    //                } else {

    //                    $.toast("失败！", function () {
    //                        $('#saveid').bind("click", save);
    //                        console.log('close');
    //                    });
    //                }
    //            }
    //        });
    //    }
    //} else {
        if (cus == "0" || khzh == "0" || gszh == "0" || amount == "" || amount == "0") {
                $.toptip('必输项未选择或者为零！', 'warning');
                $('#saveid').bind("click", save);
           
        } else {
            // alert(amount);
            $.ajax({
              //  traditional: true,
                type: "post",
              //  dataType: "json",
                url: "../API/RtCashEdit_s.ashx",//处理程序
                data: {
                    mark: 1,
                    amount: amount,
                    date: date,
                    tmemo: tmemo,
                    pic_num:pic_num,
                    cus: cus,
                    khzh: khzh,
                    khzh0: khzh0,
                    gszh: gszh,
                    serverurl: serverurl.join("|").toString()
                },
                async: true,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                  alert("网络传输错误，请重新提交");
                     // alert(XMLHttpRequest.readyState+'|'+ errorThrown+'|'+textStatus+'|'+XMLHttpRequest.error);
                    window.location.reload();
                },
                success: function (data) {
                    if ($.trim(data) == "suc") {
                        $.toast("提交成功！", function () {
                            $('#saveid').unbind("click", save);
                            console.log('close');
                            window.location.reload();
                        });
                    } else {

                        $.toast("失败！", function () {
                            $('#saveid').bind("click", save);
                            console.log('close');
                        });
                    }
                }
            });
    //     };
    };
};
