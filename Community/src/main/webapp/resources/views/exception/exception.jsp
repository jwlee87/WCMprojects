<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	response.setStatus(200);
%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<title>월드스폰</title>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<style>
		font-family: 'Nanum Gothic', sans-serif;
		body {width: 100%;}
		.msg-box {
			width: 700px;
			border-top: 2px solid #000;
			border-bottom: 2px solid #000;
			margin: 10vh auto;
			padding: 8vh 10px;
			text-align: center;
			background-image: url("/resources/img/exception/error_icon.png");
		}
		.inner-box { width: 450px; margin: 0 auto; text-align: left;}
		.highlight { color: #008080; font-size: 2.2em;}
		.highlight-2 { color: #191919; font-size: 1.2em;}
		.jw-bold {font-weight: bolder;}
	</style>
</head>
<body>
	<div class="msg-box">
		<div class="inner-box">
		<span class="highlight jw-bold">죄송합니다.</span><span class="highlight-2 jw-bold"> &nbsp;요청하신 페이지를 찾을 수 없습니다.</span><br><br>
			<p>요청하신 페이지를 찾을수가 없습니다.</p>
			<P>찾으시려는 페이지는 주소를 잘못 입력하였거나</P>
			<p>페이지 주소의 변경 또는 삭제 등의 이유로 페이지를 찾을 수 없습니다.</p>
			<p><span class="jw-bold">입력하신 페이지의 주소와 경로가 정확한지 한번더 확인 후 이용하시기 바랍니다.</span></p>
		</div><br>
		<button id="before">홈으로</button>
	</div>
<script>
$(document).ready(function(){
	$("#before").on("click", function(){
		location.href = "http://worldspon.net"; 
	});
});
</script>
</body>
</html>