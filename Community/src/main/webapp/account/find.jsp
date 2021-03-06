<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/account/css/find.css?ver=1.0"/>

<title>비밀번호 찾기</title>
</head>
<body>
	<div class="top-blank">
	</div>
	<div class="row txt-label">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<span>
			회원님의 스마트아이디를 입력하시고<br>
			메일 발송 버튼을 누르시면<br>
			가입당시 입력하신 이메일 주소로<br>
			비밀번호 변경 링크주소를 보내드립니다.
			</span>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<input id="nickName" type="text" class="form-control" placeholder="스마트아이디를 입력하세요. 예)월드스폰"></input>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-2"></div>
		<div class="col-xs-8">
			<button id="mail_btn" type="button" class="btn btn-primary btn-block">메일 발송</button>
		</div>
		<div class="col-xs-2"></div>
	</div>
	<div class="row">
		<div class="col-xs-12 help"><p>도움이 필요하시면 월드스폰 고객센터로 문의해 주세요.</p></div>
	</div>
	
	<div id="spinner">
		<img src="/resources/img/spinner/Spinner200px.gif">
	</div>
	
	<script>
		window.onload = function(){
			var height = $(window).height();
			$(".top-blank").css("height", height/3.5);
		};
		
		
		$("#mail_btn").on("click", function(){
			
			var nickName = $("#nickName").val();
			data = {};
			data["nickName"] = nickName;
			
			if( data["nickName"] == '' || data["nickName"] == null ){
				alert("스마트아이디를 입력해주세요.");
				return false;
			}else{
				
				$("#spinner").show();
				$("body").css("opacity","0.3");
				
				$.ajax({
					type: "POST"
					, url: "/find/pw"
					, data: data
					, dataType: "json"
					, success: function(result){
						if(result.check == "null"){
							alert("일치하는 스마트아이디가 없습니다.");
							hideSpinner();
						}else if(result.check == "emailNull"){
							alert("등록된 이메일 주소가 없습니다.\n고객센터로 문의해주세요.");
							hideSpinner();
						}else if(result.check == 'validEmail'){
							alert("등록되어있는 "+result.mail+"로 메일을 보내드렸습니다.");
							location.href = "/msg";
						}else if(result.check == 'invalidEmail'){
							alert("등록되어있는 "+result.mail+"은 잘못된 메일주소입니다.\n고객센터로 문의해주세요.");
							hideSpinner();
						}
					}
				})
			}
			
		});
		
		function hideSpinner(){
			$("#spinner").hide();
			$("body").css("opacity","1");
			return false;
		}
	</script>
</body>
</html>