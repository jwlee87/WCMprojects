<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <title> WORLDSPON My Assets</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1,
        maximum-scale=1, user-scalable=no">
	    <meta name="description" content="Free Reward App, Free Android App" />
	    <meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	    <meta name="author" content="WorldSpon, Inc." />
	
	    <link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	    <link rel="icon" href="/info/img/favicon/ws_p16.png" sizes="16x16">
	    <link rel="icon" href="/info/img/favicon/ws_p32.png" sizes="32x32">
        
        <link rel="stylesheet" href="/myAssets/css/font.css">
        <link rel="stylesheet" href="/myAssets/css/grid.css">
        <link rel="stylesheet" href="/myAssets/css/aminate.css">
        <link rel="stylesheet" href="/myAssets/css/bootstrap.min.css">
        
        <link rel="stylesheet" href="/myAssets/css/loader.css">
        
        <style>
            
            body { font-family: NanumSquareR sans-serif; }            
            a { color: #000000;}
            a:hover {text-decoration: none;}
            .row {
                margin: 0;
            }
            
            .container-fluid {
                background-color: #4833a4;
                margin: 0;
                padding: 4%;
            }
            .info-box {
                padding-top: 5vw;
                padding-bottom: 5vw;
                border-bottom: 1px solid #cccccc;
            }
            .assets-name {
                font-size: 4vw;
            }
            .assets-amount {
                font-size: 4.3vw;
            }
            .top-box-title {
                font-size: 4vw;
            }
            .title-amount {
            	margin-bottom: 2vw;
            }
            .title_nick {
            	margin-top: 4vw;
            }
            
        </style>
        
    </head>
    <body>
    	<div class="lds-back"></div>
        <div class="lds-ring"><div></div><div></div><div></div><div></div></div>
        
    <!-- jQuery -->
	<script src="/myAssets/js/jquery.min.js"></script>
	<!-- Bootstrap -->
	<script src="/myAssets/js/bootstrap.min.js"></script>
	<!-- Main -->
	<script src="/myAssets/js/main.js"></script>
	
	<script>
	function makeHTML(data){
		
		console.log(data.list);
		
		var no = data.list[0].no;
		var uNo = data.list[0].uNo;
		var nick = data.list[0]._Trademark;
		var coin = data.list[0]._Coin;
		var point = data.list[0]._Point;
		var l_coin = data.list[0]._LockCoin;
		var l_point = data.list[0]._LockPoint;
		
		var html = "<input id='no' type='hidden' value='"+no+"'/>";
		html += "<input id='uNo' type='hidden' value='"+uNo+"'/>";
		html += "<div class='container-fluid'>"
				  + "<div class='contents_1'>"
                       + "<div class='row main-title font-color-white'>"
                         + "<div class='title_nick more_bigger_normal_font_size bold'>"+nick
                           + "<span class='normal_font_size'> 님의 자산</span></div>"
                         + "</div>"
                         + "<div class='row blank_height_3'></div>"
                         + "<div class='row blank_height_1'></div>"
                         + "<div class='row normal_font_size bold'>"
                           + "<div class='col-12 no-double'>"
                             + "<div class='top-box-title font-color-ccc'>스폰</div>"
                             + "<div class='title-amount font-color-white'>"+numberWithCommas(Number(coin+l_coin))+" 개</div>"
                           + "</div>"
                         + " <div class='col-12 text-left no-double'>"
                           + "<div class='top-box-title font-color-ccc'>포인트</div>"
                           + "<div class='title-amount font-color-white'>"+numberWithCommas(Number(point+l_point))+" 원</div>"
                         + "</div>"
                       + "</div>"
                       + "<div class='row blank_height_1'></div>"
//                        + "<div class='row'>"
//                          + "<div class='no-double col-12 more_smaller_size bolder font-color-ccc'>나의 지분율</div>"
//                          + "<div lass='no-double col-12 more_smaller_size bold font-color-white'>0.1234567890%</div>"
//                        + "</div>"
				  + "</div>"
				+ "</div>"
				+ "<div class='info-box container-fluid bg-white'>"
				  + "<div class='assets-name font-color-gray bold'>스폰</div>"
				  + "<div class='assets-amount con-spon bold'><a href='/myAssets/detail?t=s&no"+no+"&uNo="+uNo+"'>" +numberWithCommas(coin)+ " &nbsp;&nbsp;></a></div>"
				+ "</div>"
				+ "<div class='info-box container-fluid bg-white'>"
				  +"<div class='assets-name font-color-gray bold'>포인트</div>"
				  + "<div class='assets-amount con-spon bold'><a href='/myAssets/detail?t=p&no"+no+"&uNo="+uNo+"'> "+numberWithCommas(point)+" &nbsp;&nbsp;></a></div>"
				+ "</div>"
				+ "<div class='info-box container-fluid bg-white'>"
				  + "<div class='assets-name font-color-gray bold'>락스폰</div>"
				  + "<div class='assets-amount con-spon bold'><a href='/myAssets/detail?t=ls&no"+no+"&uNo="+uNo+"'>" +numberWithCommas(l_coin)+ " &nbsp;&nbsp;></a></div>"
				+ "</div>";
				if(l_point != 0){
					html += "<div class='info-box container-fluid bg-white'>"
					  + "<div class='assets-name font-color-gray bold'>락포인트</div>"
					  + "<div class='assets-amount con-spon bold'><a href='/myAssets/detail?t=lp&no"+no+"&uNo="+uNo+"'>" +l_point+ " &nbsp;&nbsp;></a></div>"
					+ "</div>";
				}
				
		$("html").append(html);
		hideLoader();
	}
	
	$(document).ready(function(){
		
		var data = '${data}';
		var jsonData = JSON.parse(data);
		console.log("data: "+data);
		console.log("jsonData: "+jsonData);
		console.log("jsonData.no: "+jsonData.no);
		console.log("jsonData.uNo: "+jsonData.uNo);
		
		$.ajax({
			type: "POST"
			, url: "/myAssets/get"
			, data: jsonData
			, dataType: "json"
			, beforeSend : function(){
				showLoader();	
			}
		}).done(function(data){
			makeHTML(data);
		});
		
	});
	</script>
</body>
</html>