<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html id="up">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	
	<title> 게임 결과 </title>
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<style>
		font-family: 'Nanum Gothic', sans-serif;
		html, body {margin: 0; padding: 0;}
		section {
			width: 600px;
			background-color: #f8f8f8;
			text-align: center;
			margin: 10vh auto;
			border: 1px solid #ccc;
		}

		table { width: 80%; border-collapse: collapse; margin: 10px auto; margin-bottom: 20px;}
		table th, table td {border: 1px solid #ccc; text-align: center;}
		.stats {margin-bottom: 5px;}
		#clock {background-color: yellow; padding: 2px 5px; font-weight: bold;}
		
		.jw-green {font-weight: bold;}
	</style>
</head>

<body>
	<section>
		<div class="result-box">
			<p>매 5분마다 결과가 공개됩니다.</p>
			<p>게임결과가 먼저 공개되는것을 방지하고자 실제 게임과는 10초 정도의 오차가 있습니다.</p>
			<p>결과가 보이지 않을시 새로고침(F5)을 눌러주세요.</p>
			<button class="stats">어제 결과</button>
			<div class="countdown">
				<span id="clock"></span>
			</div>
		</div>
		<div class="game-data">
		<table>
			<tr>
				<th>회차</th>
				<th>왼쪽코너</th>
				<th>오른쪽코너</th>
				<th>승자</th>
<!-- 				<th>패자</th> -->
				<th>KO여부</th>
			</tr>
		</table>
		
		<a href="#up">위로</a>
		</div>
	</section>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/resources/js/jquery.countdown.js"></script>
<script>
$(document).ready(function(){
	
	var date = new Date();
	var m = date.getMinutes();
	var targetMin = "";
	var targetHour = date.getHours();
	
	switch(m%5) {
		case 0: 
			targetMin = 5;
			break;
		case 1: 
			targetMin = 4;
			break;
		case 2: 
			targetMin = 3;
			break;
		case 3: 
			targetMin = 2;
			break;
		case 4: 
			targetMin = 1;
			break;
	}
	var final_min = Number(m+targetMin);
	if(final_min >= 60){
		final_min = final_min - 60;
		final_min = "0"+final_min;
		targetHour = targetHour + 1;
	}
	
// 	console.log("final_min check= "+final_min);
	
	var nowTime = date.getFullYear()+"/"+Number(date.getMonth()+1)+"/"+date.getDate()+" "+targetHour+":"+final_min+":55";
// 	console.log(nowTime);
	
	$('#clock').countdown(nowTime)
		.on('update.countdown', function(event) {
			var format = '%M:%S';
			if(event.offset.totalDays > 0) {
				format = '%-d day%!d ' + format;
			}
			if(event.offset.weeks > 0) {
				format = '%-w week%!w ' + format;
			}
			$(this).html(event.strftime(format));
	}).on('finish.countdown', function(event) {
		location.reload();
	});
	
	
	var w = 610;
	var h = 800;
	var p_left = (window.screen.width/2)-(w/2);
	var p_top = (window.screen.height/2)-(h/2);
	
	$(".stats").on("click", function(){
		var win = window.open("../fight/yList", "게임통계", 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,copyhistory=no,width='+w+',height='+h);
		win.moveTo(p_left, p_top);
	});
	
	var resultData = '${data}';
	var result = JSON.parse(resultData);
	var result2 = result.result;
	
// 	console.log(result2);
	
	var html = "";
	
	for(var i = 0; i < result2.length; i++){
		
		var entry_1;
		var entry_2;
		var winner;
		var loser;
		var ko_check;
		
		/* 좀비 리스트 */
		switch(result2[i]._Exhibition1){
			case -1:
				entry_1 = '준비중';
				break;
			case 1:
				entry_1 = '교통경찰';
				break;
			case 2:
				entry_1 = '군인';
				break;
			case 3:
				entry_1 = '돌쇠';
				break;
			case 4:
				entry_1 = '복서';
				break;
			case 5:
				entry_1 = '아줌마';
				break;
			case 6:
				entry_1 = '여고생';
				break;
			case 7:
				entry_1 = '요리사';
				break;
			case 8:
				entry_1 = '직장인';
				break;
			case 9:
				entry_1 = '피아니스트';
				break;
			case 10:
				entry_1 = '강시';
				break;
			case 11:
				entry_1 = '힙합맨';
				break;
			case 12:
				entry_1 = '알바생';
				break;
			case 13:
				entry_1 = '간호사';
				break;
			case 14:
				entry_1 = '의원';
				break;
			case 15:
				entry_1 = '야구선수';
				break;
			case 16:
				entry_1 = '';
				break;
			case 17:
				entry_1 = '';
				break;
			case 18:
				entry_1 = '';
				break;
			case 19:
				entry_1 = '';
				break;
			case 20:
				entry_1 = '';
				break;
		}
		switch(result2[i]._Exhibition2){
			case -1:
				entry_2 = '준비중';
				break;
			case 1:
				entry_2 = '교통경찰';
				break;
			case 2:
				entry_2 = '군인';
				break;
			case 3:
				entry_2 = '돌쇠';
				break;
			case 4:
				entry_2 = '복서';
				break;
			case 5:
				entry_2 = '아줌마';
				break;
			case 6:
				entry_2 = '여고생';
				break;
			case 7:
				entry_2 = '요리사';
				break;
			case 8:
				entry_2 = '직장인';
				break;
			case 9:
				entry_2 = '피아니스트';
				break;
			case 10:
				entry_2 = '강시';
				break;
			case 11:
				entry_2 = '힙합맨';
				break;
			case 12:
				entry_2 = '알바생';
				break;
			case 13:
				entry_2 = '간호사';
				break;
			case 14:
				entry_2 = '의원';
				break;
			case 15:
				entry_2 = '야구선수';
				break;
			case 16:
				entry_2 = '';
				break;
			case 17:
				entry_2 = '';
				break;
			case 18:
				entry_2 = '';
				break;
			case 19:
				entry_2 = '';
				break;
			case 20:
				entry_2 = '';
				break;
		}
		
		switch(result2[i]._WinLose){
			case -1:
				winner = '준비중';
				loser = '준비중';
				ko_check = '-';
				break;
				
			case 1:
				winner = entry_1;
				loser = entry_2;
				ko_check = '판정승';
				break;
				
			case 2:
				winner = entry_2;
				loser = entry_1;
				ko_check = '판정승';
				break;
				
			case 21:
				winner = entry_1;
				loser = entry_2;
				ko_check = '판정승';
				break;
			case 11:
				winner = entry_1;
				loser = entry_2;
				ko_check = 'KO승';
				break;
			case 22:
				winner = entry_2;
				loser = entry_1;
				ko_check = '판정승';
				break;
			case 12:
				winner = entry_2;
				loser = entry_1;
				ko_check = 'KO승';
				break;
		}
		
		html +=	'<tr>'
			+'<td>'+result2[i]._Count+'</td>'
			+'<td class="entry_1">'+entry_1+'</td>'
			+'<td class="entry_2">'+entry_2+'</td>';
		if(winner == '준비중'){
			html += '<td class="jw-green">'+winner+'</td>';				
		}else{
			html += '<td>'+winner+'</td>';				
		}
		if(ko_check == 'KO승'){
			html += '<td class="jw-green">'+ko_check+'</td></tr>';
		}else if(ko_check == '판정승'){
			html += '<td class="jw-red">'+ko_check+'</td></tr>';
		}else{
			html += '<td class="jw-ready">'+ko_check+'</td></tr>';
		}
	}
	
// 	console.log(html);
	$("tbody").append(html);
	
});
</script>
</body>
</html>
