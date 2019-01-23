<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
	<head>
		<title> WORLDSPON P2P Exchange records </title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,
        maximum-scale=1, user-scalable=no">
	    <meta name="description" content="Free Reward App, Free Android App" />
	    <meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	    <meta name="author" content="WorldSpon, Inc." />
	
	    <link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	    <link rel="icon" href="../info/img/favicon/ws_p16.png" sizes="16x16">
	    <link rel="icon" href="../info/img/favicon/ws_p32.png" sizes="32x32">
	    
	    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
	    <link rel="stylesheet" href="../myAssets/css/bootstrap.min.css">
	    <link rel="stylesheet" href="../myAssets/css/loader.css">
		<style>
			body {
				min-width: 450px;
			}
			.btn-purple:hover, .btn-gold:hover, .btn-secondary:hover {
				cursor: default!important;
			}
            .btn-purple {
                color: white;
                background-color: mediumpurple;
            }
            .btn-gold {
                color: white;
                background-color: goldenrod;
            }
            .scl {
                margin-top: 0;
            }
            
		</style>
	</head>
	<body>

<div id="data-set"></div>
<div class="lds-back"></div>
<div class="lds-ring"><div></div><div></div><div></div><div></div></div>
<div class="container col-xl-10 col-lg-12 mx-auto">
	<div class="header-con"></div>
	<table class="table table-hover">
		<thead>
			<tr>
				<th scope="col">순서</th>
				<th scope="col">거래고유번호</th>
				<th scope="col"><a href="#">신청일시 △</a></th>
				<th scope="col">보내는 사람</th>
				<th scope="col">보내는 품목 / 수량</th>
				<th scope="col">받는 사람</th>
				<th scope="col">받는 품목 / 수량</th>
				<th scope="col">단계</th>
				<th scope="col">승인한 사람</th>
				<th scope="col">상태</th>
			</tr>
		</thead>
		<tbody id="tbody">

		</tbody>
	</table>
</div>
	<!--

	<tbody>
			<tr>
				<th scope="row">1</th>
				<td>#3001</td>
				<td>2019-01-18 12:00:00</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-purple">스폰</button><b>20,000개</b></td>
				<td>test02</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button><b>3,000,000,000</b>원</td>
				 state 0 : 1딘계 / 1 : 2단계 / 4 : 1단계 / 14 : 2단계 
				<td><b>2</b> 단계</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-danger">분쟁</button></td>
			</tr>
			<tr>
				<th scope="row">2</th>
				<td>#3002</td>
				<td>2019-01-16 15:00:00</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-secondary">락스폰</button> / <b>20,000개</b></td>
				<td>test02</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b>3,000,000,000</b>원</td>
				 state 0 : 1딘계 / 1 : 2단계 / 4 : 1단계 / 14 : 2단계 
				<td><b>2</b> 단계</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-danger">분쟁</button></td>
			</tr>
			<tr>
				<th scope="row">3</th>
				<td>#3003</td>
				<td>2019-01-16 15:00:00</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-purple">스폰</button> / <b>20,000개</b></td>
				<td>test02</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b>3,000,000,000</b>원</td>
				 state 0 : 1딘계 / 1 : 2단계 / 4 : 1단계 / 14 : 2단계 
				<td><b>1</b> 단계</td>
				<td>test02</td>
				 state 0 1단계 진행중 
				<td>진행중...</td>
			</tr>
			<tr>
				<th scope="row">4</th>
				<td>#3004</td>
				<td>2019-01-16 15:00:00</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-purple">스폰</button> / <b>20,000개</b></td>
				<td>test02</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b>3,000,000,000</b>원</td>
				 state 0 : 1딘계 / 1 : 2단계 / 4 : 1단계 / 14 : 2단계 
				<td><b>2</b> 단계</td>
				<td>개발이</td>
				 state 1 2단계 진행중 
				<td>진행중...</td>
			</tr>
			<tr>
				<th scope="row">5</th>
				<td>#3005</td>
				<td>2019-01-16 15:00:00</td>
				<td>개발이</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b>3,000,000,000</b>원</td>
				<td>test02</td>
				<td class="pt-1 pb-1"><button type="button" class="btn btn-purple">스폰</button> / <b>20,000개</b></td>
				<td><b>1</b> 단계</td>
				<td>개발이</td>
				 state 4 1단계 거절 
				<td>취소중...</td>
			</tr>
		</tbody>
	페이지네이션
	<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<li class="page-item disabled">
					<a class="page-link" href="#" tabindex="-1" aria-disabled="true">Previous</a>
				</li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item">
					<a class="page-link" href="#">Next</a>
				</li>
		</ul>
	</nav>-->
	
<!-- jQuery -->
<script src="/myAssets/js/jquery.min.js"></script>
<script src="/myAssets/js/popper.js"></script>
<!-- Bootstrap -->
<script src="/myAssets/js/bootstrap.js"></script>
<!-- Main -->
<script src="/myAssets/js/main.js"></script>
<script type="text/javascript">
showLoader();
$(function(){
	var config = {
		listType: "all",
		pageNo: "1",
		oderby: "asc"
	}
	init(config);


	
});
// 전체 리스트 클릭
$(document).on("click", "#listAll", function(){
		var config = {listType: "all", pageNo: "1", orderBy: "asc"}
		console.log("전체 리스트 클릭");
		card.fnInit(config);
	});

// 분쟁 리스트 클릭
$(document).on("click", "#listDiff", function(){
	var config = {listType: "diff",	pageNo: "1", orderBy: "asc"}
	console.log("분쟁 리스트 클릭");
	card.fnInit(config);
});

//분쟁 해결 버튼 클릭
$(document).on("click", ".btn-diff", function(){
	// var uno = $(this).parent().parent().find("td")[0].text();
	var uno = $(this).parent().parent().find("td")[0];
	// console.log(uno.innerText.trim());
	var uid = uno.innerText.trim().substring(1);
	console.log(uid);
	var data = {"uid": uid};
	
	var boolean = false;
	boolean = confirm("처리하시겠습니까?");

	if(boolean){
		alert("승인");
		card.fnCommServer(data);
	}
});

//초기 로드 함수
function init(config){
	card.fnInit(config);
}

var card = {
	//Init
	fnInit : function(config){
		console.log(config);
		$.ajax({
			type: "POST",
			url: "/p2p/init",
			data: config,
			dataType: "json",
			beforeSend: ()=>{
				showLoader();
			}
		}).done(data => {
			makeHTML.fnCreateHeader(data.config);
			makeHTML.fnInit(data.data);
		});
	},

	fnCommServer : function(data){
		$.ajax({
			type: "POST",
			url: "/p2p/clear",
			data: data,
			dataType: "json",
			beforeSend: ()=>{
				showLoader();
			}
		}).done(data => {
			console.log(data);
		});
	}
}

var makeHTML = {
	fnInit : function (data){
		$("#tbody").remove();
		console.log(typeof data);
		var listData = JSON.parse(data);
		var i = 0;
		var html = '<tbody id="tbody">';
		listData.forEach( o => {
			console.log(++i);
			console.log(o);
			html += '<tr><th scope="row">'+i+'</th>'
				+ '<td>#'+o.no+'</td>'
				+ '<td>'+o.dt+'</td>'
				+ '<td>'+o.reqUserNick+'</td>';
			if(o.type == 1){
				html += '<td class="pt-1 pb-1">';
				if(o.cAmount > 0){
					html += '<button type="button" class="btn btn-purple"> / <b> '
						+ numberWithCommas(o.cAmount)+'개</b></td>';
				}else{
					html += '<button type="button" class="btn btn-secondary">락스폰</button> / <b>'
						+ numberWithCommas(o.lcAmount)+'개</b></td>';
				}
			}else if(o.type == 0){
				html += '<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b> '
					+numberWithCommas(o.pAmount)+'원</b></td>';
			}

			html += '<td>'+o.resUserNick+'</td>';
			if(o.type == 1){
				html += '<td class="pt-1 pb-1"><button type="button" class="btn btn-gold">포인트</button> / <b> '
					+ numberWithCommas(o.pAmount)+'원</b></td>';
			}else if(o.type == 0){
				html += '<td class="pt-1 pb-1">';
				if(o.cAmount > 0){
					html += '<button type="button" class="btn btn-purple"> / <b> '
						+ numberWithCommas(o.cAmount)+'개</b></td>';
				}else{
					html += '<button type="button" class="btn btn-secondary">락스폰</button> / <b>'
						+ numberWithCommas(o.lcAmount)+'개</b></td>';
				}
			}
			if(o.level == 0 || o.level == 4){
				html += '<td><b> 1 </b></td>';
			}else if(o.level == 1 || o.level == 14){
				html += '<td><b> 2 </b></td>';
			}

			if(o.reqState == 0 && o.resState == 0){
				html += '<td> - </td>';
			}else if(o.reqState == 0 && o.resState == 2){
				html += '<td> - </td>';
			}else if(o.reqState == 2 && o.resState == 0){
				html += '<td> - </td>';
			}else if(o.reqState == 1 && o.resState == 0){
				html += '<td>'+o.reqUserNick+'</td>';
			}else if(o.reqState == 0 && o.resState == 1){
				html += '<td>'+o.resUserNick+'</td>';
			}

			if(o.level == 0){
				html += '<td> 진행중.. </td>';
			}else if(o.level == 1){
				html += '<td> 진행중.. </td>';
			}else if(o.level == 4){
				html += '<td> 취소중.. </td>';
			}else if(o.level == 14){
				html += '<td class="pt-1 pb-1"><button type="button" class="btn btn-diff btn-danger">분쟁</button></td>';
			}
			
		});
		console.log(html);

		$("table").append(html);
		hideLoader();
	},
	
	fnCreateHeader : function(param){
		var data = JSON.parse(param);
		$("#header").remove();
		var html = "<div id='header'><br><br>"
		 + "<div class='row'><div class='col-auto mr-auto btn-group' role='group' aria-label='Basic example'>";
		if(data.listType.trim() === "all"){
			html += "<button id='listAll' type='button' class='btn btn-primary'>전체보기</button>"
				+ "<button id='listDiff' type='button' class='btn btn-outline-danger'>분쟁상태</button>";
		}else if(data.listType.trim() === "diff"){
			html += "<button id='listAll' type='button' class='btn btn-outline-primary'>전체보기</button>"
				+ "<button id='listDiff' type='button' class='btn btn-danger'>분쟁상태</button>";
		}else{
			alert("페이지 오류! 관리자에 문의하세요.");
		}
		html += "</div><div class='col-auto p-1'><a href='javascript:history.go(-1)'> 뒤로 </a></div></div><br><br></div>";

		console.log(html);
		$(".header-con").append(html);
	}
}
</script>
	</body>
</html>