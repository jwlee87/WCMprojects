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
	
	<title>캐시비 포인트락 로그</title>
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<c:if test="${sessionScope.member._class eq 3}">
	<br><br>
	<div class="row">
		<h1 class="col-lg-10 col-sm-12" style="text-align: center; margin: 0 auto;">캐시비 포인트 락 목록</h1>
	</div>
	<div class="row">
		<hr class="col-lg-10 col-sm-12"/>
	</div>
	<br><br>
	<div class="row">
	<div class="table_con col-lg-10 col-sm-12"></div>
	</div>
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
	var t_head = "<tr><th>NO</th><th>유니크ID</th><th>일시</th><th>유저번호</th><th>닉네임</th><th>카드 No.</th><th>TID</th><th>포인트</th><th>상태</th></tr>";
	
	function getLockLog(){
		$.ajax({
			type: "POST"
			, url: "/log/a/lock"
			, dataType: "json"
		}).done(function(data){
			makeJson(data);
		});
	}
	function makeJson(data){
		var result = data.list;
		
		console.log(result);
		console.log(result.length);
		makeHTML(result);	
	}
	
	function makeHTML(json){
		html = "";
		html += t_head;
		
		$("#his_table").remove();
		if(json.length ==0){
			var html = "조회 결과가 없습니다.";
			$(".table_con").append(html);
			$(".table_con").addClass("col-lg-10").addClass("col-sm-12")
			.css("margin","0 auto");
			$(".table_con").css("text-align", "center");
		}else{
			for(var i=0; i < json.length; i++){
				
				var date = json[i]._DateTime;
				var uniqueID = json[i]._UniqueID;
				var userNo = json[i]._UserUniqueID;
				var nickName = json[i]._Trademark;
				var cardNo = json[i]._CardNo;
				var tid = json[i]._Tid;
				var point = json[i]._Point;
				var state = json[i]._State;
				
				html += "<tr style='border: 1px solid #ccc;'>"
					 +"<td>"+Number(i+1)+"</td>"
					 +"<td class='uniqueID'>"+uniqueID+"</td>"
					 +"<td>"+date+"</td>"
					 +"<td>"+userNo+"</td>"
					 +"<td>"+nickName+"</td>"
					 +"<td>"+cardNo+"</td>"
					 +"<td>"+tid+"</td>"
					 +"<td>"+numberWithCommas(point)+"</td>";
				
				if(state == 0 ){
					html += "<td><button class='checking'>확인</button></td></tr>"
				}else if(state == 1){
					html += "<td>확인완료</td></tr>";
				}
			}
			
			$(".table_con").addClass("col-lg-10").addClass("col-sm-12")
			.css("margin","0 auto");
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
	}

	getLockLog();
	
	$(document).on('click', '.checking', function(){
		
		var trNode = $(this).parent().parent();
		var data = {};
		data['uniqueID'] = $(($(trNode[0]).children())[1]).html().trim();
		
		$.ajax({
			type: "POST",
			url: "/cashbee/update/state",
			data: data,
			dataType: "json"
		}).done(function(data){
			if(data.check == 1){
				alert("정상적으로 확인되었습니다.");
			}else{
				alert("에러! 관리자에게 문의해주세요.");
			}
			getLockLog();
		})
		console.log( data['uniqueID'] );
		
	});
	
});

		</script>
	</body>
</html>