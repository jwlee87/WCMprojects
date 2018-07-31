<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게임기록</title>
<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
</head>
<body>
<c:if test="${sessionScope.member._class ne 3}">
	<h1>접근권한이 없습니다.</h1>
</c:if>
<c:if test="${sessionScope.member._class eq 3}">
	<input id="nickName" type="text" placeholder="검색할 아이디를 입력하세요."/>
	<button id="search">검색</button>
</c:if>
<script>
$(document).ready(function(){

	function ajaxSubmit(nick){
		var data = {};
		data["nickName"] = nick;
		
		$.ajax({
			type: "POST"
			, url: "/game/getHis"
			, data: data
			, dataType: "json"
		}).done(function(data){
			makeJson(data);
		});
	}
	
	function validCheck(){
		var nick = $("#nickName").val();
		if(nick == null || nick == ""){
			alert("닉네임을 입력해주세요.");
			return false;
		}else{
			return ajaxSubmit(nick);
		}
	}
	
	function makeJson(data){
		var result = JSON.parse(data);
		var result2 = result.resultList;
		makeHTML(result2);
	}
	
	function makeHTML(json){
		console.log(json);
		
		for(var i=0; i < json.length; i++){
			var date = json[i]._DateTime;
			var userNo = json[i]._UserUniqueID;
			var aMoney = json[i]._AMONEY;
			var memo = json[i]._MEMO;
			
			console.log(memo);
		}
		
	}

	$("#nickName").keypress(function(event){
		if(event.which == 13){
			validCheck();
		}
	});
	
	$("#search").on("click", function(){
		validCheck();
	});
	
});	
</script>
</body>
</html>