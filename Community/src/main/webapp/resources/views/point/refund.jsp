<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html id="up">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>포인트 환급 신청</title>
	
	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style type="text/css">
		font-family: 'Nanum Gothic', sans-serif;
		.main_con { width: 100%; margin: 0; padding: 0;}
		.info_box { min-width: 520px; max-width: 520px; height: 70px; margin: 0 auto; border: 1px solid #ccc; padding: 10px; text-align: center;}
		p {text-align: center; font-size: 1.2em; height: 19px; margin: 3px; padding: 0;}
		.btn_con { width: 100%; margin: 0 auto; text-align: center;}	
		.btn_box { width: 40%; margin: 0 auto;}
		#datatable { margin: 0 auto;}
		button { width: calc(50% - 60px); min-width: 60px; margin: 0 30px;}
		h4 {text-align: center; color: red;}
		h5 {text-align: center;}
		.chart_con {width: 100%; min-width: 520px; margin: 0 auto;}
		.container { max-width: 1400px; min-width: 1200px; margin: 5vh auto;}
		.btn_con {text-align: center; margin-bottom: 5vh;}
		.btn_con button {height: 50px; font-size: 2em;}
	</style>

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/highcharts/highcharts.js"></script>
<script src="/resources/js/highcharts/data.js"></script>
<script src="/resources/js/highcharts/exporting.js"></script>
<script src="/resources/js/highcharts/export-data.js"></script>
<script src="/resources/js/jquery.countdown.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
	
	<div class="container">
		
		<div class="row btn_con">
			<div class="col-md-4">
				<button class="btn btn-outline-info" id="ready_list">신청 내역</button>
			</div>
			<div class="col-md-4">
				<button class="btn btn-outline-info" id="accept_list">승인 내역</button>
			</div>
			<div class="col-md-4">
				<button class="btn btn-outline-info" id="cancle_list">취소 내역</button>
			</div>
		</div>
		
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col">No</th>
					<th scope="col" style="display: none;">uniqueID</th>
					<th scope="col" class="align-center">일시</th>
					<th scope="col" style="display: none">유저번호</th>
					<th scope="col">아이디</th>
					<th scope="col">전화번호</th>
					<th scope="col">포인트</th>
					<th scope="col" class="align-center">은행</th>
					<th scope="col">예금주</th>
					<th scope="col" class="align-center">상태</th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		
		
	</div>

		<script type="text/javascript">

$(document).ready(function(){
	
	$(document).on('click', 'a[href="#"]', function(e){
		e.preventDefault();
	});
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	var data = '${data}';
	var result = JSON.parse(data);
	var list = result.list;
	
	function getAjaxData(param){
		
		$.ajax({
			url: "/point/getAjax",
			type: "POST",
			data: param
		}).done(function(returnMap){
			if(returnMap.state == 0){
				makeHTML(returnMap.list);
			}else if(returnMap.state == 1){
				makeHTML(returnMap.list);
			}else if(returnMap.state == 2){
				makeHTML(returnMap.list);
			}else{
				alert("잘못된 값입니다. 관리자에게 문의해주세요.");
				return false;
			}
		});
	}
	
	// 신청 내역
	function makeReadyList(list){
		
		var param = {};
		param.type = 'ready';
		getAjaxData(param);
		
	}
	
	// 승인 내역
	function makeAcceptList(){
		
		var param = {};
		param['type'] = 'accept';
		getAjaxData(param);		
	}
	
	// 취소 내역
	function makeCancleList(){
		var param = {};
		param['type'] = 'cancle';
		getAjaxData(param);

	}
	
	// make HTML
	function makeHTML(list){
		
		$("tbody > tr").remove();
		$("body > #result").remove();
		var html = "";
		
		console.log(list);
		
		if(list.length == 0){
			html = "<div id='result' style='text-align: center;'>"
				 + "<h3>데이터가 없습니다.</h3></div>";
			$("body").append(html);
		}else{
			for(var i = 0; i < list.length; i++){
				html += "<tr>"
					 + "<th scope='row'>"+Number(i+1)+"</th>"
					 + "<td id='uniqueID' style='display: none;'>"+list[i]._UniqueID+"</td>"
					 + "<td>"+list[i]._DateTime+"</td>"
					 + "<td style='display: none;' id='userNo'>"+list[i]._UserUniqueID+"</td>"
					 + "<td id='nickName'><b>"+list[i]._Trademark+"</b></td>";
				if(list[i]._PHONE == null || list[i]._PHONE == ''){
					html += "<td>번호없음</td>"
				}else{
					html += "<td id='phoneNo'>"+list[i]._PHONE+"</td>"
				}
					 html += "<td id='point'>"+numberWithCommas(list[i]._Point)+"</td>"
					 + "<td id='bankInfo' class='align-center'>"+list[i]._BankNum+"</td>";
				if(list[i]._State == 0){
					 html += "<td id='userName'>"+list[i]._BankUser+"</td>"
						 + "<td><button class='btn btn-primary btn_confirm'>승인</button>"
						 + "<button class='btn btn-danger btn_refuse'>거절</button></td>"; 
				}else if(list[i]._State == 1){
					 html += "<td>"+list[i]._BankUser+"</td>";
					 if(list[i]._ResultTime == '' || list[i]._ResultTime == null){
						html += "<td><a href='#' title='정보없음'>환급완료</a></td>";
					 }else{
						html += "<td><a href='#' title='"+list[i]._ResultTime+"'>환급완료</a></td>";
					 }
				}else if(list[i]._State == 2){
					 html += "<td>"+list[i]._BankUser+"</td>";
					 if(list[i]._resultTime == '' || list[i]._resultTime == null){
						html += "<td><a href='#' title='정보없음'>취소완료</a></td>";
					 }else{
						html += "<td><a href='#' title='"+list[i]._resultTime+"'>취소완료</a></td>";
					 }
				}
			}
			$("tbody").append(html);
			$("th").css("text-align", "right");
			$("td").css("text-align", "right");
			$(".align-center").css("text-align", "center");
			$("td > a").css("text-decoration", "none");
			
			$(".btn_confirm").on("click", function(){
				
				var thisElement = $(this).parent().parent();
				var phoneNo = thisElement.find("#phoneNo").text();
				var userNo = thisElement.find("#userNo").text();
				var nickName = thisElement.find("#nickName").text();
				var point = thisElement.find("#point").text();
				var bankInfo = thisElement.find("#bankInfo").text();
				var userName = thisElement.find("#userName").text();
				var uniqueID = thisElement.find("#uniqueID").text();
				
				var check = confirm("["+userName+"]님에게 ["+bankInfo+"] 으로 ["+point+"]원을 환급 하시겠습니까?");
				if(check){
					
					var data = {};
					data.type = 'accept';
					data.userNo = userNo;
					data.uniqueID = uniqueID;
					
					$.ajax({
						url: "/point/update",
						type: "POST",
						data: data
					}).done(function(rv){
						alert("환급에 성공하였습니다.");
						makeReadyList(list);
					}).fail(function(){
						alert("환급 실패! 관리자에게 문의해 주세요.");
					});
				}else{
					alert("취소되었습니다.");
				}
			});
			
			$(".btn_refuse").on("click", function(){
				
				var thisElement = $(this).parent().parent();
				var phoneNo = thisElement.find("#phoneNo").text();
				var userNo = thisElement.find("#userNo").text();
				var nickName = thisElement.find("#nickName").text();
				var point = thisElement.find("#point").text();
				var bankInfo = thisElement.find("#bankInfo").text();
				var userName = thisElement.find("#userName").text();
				var uniqueID = thisElement.find("#uniqueID").text();
				
				var check = confirm("거절 하시겠습니까?");
				if(check){
					
					var data = {};
					data.type = 'refuse';
					data.userNo = userNo;
					data.uniqueID = uniqueID;
					
					$.ajax({
						url: "/point/update",
						type: "POST",
						data: data
					}).done(function(rv){
						alert("거절에 성공하였습니다.");
						makeReadyList(list);
					}).fail(function(){
						alert("거절 실패! 관리자에게 문의해 주세요.");
					});
				}else{
					alert("취소되었습니다.");
				}
			});
		}
	}
	
	$("#ready_list").on("click", function(){
		makeReadyList(list);
	});
	
	$("#accept_list").on("click", function(){
		makeAcceptList(list);	
	});
	
	$("#cancle_list").on("click", function(){
		makeCancleList(list);	
	});
	makeReadyList(list);
	
});

		</script>
	</body>
</html>