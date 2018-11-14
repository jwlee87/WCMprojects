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
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <link rel="stylesheet" href="/myAssets/css/bootstrap.min.css">
        
        <style>
            html {
                overflow: scroll;
                overflow-x: hidden;
            }
            ::-webkit-scrollbar {
                width: 0px;  /* remove scrollbar space */
                background: transparent;  /* optional: just make scrollbar invisible */
            }
            /* optional: show position indicator in red */
            ::-webkit-scrollbar-thumb {
                background: #FF0000;
            }
            
            
            body { font-family: NanumSquareR sans-serif; color: #333333; }            
            a { color: #333333;}
            a:hover {text-decoration: none;}
            .row {
                margin: 0;
            }
            
            .detail-top-box {
                background-color: #ffffff;
                margin: 0;
                padding: 4%;
                border-bottom: 1px solid #cccccc;
                font-size: 6vw;
            }
            
            .view-box {
                height: 100vh;
                overflow-x: hidden;
                overflow-y: scroll;
            }
            
            .log-list {
                font-size: 4.5vw;
            }
            .dropdown-toggle::after {
                display: none;
            }
            .dropdown > button {
                background: #ffffff;
            }
            .dropdown-menu {
                min-width: 0!important;
                padding-top: 0;
                padding-bottom: 0;
            }
            .dropdown-item {
                color: #333333;
                padding-top: 2vw;
                padding-bottom: 2vw;
            }
            .dropdown-item:nth-child(2) {
                border-top: 1px solid #dddddd;
                border-bottom: 1px solid #dddddd;
            }
            .detail-info-box {
                width: calc(100% - 2vw);
                margin: 1vw;
                padding-top: 3vw;
                padding-bottom: 3vw;
                border: 1px solid #dddddd;
                border-radius: 2vw;
            }
            .info-box:hover {
                background-color: #f5f5f5;
            }
            .left-info {
                padding-right: 0;
            }
            
            .contents-box {
                margin: 0;
                padding: 0;
            }
            .i-box {
                padding: 3vw 3vw 3vw 1.5vw;
            }
            .income {
                font-size: 8vw;
            }
            .fa-plus-circle {
                color: #0c9cdf;
            }
            .fa-minus-circle {
                color: #e82a5b;
            }
            
            .t_time {
                color: #333333;
                margin-left: 1vw;
                font-size: 3.4vw;
                line-height: 10vw;
                vertical-align: middle;
            }
            .memo {
                font-size: 3vw;
                line-height: 8vw;
            }
            .target-amount-income {
                color: #0c9cdf;
                height: 10vw;
                /*line-height: 15vw;*/
                font-size: 4vw;
            }
            .target-amount-income:after {
                position: absolute;
                content: '';
                height: 0.5vw;
                bottom: 3vw;
                margin: 0 auto;
                left: 0;
                right: 0;
                width: 100%;
                background: #0c9cdf;
            }
            .target-amount-withdraw {
                color: #e82a5b;
                height: 10vw;
                font-size: 4vw;
            }
            .target-amount-withdraw:after {
                position: absolute;
                content: '';
                height: 0.5vw;
                bottom: 3vw;
                margin: 0 auto;
                left: 0;
                right: 0;
                width: 100%;
                background: #e82a5b;
            }
            .target-date {
                font-size: 3.8vw;
                color: #333333;
            }
            .balance-amount {
                font-size: 3.6vw;
                font-weight: bold;
                color: #666666;
            }
            .more-see {
                /*display: none;*/
                width: 100%;
                background-color: #4833a4;
                padding: 5vw;
                font-size: 5vw;
                vertical-align: middle;
                color: white;
            }
        </style>
        
    </head>
<body>
    <div class="view-box container-fluid no-double">
       
        <div class="detail-top-box container-fluid">
            <div>
                <div class="row assets-menu">   
                    <div class="col-1 no-double">
                        <a href="javascript:history.back();"><i class="fas fa-arrow-left"></i></a>
                    </div>
                    <!--
                        <div class="col-4 bolder">포인트</div>
                        <div class="col-4 bolder">락스폰</div>
                        <div class="col-4 bolder">락포인트</div>
                    -->
                    <div class="col-4 bolder">스폰</div>
                </div>
                <div class="blank_height_3"></div>
                <div class="dropdown">
                    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        전체내역 <i class="fas fa-angle-down"></i>
                    </button>
                    <div class="dropdown-menu shadow-lg" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="#">전체내역 <i class="fas fa-angle-down"></i></a>
                        <a class="dropdown-item" href="#">입금내역</a>
                        <a class="dropdown-item" href="#">출금내역</a>
                    </div>                 
                </div>
                <div class="blank_height_3"></div>
                <div class="col-12 bolder">123,456,789,012.12345678</div>
                <div class="blank_height_1"></div>
                <div class="col-12 micro_font_size bold font-color-gray">스폰지갑</div>
                <!--<div class="col-12 micro_font_size bold font-color-gray">포인트지갑</div>-->

            </div>
        </div>
    
        <!-- Contents Box -->
        <div id="contents-box" class="contents-box container-fluid">
            
            <!-- plus income -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-plus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 24:59:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-income bolder">입금 &nbsp;123,456,789,012.12345678 </div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678 </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- minus withdraw -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-minus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 23:50:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-withdraw bolder">출금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678 </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- plus income -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-plus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 24:59:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">교통카드 충전 : 충전오류 포인트의 금액반환.</div>
                            <div class="col-12 no-double target-amount-income bolder">입금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- minus withdraw -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-minus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 23:50:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-withdraw bolder">출금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- plus income -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-plus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 24:59:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-income bolder">입금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- minus withdraw -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-minus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 23:50:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-withdraw bolder">출금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- plus income -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-plus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 24:59:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-income bolder">입금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- minus withdraw -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-minus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 23:50:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-withdraw bolder">출금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- plus income -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-plus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 24:59:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-income bold">입금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- minus withdraw -->
            <div class="detail-info-box">
                <div class="row">
                    <div class="col-3 left-info">
                        <div class="i-box">
                            <i class="fas fa-minus-circle income m-auto"></i>
                        </div>
                        <div class="row">
                            <i class="far fa-clock t_time m-auto"><span class="bold"> 23:50:33</span></i>
                        </div>
                    </div>
                    <div class="col-9 text-right">
                        <div class="row">
                            <div class="ml-auto target-date bolder">2018년 11월 06일 화요일</div>
                        </div>
                        <div class="row text-right">
                            <div class="col-12 no-double memo">선물하기 - 스폰 : 월드스폰에게서 받음.</div>
                            <div class="col-12 no-double target-amount-withdraw bold">출금 &nbsp;123,456,789,012.12345678</div>
                            <div class="ml-auto balance-amount">잔액 123,456,789,012.12345678</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- bottom more see -->
            <div class="more-see" data-fx="flipOnX">
                <div class="m-auto text-center bold">더보기</div>
            </div>
            
        </div>
        <!-- END of Contents Box -->
    </div>
    <!-- END of the whole box -->
    <!-- jQuery -->
	<script src="/myAssets/js/jquery.min.js"></script>
	<script src="/myAssets/js/popper.js"></script>
	<!-- Bootstrap -->
	<script src="/myAssets/js/bootstrap.js"></script>
	
	<!--<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>-->
<!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>-->
	<!-- Main -->
	<script src="/myAssets/js/main.js"></script>
	<script type="text/javascript">
        
    function getTopBoxHeight(){
        var aaaa = $(".detail-top-box");
        return aaaa[0].clientHeight;
    }
        
    $(document).ready(function(){
        
        $(".view-box").on("scroll", this, function(){
            
            var isTop = false;
            var topBoxHeight = getTopBoxHeight();
            
            /*console.log("1: "+this.offsetHeight);
            console.log("2: "+this.scrollTop);
            console.log("3: "+this.scrollHeight);
            console.log("4: "+topBoxHeight);*/
            
            if(this.scrollTop <= 100){
                isTop = true;
            }else{
                isTop = false;
            }
            
            if(isTop){
                if(this.scrollTop >= 100) {
                    $(this).animate({
                        scrollTop: topBoxHeight
                    });
                }
            }
        });
        
        
        
    });
            
    </script>
</body>
</html>