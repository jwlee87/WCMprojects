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
	<title>월드스폰</title>
	
	<style>
		section {
			display: none;
		}
	</style>
</head>
<body>
	<section>
		<h1>월드스폰</h1>
		<h2>월드스폰에 오신것을 환영합니다!</h2>
	</section>
	<c:import url="/view/module/topNavigation/navigation.jsp"/>
	<c:import url="/view/module/slide/slide.jsp"/>
	<c:import url="/view/module/bottomcon/bottomcon.jsp"/>
</body>
</html>