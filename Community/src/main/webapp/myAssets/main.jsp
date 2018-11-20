<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <title> WORLDSPON My Assets</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,
        maximum-scale=1, user-scalable=no">
	    <meta name="description" content="Free Reward App, Free Android App" />
	    <meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	    <meta name="author" content="WorldSpon, Inc." />
	
	    <link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	    <link rel="icon" href="/info/img/favicon/ws_p16.png" sizes="16x16">
	    <link rel="icon" href="/info/img/favicon/ws_p32.png" sizes="32x32">
        
        <link rel="stylesheet" href="/myAssets/css/font.css">
        <link rel="stylesheet" href="/myAssets/css/grid.css">
        <link rel="stylesheet" href="/myAssets/css/aminate.css">
        <link rel="stylesheet" href="/myAssets/css/bootstrap.min.css">
        
        <link rel="stylesheet" href="/myAssets/css/loader.css">
        <link rel="stylesheet" href="/myAssets/css/main.css">
        
    </head>
    <body>
    	<div id="data-set"></div>
    	<div class="lds-back"></div>
        <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
        
   <!-- jQuery -->
	<script src="/myAssets/js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="/myAssets/js/bootstrap.min.js"></script>
	<!-- Main -->
	<script src="/myAssets/js/main.js"></script>

<script type="text/javascript">

$(function(){
	
	/* 상세목록 클릭 */
	$(document).on("click", ".go-detail", function(){
		var data = getDataSet();
		var type = $(this).data("type");
		data.type = type;
		console.log(data.no +", "+ data.uNo +", "+ type);
		getAjaxDetail(data);
	});

	/* 뒤로 클릭 */
	$(document).on("click", ".goBack", function(){
		var data = {};
		var no = $("#data-set").data("no");
		no = 1;
		$("#data-set").data("no", no);
		var uNo = $("#data-set").data("uNo");
		data.no = no;
		data.uNo = uNo;
		
		console.log("goBack: "+ data.no +", "+ data.uNo);
		
		$("#detail-page").remove();
		getAjaxMain(data);
	});

	/* 더보기  클릭 */
	$(document).on("click", ".more-see", function(){
		var no = $("#data-set").data("no");
		var uNo = $("#data-set").data("uNo");
		console.log("더보기 현재 no="+ no +", uNo="+ uNo);
		no++;
		$("#data-set").data("no", no);
		console.log("더보기 누르고 no="+ no +", uNo="+ uNo);
	});
	
	/* 초기 로드 */
	init();
	
});

function init() {
	card.fnInit();
}
function getDataSet(){
	return card.fnGetDataSet();
}
function getAjaxMain(data){
	card.fnGetAjaxMain(data);
}
function getAjaxDetail(data){
	card.fnGetAjaxDetail(data);	
}
function makeMain(data){
	card.fnMakeMain(data);
}
	
function makeDetail(data){
	console.log(data);
	
	var no = data.no;
	var uNo = data.uNo;
	var l_coin = data.type;
	
	var html = "<div id='detail-page'><h1>hello world!</h1><button class='goBack'>뒤로</button><button class='more-see'>더보기</button></div>";
	
	$(".container-fluid").remove();
	$("body").append(html);
	hideLoader();
}

var card = {
	//Init
	fnInit : function(){
		var data = '${data}';
		var jsonData = JSON.parse(data);
		$("#data-set").data("no", jsonData.no);
		$("#data-set").data("uNo", jsonData.uNo);
		console.log(jsonData);
		getAjaxMain(jsonData);
	},
	
	fnGetDataSet : function(){
		var no = $("#data-set").data("no");
		var uNo = $("#data-set").data("uNo");
		var data = {};
		data.no = no;
		data.uNo = uNo;
		return data;
	},
	
	fnGetAjaxMain : function(data){
		if(!data){
			alert("정보를 불러올 수 없습니다.");
		}else{
			$.ajax({
				type: "POST"
				, url: "/myAssets/getMain"
				, data: data
				, dataType: "json"
				, beforeSend : function(){
					showLoader();
				}
			}).done(function(data){
				makeMain(data);
			});
		}
	},
	
	fnGetAjaxDetail : function(data) {
		$.ajax({
			type: "POST"
			, url: "/myAssets/getDetail"
			, data: data
			, dataType: "json"
			, beforeSend : function(){
				showLoader();
			}
		}).done(function(data){
			makeDetail(data);
		});
	},
	
	fnMakeMain : function(data) {
		
		console.log("card.fnMakeMain: "+data.list);
		
		var no = data.list[0].no;
		var uNo = data.list[0].uNo;
		var nick = data.list[0]._Trademark;
		var coin = data.list[0]._Coin;
		var point = data.list[0]._Point;
		var l_coin = data.list[0]._LockCoin;
		var l_point = data.list[0]._LockPoint;
		
		if(nick == null){
			alert("정보를 불러올 수 없습니다.");
			return false;
		}
			
		var html = "<div id='main-page' class='main-page-top container-fluid'>"
				   + "<div class='contents_1'>"
	                 + "<div class='row main-title font-color-white'>"
	                   + "<div class='title_nick more_bigger_normal_font_size bold'>"+nick
	                     + "<span class='normal_font_size'> 님의 자산</span></div>"
	                   + "</div>"
	                   + "<div class='row blank_height_3'></div>"
	                   + "<div class='row blank_height_1'></div>"
	                   + "<div class='row normal_font_size bold'>"
	                     + "<div class='col-12 no-double'>"
	                       + "<div class='top-box-title font-color-ccc'>스폰</div>"
	                       + "<div class='title-amount font-color-white'>"+numberWithCommas(Number(coin+l_coin))+" 개</div>"
	                     + "</div>"
	                     + "<div class='col-12 text-left no-double'>"
	                       + "<div class='top-box-title font-color-ccc'>포인트</div>"
	                       + "<div class='title-amount font-color-white'>"+numberWithCommas(Number(point+l_point))+" 원</div>"
	                     + "</div>"
	                   + "</div>"
	                   + "<div class='row blank_height_1'></div>"
//	                       + "<div class='row'>"
//	                         + "<div class='no-double col-12 more_smaller_size bolder font-color-ccc'>나의 지분율</div>"
//	                         + "<div lass='no-double col-12 more_smaller_size bold font-color-white'>0.1234567890%</div>"
//	                       + "</div>"
					   + "</div>"
					 + "</div>"
				   + "<div class='info-box container-fluid bg-white go-detail' data-type='s'>"
				   + "<div class='assets-name font-color-gray bold'>스폰</div>"
				   + "<div class='assets-amount con-spon bold'><a href='#'>" +numberWithCommas(coin)+ " &nbsp;&nbsp;></a></div>"
				+ "</div>"
				+ "<div class='info-box container-fluid bg-white go-detail' data-type='p'>"
				   + "<div class='assets-name font-color-gray bold'>포인트</div>"
				   + "<div class='assets-amount con-spon bold'><a href='#'> "+numberWithCommas(point)+" &nbsp;&nbsp;></a></div>"
				+ "</div>";
				if(l_coin != 0){
					html += "<div class='info-box container-fluid bg-white go-detail' data-type='ls'>"
					  + "<div class='assets-name font-color-gray bold'>락스폰</div>"
					  + "<div class='assets-amount con-spon bold'><a href='#'>" +numberWithCommas(l_coin)+ " &nbsp;&nbsp;></a></div>"
					+ "</div>";
				}
				if(l_point != 0){
					html += "<div class='info-box container-fluid bg-white go-detail' data-type='lp'>"
					  + "<div class='assets-name font-color-gray bold'>락포인트</div>"
					  + "<div class='assets-amount con-spon bold'><a href='#'>" +l_point+ " &nbsp;&nbsp;></a></div>"
					+ "</div>";
				}
				
				
				
				
				
				
				
				
		$("body").append(html);
		hideLoader();
	}
}
	
	
</script>
</body>
</html>