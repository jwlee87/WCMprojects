<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html id="up">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free Reward App, Free Android App" />
	<meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	<meta name="author" content="WorldSpon, Inc." />
	
	<link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	<link rel="icon" href="/info/img/favicon/ws_p16.png" sizes="16x16">
	<link rel="icon" href="/info/img/favicon/ws_p32.png" sizes="32x32">
	
	<title>캐시비 충전 기록</title>
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style type="text/css">
		.search_box {
			max-width: 600px;
			width: 60%;
			margin: 0 auto;
		}
		#nickName {	width: 80%;	}
		#search { width: 15%; }
	</style>

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

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

<c:if test="${sessionScope.member._class ne 3}">
	<div class="container">
		<h1>경고! 비정상적인 접근입니다.</h1>
	</div>
</c:if>
		<script id="scriptSrc" type="text/javascript">

$(document).ready(function(){
	
	$(document).on('click', 'a[href="#"]', function(e){
		e.preventDefault();
	});
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	var html = "";
	var t_head = "<tr><th>NO</th><th>일시</th><th>유저번호</th><th>닉네임</th><th>카드 No.</th><th>TID</th><th>포인트</th><th>상태</th></tr>";
	
	function ajaxSubmit(nick){
		var data = {};
		data["nickName"] = nick;
		
		$.ajax({
			type: "POST"
			, url: "/log/a/charge"
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
		var result = data.list;
		
		console.log(result);
		console.log(result.length);
		
		if(result.length == 0){
			$("#his_table").remove();
			alert("기록이 없습니다.");
			return false;
		}else{
			makeHTML(result);	
		}
	}
	
	function makeHTML(json){
		html = "";
		html += t_head;
		
		for(var i=0; i < json.length; i++){
			
			var date = json[i]._DateTime;
			var userNo = json[i]._UserUniqueID;
			var nickName = json[i]._Trademark;
			var cardNo = json[i]._CardNo;
			var tid = json[i]._Tid;
			var point = json[i]._Point;
			var state = json[i]._State;
			
			html += "<tr style='border: 1px solid #ccc;'>"
				 +"<td>"+Number(i+1)+"</td>"
				 +"<td>"+date+"</td>"
				 +"<td>"+userNo+"</td>"
				 +"<td>"+nickName+"</td>"
				 +"<td>"+cardNo+"</td>"
				 +"<td>"+tid+"</td>"
				 +"<td>"+numberWithCommas(point)+"</td>"
				 +"<td>"+state+"</td>"
				 +"</tr>";
		}
		
		$("#his_table").remove();
		$(".table_con").append('<table id="his_table"></table>');
		$("#his_table").append(html);
		$("#his_table").css("max-width", "1200px").css("width", "100%").css("border", "1px solid #ccc").css("margin", "0 auto");
		$("#his_table > tr > th").css("border", "1px solid #ccc").css("text-align", "center");
		$("#his_table > tr > td").css("border", "1px solid #ccc").css("text-align", "right");
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