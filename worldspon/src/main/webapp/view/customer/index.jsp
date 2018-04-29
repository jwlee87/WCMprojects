<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
	<c:import url="/view/common/jsp/defaultSetting.jsp"></c:import>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="/view/customer/css/index.css?ver=1.0">
	<title>월드 코인 마켓 - 고객 센터</title>
</head>
<body>
	
	<c:import url="/view/module/topNavigation/navigation.jsp"/>
	
	<div class="banner-con">
		<div class="banner-item">
			<img src="/view/customer/img/customer.png">
		</div>
	</div>
	
	<div class="bodycon">
		<div>
			<div>
				<img src="/view/customer/img/category/customer.png"/>
			</div>
			<!-- 온라인 문의 -->
			<div class="category">
				<a href="/customer">
					<img src="/view/customer/img/category/qna-off.png"/>
				</a>
			</div>
		</div>
	
		<!-- body right -->
		<div>
			<!-- top -->
			<div>
				<img src="/view/customer/img/customer-qna.png" alt="QnA"/>
			</div>
			<!-- content -->
			<div class="qna_con">
				<br>
				<p> 문의사항은 worldspon@gmail.com 으로 연락해주세요.</p>
				<p> 빠른 시일내에 답변해 드리겠습니다.</p>
				<br>
				<br>
				<p>그 외 월드스폰 어플리케이션에 관한 사항은 아래 사이트를 이용해주세요.</p>
				<button id="goBtn" type="button" class="btn btn-secondary">월드스폰 사이트로 이동</button>
			</div>
		</div>
	</div>
	
	<c:import url="/view/module/bottomcon/bottomcon.jsp"/>
	
	<script src="/view/customer/js/index.js"></script>
	<script>
		$("#goBtn").on("click", function(){
			location.href = "http://worldspon.net";
		})
	</script>
	
</body>
</html>