var sel_file;

var endIndex;

$(document).ready(function(){
	
	$("#save").click(function(){
		frm_check();
	});
	
	$("#list").on("click", function(){
		var bool = confirm("지금 목록으로 돌아가시면 진행중인 작업이 모두 사라집니다.");
		if(bool){
			location.href="/board";
		}
	});
	
	$("#clearFile").on("click", function(){
		$("#uploadFile").val("");
		$(".preview-con img").remove();
		$(".preview-con").css("overflow", "hidden").hide();
	});

//	이미지 체인지 이벤트
	$("#uploadFile").on("change", handleImgFile);
	
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
	
	function handleImgFile(e) {
		
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
				
				$(".preview-con").append("<img src='"+e.target.result+"'/>");
				$(".preview-con").css("display","block");
				endIndex = e.target.result.length;
				
			}
			reader.readAsDataURL(f);
		});
//		handleContents();
	}
	
	function getHeight(){
		var height = $("#edit-con > img").height();
		return height;
	}
	
	
	$("#edit-con").on("keydown", handleContents);
	
	$("#save2").on("click", function(){
//		handleContents();
//		var contents = $("#edit-con").html();
	});
	
	
	
	function handleContents(){
		
		var contents = $("#edit-con").html();
		
		var startIndex = contents.indexOf("<img src=");
		
		if(startIndex != -1){
			var dc = contents.substring(startIndex+10, startIndex+endIndex+10);
			var result = replaceTag(contents, dc);
			$("#askContent").text(result);
		}else{
			$("#askContent").text(contents);
		}
		
	}
	
	function replaceTag(contents, dc){
//		contents = contents.replace(/<div>/gi, "<br>");
//		contents = contents.replace(/<\/div>/gi, "");
		contents = contents.replace(dc, "");
		return contents;
	}
	
	/*function byteToMb(n) {
		n = "";
		var tv;
		var length =  n.length;
		var transFileSize;
		
		switch(length){
			case 1:
				tv = n.substring(0,1);
				transFileSize = 0.00000+tv;
				break;
			case 2:
				tv = n.substring(0,2);
				transFileSize = 0.0000+tv;
				break;
			case 3:
				tv = n.substring(0,3);
				transFileSize = 0.000+tv;
				break;
			case 4:
				tv = n.substring(0,4);
				transFileSize = 0.00+tv;
				break;
			case 5:
				tv = n.substring(0,5);
				transFileSize = 0.0+tv;
				break;
			case 6:
				tv = n.substring(0,6);
				transFileSize = 0.+tv;
				break;
			case 7:
				tv = n.substring(0,1);
				transFileSize = tv;
				break;
			case 8:
				tv = n.substring(0,2);
				transFileSize = tv;
				break;
		}
		
	}*/
	
});