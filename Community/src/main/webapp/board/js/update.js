var sel_file;

var endIndex;

$(document).ready(function(){
	$(".preview-con").css("border", "none").show();

	$("#deleteFile").on("click", function(){
		
		var data = {};
		data["fID"] = $("#fileUniqueID").val();
		data["bID"] = $("#boardUniqueID").val();
		
		$(".preview-con img").remove();
		$(".preview-con").hide();
		$(".delete-btn-con").hide();
		$(".inputFile").show();
		
		$.ajax({
			type: "POST"
			, url: "/board/deleteAttachFile"
			, data: data
			, dataType: "json"
			, success: function(data){
				alert("삭제 완료");
			}
			,error: function(){
				alert("실패");
			}
		})
		
	});
	
	$("#addFile").on("click", function(){
		$(".delete-btn-con").hide();
		$(".inputFile").show();
	});
	
	$("#clearFile").on("click", function(){
		$("#uploadFile").val("");
		$(".preview-con img").remove();
		$(".preview-con").css("overflow", "hidden").hide();
	});
	
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
	
	
});