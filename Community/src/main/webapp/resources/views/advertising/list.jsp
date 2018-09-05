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
		input.form-control { height: 1.25em!important; padding: 1em 0.5em!important; line-height: 4em!important; font-size: 2.4em!important;}
		.input_box { position: fixed; bottom: 5vh; right: 0; width: 800px; background-color: white; border: 1px solid #eee; padding: 2em; display: none; z-index: 10002; border-radius: 10px;}
		.input_box_2 {position: fixed; top: 20%; transform: translateX(-50%); left: 50%;  width: 200px; background-color: white; border: 1px solid #eee; padding: 2em; display: none; z-index: 10002; border-radius: 10px;}
		.input_row > button { width: calc(33.3333% - 12px); font-size: 2em; border: 1px solid #ccc; border-radius: 10%!important; margin: 0 5px;}
		.in_btn_box { width: 30%; height: 4em!important; text-align: right; float: right; margin-right: -7px!important;}
		#pw_check_btn {width: 100%;}
	</style>

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<%-- <c:if test="${sessionScope.member._class eq 3}"> --%>
	<br><br>
	<div class="container">
		
		<table class="table table-striped table-hover">
			<thead>
				<tr>
					<th scope="col" class="align-center" style="width: 3%;">No</th>
					<th scope="col" class="align-center" style="width: 17%; min-width: 100px;">회사명</th>
					<th scope="col" class="align-center" style="width: 10%;">URL</th>
					<th scope="col" class="align-center" style="width: 10%;">아이디</th>
					<th scope="col" class="align-center" style="width: 10%;">비밀번호</th>
					<th scope="col" class="align-center" style="width: 15%; min-width: 140px;">삽입 위치</th>
					<th scope="col" class="align-center" style="width: 25%; min-width: 100px;">비고</th>
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
			<h1>광고 공급자 추가</h1>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_company_name">회사명</span>
				</div>
				<input id="in_company_name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_company_name">
			</div>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_company_url">URL</span>
				</div>
				<input id="in_company_url" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_company_url">
			</div>
		</div>
		<div class="row input_row">
			<div class="col-6 input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_login_id">아이디</span>
				</div>
				<input id="in_login_id" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_login_id">
			</div>
			<div class="col-6 input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_login_pw">비밀번호</span>
				</div>
				<input id="in_login_pw" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_login_pw">
			</div>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_part_name">위치</span>
				</div>
				<input id="in_part_name" type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_part_name">
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
			<button id="in_submit_btn" type="button" class="btn btn-primary">등록</button>
			<button id="in_reset_btn" type="reset" class="btn btn-light">리셋</button>
			<button id="in_cancle_btn" type="button" class="btn btn-danger">취소</button>
		</div>
	</div>
	</form>
	<div class="input_box_2">
		<div class="row input_row">
			<h1>비밀번호 확인</h1>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_pw_check">비밀번호</span>
				</div>
				<input id="in_pw_check" type="password" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup_in_pw_check">
			</div>
		</div>
		<button id="submit_pw_check" type="button" class="btn btn-primary">확인</button>
	</div>
<%-- </c:if> --%>
<%-- <c:if test="${sessionScope.member._class ne 3}"> --%>
<!-- 	<div class="container"> -->
<!-- 		<h1>경고! 비정상적인 접근입니다.</h1> -->
<!-- 	</div> -->
<%-- </c:if> --%>

		<script type="text/javascript">

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
			});
		});
	}
	
	function outInputBox(){
		$(".cover_1").fadeOut("fast", function(){
			$(".input_box").fadeOut("fast", function(){
				$(".first_box").fadeIn("fast");
			});
		});
	}
	
	function getAjaxList(){
		$.ajax({
			url: "/ap/get/a",
			type: "POST"
		}).done(function(data){
			var value = data.list;
			var list = JSON.parse(value);
			return value;
		}).fail(function(){
			return "no-data";
		});
	}
	
	function addAjaxAp(formData){
		$.ajax({
			url: "/ap/add",
			type: "POST",
			data: formData
		}).done(function(data){
			if(data.check == "success"){
				alert("등록되었습니다.");
				outInputBox();
				$.ajax({
					url: "/ap/get/a",
					type: "POST"
				}).done(function(data){
					var value = data.list;
					var list = JSON.parse(value);
					makeHTML(list);
				}).fail(function(){
					alert("데이터를 받아올 수 없습니다.");
				});
			}else{
				alert("등록에 실패하였습니다.");
			}
		}).fail(function(){
			alert("서버에러 - 등록에 실패하였습니다.")
		});
	}
	
	var data = '${list}';
	var list = JSON.parse(data);
	
	for(var i = 0; i < list.length; i++){
// 		console.log(list[i]);
	}
	
	$(".first_box").on("click", function(){ inInputBox(); });
	$(".cover_1").on("click", function(){ outInputBox(); });
	$("#in_cancle_btn").on("click", function(){ outInputBox(); });
	
	// make HTML
	function makeHTML(list){
		
		$("tbody > tr").remove();
		$("#result > h3").remove();
		var html = "";
		if(list.length == 0){
			html = "<h3>데이터가 없습니다.</h3>";
			$("#result").append(html);
		}else{
			for(var i = 0; i < list.length; i++){
				
				var addr = list[i].site_address;
				html += "<tr style='height: 2em; font-size: 1.2em; padding: 0.5em;' >"
					 + "<th scope='row' id='uniqueID' class='align-center'>"+list[i].no+"</th>"
					 + "<td class='align-center'>"+list[i].company_name+"</td>"
					 + "<td class='align-center' style='padding: 0.2em;'><a class='btn btn-primary' href='http://"+addr+"' target='_blank' style='font-size: 1em;'"
					 + " data-toggle='tooltip' data-html='true' title='<p style=\"font-size: 2em;\">"+addr+"'>이동</a></td>"
					 + "<td class='align-center'>"+list[i].login_id+"</td>"
					 + "<td class='align-center' style='padding: 0.2em;'><button id='btn_pw_check' class='btn btn-outline-primary' style='font-size: 1em;'>확인하기</button></td>"
					 + "<td class='align-center'>"+list[i].part_name+"</td>"
					 + "<td class='align-center'>"+list[i].note+"</td>"
					 + "<td class='align-center' style='padding: 0.2em 0.1em 0.2em 0.1em;'>"
					 + "<button class='btn btn-outline-success' style='font-size: 1em; margin-right: 0.1em;'>수정</button>"
					 + "<button class='btn btn-outline-danger' style='font-size: 1em;margin-left: 0.1em;'>삭제</button>"
					 + "</td></tr>";
			}
			$("tbody").append(html);
			$(".align-center").css("text-align", "center");
			$("td > a").css("text-decoration", "none");
			$(function () {
				  $('[data-toggle="tooltip"]').tooltip()
			});
			
			$("#btn_pw_check").on("click", function(){
				$(".cover_1").fadeIn("fast", function(){
					$(".input_box_2").fadeIn("fast");
				});
				
				var thisElement = $(this).parent().parent();
// 				var phoneNo = thisElement.find("#phoneNo").text();
// 				var userNo = thisElement.find("#userNo").text();
// 				var nickName = thisElement.find("#nickName").text();
// 				var point = thisElement.find("#point").text();
// 				var bankInfo = thisElement.find("#bankInfo").text();
// 				var userName = thisElement.find("#userName").text();
// 				var uniqueID = thisElement.find("#uniqueID").text();
				
// 				var check = confirm("["+userName+"]님에게 ["+bankInfo+"] 으로 ["+point+"]원을 환급 하시겠습니까?");
// 				if(check){
					
// 					var data = {};
// 					data.type = 'accept';
// 					data.userNo = userNo;
// 					data.uniqueID = uniqueID;
					
// 					$.ajax({
// 						url: "/point/update",
// 						type: "POST",
// 						data: data
// 					}).done(function(rv){
// 						if(rv.result == 1){
// 							alert("환급에 성공하였습니다.");
// 						}else if(rv.result == 0){
// 							alert("이미 처리되었습니다.");
// 						}else{
// 							alert("로그인 후 처리해주세요.");
// 							location.reload();
// 							return false;
// 						}
// 							makeReadyList(list);
// 					}).fail(function(){
// 						alert("환급 실패! 관리자에게 문의해 주세요.");
// 					});
// 				}else{
// 					alert("취소되었습니다.");
// 				}
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
					data.point = point;
					
					$.ajax({
						url: "/point/update",
						type: "POST",
						data: data
					}).done(function(rv){
						if(rv.result == 1){
							alert("거절 하였습니다.");
						}else if(rv.result == 0){
							alert("이미 처리되었습니다.");
						}else{
							alert("로그인 후 처리해주세요.");
							location.reload();
							return false;
						}
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
	
	// 비밀번호 확인
	$("#submit_pw_check").on("click", function(){
		
	});
	
	// 글쓰기
	$("#in_submit_btn").on("click", function(){
		
		var formData = {};
		formData.companyName = $("#in_company_name").val();
		formData.companyUrl = $("#in_company_url").val();
		formData.loginId = $("#in_login_id").val();
		formData.loginPw = $("#in_login_pw").val();
		formData.partName = $("#in_part_name").val();
		formData.note = $("#in_note").val();
		
		var loginId = formData.loginId;
		var loginPw = formData.loginPw;
		var empty_space = /\s/gi;
		if( loginId.match(empty_space) || loginPw.match(empty_space) ){
			alert("공백은 포함될 수 없습니다.");
			return false;
		}
		if(formData.companyName == "" || formData.companyName.trim().length == 0 ){
			alert("회사명은 필수값입니다.");
			return false;
		}
		if(formData.companyUrl == "" || formData.companyUrl.trim().length == 0 ){
			alert("URL은 필수값입니다.");
			return false;
		}
		if(formData.loginId == "" || formData.loginId.trim().length == 0 ){
			alert("아이디는 필수값입니다.");
			return false;
		}
		if(formData.loginPw == "" || formData.loginPw.trim().length == 0 ){
			alert("비밀번호는 필수값입니다.");
			return false;
		}
		if(formData.partName == "" || formData.partName.trim().length == 0 ){
			alert("위치는 필수값입니다.");
			return false;
		}
		
		addAjaxAp(formData);
		
		
	});
	
	makeHTML(list);
});

		</script>
	</body>
</html>