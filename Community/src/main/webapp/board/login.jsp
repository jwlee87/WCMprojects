<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="navi" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/board/css/login.css?ver=1.0"/>

<title>로그인</title>
</head>
<body>

	<div class="top-blank"></div>
	
	<form id="frm" action="/board/loginAction" method="post">
		<div class="write-wrap">
			<div class="top-wrap">
				<label for="name">아이디</label>
				<input type="text" id="name" name="tradeMark"/>
				<label for="pass">비밀번호</label>
				<input type="password" id="pass" name="password"/>
			</div>
		</div>
		<div class="button-con">
			<input type="button" id="save" value="로그인"/>
			<input type="button" id="goHome" value="처음으로"/>
		</div>
	</form>

<script>
	$("#save").on("click", function(){
		
		var data = {};
		data["tradeMark"] = $("#name").val();
		data["password"] = $("#pass").val();
		
		$.ajax({
			type: "POST"
			, url: "/board/idChk"
			, data: data
			, dataType: "json"
			, success: function(data){
				if(data.check=='noTM'){
					alert("아이디가 존재하지 않습니다.");
					location.reload();
					
				}else if(data.check=='ok'){
					$("#frm").submit();
					
				}else if(data.check=="noPW"){
					alert("비밀번호가 일치하지 않습니다.");
					location.reload();
					
				}else if(data.check=="error"){
					alert("error code: 01");
				}else {
					alert("error code: 02")
				}
			}
		})
		
	});
	
	$("#goHome").on("click", function(){
		location.href = "/";
	});
</script>
</body>
</html>