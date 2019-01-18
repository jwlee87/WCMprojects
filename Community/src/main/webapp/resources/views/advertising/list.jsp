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
					<th scope="col" class="align-center" style="width: 5%; ">식별No.</th>
					<th scope="col" class="align-center" style="width: 18%; min-width: 100px;">회사명</th>
					<th scope="col" class="align-center" style="width: 12%;">URL</th>
					<th scope="col" class="align-center" style="width: 8%;">아이디</th>
					<th scope="col" class="align-center" style="width: 8%;">비밀번호</th>
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
			<button type="button" class="in_submit_btn btn btn-primary">등록</button>
			<button type="reset" class="in_reset_btn btn btn-light">리셋</button>
			<button type="button" class="in_cancle_btn btn btn-danger">취소</button>
		</div>
	</div>
	</form>
	
	<!-- 비밀번호 확인 창 -->
	<div class="input_box_2">
		<div class="row input_row">
			<h1>비밀번호 확인</h1>
		</div>
		<div class="row input_row">
			<div class="input-group input-group-lg">
				<div class="input-group-prepend">
					<span class="input-group-text" id="inputGroup_in_pw_check">비밀번호</span>
				</div>
				<input type="password" class="form-control in_pw_check" aria-label="Sizing example input" aria-describedby="inputGroup_in_pw_check">
			</div>
		</div>
		<button type="button" class="btn btn-primary submit_pw_check">확인</button>
	</div>
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
		$(".in_pw_check").val("");
		$("#in_company_name").val("");
		$("#in_company_url").val("");
		$("#in_login_id").val("");
		$("#in_login_pw").val("");
		$("#in_part_name").val("");
		$("#in_note").val("");
		$(".cover_1").fadeOut("fast", function(){
			$(".input_box").fadeOut("fast", function(){
				$(".input_box_2").fadeOut("fast", function(){
					$(".first_box").fadeIn("fast");
				});
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
	
	function getPass(no){
		var data = {};
		data.no = no;
		$.ajax({
			url: "/ap/get/simplepw",
			type: "POST",
			data: data
		}).done(function(d){
			data.pw = d.login_pw;
		});
		return data;
	}
	
	function ajaxPass(no, pass){
		var data = {};
		data.no = no;
		data.pass = pass;
		$.ajax({
			url: "/ap/get/pw",
			type: "POST",
			data: data
		}).done(function(d){
			var check = d.check;
			if(check == "true"){
				$(".in_pw_check").val("");
				outInputBox();
			}else{
				$(".in_pw_check").val("");
				outInputBox();
			}
			alert(d.result);
		});
	}
	
	function checkPass(no ,pass){
		var no = no;
		var pass = pass;
		var empty_space = /\s/gi;
		if( pass.match(empty_space) ){
			alert("공백은 포함될 수 없습니다.");
			$(".in_pw_check").val("");
			$(".in_pw_check").focus();
			return false;
		}
		if( pass == "" ){
			alert("비밀번호를 입력하세요.");
			return false;
		}
		ajaxPass(no, pass);
	}
	
	var data = '${list}';
	var list = JSON.parse(data);
	
// 	for(var i = 0; i < list.length; i++){
// 		console.log(list[i]);
// 	}
	
	$(".first_box").on("click", function(){ inInputBox(); });
	$(".cover_1").on("click", function(){ outInputBox(); });
	$(".in_cancle_btn").on("click", function(){ outInputBox(); });
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
	///////////////
	// make HTML //
	///////////////
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
// 					 + "<th scope='row' align-center'>"+(i + 1)+"</th>"
					 + "<th scope='row' class='uniqueID align-center'>"+list[i].no+"</th>"
					 + "<td class='align-center td_company_name'>"+list[i].company_name+"</td>"
					 + "<td class='align-center td_company_url' style='padding: 0.2em;'><a class='btn btn-primary' href='"+addr+"' target='_blank' style='font-size: 1em;'"
					 + " data-toggle='tooltip' data-html='true' title='<p style=\"font-size: 2em;\">"+addr+"'>이동</a></td>"
					 + "<td class='align-center td_login_id'>"+list[i].login_id+"</td>"
					 + "<td class='align-center td_login_pw' style='padding: 0.2em;'><button class='btn btn-outline-primary btn_pw_check' style='font-size: 1em;'>확인하기</button></td>"
					 + "<td class='align-center td_part_name'>"+list[i].part_name+"</td>"
					 + "<td class='align-center td_note'>"+list[i].note+"</td>"
					 + "<td class='align-center td_btn_box' style='padding: 0.2em 0.1em 0.2em 0.1em;'>"
					 + "<button class='btn btn-outline-success modify_btn' style='font-size: 1em; margin-right: 0.1em;' disabled>수정</button>"
					 + "<button class='btn btn-outline-danger modify_delete_btn' style='font-size: 1em;margin-left: 0.1em;'>삭제</button>"
					 + "</td></tr>";
			}
			$("tbody").append(html);
			$(".align-center").css("text-align", "center");
			$("td > a").css("text-decoration", "none");
			$(function () {
				  $('[data-toggle="tooltip"]').tooltip();
			});
			/////////////////////////////////////////////////////////////////////////////////
			// 비밀번호 확인 클릭 비밀번호 창 열기 //
			var no = "";
			$(".btn_pw_check").on("click", function(){
				$(".first_box").fadeOut("fast", function(){
					$(".cover_1").fadeIn("fast", function(){
						$(".input_box_2").fadeIn("fast");
						$(".in_pw_check").focus();
					});
				});
				var thisElement = $(this).parent().parent();
				no = thisElement.find(".uniqueID").text();
			});
			// 비밀번호 확인 //
			$(".in_pw_check").on("keydown", function(e){
				if(e.keyCode == 13){
					var pass = $(".in_pw_check").val().trim();
					checkPass(no ,pass);
				}
			})
			$(".submit_pw_check").on("click", function(){
				var thisElement = $(this).parent().parent();
				var pass = $(".in_pw_check").val().trim();
				checkPass(no, pass);
			});
			/////////////////////////////////////////////////////////////////////////////////
			// 수정 버튼 //
			$(".modify_btn").on("click", function(){
				var thisElement = $(this).parent().parent();
				no = thisElement.find(".uniqueID").text();
				var companyName = thisElement.find(".td_company_name");
				var b_companyName = thisElement.find(".td_company_name").text();
				var companyUrl = thisElement.find(".td_company_url");
				var loginId = thisElement.find(".td_login_id");
				var b_loginId = thisElement.find(".td_login_id").text();
				var loginPw = thisElement.find(".td_login_pw");
				var b_loginPw = thisElement.find(".td_login_pw").text();
				var partName = thisElement.find(".td_part_name");
				var b_partName = thisElement.find(".td_part_name").text();
				var note = thisElement.find(".td_note");
				var b_note = thisElement.find(".td_note").text();
				var btnBox = thisElement.find(".td_btn_box");
				
				console.log("수정1: "+companyUrl);
				
				var text = "<button id='update_complete_btn' class='btn btn-success' style='font-size: 1em; margin-right: 0.1em;'>적용</button>"
						 + "<button class='btn btn-danger modify_cancle_btn' style='font-size: 1em;margin-left: 0.1em;'>취소</button>";
				
// 				modifyBtn.text("적용").prop("id","update_complete_btn").removeClass("btn-outline-success").addClass("btn-success").removeClass("modify_btn");
// 				cancleBtn.text("취소").addClass("update_cancle_btn").removeClass("btn-outline-danger").addClass("btn-danger");
				
				companyName.html("<input id='modi_companyNm' value='"+companyName.text()+"'></input>");
				var tempStr = companyUrl.find("a").prop("href");
// 				var tempAddr = tempStr.substring(7, tempStr.length-1);
				var tempAddr = tempStr
				companyUrl.html("<input id='modi_companyUrl' value='"+tempAddr+"'></input>").css("padding", "8px");
				loginId.html("<input id='modi_id' value='"+loginId.text()+"'></input>");
				loginPw.html("<input id='modi_pw' type='password'></input>").css("padding", "8px");
				partName.html("<input id='modi_partName' value='"+partName.text()+"'></input>");
				note.html("<input id='modi_note' value='"+note.text()+"'></input>");
				btnBox.css("padding-top", "6.25px").css("padding-bottom", "6.25px");
				btnBox.html(text);
				$("#modi_companyNm").focus();
				
				////////////
				// 취소 버튼 //
				$(".modify_cancle_btn").on("click", function(){
					location.reload();
				});
				
				// 업데이트 적용 //
				$("#update_complete_btn").on("click", function(){
					data = {};
					data.no = no;
					data.companyName = $("#modi_companyNm").val().trim();
					data.companyUrl = $("#modi_companyUrl").val().trim();
					data.loginId = $("#modi_id").val().trim();
					data.loginPw = $("#modi_pw").val().trim();
					data.partName = $("#modi_partName").val().trim();
					data.note = $("#modi_note").val().trim();
					data.bCompanyName = b_companyName;
					data.bCompanyUrl = tempAddr.trim();
					data.bLoginId = b_loginId;
					data.bPartName = b_partName;
					data.bNote = b_note;
					
					console.log("수정2: "+data);
					
					$.ajax({
						url: "/ap/get/simplepw",
						type: "POST",
						data: data
					}).done(function(d){
						data.bLoginPw = d.login_pw;
						
						var regExUrl = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
						var empty_space = /\s/gi;
						if(data.loginPw.match(empty_space)){
							alert("공백은 포함될 수 없습니다.");
							$("#modi_pw").val("");
							$("#modi_pw").focus();
							return false;
						}
						if(data.companyName.trim().length == 0){
							alert("회사명은 필수값입니다.");
							return false;
						}
						if(data.companyUrl.trim().length == 0){
							alert("URL은 필수값입니다.");
							return false;
						}
						if(regExUrl.test(data.companyUrl)){
							alert("URL 형식이 올바르지 않습니다.");
							return false;
						}
						if(data.loginId.trim().length == 0){
							alert("아이디는 필수값입니다.");
							return false;
						}
						if(data.loginPw.trim().length == 0){
							alert("비밀번호는 필수값입니다.");
							return false;
						}
						if(data.partName.trim().length == 0){
							alert("삽입위치는 필수값입니다.");
							return false;
						}
						
						$.ajax({
							url: "/ap/u",
							type: "POST",
							data: data
						}).done(function(d){
							if(d.result == "success"){
								
								$.ajax({
									url: "/ap/get/a",
									type: "POST"
								}).done(function(data){
									alert("변경 되었습니다.");
									location.reload();
								}).fail(function(){
									outInputBox();
								});
								
							}else if(d.result == "false-1"){
								alert("업데이트에 실패하였습니다.")
								location.reload();
							}else if(d.result == "false-2"){
								alert("이미 변경되어 수정이 불가능합니다.")
								location.reload();
							}
						});
					});
				});
				// end of update //
				///////////////////
				
				
			});
			/////////////////////////////////////////////////////////////////////////////////
			// 삭제 버튼 //
			$(".modify_delete_btn").on("click", function(){
				var thisElement = $(this).parent().parent();
				no = thisElement.find(".uniqueID").text();
				
				var isRun = false;
				isRun = true;
				
				if(isRun){
					$.ajax({
						url: "/ap/d",
						type: "POST",
						data: {"no": no}
					}).done(function(d){
						alert(d.result);
						location.reload();
					});	
				}else{
					alert("다시 시도해주세요.");
				}
			});
		}
	}
/////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////
	// 글쓰기  //
	$(".in_submit_btn").on("click", function(){
		var formData = {};
		formData.companyName = $("#in_company_name").val().trim();
		formData.companyUrl = $("#in_company_url").val().trim();
		formData.loginId = $("#in_login_id").val().trim();
		formData.loginPw = $("#in_login_pw").val().trim();
		formData.partName = $("#in_part_name").val().trim();
		formData.note = $("#in_note").val().trim();
		
		var loginId = formData.loginId;
		var loginPw = formData.loginPw;
		var empty_space = /\s/gi;
		var regExUrl = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
		
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
		console.log(formData.companyUrl);
		console.log(regExUrl.test(formData.companyUrl));
		
		if(regExUrl.test(formData.companyUrl)){
			alert("URL 형식이 올바르지 않습니다.");
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
	
	///////////////////
	// esc key event //
	///////////////////
	$("body").on("keydown", function(){
		if( $(".cover_1").css("display") == "block" ){
			if( event.keyCode == 27 ){
				outInputBox();
			}
		}
	});
	//////////////////
	// 시작 리스트 받아오기
	//////////////////
	makeHTML(list);
});

		</script>
	</body>
</html>