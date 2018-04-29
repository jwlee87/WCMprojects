<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/view/common/jsp/defaultSetting.jsp"></c:import>

<link rel="stylesheet" href="/view/business/css/index.css?ver=1.0"/>

<title>월드  코인 마켓 - 게임</title>
</head>
<body>
	
	<c:import url="/view/module/topNavigation/navigation.jsp"/>
	<c:import url="/view/business/bannercon.jsp"/>
	
	<div class="bodycon">
		<div>
			<div>
				<img src="/view/business/img/category/business.png"/>
			</div>
			<!-- 사업 소개 -->
			<div class="category">
				<a href="/business/">
					<img src="/view/business/img/category/bintroduce-off.png"/>
				</a>
			</div>
			<!-- 컨텐츠 소개 -->
			<div class="category">
				<a href="#">
					<img src="/view/business/img/category/contents-off.png"/>
				</a>
				
				<!-- 컨텐츠 하위 -->
				<div class="sub">
					<!-- 컨텐츠 - 바카라 -->
					<div>
						<div class="empty"></div>
					</div>
					<div class="sub-category">
						<a href="/business/contents/game">
							<img src="/view/business/img/category/baccarat-off.png"/>
						</a>
					</div>
					<div>
						<div class="empty"></div>
					</div>
					<!-- 컨텐츠 - 앱 -->
					<div class="sub-category sub-app">
						<a href="/business/contents/app">
							<img src="/view/business/img/category/app-off.png"/>
						</a>
					</div>
					<div>
						<div class="empty empty-long"></div>
					</div>
					
				</div>
				
			</div>
		</div>
		
		<!-- bodycon right -->
		<div>
			<div>
				<img src="/view/business/img/body-contents.png" alt="contents"/>
			</div>
			
			<!-- bodycon content -->
			<div class="bodycon-content">
				<img src="/view/business/img/contents/app.png" alt="game"/>
			</div>
			
		</div>
	</div>
	
	<c:import url="/view/module/bottomcon/bottomcon.jsp"/>
	
</body>
</html>