<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html id="up">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	
	<title> 나의 배팅 내역 </title>
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<style>
		font-family: 'Nanum Gothic', sans-serif;
		html, body {width: 800px; margin: 0; padding: 0;}
		section {
			width: 800px;
/* 			background-color: #f8f8f8; */
			text-align: center;
			margin: 10vh auto;
/* 			border: 1px solid #ccc; */
		}

		table { width: 100%; border-collapse: collapse; margin: 10px 0; margin-bottom: 20px;}
		table th, table td {border: 1px solid #ccc; text-align: center; padding: 5px; font-size: 12px;}
		table th {font-size: 10px;}
		table th:nth-child(1) {width: 10%;}
		.stats {margin-bottom: 5px;}
		#clock {background-color: yellow; padding: 2px 5px; font-weight: bold;}
		
		.jw-bold {font-size: 12px; font-weight: bold;}
		.jw-red {background-color: red;}
		.jw-green {background-color: green;}
		.jw-green2 {background-color: #82E0AA;}
		.jw-green3 {background-color: #D4EFDF;}
		.jw-yellow {background-color: #F9E79F;}
		.jw-gray {background-color: #CCD1D1;}
	</style>

</head>
<body>
	<section>
		<div class="result-box">
			<p>약 2일간의 나의 배팅 내역이 공개됩니다.</p>
		</div>
		<div class="game-data">
		
		<table id="table">
		</table>
		
		<a href="#up">위로</a>
		</div>
	</section>


<script>

$(document).ready(function(){
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	
	var resultData = '${data}';
	var result = JSON.parse(resultData);
	var result2 = result.result;
	
	var html = "";
	
	if(result.gameName == 'fight'){
		
		html += '<tr><th>일시</th>'
			+'<th>회차</th>'
			+'<th>내가 건 좀비</th>'
			+'<th>KO 옵션</th>'
			+'<th>배팅 전 게임머니</th>'
			+'<th>배팅쿠폰</th>'
			+'<th>배팅 후 게임머니</th>'
			+'<th>당첨 게임머니</th>'
			+'<th>당첨 랭킹점수</th>'
			+'<th>당첨 스폰</th>'
			+'<th>결과</th>'
			+'<th>총 게임머니</th>'
			+'</tr>';
		
		for(var i = 0 ; i < result2.length ; i++){
			var entry_1;
			var ko_check;
			var result;
			var beforeGM = numberWithCommas(result2[i]._B_GMoney);
			var nowGM = numberWithCommas(result2[i]._N_GMoney);
			var resultGM = numberWithCommas(result2[i]._Result_GMoney);
			var resultRP = numberWithCommas(result2[i]._Result_RankValue);
			var total = numberWithCommas(result2[i]._A_GMoney);
			
			switch(result2[i]._BetZombiUniqueID){
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
			
			switch(result2[i]._KoWin){
				case 0:
					ko_check = '선택X';
					break;
				case 1:
					ko_check = 'KO승';
					break;
				case 2:
					ko_check = '판정승';
					break;
			}

			switch(result2[i]._WinLose) {
				case 0:
					result = '기록없음';
					break;
				case 1:
					result = '당첨';
					break;
				case 2:
					result = '실패';
					break;
			}
			
			html += '<tr>'
				+'<td class="jw-bold">'+result2[i]._DateTime+'</td>'
				+'<td>'+result2[i]._GameCount+'</td>'
				+'<td>'+entry_1+'</td>'
				+'<td>'+ko_check+'</td>'
				+'<td>'+beforeGM+'</td>'
				+'<td>'+result2[i]._Coupon+'개</td>'
				+'<td>'+nowGM+'</td>'
				+'<td class="jw-yellow">'+resultGM+'</td>'
				+'<td class="jw-yellow">'+resultRP+'점</td>'
				+'<td>'+result2[i]._CoinGain+'개</td>';
				if(result == '당첨'){
					html += '<td class="jw-bold jw-green">'+result+'</td>';
				}else{
					html += '<td class="jw-bold jw-red">'+result+'</td>';
				}
				html += '<td>'+total+'</td></tr>';
		}
	}else if(result.gameName == 'run'){
		html += '<tr><th>일시</th>'
			+'<th>회차</th>'
			+'<th>내가 건 좀비</th>'
			+'<th>배팅 전 게임머니</th>'
			+'<th class="jw-bold">배팅쿠폰</th>'
			+'<th>배팅 후 게임머니</th>'
			+'<th>당첨 게임머니</th>'
			+'<th>당첨 랭킹점수</th>'
			+'<th>결과</th>'
			+'<th>총 게임머니</th>'
			+'</tr>'
			
		for(var i = 0 ; i < result2.length ; i++){
			
			var zombie;
			var result;
			var beforeGM = numberWithCommas(result2[i]._B_GMoney);
			var nowGM = numberWithCommas(result2[i]._N_GMoney);
			var resultGM = numberWithCommas(result2[i]._Result_GMoney);
			var resultRP = numberWithCommas(result2[i]._Result_RankValue);
			var total = numberWithCommas(result2[i]._A_GMoney);
				
			switch(result2[i]._BetZombiUniqueID){
				case -1:
					zombie = '준비중';
					break;
				case 1:
					zombie = '교통경찰';
					break;
				case 2:
					zombie = '군인';
					break;
				case 3:
					zombie = '돌쇠';
					break;
				case 4:
					zombie = '복서';
					break;
				case 5:
					zombie = '아줌마';
					break;
				case 6:
					zombie = '여고생';
					break;
				case 7:
					zombie = '요리사';
					break;
				case 8:
					zombie = '직장인';
					break;
				case 9:
					zombie = '피아니스트';
					break;
				case 10:
					zombie = '강시';
					break;
				case 11:
					zombie = '힙합맨';
					break;
				case 12:
					zombie = '알바생';
					break;
				case 13:
					zombie = '간호사';
					break;
				case 14:
					zombie = '의원';
					break;
				case 15:
					zombie = '야구선수';
					break;
				case 16:
					zombie = '';
					break;
				case 17:
					zombie = '';
					break;
				case 18:
					zombie = '';
					break;
				case 19:
					zombie = '';
					break;
				case 20:
					zombie = '';
					break;
			}
			
			switch(result2[i]._Result) {
				case 0:
					result = '기록없음';
					break;
				case 1:
					result = '1등';
					break;
				case 2:
					result = '2등';
					break;
				case 3:
					result = '3등';
					break;
				case 4:
					result = '4등';
					break;
				case 5:
					result = '5등';
					break;
			}
			
			html += '<tr>'
				+'<td class="jw-bold">'+result2[i]._DateTime+'</td>'
				+'<td>'+result2[i]._GameCount+'</td>'
				+'<td>'+zombie+'</td>'
				+'<td>'+beforeGM+'</td>'
				+'<td>'+result2[i]._Coupon+'개</td>'
				+'<td>'+nowGM+'</td>'
				+'<td class="jw-yellow">'+resultGM+'</td>'
				+'<td class="jw-yellow">'+resultRP+'점</td>';
				if(result == '1등'){
					html += '<td class="jw-bold jw-green">'+result+'</td>';
				}else if(result == '2등'){
					html += '<td class="jw-bold jw-green2">'+result+'</td>';
				}else if(result == '3등'){
					html += '<td class="jw-bold jw-green3">'+result+'</td>';
				}else if(result == '4등'){
					html += '<td class="jw-bold jw-red">'+result+'</td>';
				}else if(result == '5등'){
					html += '<td class="jw-bold jw-red">'+result+'</td>';
				}else{
					html += '<td>'+result+'</td>';
				}
			html += '<td>'+total+'</td></tr>';
		}
	}else if(result.gameName == 'break'){
		html += '<tr><th>일시</th>'
			+'<th>회차</th>'
			+'<th>내가 건 좀비</th>'
			+'<th>배팅 전 게임머니</th>'
			+'<th class="jw-blod">배팅쿠폰</th>'
			+'<th>배팅 후 게임머니</th>'
			+'<th>당첨 게임머니</th>'
			+'<th>당첨 랭킹점수</th>'
			+'<th>결과</th>'
			+'<th>총 게임머니</th>'
			+'</tr>'
		for(var i = 0 ; i < result2.length ; i++){
			
			var zombie;
			var result;
			var beforeGM = numberWithCommas(result2[i]._B_GMoney);
			var nowGM = numberWithCommas(result2[i]._N_GMoney);
			var resultGM = numberWithCommas(result2[i]._Result_GMoney);
			var resultRP = numberWithCommas(result2[i]._Result_RankValue);
			var total = numberWithCommas(result2[i]._A_GMoney);
				
			switch(result2[i]._BetZombiUniqueID){
				case -1:
					zombie = '준비중';
					break;
				case 1:
					zombie = '교통경찰';
					break;
				case 2:
					zombie = '군인';
					break;
				case 3:
					zombie = '돌쇠';
					break;
				case 4:
					zombie = '복서';
					break;
				case 5:
					zombie = '아줌마';
					break;
				case 6:
					zombie = '여고생';
					break;
				case 7:
					zombie = '요리사';
					break;
				case 8:
					zombie = '직장인';
					break;
				case 9:
					zombie = '피아니스트';
					break;
				case 10:
					zombie = '강시';
					break;
				case 11:
					zombie = '힙합맨';
					break;
				case 12:
					zombie = '알바생';
					break;
				case 13:
					zombie = '간호사';
					break;
				case 14:
					zombie = '의원';
					break;
				case 15:
					zombie = '야구선수';
					break;
				case 16:
					zombie = '';
					break;
				case 17:
					zombie = '';
					break;
				case 18:
					zombie = '';
					break;
				case 19:
					zombie = '';
					break;
				case 20:
					zombie = '';
					break;
			}
			
			switch(result2[i]._Result) {
				case 0:
					result = '기록없음';
					break;
				case 1:
					result = '승리';
					break;
				case 2:
					result = '패배';
					break;
				case 3:
					result = '무승부';
					break;
			}
			
			html += '<tr>'
				+'<td class="jw-bold">'+result2[i]._DateTime+'</td>'
				+'<td>'+result2[i]._GameCount+'</td>'
				+'<td>'+zombie+'</td>'
				+'<td>'+beforeGM+'</td>'
				+'<td>'+result2[i]._Coupon+'개</td>'
				+'<td>'+nowGM+'</td>'
				+'<td class="jw-yellow">'+resultGM+'</td>'
				+'<td class="jw-yellow">'+resultRP+'점</td>';
				if(result == '승리'){
					html += '<td class="jw-bold jw-green">'+result+'</td>';
				}else if(result == '패배'){
					html += '<td class="jw-bold jw-red">'+result+'</td>';
				}else if(result == '무승부'){
					html += '<td class="jw-bold jw-gray">'+result+'</td>';
				}else{
					html += '<td>'+result+'</td>';
				}
			html += '<td>'+total+'</td></tr>';
		}
	}
	
	$("#table").append(html);

});
</script>
</body>
</html>