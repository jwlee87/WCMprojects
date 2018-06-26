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
		html, body {margin: 0; padding: 0; width: 600px;}
		section {
			width: 600px;
			background-color: #f8f8f8;
			text-align: center;
			border: 1px solid #ccc;
		}

		table { width: 600px; border-collapse: collapse; margin: 10px 0; margin-bottom: 20px;}
		table th, table td {border: 1px solid #ccc;}
		.stats {margin-bottom: 5px;}
		#clock {background-color: yellow; padding: 2px 5px; font-weight: bold;}
	</style>
</head>

<body style="width: 600px;">
	<section>
		<div class="result-box">
			<p>어제의 게임기록</p>
		</div>
		<div class="game-data">
		<table>
			<tr>
				<th>회차</th>
				<th>1등</th>
				<th>2등</th>
				<th>3등</th>
				<th>4등</th>
				<th>5등</th>
			</tr>
		</table>
		
		<a href="#up">위로</a>
		</div>
	</section>



<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="/resources/js/jquery.countdown.js"></script>
<script>
$(document).ready(function(){
	
	var resultData = '${data}';
	var result = JSON.parse(resultData);
	var result2 = result.result;
	
	var html = "";
	
	for(var i = 0; i < result2.length; i++){
		
		var winner_1;
		var winner_2;
		var winner_3;
		var winner_4;
		var winner_5;
		
		/* 좀비 리스트 */
		switch(result2[i]._WIN1){
			case -1:
				winner_1 = '준비중';
				break;
			case 1:
				winner_1 = '교통경찰';
				break;
			case 2:
				winner_1 = '군인';
				break;
			case 3:
				winner_1 = '돌쇠';
				break;
			case 4:
				winner_1 = '복서';
				break;
			case 5:
				winner_1 = '아줌마';
				break;
			case 6:
				winner_1 = '여고생';
				break;
			case 7:
				winner_1 = '요리사';
				break;
			case 8:
				winner_1 = '직장인';
				break;
			case 9:
				winner_1 = '피아니스트';
				break;
			case 10:
				winner_1 = '강시';
				break;
			case 11:
				winner_1 = '힙합맨';
				break;
			case 12:
				winner_1 = '알바생';
				break;
			case 13:
				winner_1 = '간호사';
				break;
			case 14:
				winner_1 = '의원';
				break;
			case 15:
				winner_1 = '야구선수';
				break;
			case 16:
				winner_1 = '';
				break;
			case 17:
				winner_1 = '';
				break;
			case 18:
				winner_1 = '';
				break;
			case 19:
				winner_1 = '';
				break;
			case 20:
				winner_1 = '';
				break;
		}
		switch(result2[i]._WIN2){
			case -1:
				winner_2 = '준비중';
				break;
			case 1:
				winner_2 = '교통경찰';
				break;
			case 2:
				winner_2 = '군인';
				break;
			case 3:
				winner_2 = '돌쇠';
				break;
			case 4:
				winner_2 = '복서';
				break;
			case 5:
				winner_2 = '아줌마';
				break;
			case 6:
				winner_2 = '여고생';
				break;
			case 7:
				winner_2 = '요리사';
				break;
			case 8:
				winner_2 = '직장인';
				break;
			case 9:
				winner_2 = '피아니스트';
				break;
			case 10:
				winner_2 = '강시';
				break;
			case 11:
				winner_2 = '힙합맨';
				break;
			case 12:
				winner_2 = '알바생';
				break;
			case 13:
				winner_2 = '간호사';
				break;
			case 14:
				winner_2 = '의원';
				break;
			case 15:
				winner_2 = '야구선수';
				break;
			case 16:
				winner_2 = '';
				break;
			case 17:
				winner_2 = '';
				break;
			case 18:
				winner_2 = '';
				break;
			case 19:
				winner_2 = '';
				break;
			case 20:
				winner_2 = '';
				break;
		}
		switch(result2[i]._WIN3){
			case -1:
				winner_3 = '준비중';
				break;
			case 1:
				winner_3 = '교통경찰';
				break;
			case 2:
				winner_3 = '군인';
				break;
			case 3:
				winner_3 = '돌쇠';
				break;
			case 4:
				winner_3 = '복서';
				break;
			case 5:
				winner_3 = '아줌마';
				break;
			case 6:
				winner_3 = '여고생';
				break;
			case 7:
				winner_3 = '요리사';
				break;
			case 8:
				winner_3 = '직장인';
				break;
			case 9:
				winner_3 = '피아니스트';
				break;
			case 10:
				winner_3 = '강시';
				break;
			case 11:
				winner_3 = '힙합맨';
				break;
			case 12:
				winner_3 = '알바생';
				break;
			case 13:
				winner_3 = '간호사';
				break;
			case 14:
				winner_3 = '의원';
				break;
			case 15:
				winner_3 = '야구선수';
				break;
			case 16:
				winner_3 = '';
				break;
			case 17:
				winner_3 = '';
				break;
			case 18:
				winner_3 = '';
				break;
			case 19:
				winner_3 = '';
				break;
			case 20:
				winner_3 = '';
				break;
		}
		switch(result2[i]._WIN4){
			case -1:
				winner_4 = '준비중';
				break;
			case 1:
				winner_4 = '교통경찰';
				break;
			case 2:
				winner_4 = '군인';
				break;
			case 3:
				winner_4 = '돌쇠';
				break;
			case 4:
				winner_4 = '복서';
				break;
			case 5:
				winner_4 = '아줌마';
				break;
			case 6:
				winner_4 = '여고생';
				break;
			case 7:
				winner_4 = '요리사';
				break;
			case 8:
				winner_4 = '직장인';
				break;
			case 9:
				winner_4 = '피아니스트';
				break;
			case 10:
				winner_4 = '강시';
				break;
			case 11:
				winner_4 = '힙합맨';
				break;
			case 12:
				winner_4 = '알바생';
				break;
			case 13:
				winner_4 = '간호사';
				break;
			case 14:
				winner_4 = '의원';
				break;
			case 15:
				winner_4 = '야구선수';
				break;
			case 16:
				winner_4 = '';
				break;
			case 17:
				winner_4 = '';
				break;
			case 18:
				winner_4 = '';
				break;
			case 19:
				winner_4 = '';
				break;
			case 20:
				winner_4 = '';
				break;
		}
		
		switch(result2[i]._WIN5){
			case -1:
				winner_5 = '준비중';
				break;
			case 1:
				winner_5 = '교통경찰';
				break;
			case 2:
				winner_5 = '군인';
				break;
			case 3:
				winner_5 = '돌쇠';
				break;
			case 4:
				winner_5 = '복서';
				break;
			case 5:
				winner_5 = '아줌마';
				break;
			case 6:
				winner_5 = '여고생';
				break;
			case 7:
				winner_5 = '요리사';
				break;
			case 8:
				winner_5 = '직장인';
				break;
			case 9:
				winner_5 = '피아니스트';
				break;
			case 10:
				winner_5 = '강시';
				break;
			case 11:
				winner_5 = '힙합맨';
				break;
			case 12:
				winner_5 = '알바생';
				break;
			case 13:
				winner_5 = '간호사';
				break;
			case 14:
				winner_5 = '의원';
				break;
			case 15:
				winner_5 = '야구선수';
				break;
			case 16:
				winner_5 = '';
				break;
			case 17:
				winner_5 = '';
				break;
			case 18:
				winner_5 = '';
				break;
			case 19:
				winner_5 = '';
				break;
			case 20:
				winner_5 = '';
				break;
		}
		
		html +=	'<tr>'
			+'<td>'+result2[i]._Count+'</td>'
			+'<td>'+winner_1+'</td>'
			+'<td>'+winner_2+'</td>'
			+'<td>'+winner_3+'</td>'
			+'<td>'+winner_4+'</td>'
			+'<td>'+winner_5+'</td>'
			+'</tr>';	
	}
	
	console.log(html);
	$("tbody").append(html);
	
});
</script>
</body>
</html>
