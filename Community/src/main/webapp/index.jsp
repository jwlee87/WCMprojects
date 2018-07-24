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
<link rel="stylesheet" href="/resources/css/index.css?ver=1.0"/>

<title>월드스폰</title>
</head>
<body>
	<div class="top-blank"></div>
	
	<div class="main-con">
	
		<div class="hello-con">
			<span>월드스폰에 오신것을 환영합니다!</span>
		</div>
		<div class="box-con">
			<div class="box left-box">
				<button id="btn-board" type="button" class="btn btn-primary btn-lg">게시판</button>
			</div>
			<div class="box right-box">
				<button id="btn-ad" type="button" class="btn btn-default btn-lg" disabled="disabled">광고 신청</button>
			</div>
		</div>
		
		<div class="box-con">
			<div class="box left-box">
				<button id="btn-linead" type="button" class="btn btn-info btn-lg">한줄 광고 신청</button>
			</div>
			<div class="box right-box">
				<button id="btn_findPw" type="button" class="btn btn-light btn-lg">비밀번호 찾기</button>
			</div>
		</div>
		
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/game/run/tList" type="button" class="btn btn-default btn-block">좀비레이스 게임 결과</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="game/break/tList" type="button" class="btn btn-default btn-block">좀비격파 게임 결과</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="game/fight/tList" type="button" class="btn btn-default btn-block">좀비격투 게임 결과</a>
			</div>
		</div>
		
		<c:if test="${sessionScope.member eq null}">
		<div class="login-con">
			<div class="login-btn-box">
				<button id="btn-login" type="button" class="btn btn-default btn-block">로그인</button>
			</div>
		</div>
		</c:if>
		<c:if test="${sessionScope.member ne null}">
		<div class="login-con">
			<div class="login-btn-box">
				<button id="btn-logout" type="button" class="btn btn-default btn-block">로그아웃</button>
			</div>
		</div>
		</c:if>
	</div>
	
<script>
	$("#btn-board").on("click", function(){
		location.href="/board";
	});
	
	$("#btn-ad").on("click", function(){
		location.href="/bann"
	});
	
	$("#btn-login").on("click", function(){
		location.href="/board/login";
	});
	
	$("#btn-linead").on("click", function(){
		location.href="/line"
	});
	
	$("#btn-logout").on("click", function(){
		
		$.ajax({
			url: "/board/logout"
			, success: function(){
				location.reload();
			}
		});
	});
	
	$("#btn_findPw").on("click", function(){
		location.href="/find"
	});
</script>
</body>
</html>