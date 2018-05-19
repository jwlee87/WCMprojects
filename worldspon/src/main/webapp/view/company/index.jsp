<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/view/common/jsp/defaultSetting.jsp?ver=1.0"></c:import>

<title>월드스폰 - 회사 소개</title>
</head>
<body>
	
	<c:import url="/view/module/topNavigation/navigation.jsp"/>
	<c:import url="/view/company/bannercon.jsp"/>
	
	<div class="bodycon">
		<div>
			<div>
				<img src="/view/company/img/category/company.png"/>
			</div>
			<!-- 회사 소개 -->
			<div class="category">
				<a href="/company/">
					<img src="/view/company/img/category/introduce-off.png"/>
				</a>
			</div>
			<!-- CI 소개 -->
			<div class="category">
				<a href="/company/ci">
					<img src="/view/company/img/category/ci-off.png"/>
				</a>
			</div>
			<!-- 오시는 길 -->
			<div class="category">
				<a href="/company/location">
					<img src="/view/company/img/category/location-off.png"/>
				</a>
			</div>
		</div>
		
		<!-- body right -->
		<div>
			<!-- top -->
			<div>
				<img src="/view/company/img/company-intro.png" alt="company"/>
			</div>
			<!-- content -->
			<div>
				<img src="/view/company/img/body-intro.png"/>
			</div>
		</div>
	</div>
	
	<c:import url="/view/module/bottomcon/bottomcon.jsp"/>
	
</body>
</html>