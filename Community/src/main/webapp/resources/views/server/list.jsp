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
	<title>광고 관리</title>
	
	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style type="text/css">
		font-family: 'Nanum Gothic', sans-serif;
		body { width: 100%; height: 100%; padding: 0;}
		.container { min-width: 400px; max-width: 1700px; padding: 1em;}
		.fixed_box_1 { position: fixed; width: 50px; font-size: 5em; margin: 0.3em auto; top: 80vh; left: 93%;}
		.first_box { -webkit-transition: width 1s, height 1s, background-color 1s, -webkit-transform 1s;
			transition: width 1s, height 1s, background-color 1s, transform 1s;}
		.first_box:hover { cursor: pointer; -webkit-transform: rotate(180deg); transform: rotate(180deg);}
		.cover_1 { position: fixed; width: 100%; height: 100vh; top: 0; left: 0; background-color: #333; opacity: 0.3; display: none; z-index: 10001; padding: 0; margin: 0;}
		.input_row { width: 100%; margin: 0.4em auto; height: 5em;}
		.input-group, .input-group-prepend, .input-group-text { height: 4em!important; }
		.input-group-prepend > span { width: 70px!important;}
		input.form-control { height: 1.25em!important; padding: 1em 0.5em!important; line-height: 4em!important; font-size: 2.4em!important;}
		.input_box { position: fixed; bottom: 5vh; right: 0; width: 800px; background-color: white; border: 1px solid #eee; padding: 2em; display: none; z-index: 10002; border-radius: 10px;}
		.input_row > button { width: calc(33.3333% - 12px); font-size: 2em; border: 1px solid #ccc; border-radius: 10%!important; margin: 0 5px;}
		.in_btn_box { width: 30%; height: 4em!important; text-align: right; float: right; margin-right: -7px!important;}
		.submit_pw_check {width: 100%; font-size: 1.7em;}
	</style>

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<c:if test="${sessionScope.member._class eq 3}">
	<br><br>
	<div class="container">
		
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col" class="align-center" style="width: 5%;">No</th>
					<th scope="col" class="align-center" style="width: 20%; min-width: 100px;">아이피</th>
					<th scope="col" class="align-center" style="width: 8%;">포트</th>
					<th scope="col" class="align-center" style="width: 10%;">위치</th>
					<th scope="col" class="align-center" style="width: 10%;">아이디</th>
					<th scope="col" class="align-center" style="width: 30%; min-width: 150px;">비고</th>
					<th scope="col" class="align-center" style="width: 7%;">결제일</th>
					<th scope="col" class="align-center" style="width: 10%; min-width: 120px;"></th>
				</tr>
			</thead>
			<tbody>
			</tbody>
		</table>
		<div id="result" style="text-align: center;"></div>
		<div id="paging_box" style="text-align: center;">
		</div>
		
		<div class="fixed_box_1 first_box">
			<i class="fas fa-plus-circle"></i>
		</div>
	</div>
	
	<!-- ============================================= -->
	<!-- ================= 글쓰기 모드 화면 =============== -->
	<!-- ============================================= -->
	<form>
	<div class="cover_1"></div>
	<div class="input_box">
		<div class="row input_row">
			<h1>서버 추가</h1>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_server_ip">아이피</span>
				</div>
				<input id="in_server_ip" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_server_ip">
			</div>
		</div>
		<div class="row input_row">
			<div class="col-6 input-group input-group-lg" style="padding-right: 5px">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_server_port">포트</span>
				</div>
				<input id="in_server_port" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_server_port">
			</div>
			<div class="col-6 input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_server_location">위치</span>
				</div>
				<input id="in_server_location" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_server_location">
			</div>
		</div>
		<div class="row input_row" >
			<div class="col-6 input-group input-group-lg" style="padding-right: 5px;">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_login_id">아이디</span>
				</div>
				<input id="in_login_id" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_login_id">
			</div>
			<div class="col-6 input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_sub_payment">결제일</span>
				</div>
				<input id="in_payment" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_sub_payment">
			</div>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_note">비고</span>
				</div>
				<input id="in_note" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_note">
			</div>
		</div>
		<div class="row input_row in_btn_box">
			<button type="button" class="in_submit_btn btn btn-primary">등록</button>
			<button type="reset" class="in_reset_btn btn btn-light">리셋</button>
			<button type="button" class="in_cancle_btn btn btn-danger">취소</button>
		</div>
	</div>
	</form>
	
</c:if>
<c:if test="${sessionScope.member._class ne 3}">
	<div class="container">
		<h1>경고! 비정상적인 접근입니다.</h1>
	</div>
</c:if>

		<script id="scriptSrc" type="text/javascript">

$(document).ready(function(){
	
	$(document).on('click', 'a[href="#"]', function(e){
		e.preventDefault();
	});
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function inInputBox(){
		$(".first_box").fadeOut("fast", function(){
			$(".cover_1").fadeIn("fast", function(){
				$(".input_box").fadeIn("fast");
				$("#in_company_name").focus();
			});
		});
	}
	
	function outInputBox(){
		$("#in_server_ip").val("");
		$("#in_server_port").val("");
		$("#in_server_location").val("");
		$("#in_login_id").val("");
		$("#in_note").val("");
		$("#in_note").val("");
		$("#in_sub_payment").val("");
		$(".cover_1").fadeOut("fast", function(){
			$(".input_box").fadeOut("fast", function(){
				$(".first_box").fadeIn("fast");
			});
		});
	}
	
	// 유효성 검사 //
	function validCheck(data){
		var flag = true;
		var formData = data;
		
		var ip = formData.ip;
		var port = formData.port;
		var location = formData.location;
		var loginId = formData.loginId;
		var note = formData.note;
		var payment = formData.payment;
		
		var empty_space = /\s/gi;
		
		if( ip.match(empty_space) || port.match(empty_space) || location.match(empty_space) || loginId.match(empty_space) || payment.match(empty_space) ){
			alert("공백은 포함될 수 없습니다.");
			flag = false;
		}
		
		if( ip == "" || ip.trim().length == 0 ){
			alert("아이피는 필수값입니다.");
			$("#in_server_ip").focus();
			flag = false;
		}
		if( port == "" || port.trim().length == 0 ){
			alert("포트는 필수값입니다.");
			$("#in_server_port").focus();
			flag = false;
		}
		if( location == "" || location.trim().length == 0 ){
			alert("위치는 필수값입니다.");
			$("#in_server_location").focus();
			flag = false;
		}
		if( loginId == "" || loginId.trim().length == 0 ){
			alert("아이디는 필수값입니다.");
			$("#in_login_id").focus();
			flag = false;
		}
		if( note == "" || note.trim().length == 0 ){
			alert("비고는 필수값입니다.");
			$("#in_note").focus();
			flag = false;
		}
		if( payment == "" || payment.trim().length == 0 ){
			alert("결제일은 필수값입니다.");
			$("#in_payment").focus();
			flag = false;
		}
		return flag;
	}
	
	function getAjaxList(){
		$.ajax({
			url: "/server/get/a",
			type: "POST"
		}).done(function(data){
			makeHTML(data);
		}).fail(function(){
			alert("데이터를 불러오는데 실패했습니다.");
			return false;
		});
	}
	
	function addAjaxServer(formData){
		$.ajax({
			url: "/server/add",
			type: "POST",
			data: formData
		}).done(function(data){
			if(data.check == "success"){
				alert("등록되었습니다.");
				outInputBox();
				getAjaxList();
			}else{
				alert("등록에 실패하였습니다.");
			}
		}).fail(function(){
			alert("서버에러 - 등록에 실패하였습니다.")
		});
	}
	
	function updateAjaxServer(formData){
		$.ajax({
			url: "/server/u",
			type: "POST",
			data: formData
		}).done(function(d){
			if(d.result == "success"){
				alert("변경 되었습니다.");
				getAjaxList();
			}else if(d.result == "false"){
				alert("업데이트에 실패하였습니다.")
				getAjaxList();
			}
		});
	}
	
	
	
	///////////////
	// make HTML //
	///////////////
	function makeHTML(data){
		
		var list = data.list;
		
		$("tbody > tr").remove();
		$("#result > h3").remove();
		var html = "";
		if(list.length == 0){
			html = "<h3>데이터가 없습니다.</h3>";
			$("#result").append(html);
		}else{
			for(var i = 0; i < list.length; i++){
				
				console.log(list[i]);
				
				html += "<tr style='height: 2em; font-size: 1.2em; padding: 0.5em;' >"
					 + "<th scope='row' class='align-center'>"+ (i + 1) +"</th>"
					 + "<input class='uniqueID' type='hidden' value='"+list[i].no+"'></input>"
					 + "<td class='align-center td_ip'>"+list[i].ip+"</td>"
					 + "<td class='align-center td_port'>"+list[i].port+"</td>"
					 + "<td class='align-center td_location'>"+list[i].location+"</td>"
					 + "<td class='align-center td_login_id'>"+list[i].login_id+"</td>"
					 + "<td class='align-center td_note'>"+list[i].note+"</td>"
					 + "<td class='align-center td_payment'>"+list[i].payment+"</td>"
					 + "<td class='align-center td_btn_box' style='padding: 0.2em 0.1em 0.2em 0.1em;'>"
					 + "<button class='btn btn-outline-success modify_btn' style='font-size: 1em; margin-right: 0.1em;'>수정</button>"
					 + "<button class='btn btn-outline-danger modify_delete_btn' style='font-size: 1em;margin-left: 0.1em;'>삭제</button>"
					 + "</td></tr>";
			}
			$("tbody").append(html);
			$(".align-center").css("text-align", "center");
			$("td > a").css("text-decoration", "none");
			$(function () {
				  $('[data-toggle="tooltip"]').tooltip();
			});
		}
	}
	
	$(document).on("click", ".first_box", function(){ inInputBox(); });
	$(document).on("click", ".cover_1", function(){ outInputBox(); });
	$(document).on("click", ".in_cancle_btn", function(){ outInputBox(); });
	
	// 취소 버튼 //
	$(document).on("click", ".modify_cancle_btn", function(){
		getAjaxList();
	});
	
	// 수정 버튼 //
	$(document).on("click", ".modify_btn", function(){
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		var ip = thisElement.find(".td_ip");
		var port = thisElement.find(".td_port");
		var location = thisElement.find(".td_location");
		var loginId = thisElement.find(".td_login_id");
		var note = thisElement.find(".td_note");
		var payment = thisElement.find(".td_payment");
		var btnBox = thisElement.find(".td_btn_box");
		
		var text = "<button id='update_complete_btn' class='btn btn-success' style='font-size: 1em; margin-right: 0.1em;'>적용</button>"
				 + "<button class='btn btn-danger modify_cancle_btn' style='font-size: 1em;margin-left: 0.1em;'>취소</button>";
		ip.html("<input id='modi_ip' value='"+ip.text()+"'></input>");
		port.html("<input id='modi_port' value='"+port.text()+"'></input>").css("padding", "8px");
		location.html("<input id='modi_location' value='"+location.text()+"'></input>").css("padding", "8px");
		loginId.html("<input id='modi_id' value='"+loginId.text()+"'></input>");
		note.html("<input id='modi_note' value='"+note.text()+"'></input>");
		payment.html("<input id='modi_payment' value='"+payment.text()+"'></input>");
		btnBox.css("padding-top", "6.25px").css("padding-bottom", "6.25px");
		btnBox.html(text);
		$("#modi_ip").focus();
	});
	
	// 업데이트 적용 //
	$(document).on("click", "#update_complete_btn", function(){
		var isRun = false;
		isRun = true;
		
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		data = {};
		data.no = no;
		data.ip = $("#modi_ip").val().trim();
		data.port = $("#modi_port").val().trim();
		data.location = $("#modi_location").val().trim();
		data.loginId = $("#modi_id").val().trim();
		data.note = $("#modi_note").val().trim();
		data.modifier = "${sessionScope.member.tradeMark}";
		data.payment = $("#modi_payment").val().trim();
		
		if(isRun){
			if(validCheck(data)){
				updateAjaxServer(data);
			}else{
				return false;
			};
		}else{
			alert("천천히 한번만 시도해주세요.");
		};
	});
	// end of update //
	
	// 삭제 버튼 //
	$(document).on("click", ".modify_delete_btn", function(){
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		
		var isRun = false;
		isRun = true;
		
		if(isRun){
			$.ajax({
				url: "/server/d",
				type: "POST",
				data: {"no": no}
			}).done(function(d){
				
				console.log(d.result);
				
				if(d.result == "success"){
					alert("삭제되었습니다.");
				}else{
					alert("삭제할 수 없습니다.");
				}
				getAjaxList();
			});	
		}else{
			alert("천천히 한번만 시도해주세요.");
		}
	});
	
	// 글쓰기  //
	$(document).on("click", ".in_submit_btn", function(){
		var isRun = false;
		isRun = true;
		
		var formData = {};
		formData.ip = $("#in_server_ip").val();
		formData.port = $("#in_server_port").val();
		formData.location = $("#in_server_location").val();
		formData.loginId = $("#in_login_id").val();
		formData.note = $("#in_note").val().trim();
		formData.payment = $("#in_payment").val().trim();
		formData.writer = "${sessionScope.member.tradeMark}";
		
		if(isRun){
			if(validCheck(formData)){
				addAjaxServer(formData);
			}else{
				return false;
			}
		}else{
			alert("천천히 한번만 시도해주세요.");
		}
		
	});
/////////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////
	// esc key event //
	///////////////////
	$(document).on("keydown", "body", function(){
		if( $(".cover_1").css("display") == "block" ){
			if( event.keyCode == 27 ){
				outInputBox();
			}
		}
	});
	//////////////////
	// 시작 리스트 받아오기
	//////////////////
	getAjaxList();
});

		</script>
	</body>
</html>