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
	<title>광고 수익금 내역</title>
	
	<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	
	<style type="text/css">
		font-family: 'Nanum Gothic', sans-serif;
		.main_con { width: 100%; margin: 0; padding: 0;}
		.info_box { min-width: 520px; max-width: 520px; height: 70px; margin: 0 auto; border: 1px solid #ccc; padding: 10px; text-align: center;}
		p {text-align: center; font-size: 1.2em; height: 19px; margin: 3px; padding: 0;}
		.btn_con { width: 100%; margin: 0 auto; text-align: center;}	
		.btn_box { width: 40%; margin: 0 auto;}
		#datatable { margin: 0 auto;}
		button { width: calc(50% - 60px); min-width: 60px; margin: 0 30px; }
		h4 {text-align: center; color: red;}
		h5 {text-align: center;}
		.chart_con {width: 100%; min-width: 520px; margin: 0 auto;}
	</style>

</head>
	<body>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="/resources/js/highcharts/highcharts.js"></script>
<script src="/resources/js/highcharts/data.js"></script>
<script src="/resources/js/highcharts/exporting.js"></script>
<script src="/resources/js/highcharts/export-data.js"></script>
<script src="/resources/js/jquery.countdown.js"></script>
	<br><br>
	<div class="chart_con">
		<h4>※환율 변동과 구글의 정책에 따라서 실제 입금금액은 오차가 있을 수 있음을 알려드립니다.※ </h4>
		<h5>업데이트는 익일 완료되며, 매 월 1일과 마지막일에는 업데이트가 조금 늦어질 수 있음을 미리 알려드립니다.</h5>
	</div>
	<br><br>
<div class="main_con">
	<div class="chart_con">
		<div id="container">
			<table id="datatable">
				<thead></thead>
				<tbody></tbody>
			</table>
		</div>
		<div id="container2"></div>
	</div>
	<div class="info_box"></div><br><br>
	<div class="btn_con">
		<div class="btn_box">
		<button id="previous_btn">지난 달</button><button id="this_btn">이번 달</button>
		</div>
	</div>
	<br><br>
	<div class="btn_con">
		<a href="http://worldspon.net">홈으로</a>
	</div>
	<br><br>
</div>

		<script type="text/javascript">

$(document).ready(function(){
	
	var monthData = '${data}';
	var thisResult = JSON.parse(monthData);
	var monthData = thisResult.result;
	var whichMonth = '${menu}';
	
	var date = new Date();
	var thisMonthLastDay = new Date(date.getFullYear(), Number(date.getMonth()+1), 0).getDate();
	var previousMonthLastDay = new Date(date.getFullYear(), Number(date.getMonth()), 0).getDate();
	
	function numberWithCommas(x) {
		return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}

	function makeHalfPieChart(paramMap){
		
		Highcharts.chart('container2', {
			chart: {
				plotBackgroundColor: null,
				plotBorderWidth: 0,
				plotShadow: false
			},
			title: {
				text: paramMap.month+'월<br>수익금<br>내역',
				align: 'center',
				verticalAlign: 'middle',
				y: 40
			},
			tooltip: {
				pointFormat: '<b>{series.name}</b>: <b>{point.percentage:.1f}%</b><br> 총 수익금: <b>'+numberWithCommas(paramMap.totalProfit)
				+'</b><br> 차감액: <b>'+numberWithCommas(paramMap.totalLose)
				+'</b><br> 순 수익금: <b>'+numberWithCommas(paramMap.netIncome)+'</b>'
			},
			plotOptions: {
				pie: {
					dataLabels: {
						enabled: true,
						distance: -50,
						style: {
							fontWeight: 'bold',
							color: 'white'
						}
					},
					startAngle: -90,
					endAngle: 90,
					center: ['50%', '75%']
				}
			},
			series: [{
				type: 'pie',
				name: '점유율',
				innerSize: '50%',
				data: [
					['순수익금', Number(paramMap.totalProfit) ],
					['차감액', Number(paramMap.totalLose) ]
				]
			}]
		});
		
		$("path.highcharts-button-symbol").css("display", "none");
		$("text.highcharts-credits").css("display","none");
	}
	
	function makeHighcharts(x){
		Highcharts.chart('container', {
			data: {
				table: 'datatable'
			},
			chart: {
				type: 'column'
			},
			title: {
				text: x+'월 광고 수익금 내역'
			},
			yAxis: {
				allowDecimals: false,
				title: {
					text: '달러'
				}
			},
			tooltip: {
				formatter: function () {
					return '<b>' + this.series.name + '</b><br/>' +
						numberWithCommas(this.point.y) + ' ' + this.point.name.toLowerCase();
				}
			}
		});
		
		$("path.highcharts-button-symbol").css("display","none");
		$("text.highcharts-credits").css("display","none");
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////
	
	function loadData(data){
		var data = data;
		var totalLose = 0;
		var totalProfit = 0;
		
		if(data.length == 1 ){
			
			var dayProfits = {}
			dayProfits['day1'] = data[0]._01DAY;
			dayProfits['day2'] = data[0]._02DAY;
			dayProfits['day3'] = data[0]._03DAY;
			dayProfits['day4'] = data[0]._04DAY;
			dayProfits['day5'] = data[0]._05DAY;
			dayProfits['day6'] = data[0]._06DAY;
			dayProfits['day7'] = data[0]._07DAY;
			dayProfits['day8'] = data[0]._08DAY;
			dayProfits['day9'] = data[0]._09DAY;
			dayProfits['day10'] = data[0]._10DAY;
			dayProfits['day11'] = data[0]._11DAY;
			dayProfits['day12'] = data[0]._12DAY;
			dayProfits['day13'] = data[0]._13DAY;
			dayProfits['day14'] = data[0]._14DAY;
			dayProfits['day15'] = data[0]._15DAY;
			dayProfits['day16'] = data[0]._16DAY;
			dayProfits['day17'] = data[0]._17DAY;
			dayProfits['day18'] = data[0]._18DAY;
			dayProfits['day19'] = data[0]._19DAY;
			dayProfits['day20'] = data[0]._20DAY;
			dayProfits['day21'] = data[0]._21DAY;
			dayProfits['day22'] = data[0]._22DAY;
			dayProfits['day23'] = data[0]._23DAY;
			dayProfits['day24'] = data[0]._24DAY;
			dayProfits['day25'] = data[0]._25DAY;
			dayProfits['day26'] = data[0]._26DAY;
			dayProfits['day27'] = data[0]._27DAY;
			dayProfits['day28'] = data[0]._28DAY;
			dayProfits['day29'] = data[0]._29DAY;
			dayProfits['day30'] = data[0]._30DAY;
			dayProfits['day31'] = data[0]._31DAY;
			
// 			dayProfits['aDay1'] = data[0]._01DAY_A1;
// 			dayProfits['aDay2'] = data[0]._02DAY_A1;
// 			dayProfits['aDay3'] = data[0]._03DAY_A1;
// 			dayProfits['aDay4'] = data[0]._04DAY_A1;
// 			dayProfits['aDay5'] = data[0]._05DAY_A1;
// 			dayProfits['aDay6'] = data[0]._06DAY_A1;
// 			dayProfits['aDay7'] = data[0]._07DAY_A1;
// 			dayProfits['aDay8'] = data[0]._08DAY_A1;
// 			dayProfits['aDay9'] = data[0]._09DAY_A1;
// 			dayProfits['aDay10'] = data[0]._10DAY_A1;
// 			dayProfits['aDay11'] = data[0]._11DAY_A1;
// 			dayProfits['aDay12'] = data[0]._12DAY_A1;
// 			dayProfits['aDay13'] = data[0]._13DAY_A1;
// 			dayProfits['aDay14'] = data[0]._14DAY_A1;
// 			dayProfits['aDay15'] = data[0]._15DAY_A1;
// 			dayProfits['aDay16'] = data[0]._16DAY_A1;
// 			dayProfits['aDay17'] = data[0]._17DAY_A1;
// 			dayProfits['aDay18'] = data[0]._18DAY_A1;
// 			dayProfits['aDay19'] = data[0]._19DAY_A1;
// 			dayProfits['aDay20'] = data[0]._20DAY_A1;
// 			dayProfits['aDay21'] = data[0]._21DAY_A1;
// 			dayProfits['aDay22'] = data[0]._22DAY_A1;
// 			dayProfits['aDay23'] = data[0]._23DAY_A1;
// 			dayProfits['aDay24'] = data[0]._24DAY_A1;
// 			dayProfits['aDay25'] = data[0]._25DAY_A1;
// 			dayProfits['aDay26'] = data[0]._26DAY_A1;
// 			dayProfits['aDay27'] = data[0]._27DAY_A1;
// 			dayProfits['aDay28'] = data[0]._28DAY_A1;
// 			dayProfits['aDay29'] = data[0]._29DAY_A1;
// 			dayProfits['aDay30'] = data[0]._30DAY_A1;
// 			dayProfits['aDay31'] = data[0]._31DAY_A1;
			
			for(var i = 1; i <= 31; i++){
				totalProfit += dayProfits['day'+i];
			}
			totalProfit = parseFloat(totalProfit).toFixed(2);
			
			if(whichMonth == 'cm'){
				var thead = "<tr>"
					 + "<th></th>"
					 + "<th>수익금</th>"
					 + "</tr>";	
			}else if(whichMonth == 'pm'){
				var thead = "<tr>"
					 + "<th></th>"
					 + "<th>수익금</th>"
// 					 + "<th>무효클릭 차감액</th>"
					 + "</tr>";	
			}
		
			$("#datatable > thead").append(thead);
			
			var count = "";
			var tbody = "";

			if(whichMonth == 'cm'){
				
				for(var i = 1; i <= previousMonthLastDay; i++){
					if(dayProfits["day"+i] == 0){
						break;
					}else{
						tbody += "<tr>"
							+ "<th>"+i+"일</th>"
							+ "<td>"+dayProfits["day"+i]+"</td>"
							+ "</tr>"
					}
				}
			}else if(whichMonth == 'pm'){
				
				var dayLose = {};
				dayLose['day1'] = data[0]._01NULLITY;
				dayLose['day2'] = data[0]._02NULLITY;
				dayLose['day3'] = data[0]._03NULLITY;
				dayLose['day4'] = data[0]._04NULLITY;
				dayLose['day5'] = data[0]._05NULLITY;
				dayLose['day6'] = data[0]._06NULLITY;
				dayLose['day7'] = data[0]._07NULLITY;
				dayLose['day8'] = data[0]._08NULLITY;
				dayLose['day9'] = data[0]._09NULLITY;
				dayLose['day10'] = data[0]._10NULLITY;
				dayLose['day11'] = data[0]._11NULLITY;
				dayLose['day12'] = data[0]._12NULLITY;
				dayLose['day13'] = data[0]._13NULLITY;
				dayLose['day14'] = data[0]._14NULLITY;
				dayLose['day15'] = data[0]._15NULLITY;
				dayLose['day16'] = data[0]._16NULLITY;
				dayLose['day17'] = data[0]._17NULLITY;
				dayLose['day18'] = data[0]._18NULLITY;
				dayLose['day19'] = data[0]._19NULLITY;
				dayLose['day20'] = data[0]._20NULLITY;
				dayLose['day21'] = data[0]._21NULLITY;
				dayLose['day22'] = data[0]._22NULLITY;
				dayLose['day23'] = data[0]._23NULLITY;
				dayLose['day24'] = data[0]._24NULLITY;
				dayLose['day25'] = data[0]._25NULLITY;
				dayLose['day26'] = data[0]._26NULLITY;
				dayLose['day27'] = data[0]._27NULLITY;
				dayLose['day28'] = data[0]._28NULLITY;
				dayLose['day29'] = data[0]._29NULLITY;
				dayLose['day30'] = data[0]._30NULLITY;
				dayLose['day31'] = data[0]._31NULLITY;
				
				
				for(var i = 1; i <= 31; i++){
					totalLose += dayLose['day'+i];
				}
				totalLose = parseFloat(totalLose).toFixed(2);
				
				for(var i = 1; i <= previousMonthLastDay; i++){
					if(dayProfits["day"+i] == 0){
						break;
					}else{
						tbody += "<tr>"
							+ "<th>"+i+"일</th>"
							+ "<td>"+dayProfits["day"+i]+"</td>"
// 							+ "<td>"+dayLose["day"+i]+"</td>"
							+ "</tr>"
					}
				}
			}
			
			$("#datatable > tbody").append(tbody);
			
			if(whichMonth == 'pm'){
				
				var paramMap = {}
				
				if(Number(date.getMonth()) == 0){
					paramMap['month'] = 12;
				}else{
					paramMap['month'] = Number(date.getMonth());
				}
				paramMap['totalProfit'] = totalProfit;
				paramMap['totalLose'] = totalLose;
				paramMap['netIncome'] = parseFloat(Number(totalProfit) - Number(totalLose)).toFixed(2);
				
				var profitAmoutText = "<table style='margin: 0 auto; width: 500px;'>"
					+ "<tr><th>총 수익금</th><th>총 차감액</th><th>순 수익금</th></tr>"
					+ "<tr><td>"+numberWithCommas(paramMap.totalProfit)+" <b>달러</b></td>"
					+ "<td>"+numberWithCommas(paramMap.totalLose)+" <b>달러</b></td>"
					+ "<td>"+numberWithCommas(paramMap.netIncome)+" <b>달러</b></td></tr></table>";
				
				makeHighcharts(paramMap['month']);
				makeHalfPieChart(paramMap);
				$(".info_box").append(profitAmoutText);
				$("th").css("text-align", "center");
				$("td").css("padding", "10px");
				$("td").css("text-align", "center");
				
			}else if(whichMonth == 'cm'){
				
				makeHighcharts(Number(date.getMonth()+1));

				var profitAmoutText = "<table style='margin: 0 auto; width: 500px;'>"
					+ "<tr><th>이번달 누적 수익금</th></tr>"
					+ "<tr><td>"+numberWithCommas(totalProfit)+" <b>달러</b></td></tr></table>";
				
				$(".info_box").append(profitAmoutText);
				$("th").css("text-align", "center");
				$("td").css("padding", "10px");
				$("td").css("text-align", "center");
			}
			
		}else{
			alert("데이터가 잘못되었습니다.");
		}
	}
	
	loadData(monthData);
	
	$("#this_btn").on("click", function(){
		location.href="/benefit/data/cm";
	});
	$("#previous_btn").on("click", function(){
		location.href="/benefit/data/pm";
	});
	
	$("#home_btn").on("click", function(){
		location.href="http://worldspon.net";
	});

});
		</script>
	</body>
</html>