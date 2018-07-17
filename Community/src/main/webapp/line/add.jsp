<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="navi" %>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/line/css/add.css?ver=1.0"/>

<title>한줄 광고 신청</title>


</head>
<body>
	
	<div class="body-con">
		
		<div class="blank-con"></div>
		
		<div class="contents-con">
		
			<form id="frm" action="/line/addAction" method="post">
				<div class="form-group">
					<label for="chat">한줄 광고 내용</label>
					<input type="text" class="form-control" id="chat" name="chat" maxlength="80" required/>
					
					<div class="select-con">
						<select class="form-control" id="useDay" name="useDate">
							<option value="1">1 일</option>
							<option value="3">3 일</option>
							<option value="7">7 일</option>
							<option value="15">15 일</option>
							<option value="30">30 일</option>
							<option value="60">60 일</option>
							<option value="90">90 일</option>
						</select>
					</div>
					
					<div class="select-con">
						<select class="form-control" id="colorKey" name="colorKey">
							<option value="0">회색</option>
							<option value="1">빨간색</option>
							<option value="2">주황색</option>
							<option value="3">노랑색</option>
							<option value="4">초록색</option>
							<option value="5">파랑색</option>
							<option value="6">남색</option>
							<option value="7">보라색</option>
						</select>
					</div>
					
					<div class="price-con">
						<span>광고가격 </span><span class="price"> 17</span><span>코인</span>
					</div>
					
					<input type="hidden" id="userUniqueID" name="userUniqueID" value="${member.uniqueID}"/>
					<input type="hidden" id="onedayPrice" name="onedayPrice" value="${onedayPirce}"/>
					
					<div class="button-con">
						<button type="button" id="ok_btn" class="btn btn btn-primary">신청</button>
						<button type="button" class="btn btn btn-default" onclick="javascript:history.go(-1);">뒤로</button>
					</div>
										
				</div>
			</form>
		</div>
		
	</div>

<script>
	$("#useDay").on("change", function(){
		day = $("#useDay").val();
		onedayPrice = $("#onedayPrice").val();
		
		totalPrice = onedayPrice * day;
		
		$(".price").text(totalPrice);
	});
	
	function valCheck(){
		text = $("#chat").val();
		if(text.length >= 10 && text.length <= 80){
			$("#frm").submit();
		}else{
			alert("한줄 광고는 10자이상 80자이하로 등록해주세요.")
			event.stopPropagation();
			return false;
		}
	}
	
	$("#ok_btn").on("click", function(){
		valCheck();
	});
	
</script>
</body>
</html>