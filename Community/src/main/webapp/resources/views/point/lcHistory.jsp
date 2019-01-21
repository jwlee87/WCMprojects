<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title> 락 코인 기록 </title>
<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<style>
	html, body {width: 100%; margin: 0; padding: 0;}
</style>
</head>
<body>
<c:if test="${sessionScope.member._class ne 3}">
	<h1>접근권한이 없습니다.</h1>
</c:if>
<c:if test="${sessionScope.member._class eq 3}">
	<br><br>
	<div class="search_box">
		<input id="nickName" type="text" placeholder="검색할 아이디를 입력하세요."/>
		<button id="search">검색</button>
	</div>
	<br><br>
	<div class="table_con"></div>
	<br><br>
</c:if>
<script>
$(document).ready(function(){
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	
	var html = "";
	var t_head = "<tr><th>NO</th><th>일시</th><th>유저번호</th><th>닉네임</th><th>코드</th><th>락코인</th><th>전 락코인</th><th>후 락코인</th><th>메모</th></tr>";
	
	function cssSetting(){
		$(".search_box").css("max-width", "600px").css("width", "60%").css("margin", "0 auto");
		$("#nickName").css("width", "80%");
		$("#search").css("width", "15%");
	}
	cssSetting();
	
	function ajaxSubmit(nick){
		var data = {};
		data["type"] = 'lCoin';
		data["nickName"] = nick;
		
		$.ajax({
			type: "POST"
			, url: "/history/getHis"
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
		var result = data;
		var result2 = result.resultList;
		
		console.log(result2.length);
		if(result2.length == 0){
			$("#his_table").remove();
			alert("기록이 없습니다.");
			return false;
		}else{
			makeHTML(result2);			
		}
	}
	
	function makeHTML(json){
		html = "";
		html += t_head;
		
		for(var i=0; i < json.length; i++){
			
			var date = json[i]._DateTime;
			var userNo = json[i]._UserUniqueID;
			var nickName = json[i]._Trademark;
			var pCode = json[i]._ProcessCode;
			var lockcoin = json[i]._LOCKCOIN;
			var bLockCoin = json[i]._BLOCKCOIN;
			var aLockCoin = json[i]._ALOCKCOIN;
			var memo = json[i].memo;
			
			html += "<tr style='border: 1px solid #ccc;'>"
				 +"<td>"+Number(i+1)+"</td>"
				 +"<td>"+date+"</td>"
				 +"<td>"+userNo+"</td>"
				 +"<td>"+nickName+"</td>"
				 +"<td>"+pCode+"</td>"
				 +"<td>"+numberWithCommas(lockcoin)+"</td>"
				 +"<td>"+numberWithCommas(bLockCoin)+"</td>"
				 +"<td>"+numberWithCommas(aLockCoin)+"</td>"
				 +"<td>"+memo+"</td>"
				 +"</tr>";
		}
		
		$("#his_table").remove();
		$(".table_con").append('<table id="his_table"></table>');
		$("#his_table").append(html);
		$("#his_table").css("max-width", "1400px").css("width", "100%").css("border", "1px solid #ccc").css("margin", "0 auto");
		$("#his_table > tr > th").css("border", "1px solid #ccc").css("text-align", "center");
		$("#his_table > tr > td").css("border", "1px solid #ccc").css("text-align", "right").css("padding", "10px");
		$("#his_table > tr").mouseenter(function(){
			$(this).css("background-color", "#ccc").css("font-weight", "bold");
		}).mouseleave(function(){
			$(this).css("background-color", "white").css("font-weight", "normal");
		});
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