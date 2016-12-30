(function (t, w, f) {
    var host = "http://shawndev.lekar.cn";
    w[t] = f(host);
}("JwxTool", window, function (host)
{
    var jt = {};
    var wxFunc = {};

    wx.ready(function () {
        jt.isWxReady = true;
        if (typeof jt.readyFunc == "function") {
            jt.readyFunc();
        }
    });

    wx.error(function (res) {
        jt.isWxReady = false;
        if (typeof jt.errorFunc == "function") {
            jt.errorFunc();
        }
    });

    /* Config */
    wxFunc.config = function (debug, appId, data, jsApiList) {
        wx.config({
            debug: debug,
            appId: appId,
            timestamp: data.timestamp,
            nonceStr: data.nonceStr,
            signature: data.signature,
            jsApiList: jsApiList
        });
    }

    /* 添加会员卡 */
    wxFunc.addCard = function (cardId, cardExt, successCallback) {
        wx.addCard({
                cardList: [{
                    cardId: cardId,
                    cardExt: JSON.stringify(cardExt)
                }],
                success: function(res){
                	successCallback(res);
                }
            }
        )
    }

    /* 隐藏右上角部分能隐藏的所有按钮 */
    wxFunc.hideOptionMenu = function () {
        wx.hideOptionMenu();
    }

    jt.ready = function (f) {
        jt.readyFunc = f;
    }

    jt.error = function (f) {
        jt.errorFunc = f;
    }

    jt.networkError = function (f) {
        jt.networkErrorFunc = f;
    }

    /* 签名JS-SDK */
    jt.JsapiSign = function (debug, appId, jsApiList) {
        $.ajax({
            type: 'POST',
            url: host + '/native/sign/jsapi',
            data: {
                url: window.location.href
            },
            timeout: 30000,
            success: function (data) {
                wxFunc.config(debug, appId, data, jsApiList);

            },
            error: function () {
                jt.networkErrorFunc(host)
            },
            complete: function (xhr, status) {
            }
        })
    }

    /* 添加会员卡 */
    jt.wxcardCreateSign = function (cardId, successCallback) {
        $.ajax({
            type: 'POST',
            url: host + '/native/sign/wxCardCreate',
            data: {},
            timeout: 30000,
            success: function (data) {
                wxFunc.addCard(cardId, data, successCallback)
            },
            error: function () {
                jt.networkErrorFunc(host)
            },
            complete: function (xhr, status) {
            }
        })
    }

    /* 隐藏右上角部分能隐藏的所有按钮 */
    jt.wxhideOptionMenu = function () {
        wxFunc.hideOptionMenu()
    }
    return jt;
}))
;
