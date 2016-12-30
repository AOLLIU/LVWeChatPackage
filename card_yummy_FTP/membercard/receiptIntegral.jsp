<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh">
<head>
<meta charset="UTF-8">
<meta http-equiv="x-ua-compatible" content="ie=edge">
	<meta name="format-detection" content="telephone=no" />
<title>积分领取</title>
<meta name="description" content="">
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
	<link rel="stylesheet" href="../include/css/package/getIntegralResult.css">
</head>





<%--<body>--%>

<%--<div>凭证编号：${tradeId}</div>--%>
<%--<div>本次消费累计积分：${integralFee}</div>--%>
<%--<div>消费金额：${amount}</div>--%>
<%--<div>可积分额度：${amountSe}</div>--%>

<%--</body>--%>


	<body>

	<div  id="app">

	<!--凭证编号-->
	<div class="proofNumber">凭证编号: ${tradeId}</div>

	<!--领取提示-->
	<div class="getIntegralCardContainer">
	<div class="getIntegralCardTipImageContainer">
	<img v-bind:src="tipInfo.tipImage" class="getIntegralCardTipImage">

	</div>
	<div class="cardTipImageFirstTip">{{tipInfo.firstTip}}</div>
	<div class="cardTipImageSecondTip">{{tipInfo.secondTip}} <span id="cardTipSpan"></span></div>
	</div>
	<input type="hidden" value="${integralFee}" id="hiddenScoreInput">

	<!--支付详情-->
	<div class="getIntegralCardDetail">
		<div class="getIntegralCardDetailTitle fontWeight">支付详情:</div>
		<div class="seperateLine"></div>
		<div class="getIntegralCardDetailMoney">
			<span class="getIntegralCardDetailMoneyTitle">消费金额</span>
			<span class="getIntegralCardDetailMoneyCount">¥ ${amount/100}元</span>
		</div>
	<%--<div class="seperateLine"></div>--%>
	<%--<div class="canGetIntegralLimitContainer">--%>
	<%--<span class="canGetIntegralLimit">可积分额度: ¥ ${amountSe/100}元</span>--%>
	<%--</div>--%>

		<div class="seperateLine"></div>
		<div class="distributeIntegralContainer">
			<span class="distributeIntegral">发放积分:<span id="distributeIntegralInner"></span></span>
			<span class="distributeIntegralState">${receiptDesc}</span>
		</div>
	</div>

	<!--查看积分记录按钮-->
	<!--<div class="scanRecordBtn">查看积分记录</div>-->

	</div>

	<script src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
	<script src="../include/tool.js"></script>
	<script src="../include/zepto.min.js"></script>
	<script src="../include/vue.min.js"></script>

	<script>

	$(function () {
		var inputInner = $("#hiddenScoreInput").val();
		<%--alert(inputInner)--%>
		if(inputInner>0){
			appData.tipInfo = {
				"tipImage":"./others/happy.png",
				"firstTip":"积分领取成功!",
				"secondTip":"本次消费累计积分"
			}
		}else{
			appData.tipInfo = {
				"tipImage":"./others/cry.png",
				"firstTip":"积分已被领取",
				"secondTip":"请勿重复领取哦!"
			}
			$("#cardTipSpan").hide()
			$(".distributeIntegralState").addClass("nouseState")
			$(".getIntegralCardDetailTitle").removeClass("fontWeight")
			$(".cardTipImageFirstTip").addClass("warningColor")
			$(".cardTipImageSecondTip").addClass("warningColor")
			<%--$(".getIntegralCardDetail").hide()--%>
		}
		$("#cardTipSpan").text(parseInt(inputInner/100))
		$("#distributeIntegralInner").text(parseInt(inputInner/100))

	});

	JwxTool.ready(function () {
		JwxTool.wxhideOptionMenu()
	})

	var appData = {
	integralCardInfo:{},
	tipInfo:{}
	};


	var appFunc = {
	};

	var app = new Vue({
		el : '#app',
		data : appData,
		methods : {
					},
		mounted : function() {

		JwxTool.JsapiSign(false, 'wx41dc46a54f790917', [ "addCard",
		"openCard" ]);
		getIntegralCardInfo();

		}

	});

	function getIntegralCardInfo() {
	appData.integralCardInfo = {"proofNumber":"SFXXXXXX0001","distributeIntegral":"20","integralCardDetailMoney":"200","canGetIntegralLimit":"200"}
	}

	</script>
	</body>

</html>
