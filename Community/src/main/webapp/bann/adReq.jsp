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
<link rel="stylesheet" href="/bann/css/req.css?ver=1.0"/>

<title>광고 등록</title>

</head>
<body>
	<div class="top-blank"></div>
	
	<div class="content-con">
		
		<div class="con-header">
			<div class="title-con">
				<span>배너광고 신청</span>
			</div>
		</div>
		
		<div class="explain-con">
			<div>
				<span>아래 주의사항을 잘 읽고 광고 신청을 해주세요.</span>
			</div>
			<br/>
			<div>
				<span>※주의사항※</span>
			</div>
			<div>
				<span>광고 유형에 따른 이미지는 직접  조건에 맞게 제작해서 첨부해 주셔야 합니다.</span>
			</div>
			<div>
				<span>배너와 연동될 사이트 주소를 정확히 입력해 주세요.</span>
			</div>
			<div>
				<span>고객의 부주의로 인한 신청은 보상하지 않습니다.</span>
			</div>
			<div>
				<span>장기등록시 더 높은 할인률이 적용됩니다.</span>
			</div>
		</div>
		
		<!-- 폼 시작 form start -->
		<form id="frm" action="/adReqAction" method="post" enctype="multipart/form-data">
		
		<div class="type-con">
			
			<div class="select-type type-1">
				<div class="span-con">
					<div><span>상단 배너</span></div>
					<div><span>사이즈</span></div>
					<div><span>가로 OOOpixel</span></div>
					<div><span>세로 OOOpixel</span></div>
					<div><span>용량제한 4mb</span></div>
					<br>
					<div class="ex_img">
						<!-- 200 by 320 -->
						<img src="/resources/img/example/top.png" alt="예시이미지"/>
					</div>
					<div><span>기본요금</span></div>
					<div><span>30코인 / 일</span></div>
				</div>
				<input type="radio" name="type" id="type1" value="3"/>
			</div>
			<div class="select-type type-2">
				<div class="span-con">
					<div><span>중단 배너</span></div>
					<div><span>사이즈</span></div>
					<div><span>가로 OOOpixel</span></div>
					<div><span>세로 OOOpixel</span></div>
					<div><span>용량제한 4mb</span></div>
					<br>
					<div class="ex_img">
						<img src="/resources/img/example/middle.png" alt="예시이미지"/>
					</div>
					<div><span>기본요금</span></div>
					<div><span>20코인 / 일</span></div>
				</div>
				<input type="radio" name="type" id="type2" value="2"/>
			</div>
			<div class="select-type type-3">
				<div class="span-con">
					<div><span>하단 배너</span></div>
					<div><span>사이즈</span></div>
					<div><span>가로 OOOpixel</span></div>
					<div><span>세로 OOOpixel</span></div>
					<div><span>용량제한 4mb</span></div>
					<br>
					<div class="ex_img">
						<img src="/resources/img/example/bottom.png" alt="예시이미지"/>
					</div>
					<div><span>기본요금</span></div>
					<div><span>10코인 / 일</span></div>
				</div>
				<input type="radio" name="type" id="type3" value="1"/>
			</div>
		</div>
		
		<br/>
		
		<div class="preview-con"></div>
		
		<div class="select-con">
		
			<select id="typeOptions" name="duration" class="form-control">
				<option value="1">1일</option>
				<option value="3">3일</option>
				<option value="7">7일</option>
				<option value="15">15일</option>
				<option value="30">30일</option>
				<option value="60">60일</option>
				<option value="90">90일</option>
			</select>
			
			<div class="file-con">
				<input type="file" id="uploadFile" name="uploadFile" value=""/>
			</div>
			<div class="url-con">
				<span>광고와 연동될 사이트 주소</span>
				<input id="urlAddr" name="linkAddr" type="text" class="form-control" placeholder="예)www.naver.com"/>
			</div>
			
			<div class="price-con"></div>
			
			<button id="btn-okay" type="button" class="btn btn-primary btn-block">광고 신청</button>
		</div>
		
		<input type="hidden" name="memberUniqueID" value="${member.uniqueID}"/>
		<input type="hidden" name="tradeMark" value="${member.tradeMark}"/>
		<input type="hidden" name="price" value=""/>
		
		</form>
		
	</div>
	
	
<script>
	
	$(".select-type").on("click", function(){
		
		//$(this).addClass("selected");
		
		var selectedType = $(this).attr("class");
		var thisNo = selectedType.substr(17,18);
		
		dc(thisNo);
		
	});
	
	function dc(thisNo){
		for(var start=1; start<=3; start++){
			$(".type-"+start).removeClass("selected");
			//console.log($(".type-"+start).attr("class"));
			$(".type-"+thisNo).addClass("selected");
		}
	};
	
	$("html").not(".select-type").on("click", function(){
		//console.log(this);
		$(".select-type").removeClass("selected");
	});
	
	$("#uploadFile").on("change", handleImgFile);
	
	function handleImgFile(e) {
		var adType = $("input[type='radio']:checked").val();
		if(adType==undefined || adType==null || adType==""){
			alert(" 광고 타입을 먼저 선택하시고 그에 맞는 이미지를 추가해주세요. ");
			$("#uploadFile").val("");
			return false;
		}
		
		if($(".preview-con img").length){
			$(".preview-con img").remove();
		}
		
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		
		filesArr.forEach(function(f){
			
			fileCheck(f);
			
			if(!f.type.match("image.*")) {
				$("#uploadFile").val("");
				alert("이미지 파일만 가능합니다.");
				return;
			}
			
			sel_file = f;
			
			var reader = new FileReader();
			reader.onload = function(e) {
				
				$(".preview-con").append("<img id='banner' src='"+e.target.result+"'/>");
				$(".preview-con").css("display","block");
				endIndex = e.target.result.length;
				
			}
			reader.readAsDataURL(f);
		});
		
	}
	
	function fileCheck(file){
		// 사이즈 체크
		// 파일 사이즈
		var maxSize = 4 * 1024 * 1024;	//4MB
		var fileSize = 0;
		
		var browser=navigator.appName;
		
		//익스플로러일 경우
		if(browser=="Microsoft Internet Explorer"){
			var oas = new ActiveXObject("Scripting.FileSystemObject");
			fileSize = oas.getFile(file.value).size;
		}
		//익스플로러가 아닐경우
		else{
			fileSize = file.size;
		}
		
//		$(".button-con").append("<span class='file-size' style='color: black;'>&nbsp;&nbsp;현재 파일 용량: "+byteToMb(file.size)+" MB</span>");
		
		if(fileSize > maxSize){
			alert("첨부파일 사이즈는 4MB 이내로 등록 가능합니다.   ");
			return;
		}
	}
	
	function sizeCheck(adType){
		
		var width;
		var height;
		var imgWidth = $(".preview-con img").width();
		var imgHeight = $("#banner").height();
		
		console.log(adType);
		
		// 상단배너
		if(adType == "3"){
			width = 960;
			height = 710;
		// 중단배너
		}else if(adType == "2"){
			width = 700;
			height = 300;
		// 하단배너
		}else if(adType == "1"){
			width = 700;
			height = 300;
		}
		
		console.log(width+", "+height);
		console.log(imgWidth+", "+imgHeight);
		
		
		if(imgWidth<=width && imgHeight<=height){
			return "true";
		}else{
			return "false";
		}
		
		
	}
	
	$("#btn-okay").on("click", function(){
		var adType = $("input[type='radio']:checked").val();
		var resultValue = sizeCheck(adType);
		var urlAddr = $("#urlAddr").val();
		
		if(resultValue=='false'){
			alert("이미지 파일의 사이즈를 확인해주세요.");
			return false;
		}else{
			if(urlAddr=="" || urlAddr==null){
				alert("광고와 연동하실 사이트 주소를 입력해주세요.");
				return false;
			}
			$("#frm").submit();
		}
	});
	
	$("input[type='radio']").on("click", function(){
		
		var whichType = $(this).val();
		var duration = $("#typeOptions").val();
		console.log(whichType+", "+duration);
		
		if(duration == 1 || duration == 3 || duration == 7){
			var price = whichType * duration;
		}else if(duration == 15){
			var price = whichType * duration * 0.95;
		}else if(duration == 30){
			var price = whichType * duration * 0.9;
		}else if(duration == 60){
			var price = whichType * duration * 0.85;
		}else if(duration == 90){
			var price = whichType * duration * 0.8;
		}else{
			var price = 0;
		}
		
		$(".price-con").text("가격: "+Math.round(price)+" 코인");
		$("input[name='price']").val(Math.round(price));
		
	});
	
	$("#typeOptions").on("change", function(){
		var whichType = $("input[type='radio']:checked").val();
		var duration = $("#typeOptions").val();
		console.log(whichType+", "+duration);
		
		if(duration == 1 || duration == 3 || duration == 7){
			var price = whichType * duration;
		}else if(duration == 15){
			var price = whichType * duration * 0.95;
		}else if(duration == 30){
			var price = whichType * duration * 0.9;
		}else if(duration == 60){
			var price = whichType * duration * 0.85;
		}else if(duration == 90){
			var price = whichType * duration * 0.8;
		}else{
			var price = 0;
		}
		$(".price-con").text("가격: "+Math.round(price)+" 코인");
		$("input[name='price']").val(Math.round(price));
	});
	
</script>

</body>
</html>