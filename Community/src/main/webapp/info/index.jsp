<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html class="no-js">
	<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>WorldSpon &mdash; Free Reward App, Free Android App</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="Free Reward App, Free Android App" />
	<meta name="keywords" content="worldspon, WorldSpon, 월드스폰" />
	<meta name="author" content="WorldSpon, Inc." />
	
	<link rel='shortcut icon' href='/info/img/favicon/ws_p32.png'>
	<link rel="icon" href="/info/img/favicon/ws_p16.png" sizes="16x16">
	<link rel="icon" href="/info/img/favicon/ws_p32.png" sizes="32x32">
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	
	<!-- Animate.css -->
	<link rel="stylesheet" href="/info/css/animate.css">
	<!-- Icomoon Icon Fonts-->
	<link rel="stylesheet" href="/info/css/icomoon.css">
	<!-- Simple Line Icons -->
	<link rel="stylesheet" href="/info/css/simple-line-icons.css">
	<!-- Owl Carousel -->
	<link rel="stylesheet" href="/info/css/owl.carousel.min.css">
	<link rel="stylesheet" href="/info/css/owl.theme.default.min.css">
	<!-- Bootstrap  -->
	<link rel="stylesheet" href="/info/css/bootstrap.css">

	<link rel="stylesheet" href="/info/css/style.css">

	<!-- Modernizr JS -->
	<script src="/info/js/modernizr-2.6.2.min.js"></script>
	<!-- FOR IE9 below -->
	<!--[if lt IE 9]>
	<script src="js/respond.min.js"></script>
	<![endif]-->

	<style>
		#main_popup {
			background-color: white;
			border: 2px solid black;
		}
		.popup_bottom {
			font-weight: bold;
		}
		.popup_bottom > a {
			color: black;
			margin: 2px;
		}
	
	</style>
	
	
	</head>
	<body>
	<header role="banner" id="yizi-header">
			<div class="container">
				<!-- <div class="row"> -->
			    <nav class="navbar navbar-default">
		        <div class="navbar-header">
		        	<!-- Mobile Toggle Menu Button -->
					<a href="#" class="js-fh5co-nav-toggle fh5co-nav-toggle" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"><i></i></a>
		          	<a class="navbar-brand" href="http://worldspon.net/info" style="color: #14d85c;"><b>WORLDSPON Inc.</b></a> 
		        </div>
		        <div id="navbar" class="navbar-collapse collapse">
		          <ul class="nav navbar-nav navbar-right">
<!-- 		            <li class="navbar-home active"><a href="#" data-nav-section="home"><span>Home</span></a></li> -->
		            <li><a href="#" data-nav-section="aboutWS"><span>About</span></a></li>
				    <li><a href="#" data-nav-section="features"><span>Features</span></a></li>
					<li class="navbar-contact"><a  href="#" data-nav-section="contact"><span>Contact</span></a></li>
		          </ul>
		        </div>
			    </nav>
			  <!-- </div> -->
		  </div>
	</header>

	
    <div class="owl-carousel owl-carousel-main owl-carousel-fullwidth">
	    <!-- You may change the background color here. -->
        <div class="item" style="background: #493869">
		    <div class="container" style="position: relative;">
		        <div class="row animate-box" data-animate-effect="fadeIn">
				    <div class="col-md-7 col-sm-7">
                        <div class="fh5co-owl-text-wrap">
						    <div class="fh5co-owl-text">
						        <h2 style="color: #fff; margin-bottom: 0; padding-bottom: 0;"><b>유저의 수익을 더 크게,</b></h2>
						    	<h2 style="color: #fff; margin-top: 0; padding-top: 0;"><b>무료로 시작하세요.</b></h2>
								<p style="font-size: 1.2em; color: #fff;">월드스폰은 무료로 이용가능한 가장 강력한 리워드앱입니다. 월드스폰앱을 안드로이드에서 무료로 이용해보세요.</p>
                                <a href="https://play.google.com/store/apps/details?id=com.coinbank.worldspon" class="col-md-8" style="border: none; padding: 0;">
								<img class="btn get_on_android" src="/info/img/google_play.png"
                                            style="padding: 0; margin: 0 border: none;" alt="get on Android"> 
								</a>
						      </div>
                        </div>
                    </div>
                    <div class="col-md-4 col-md-push-1 col-sm-4 col-sm-push-1 mobile-image">
                        <div class="mobile"><img src="/info/img/mobile_1.png" alt="mobile_1"></div>
                    </div>
                </div>
            </div>
        </div>
        <!-- You may change the background color here.  -->
		<div class="item" style="background: #493869">
		    <div class="container" style="position: relative;">
		        <div class="row animate-box" data-animate-effect="fadeIn">
		    	    <div class="col-md-7 col-md-push-1 col-md-push-5 col-sm-7 col-sm-push-1 col-sm-push-5">
			    	    <div class="fh5co-owl-text-wrap">
						    <div class="fh5co-owl-text">
						        <h1 class="fh5co-lead ">안드로이드 전용 앱</h1>
                                <p style="font-size: 1.2em; color: #fff;">안드로이드에서 가장 강력한 무료 리워드앱 '월드스폰'을 지금 바로 플레이스토어에서 경험 해 보세요.</p>
								<a href="https://play.google.com/store/apps/details?id=com.coinbank.worldspon" class="col-md-8" style="border: none; padding: 0;">
								<img class="btn get_on_android" src="/info/img/google_play.png"
                                            style="padding: 0; margin: 0;" alt="get on Android"> 
								    </a>
                            </div>
                        </div>
                    </div>
				<div class="col-md-4 col-md-pull-7 col-sm-4 col-sm-pull-7 mobile-image">
                    <div class="mobile"><img src="/info/img/mobile_2.png" alt="mobile_2"></div>
                </div>
            </div>
		  </div>
        </div>

		   
		</div>
	
    <!-- START About WorldSpon -->
    <div class="container" data-section="aboutWS" style="margin-top: 30px!important;">
		<div>
			<div class="jw-container">
			    <div class="row">
                    <div class="col-md-12 col-md-offset-0 text-left">
                        <div class="display-t">
                            <div class="display-tc">
                                <div class="row">
                                    <div class="col-md-12 animate-box">
                                        <h1 class="no-margin"><b>월드스폰</b><span style="font-size: 0.8em"> 이란?</span></h1>
                                        <p style="margin-right: 30%; font-size: 1.2em;">월드스폰을 이용하는 고객들의 힘으로 발생한 수익을 다시 고객들에게 배당하는 시스템을 이용하는
                                        신개념 리워드 앱입니다. 더 많은 유저가 동참할수록 수익은 커지게 되고, 그 수익은 바로 유저에게 
                                        되돌아가는 선순환을 만드는 것이 월드스폰의 이념입니다.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
		    </div>
        </div>
		
		<!-- START Why WorldSpon -->
		<div>
			<div class="jw-container">
			    <div class="row">
                    <div class="col-md-12 col-md-offset-0 text-left">
                        <div class="display-t">
                            <div class="display-tc">
                                <div class="row">
                                    <div class="col-md-12 animate-box" style="text-align: center;">
                                        <h1 class="no-margin"><b>왜?</b><span style="font-size: 0.8em;"> 수익을 나누나요?</span></h1>
                                        <p style="margin: 1em 10%; font-size: 1.2em;">기존 리워드 앱들은 시스템 구조상 유저의 이익보다는 회사의 이익을 우선으로 생각할 수밖에 없었습니다.
                                        그러다 보니 유저들에게 돌아가는 이익은 적어지고 실망한 유저들이 떠나게 되는 악순환의 반복이었습니다. 그래서 저희는 유저에게 더 큰 
                                        이익을 드리고 이에 따라 더 많은 유저들이 참여하여 더 큰 이익을 함께 나눌 수 있는 선순환구조를 만들기 위해 더욱 획기적인 시스템을
                                        구상하였습니다. 그렇게 <b>'스폰'</b>이 탄생하였습니다.</p>
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
		    </div>
        </div>
		<!-- END Why WorldSpon -->
		<!-- START Why WorldSpon -->
		<div>
			<div class="jw-container jw-margin-bottom-0">
			    <div class="row">
                    <div class="col-md-12 col-md-offset-0 text-left">
                        <div class="row">
                            <div class="col-md-12 animate-box" style="text-align: right;">
                                <h1 class="no-margin"><b>그럼...</b><span style="font-size: 0.8em;"> 회사는 어떻게 수익을 내나요?</span></h1>
                                <p style="margin-left: 30%; text-align: left; font-size: 1.2em;">월드스폰의 시스템을 이해하신 유저분들 중에서 너무나 감사하게도 위 질문과 같이 회사의 수익성에 대해서 걱정해 주십니다. 유저분들에게 더 큰 수익을 드리기 위해 만들어진 <b>'스폰'</b> 시스템에 그 답이 있습니다. 더 많은 유저가 모여서 수익이 커지면 스폰의 가치가 상승하게 되고, 회사의 수익은 당연하게 증가합니다. 유저분들의 관심과 사랑이 커질수록 월드스폰은 더 발전하게 됩니다.</p>
                            </div>
                        </div>
                    </div>
                </div>
		    </div>
        </div>
    </div>
    <!-- END About WorldSpon -->
	
	<!-- START Features -  당신의 투자를 더 쉽게! -->
    <div class="container jw-ft-con" >
    <div data-section="features">
		<div>
            <div class="container animate-box">
			    <div class="col-md-4 col-sm-4 jw-ft-box">
				    <div class="animate-box jw-ft-text">
                        <hr>
                        <h4 class="jw-features" style="text-align: center;"><i class="icon-present"></i><span> 수익성</span></h4>
                        <hr>
						<p>월드스폰은 차별화된 기술력을 이용하여 기존의 리워드앱과는 전혀 다른 보상체계를 만들었습니다. 이를 기반으로 유저에게 더 큰 이익을 돌려드리고 있습니다. 월드스폰의 유저가 더 많아질수록, 월드스폰 커뮤니티가 활성화 될수록 수익은 더 커진다는 점! 기억하세요!</p>
				    </div>
				</div>
				<div class="col-md-4 col-sm-4 jw-ft-box">
				    <div class="animate-box jw-ft-text">
                        <hr>
                        <h4 class="jw-features" style="text-align: center;"><i class="icon-eye"></i><span> 호환성</span></h4><hr>
						<p>안드로이드 운영체제에서 완벽한 호환성을 자랑합니다. 모바일 환경은 뛰어난 접근성을 제공하여 월드스폰 유저들의 커뮤니티 활성화에 도움을 줄 것입니다. 거래가 활성화될수록 월드스폰의 스폰 시스템은 빛나게되고, 스폰의 미래는 더 밝아질 것입니다.</p>
					</div>
				</div>
				<div class="col-md-4 col-sm-4 jw-ft-box">
					<div class="animate-box jw-ft-text">
                        <hr><h4 class="jw-features" style="text-align: center;"><i class="icon-speedometer"></i><span> 기술력</span></h4><hr>
						<p>월드스폰만의 기술력으로 자체 스폰 시스템과 서버를 구축하였습니다. 외주개발이 아닌 당사의 기술력으로 솔루션을 개발하였기 때문에 서버의 응답성이 정확하며 빠릅니다. 전문 개발인력이 상주하며 시스템의 유지/보수를 책임지고 있습니다.</p>
						</div>
				</div>
				<div class="clearfix visible-md-block visible-sm-block"></div>
            </div>
            <hr>
            <div class="row">
			    <div class="col-md-8 col-md-offset-2 gtco-heading text-center">
				    <h2 class="animate-box">당신의 투자를 더 쉽게!</h2>
				    <p class="animate-box" style="margin-bottom: 0;">더 많은 스폰을 보유할수록, 더 많은 배당이 찾아갑니다.</p>
					<p class="animate-box" style="margin-top: 0; padding-top:0;">지금 바로 구글플레이에서 만나보세요!</p>
					<div class="row animate-box">
                        <div class="col-md-12 jw-margin-bottom-10">
                            <a href="https://play.google.com/store/apps/details?id=com.coinbank.worldspon">
                            <img class="btn get_on_android" src="/info/img/google_play.png"
                                style="padding: 0; margin: 0;" alt="get on Android"></a>
                        </div>
                    </div>
				</div>
            </div>
            <hr>
        </div>
        
    </div>
    </div>
	<!-- END Features -->
	
	
	<!-- START App Screenshot -->
	<div id="fh5co-product-screenshots">
		<div class="owl-carousel-center">
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture01.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture02.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture03.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture04.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture05.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture06.png"></div>
			<div class="animate-box" data-animate-effect="fadeIn"><img src="/info/img/inapp/capture07.png"></div>
		</div>
	</div>
	<!-- END App Screenshot -->

    <!-- Start contact -->
    <!-- Start footer -->
	<footer id="footer" role="contentinfo" data-section="contact">
		<div class="container">
            <div class="row footer-contact">
                <div class="col-md-8 col-md-offset-2 text-center">
                    <h3>BUSINESS에 대한 문의는 언제나 환영합니다.</h3>
                </div>
            </div>
		    <div class="row">
                <div class="col-md-5">
				    <h3 style="color: white;"><b>WORLDSPON Inc.</b></h3>
				    <p><span style="font-size: 0.9em!important;">사업자등록번호 : 374-86-00996</span><br>
				    <span style="font-size: 0.9em!important;">업종 : 전자상거래</span><br>
				    <span style="font-size: 0.9em!important;">대표이사 : 김성봉</span><br>
				    <span style="font-size: 0.9em!important;">주소 : 서울특별시 강남구 테헤란로63길 14, 9층(삼성동, 인화빌딩)</span>
				    </p><br><br>
				</div>
				
				<div class="col-md-7 text-right partnership-contact">
                    <h3  style="color: white;">파트너쉽 문의</h3><br>
                    <p><a href="mailto:worldspon@gmail.com" class="btn btn-white">연락하기</a></p>
                    <!--<div class="row">
					    <div class="col-md-6"></div>
				        <div class="col-md-6">
						    <p>
							    <a href="tel://+820220519777">+82 02 2051 9777</a><br>
								<a href="#">worldspon@gmail.com</a>
				            </p>
				        </div>
				    </div>-->
                    <!-- mail to -->
                    <!--
				    <form class="form-inline">
					    <div class="form-group">
						    <label class="sr-only">Email address</label>
						    <input type="email" class="form-control" id="" placeholder="Email">
				        </div>
						<button type="submit" class="btn btn-primary">Send</button>
				    </form>
				    -->
				</div>
            </div>
			<div class="row row-bottom-padded-sm">
			    <div class="col-md-12">
				    <p class="copyright text-center">Copyright 2018 <b>WORLDSPON Inc.</b> All Rights Reserved.<br><br><span style="font-size: 0.8em"> There are another sites of our business below.</span></p>
				    
				</div>
			</div>
			<div class="row">
				<div class="col-md-12 text-center">
					<ul class="social social-circle">
					    <li><a href="http://worldspon.net"><i class="icon-link"></i></a></li>
					    <li><a href="http://worldspon.com"><i class="icon-globe"></i></a></li>
						<!--<li><a href="#"><i class="icon-twitter"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-facebook"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-youtube"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-pinterest"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-linkedin"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-instagram"></i></a></li>-->
						<!--<li><a href="#"><i class="icon-dribbble"></i></a></li>-->
					</ul>
				</div>
			</div>
		</div>
	</footer>
	<!-- END footer -->
	
	<div class="gototop js-top">
		<a href="#" class="js-gotop"><i class="icon-arrow-up"></i></a>
	</div>
	
	
	<!-- MAIN POPUP -->
	<div id="main_popup" class="main_popup" style="position: absolute; z-index:10000; top:0px; left:0; display: none;">
		<a href="#" ><img src="/info/pop/pop_cashbee.png" style="width:100%;height:400px;"/></a>
		<div class="popup_bottom">
			<a href="javascript:closePopupNotToday()">오늘하루 그만보기</a>
			<a class="pull-right white" href="javascript:closePopup();">닫기</a>
		</div>
	</div>
	
	<!-- jQuery -->
	<script src="/info/js/jquery.min.js"></script>
	<!-- jQuery Easing -->
	<script src="/info/js/jquery.easing.1.3.js"></script>
	<!-- Bootstrap -->
	<script src="/info/js/bootstrap.min.js"></script>
	<!-- Waypoints -->
	<script src="/info/js/jquery.waypoints.min.js"></script>
	<!-- Owl Carousel -->
	<script src="/info/js/owl.carousel.min.js"></script>
	<!-- Main JS (Do not remove) -->
	<script src="/info/js/main.js"></script>
	
	<script>
	
	function setCookie(name, value, expiredays) {
		var today = new Date();
		    today.setDate(today.getDate() + expiredays);
		    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
	}
	
	function getCookie(name) 
	{ 
	    var cName = name + "="; 
	    var x = 0; 
	    while ( x <= document.cookie.length ) 
	    { 
	        var y = (x+cName.length); 
	        if ( document.cookie.substring( x, y ) == cName ) 
	        { 
	            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
	                endOfCookie = document.cookie.length;
	            return unescape( document.cookie.substring( y, endOfCookie ) ); 
	        } 
	        x = document.cookie.indexOf( " ", x ) + 1; 
	        if ( x == 0 ) 
	            break; 
	    } 
	    return ""; 
	}
	
	function closePopupNotToday(){
		setCookie('notToday','Y', 1);
		$("#main_popup").hide('fade');
	}
	function closePopup(){
		$("#main_popup").hide('fade');
	}
	
	$(document).ready(function(){
		if(getCookie("notToday")!="Y"){
			$("#main_popup").show('fade');
		}
		var winWidth = $("body").width();
		$("html, body").css("overflow-x", "hidden").css("position", "relative");
	});
	</script>

	</body>
</html>
