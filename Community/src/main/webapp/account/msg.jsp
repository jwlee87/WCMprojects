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
<link rel="stylesheet" href="/account/css/find.css?ver=1.0"/>

<title>비밀번호 찾기</title>
</head>
<body>
	<div class="top-blank">
	</div>
	<div class="row txt-label">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<span style="font-size: 2.4em;">
			가입 당시 입력하신 이메을 주소로<br> 
			비밀번호 변경 링크 주소를 보내드렸습니다.<br>
			이메일을 확인해 주세요.<br>
			</span>
		</div>
		<div class="col-xs-2"></div>
	</div>
	
	<script>
		window.onload = function(){
			var height = $(window).height();
			$(".top-blank").css("height", height/3.5);
		};
	</script>
</body>
</html>