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
	<title>광고 관리</title>
	
	<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic" rel="stylesheet">
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<style type="text/css">
	</style>

</head>
	<body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js" integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy" crossorigin="anonymous"></script>

<c:if test="${sessionScope.member._class eq 3}">
<h1>안녕하십니까 저는 락 로그입니다.</h1>
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
	
	function getAjaxList(){
		$.ajax({
			url: "/server/get/a",
			type: "POST"
		}).done(function(data){
			makeHTML(data);
		}).fail(function(){
			alert("데이터를 불러오는데 실패했습니다.");
			return false;
		});
	}
	
	///////////////
	// make HTML //
	///////////////
	function makeHTML(data){
		
		var list = data.list;
		
		$("tbody > tr").remove();
		$("#result > h3").remove();
		var html = "";
		if(list.length == 0){
			html = "<h3>데이터가 없습니다.</h3>";
			$("#result").append(html);
		}else{
			for(var i = 0; i < list.length; i++){
				
				console.log(list[i]);
				
				html += "<tr style='height: 2em; font-size: 1.2em; padding: 0.5em;' >"
					 + "<th scope='row' class='align-center'>"+ (i + 1) +"</th>"
					 + "<input class='uniqueID' type='hidden' value='"+list[i].no+"'></input>"
					 + "<td class='align-center td_ip'>"+list[i].ip+"</td>"
					 + "<td class='align-center td_port'>"+list[i].port+"</td>"
					 + "<td class='align-center td_location'>"+list[i].location+"</td>"
					 + "<td class='align-center td_login_id'>"+list[i].login_id+"</td>"
					 + "<td class='align-center td_note'>"+list[i].note+"</td>"
					 + "<td class='align-center td_payment'>"+list[i].payment+"</td>"
					 + "<td class='align-center td_btn_box' style='padding: 0.2em 0.1em 0.2em 0.1em;'>"
					 + "<button class='btn btn-outline-success modify_btn' style='font-size: 1em; margin-right: 0.1em;'>수정</button>"
					 + "<button class='btn btn-outline-danger modify_delete_btn' style='font-size: 1em;margin-left: 0.1em;'>삭제</button>"
					 + "</td></tr>";
			}
			$("tbody").append(html);
			$(".align-center").css("text-align", "center");
			$("td > a").css("text-decoration", "none");
			$(function () {
				  $('[data-toggle="tooltip"]').tooltip();
			});
		}
	}
	
	$(document).on("click", ".first_box", function(){ inInputBox(); });
	$(document).on("click", ".cover_1", function(){ outInputBox(); });
	$(document).on("click", ".in_cancle_btn", function(){ outInputBox(); });
	
	// 취소 버튼 //
	$(document).on("click", ".modify_cancle_btn", function(){
		getAjaxList();
	});
	
	// 수정 버튼 //
	$(document).on("click", ".modify_btn", function(){
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		var ip = thisElement.find(".td_ip");
		var port = thisElement.find(".td_port");
		var location = thisElement.find(".td_location");
		var loginId = thisElement.find(".td_login_id");
		var note = thisElement.find(".td_note");
		var payment = thisElement.find(".td_payment");
		var btnBox = thisElement.find(".td_btn_box");
		
		var text = "<button id='update_complete_btn' class='btn btn-success' style='font-size: 1em; margin-right: 0.1em;'>적용</button>"
				 + "<button class='btn btn-danger modify_cancle_btn' style='font-size: 1em;margin-left: 0.1em;'>취소</button>";
		ip.html("<input id='modi_ip' value='"+ip.text()+"'></input>");
		port.html("<input id='modi_port' value='"+port.text()+"'></input>").css("padding", "8px");
		location.html("<input id='modi_location' value='"+location.text()+"'></input>").css("padding", "8px");
		loginId.html("<input id='modi_id' value='"+loginId.text()+"'></input>");
		note.html("<input id='modi_note' value='"+note.text()+"'></input>");
		payment.html("<input id='modi_payment' value='"+payment.text()+"'></input>");
		btnBox.css("padding-top", "6.25px").css("padding-bottom", "6.25px");
		btnBox.html(text);
		$("#modi_ip").focus();
	});
	
	// 업데이트 적용 //
	$(document).on("click", "#update_complete_btn", function(){
		var isRun = false;
		isRun = true;
		
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		data = {};
		data.no = no;
		data.ip = $("#modi_ip").val().trim();
		data.port = $("#modi_port").val().trim();
		data.location = $("#modi_location").val().trim();
		data.loginId = $("#modi_id").val().trim();
		data.note = $("#modi_note").val().trim();
		data.modifier = "${sessionScope.member.tradeMark}";
		data.payment = $("#modi_payment").val().trim();
		
		if(isRun){
			if(validCheck(data)){
				updateAjaxServer(data);
			}else{
				return false;
			};
		}else{
			alert("천천히 한번만 시도해주세요.");
		};
	});
	// end of update //
	
	// 삭제 버튼 //
	$(document).on("click", ".modify_delete_btn", function(){
		var thisElement = $(this).parent().parent();
		no = thisElement.find(".uniqueID").val();
		
		var isRun = false;
		isRun = true;
		
		if(isRun){
			$.ajax({
				url: "/server/d",
				type: "POST",
				data: {"no": no}
			}).done(function(d){
				
				console.log(d.result);
				
				if(d.result == "success"){
					alert("삭제되었습니다.");
				}else{
					alert("삭제할 수 없습니다.");
				}
				getAjaxList();
			});	
		}else{
			alert("천천히 한번만 시도해주세요.");
		}
	});
	
	// 글쓰기  //
	$(document).on("click", ".in_submit_btn", function(){
		var isRun = false;
		isRun = true;
		
		var formData = {};
		formData.ip = $("#in_server_ip").val();
		formData.port = $("#in_server_port").val();
		formData.location = $("#in_server_location").val();
		formData.loginId = $("#in_login_id").val();
		formData.note = $("#in_note").val().trim();
		formData.payment = $("#in_payment").val().trim();
		formData.writer = "${sessionScope.member.tradeMark}";
		
		if(isRun){
			if(validCheck(formData)){
				addAjaxServer(formData);
			}else{
				return false;
			}
		}else{
			alert("천천히 한번만 시도해주세요.");
		}
		
	});
/////////////////////////////////////////////////////////////////////////////////////////////
	
	
	///////////////////
	// esc key event //
	///////////////////
	$(document).on("keydown", "body", function(){
		if( $(".cover_1").css("display") == "block" ){
			if( event.keyCode == 27 ){
				outInputBox();
			}
		}
	});
	//////////////////
	// 시작 리스트 받아오기
	//////////////////
	getAjaxList();
});

		</script>
	</body>
</html>