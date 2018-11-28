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
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
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
	<script src="/myAssets/js/popper.js"></script>
	<!-- Bootstrap -->
	<script src="/myAssets/js/bootstrap.js"></script>
	<!-- Main -->
	<script src="/myAssets/js/main.js"></script>

<script type="text/javascript">

$(function(){
	
	/* 상세목록 클릭 */
	$(document).on("click", ".go-detail", function(){
		var data = getDataSet();
		var type = $(this).data("type");
		var lt = $(this).data("lt");
		$("#data-set").data("lt", lt);
		$("#data-set").data("type", type);
		data.type = type;
		data.listType = lt;
// 		console.log($.extend({'location':'event-click.go-detail', 'debug-target':'params'}, data));
		getAjaxDetail(data);
	});
	
	/* 상세보기 전체보기 */

	/* 뒤로 클릭 */
	$(document).on("click", ".goBack", function(){
		var data = {};
		var no = $("#data-set").data("no");
		no = 1;
		$("#data-set").data("no", no);
		var uNo = $("#data-set").data("uNo");
		data.no = no;
		data.uNo = uNo;
		
// 		console.log("goBack: "+ data.no +", "+ data.uNo);
		
		$("#detail-page").remove();
		getAjaxMain(data);
	});

	/* 더보기  클릭 */
	$(document).on("click", ".more-see", function(){
		
		var data = {};
		
		var no = $("#data-set").data("no");
		var total = $("#data-set").data("total");
		var listType = $("#data-set").data("lt");
		var type = $("#data-set").data("type");
		var page = pagination(no, total);
		var max = page.max;
		no++;
		if(no >= max){
			$("#data-set").data("no", max);
		}else{
			$("#data-set").data("no", no);
		}
		
		data.no = $("#data-set").data("no");
		data.uNo = $("#data-set").data("uNo");
		data.type = type;
		data.listType = listType;
		data.total = total;
// 		console.log(data);
		makeDetailContents(data);
		
	});
	
	/* 내역 옵션 change */
	$(document).on("click", ".dropdown-item", function(){
		var data = {};
		var uNo = $("#data-set").data("uNo");
		var total = $("#data-set").data("total");
		var type = $("#data-set").data("type");
		var lt = $(this).data("lt");
		$("#data-set").data("lt", lt);
		data.no = 1;
		data.uNo = uNo;
		data.total = total;
		data.type = type;
		data.listType = lt;
		
// 		console.log(data);
		getAjaxDetail(data);
		
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
function makeDetailContents(data){
	card.fnGetAjaxContents(data);
}


var card = {
	//Init
	fnInit : function(){
		var data = '${data}';
		var jsonData = JSON.parse(data);
		$("#data-set").data("no", jsonData.no);
		$("#data-set").data("uNo", jsonData.uNo);
// 		console.log(jsonData);
		card.fnGetAjaxMain(jsonData);
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
// 		console.log($.extend({'location':'card.fnGetAjaxMain', 'debug-target':'params'}, data));
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
				card.fnMakeMain(data);
			});
		}
	},
	
	fnGetAjaxDetail : function(data) {
// 		console.log($.extend({'location':'card.fnGetAjaxDetail', 'debug-target':'params'}, data));
		
		$.ajax({
			type: "POST"
			, url: "/myAssets/getDetail"
			, data: data
			, dataType: "json"
			, beforeSend : function(){
				showLoader();
			}
		}).done(function(data){
			card.fnMakeDetailTop(data);
		});
	},
	
	fnMakeMain : function(data) {
// 		console.log($.extend({'location':'card.fnMakeMain', 'debug-target':'params'}, data.list[0]));
		var no = data.list[0].no;
		var uNo = data.list[0].uNo;
		var nick = data.list[0]._Trademark;
		var coin = data.list[0]._Coin;
		var coin
		var point = data.list[0]._Point;
		var l_coin = data.list[0]._LockCoin;
		var l_point = data.list[0]._LockPoint;
		
		if(nick == null){
			alert("정보를 불러올 수 없습니다.");
			return false;
		}
		var html = "";
		html += "<div id='main-page' class='main-page-top container-fluid'>"
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
//	                      + "<div class='row'>"
//	                        + "<div class='no-double col-12 more_smaller_size bolder font-color-ccc'>나의 지분율</div>"
//	                        + "<div lass='no-double col-12 more_smaller_size bold font-color-white'>0.1234567890%</div>"
//	                      + "</div>"
				   + "</div>"
				 + "</div>"
				 + "<div class='info-box container-fluid bg-white go-detail' data-type='s' data-lt='a'>"
				   + "<div class='assets-name font-color-gray bold'>스폰</div>"
				   + "<div class='assets-amount con-spon bold'><a href='#'>" +numberWithCommas(coin)+ " &nbsp;&nbsp;></a></div>"
				+ "</div>"
				+ "<div class='info-box container-fluid bg-white go-detail' data-type='p' data-lt='a'>"
				   + "<div class='assets-name font-color-gray bold'>포인트</div>"
				   + "<div class='assets-amount con-spon bold'><a href='#'> "+numberWithCommas(point)+" &nbsp;&nbsp;></a></div>"
				+ "</div>";
				if(l_coin != 0){
					html += "<div class='info-box container-fluid bg-white go-detail' data-type='ls' data-lt='a'>"
					  + "<div class='assets-name font-color-gray bold'>락스폰</div>"
					  + "<div class='assets-amount con-spon bold'><a href='#'>" +numberWithCommas(l_coin)+ " &nbsp;&nbsp;></a></div>"
					+ "</div>";
				}
				if(l_point != 0){
					html += "<div class='info-box container-fluid bg-white go-detail' data-type='lp' data-listType='a'>"
					  + "<div class='assets-name font-color-gray bold'>락포인트</div>"
					  + "<div class='assets-amount con-spon bold'><a href='#'>" +l_point+ " &nbsp;&nbsp;></a></div>"
					+ "</div>";
				}
		$(".detail-page").remove();
		$("body").append(html);
		hideLoader();
	},
	
	fnMakeDetailTop : function(data){
			
		$("#data-set").data("total", data.total);
// 		console.log($.extend({'location':'fnMakeDetailTop', 'debug-target':'params'}, data));
		
		var no = data.no;
		var uNo = data.uNo;
		var type = data.type;
		var coin = data.list[0]._Coin;
		var l_coin = data.list[0]._LockCoin;
		var point = data.list[0]._Point;
		var l_point = data.list[0]._LockPoint;
		
// 		console.log(data.listType);
		if(data.listType == "a"){
// 			console.log("listType is a");
		}else{
// 			console.log("listType is not a");
		}
		
		
		var html = "";
		html += "<div class='detail-page view-box container-fluid no-double'>"
			 +     "<div class='detail-top-box container-fluid'>"
			 +	     "<div>"
			 +		   "<div class='row assets-menu'>"
			 +			  "<div class='col-1 no-double'>"
			 +			    "<a href='#' class='goBack'><i class='fas fa-arrow-left'></i></a>"
			 +			  "</div>";
			 
		if(type == 'p'){
			html +=		   "<div class='col-4 bolder'>포인트</div></div>";
		}else if(type == 's'){
			html +=		   "<div class='col-4 bolder'>스폰</div></div>";
		}else if(type == 'lp'){
			html +=		   "<div class='col-4 bolder'>락포인트</div></div>";
		}else if(type == 'ls'){
			html +=		   "<div class='col-4 bolder'>락스폰</div></div>";
		}
	    html += "<div class='blank_height_3'></div>"
	         +  "<div class='dropdown'>"
	         +    "<button class='btn btn-default dropdown-toggle' type='button' id='dropdownMenuButton' data-toggle='dropdown' aria-haspopup='true' aria-expanded='false'>";
		if(data.listType == 'a'){
			html += "전체내역";
		}else if(data.listType == 'i'){
			html += "입금내역";
		}else if(data.listType == 'o'){
			html += "출금내역";
		}
		html += " <i class='fas fa-angle-down'></i></button>"
	         +		"<div class='dropdown-menu shadow-lg' aria-labelledby='dropdownMenuButton'>";
		if(data.listType == 'a'){
			html += "<a class='dropdown-item' href='#' data-lt='a'>전체내역 <i class='fas fa-angle-down'></i></a>"
				 +  "<a class='dropdown-item' href='#' data-lt='i'>입금내역</a>"
				 +  "<a class='dropdown-item' href='#' data-lt='o'>출금내역</a>";
		}else if(data.listType == 'i'){
			html += "<a class='dropdown-item' href='#' data-lt='a'>전체내역</a>"
				 +  "<a class='dropdown-item' href='#' data-lt='i'>입금내역 <i class='fas fa-angle-down'></i></a>"
				 +  "<a class='dropdown-item' href='#' data-lt='o'>출금내역</a>";
		}else if(data.listType == 'o'){
			html += "<a class='dropdown-item' href='#' data-lt='a'>전체내역</a>"
				 +  "<a class='dropdown-item' href='#' data-lt='i'>입금내역</a>"
				 +  "<a class='dropdown-item' href='#' data-lt='o'>출금내역 <i class='fas fa-angle-down'></i></a>";
		}
		html += "</div></div>"
			 + "<div class='blank_height_3'></div>"
			 + "<div class='col-12 bolder'>";
		if(type == 's'){
			html += numberWithCommas(coin)+"</div>";
		}else if(type == 'p'){
			html += numberWithCommas(point)+"</div>";
		}else if(type == 'ls'){
			html += numberWithCommas(l_coin)+"</div>";
		}else if(type == 'lp'){
			html += numberWithCommas(l_point)+"</div>";
		}
		html += "<div class='blank_height_1'></div>"
	         +  "<div class='col-12 micro_font_size bold font-color-gray'>";
		if(type == 's'){
			html += "스폰지갑</div>";
		}else if(type == 'p'){
			html += "포인트지갑</div>";
		}else if(type == 'ls'){
			html += "락스폰지갑</div>";
		}else if(type == 'lp'){
			html += "락포인트지갑</div>";
		}
		html += "</div></div>";

//     <!-- Contents Box -->
		html += "<div id='contents-box' class='contents-box container-fluid'></div>";
		
		$(".container-fluid").remove();
		$("body").append(html);
		hideLoader();
		
// 		console.log(html);
		
		
// 		console.log("탑 나가기전");
// 		console.log(data)
// 		console.log("탑 종료");
		
		card.fnGetAjaxContents(data);
	},
	
	fnGetAjaxContents : function(data){
		
		var no = data.no;
		var uNo = data.uNo;
		var type = data.type;
		var listType = data.listType;
		var total = data.total;
		data.page = pagination(data.no, data.total);
		delete data.list;
		
// 		console.log($.extend({"location":"fnGetAjaxContents"}, data));
		
		$.ajax({
			type: "POST",
			url: "/myAssets/getDetailContents",
			data: data,
			dataType: "json",
			beforeSend : function(){
				showLoader();
			}
		}).done(function(data){
			card.fnMakeContents(data);
		});
	},
	
	fnMakeContents : function(data){
// 		console.log($.extend({"location": "fnMakeContents"}, data));
		
		var html = "";
		var array = data.list;
// 		console.log(array);
		
		array.forEach(function(e){
			html += "<div class='detail-info-box'>"
					+ "<div class='row'>"
					+ "<div class='col-3 left-info'>"
						+ "<div class='i-box'>";
						
			/* 스폰 */
			if(data.type == 's'){
				if( Number(e.coin) > 0){
					html += "<i class='fas fa-plus-circle income m-auto'></i></div>";
				}else if( Number(e.coin) < 0){
					html += "<i class='fas fa-minus-circle income m-auto'></i></div>";
				}
				html += "<div class='row'>"
					+ "<i class='far fa-clock t_time m-auto'><span class='bold'>"+e.hms+"</span></i>"
					+ "</div>"
					+ "</div>"
					+ "<div class='col-9 text-right'>"
					+ "<div class='row'>"
					+ "<div class='ml-auto target-date bolder'>"+ ((e.ymd).split("-"))[0] +"년 "
					+ ((e.ymd).split("-"))[1] +"월 "+ ((e.ymd).split("-"))[2] +"일 "+ getWeekday(e.ymd)
					+ "</div>"
					+ "</div>"
					+ "<div class='row text-right'>"
					+ "<div class='col-12 no-double memo'>"+e.memo+"</div>";
				
				if( Number(e.coin) > 0){
					html += "<div class='col-12 no-double target-amount-income bolder'>입금 &nbsp;"+ numberWithCommas(e.coin) +"</div>";
				}else if( Number(e.coin) < 0){
					html += "<div class='col-12 no-double target-amount-withdraw bolder'>출금 &nbsp"+ numberWithCommas(-1*e.coin) +"</div>";
				}
				html += "<div class='ml-auto balance-amount'> 잔액 "+ numberWithCommas(e.aCoin) +"</div>"
					+ "</div></div></div></div>"
			
			/* 포인트 */
			}else if(data.type == 'p'){
				if( Number(e.point) > 0){
					html += "<i class='fas fa-plus-circle income m-auto'></i></div>";
				}else if( Number(e.point) < 0){
					html += "<i class='fas fa-minus-circle income m-auto'></i></div>";
				}
				html += "<div class='row'>"
					+ "<i class='far fa-clock t_time m-auto'><span class='bold'>"+e.hms+"</span></i>"
					+ "</div>"
					+ "</div>"
					+ "<div class='col-9 text-right'>"
					+ "<div class='row'>"
					+ "<div class='ml-auto target-date bolder'>"+ ((e.ymd).split("-"))[0] +"년 "
					+ ((e.ymd).split("-"))[1] +"월 "+ ((e.ymd).split("-"))[2] +"일 "+ getWeekday(e.ymd)
					+ "</div>"
					+ "</div>"
					+ "<div class='row text-right'>"
					+ "<div class='col-12 no-double memo'>"+e.memo+"</div>";
				
				if( Number(e.point) > 0){
					html += "<div class='col-12 no-double target-amount-income bolder'>입금 &nbsp;"+ numberWithCommas(e.point) +"</div>";
				}else if( Number(e.point) < 0){
					html += "<div class='col-12 no-double target-amount-withdraw bolder'>출금 &nbsp"+ numberWithCommas(-1*e.point) +"</div>";
				}
				html += "<div class='ml-auto balance-amount'> 잔액 "+ numberWithCommas(e.aPoint) +"</div>"
					+ "</div></div></div></div>"
					
			/* 락스폰 */
			}else if(data.type == 'ls'){
				if( Number(e.lCoin) > 0){
					html += "<i class='fas fa-plus-circle income m-auto'></i></div>";
				}else if( Number(e.lCoin) < 0){
					html += "<i class='fas fa-minus-circle income m-auto'></i></div>";
				}
				html += "<div class='row'>"
					+ "<i class='far fa-clock t_time m-auto'><span class='bold'>"+e.hms+"</span></i>"
					+ "</div>"
					+ "</div>"
					+ "<div class='col-9 text-right'>"
					+ "<div class='row'>"
					+ "<div class='ml-auto target-date bolder'>"+ ((e.ymd).split("-"))[0] +"년 "
					+ ((e.ymd).split("-"))[1] +"월 "+ ((e.ymd).split("-"))[2] +"일 "+ getWeekday(e.ymd)
					+ "</div>"
					+ "</div>"
					+ "<div class='row text-right'>"
					+ "<div class='col-12 no-double memo'>"+e.memo+"</div>";
				
				if( Number(e.lCoin) > 0){
					html += "<div class='col-12 no-double target-amount-income bolder'>입금 &nbsp;"+ numberWithCommas(e.lCoin) +"</div>";
				}else if( Number(e.lCoin) < 0){
					html += "<div class='col-12 no-double target-amount-withdraw bolder'>출금 &nbsp"+ numberWithCommas(-1*e.lCoin) +"</div>";
				}
				html += "<div class='ml-auto balance-amount'> 잔액 "+ numberWithCommas(e.aLcoin) +"</div>"
					+ "</div></div></div></div>"
			}
			
		})
		
		if(data.no < data.max){
			html += "<div class='more-see'>"
				+ "<div class='m-auto text-center bold'>더보기</div>"
				+ "</div>";
		}else{
			html += "<br><div>"
				+ "<div class='m-auto text-center'> 더이상 내역이 없습니다. </div>"
				+ "</div><br>";
		}
		
		$(".more-see").remove();
		
		$("#contents-box").append(html);
		hideLoader();
	}
}
	
	
</script>
</body>
</html>