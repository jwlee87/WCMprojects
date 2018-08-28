<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 계정 찾기 </title>
	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	html, body {width: 100%; margin: 0; padding: 0;}
	.input-group {height: 5vh;}
	.form-control {height: 5vh; font-size: 30px; border-color: #6c757d;}
	.search {font-size: 16px;}
	.search_1 {background-color: #6c757d; color: white;}
</style>
	</head>
	<body>
<div class="container">
	<c:if test="${sessionScope.member._class ne 3}">
		<h1>접근권한이 없습니다.</h1>
	</c:if>
	<c:if test="${sessionScope.member._class eq 3}">
		<br><br>
		<br><br>
	<div class="row">
		<div class="col-12" style="margin: 0 auto;">
			<div class="input-group" style="height: 5vh;">
				<input id="value" type="text" class="form-control" placeholder="폰번호 또는 아이디를 입력하세요." aria-label="Recipient's username with two button addons" aria-describedby="button-addon4">
				<div class="input-group-append" id="button-addon4">
					<button class="btn btn-outline-secondary search search_1" type="button">폰번호로 찾기</button>
					<button class="btn btn-outline-secondary search search_2" type="button">아이디로 찾기</button>
					<input id="checkCondition" type="hidden" value="10101">
				</div>
			</div>
		</div>
	</div>
		<br><br>
	</c:if>
</div>
	<script>
$(document).ready(function(){
	
	function ajaxSubmit(value, Command){
		var data = {};
		data["value"] = value;
		data["Command"] = Command;
		
		$.ajax({
			type: "POST"
			, url: "/admin/callFind"
			, data: data
			, dataType: "json"
		}).done(function(data){
			var dataStr = data.result;
			var beginIndex = dataStr.search("PASSWORD:");
			var endIndex = dataStr.search("</body>");
			var resultWord = dataStr.substring(beginIndex, endIndex);
			if(resultWord.length > 11){
				alert(resultWord);
			}else{
				alert("조회된 회원이 없습니다.");
			}
			
		}).fail(function(data){
			alert("Timeout Exception! 관리자에게 문의해 주세요.");
		});
	}
	
	function validCheck(){
		var value = $("#value").val();
		var Command = $("#checkCondition").val();
		if(value == null || value == ""){
			alert("폰번호 or 아이디를 입력해주세요.");
			return false;
		}else{
			ajaxSubmit(value, Command);
		}
	}
	
	function changeCheckValue(target){
		
		var className = target.attr("class");
		var classType = className.substring(className.length, className.length-1);
		if(classType == '1'){
			$("#checkCondition").val("10101");
			target.css("background-color", "#6c757d").css("color","white");
			$(".search_2").css("background-color", "white").css("color","#6c757d");
		}else if(classType == '2'){
			$("#checkCondition").val("10102");
			target.css("background-color", "#6c757d").css("color","white");
			$(".search_1").css("background-color", "white").css("color","#6c757d");
		}else{
			alert("시스템 에러! 관리자에게 문의해주세요.");
			return false;
		}
		validCheck();
	}

	$("#value").keypress(function(event){
		if(event.which == 13){
			validCheck();
		}
	});
	
	$(".search").on("click", function(){
		changeCheckValue($(this));
	});
	
});	
	</script>
	</body>
</html>