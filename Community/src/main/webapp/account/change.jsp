<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/account/css/change.css?ver=1.0"/>

<title>비밀번호 변경</title>
</head>
<body>
	<div class="top-blank"></div>
	
	<c:if test="${resultMap.check eq true}">
	
	<div class="row txt-label">
		<div class="col-xs-1"></div>
		<div class="col-xs-10 errorMsg">
			비밀번호 변경
		</div>
		<div class="col-xs-1"></div>
	</div>
	
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<input id="pass" type="password" class="form-control" placeholder="변경하실 비밀번호를 입력해 주세요."></input>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<input id="passCheck" type="password" class="form-control" placeholder="비밀번호 확인"></input>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<button id="check_btn" type="button" class="btn btn-primary btn-block">변경</button>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<input type="hidden" id="userUniqueID" value="${resultMap.userUniqueID}">
	
	</c:if>
	<c:if test="${resultMap.check eq false}">
		<div class="row txt-label">
		<div class="col-xs-1"></div>
		<div class="col-xs-10 errorMsg">
			<span style="color: red; font-weight: bold;">비정상적 접근</span><br>
			메일 유효시간이 만료되었습니다.
		</div>
		<div class="col-xs-1"></div>
	</div>
	</c:if>
	
	<script>
		window.onload = function(){
			var height = $(window).height();
			$(".top-blank").css("height", height/3.5);
		};
		
		
		$("#check_btn").on("click", function(){
			var pass = $("#pass").val();
			var passCheck = $("#passCheck").val();
			var userUniqueID = $("#userUniqueID").val();
			
			if(pass.length < 4){
				alert("비밀번호가 너무 짧습니다.");
				return false;
			}else if(pass != passCheck){
				alert("비밀번호가 일치하지 않습니다.");
				return false;
			}else{
				
				$.ajax({
					type: "POST"
					, url: "/changeAction/"+userUniqueID+"/"+pass
					, dataType: "json"
					, success: function(data){
						if(data.key == "true"){
							alert("비밀번호가 변경되었습니다.");
							location.href = "/"
						}else{
							alert("실패했습니다.");
							location.href = "/"
						}
					}
				});
				
			}
			
		});
	</script>
</body>
</html>