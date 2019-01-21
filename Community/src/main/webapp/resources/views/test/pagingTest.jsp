<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>페이징 테스트</title>
	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="/resources/js/highcharts/highcharts.js"></script>
<script src="/resources/js/highcharts/data.js"></script>
<script src="/resources/js/highcharts/exporting.js"></script>
<script src="/resources/js/highcharts/export-data.js"></script>
<script src="/resources/js/jquery.countdown.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js" integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js" integrity="sha384-h0AbiXch4ZDo7tp9hKZ4TsHbi047NrKGLO3SEJAg45jXxnGIfYzk4Si90RDIqNm1" crossorigin="anonymous"></script>
<script src="/resources/views/js/pagination.js"></script>

	<h1>페이징 테스트</h1>
	
	<br><br><br><br>
	
	<div class="container">
		<div class="row">
			<div id="hihi" class="col-12" style="text-align: center;"></div>
		</div>
	</div>
	
	<br><br><br><br>
		<script>

 var data = '${data}';
 
 /**
  *  페이징 모듈
  * @param totalCount    총 리스트 갯수
  * @param currentPage   현재 페이지
  * @param pageSize      한페이지 보여질 목록 갯수
  * @param listSize      한번에 보여질 페이징 갯수
  * @param linkFunction  클릭 function
  * @param targetDiv     만들어징 페이징이 적용될 div ID
  * @returns {*}
  */

  console.log(data);
  var result = JSON.parse(data);
  console.log(result.now);
  
  makePageNavigationBar(result.totalList, result.now, 10, 10, 'getAjax', hihi, false);

function getAjax(targetPage){
	makePageNavigationBar(result.totalList, targetPage, 10, 10, 'getAjax', hihi, false);
// 	location.href="/testPage?now="+targetPage;
}
		</script>
	</body>
</html>