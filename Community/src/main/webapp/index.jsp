<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free Reward App, Free Android App" />
	<meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	<meta name="author" content="WorldSpon, Inc." />
	
	<link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	<link rel="icon" href="/info/img/favicon/ws_p16.png" sizes="16x16">
	<link rel="icon" href="/info/img/favicon/ws_p32.png" sizes="32x32">

	<style>
		.btn btn-default btn-block {
			
		}
	</style>
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
		
		<c:if test="${sessionScope.member ne null}">
		<div class="login-con">
			<div class="login-btn-box">
				<button id="btn-benefit" type="button" class="btn btn-primary btn-block" style="height: 150px; font-size: 1.8em;">월드스폰 수익보기</button>
			</div>
		</div>
		</c:if>
		
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
		<br><br>
		<c:if test="${sessionScope.member._class eq 3}">
		<div class="login-con">
			<div class="login-btn-box">
				<a href="game/history" type="button" class="btn btn-default btn-block">게임 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/point/history" type="button" class="btn btn-default btn-block">포인트 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/coin/history" type="button" class="btn btn-default btn-block">코인 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/lCoin/history" type="button" class="btn btn-default btn-block">락코인 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/p2p" type="button" class="btn btn-default btn-block">P2P거래 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/log/charge" type="button" class="btn btn-default btn-block">캐시비 충전 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/log/lock" type="button" class="btn btn-danger btn-block">캐시비 락포인트 기록</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a target="_blank" href="https://partner.coin-box.kr/" type="button" class="btn btn-primary btn-block">캐시비 관리자</a>
			</div>
		</div>
		<br><br>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/point/refund" type="button" class="btn btn-info btn-block">포인트 환급</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/admin/find" type="button" class="btn btn-default btn-block">관리자용 비밀번호 찾기</a>
			</div>
		</div>
		<br><br>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/ap" type="button" class="btn btn-default btn-block">광고 공급자 관리</a>
			</div>
		</div>
		<div class="login-con">
			<div class="login-btn-box">
				<a href="/server" type="button" class="btn btn-default btn-block">서버 관리</a>
			</div>
		</div>
		<br><br>
		</c:if>
	</div>
	
<script>
	$("#btn-board").on("click", function(){
		location.href="/board";
	});
	
	$("#btn-ad").on("click", function(){
		location.href="/bann";
	});
	
	$("#btn-login").on("click", function(){
		location.href="/board/login";
	});
	
	$("#btn-linead").on("click", function(){
		location.href="/line";
	});
	
	$("#btn-benefit").on("click", function(){
		location.href="/benefit/data/cm";
	})
	
	$("#btn-logout").on("click", function(){
		
		$.ajax({
			url: "/board/logout"
			, success: function(){
				location.reload();
			}
		});
	});
	
	$("#btn_findPw").on("click", function(){
		location.href="/find";
	});
</script>
</body>
</html>