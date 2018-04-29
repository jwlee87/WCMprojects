$(document).ready(function(){
	
	$("#replyContents").on("keyup", function(){
		
		var text_size = $("#replyContents").val().length;
		console.log(text_size);
		
		if(text_size > 300){
			$(".text-size").css("color", "red");
		}
		
		$(".text-size").text(text_size);
	});
	
	$("#save_cmt").on("click", function(){
		var text_size = $("#replyContents").val().length;
		if(text_size > 300){
			alert("댓글이 300자를 초과하였습니다.")
			return false;
		}
		
		var text_val =  $("#replyContents").val();
		
		if(text_val == "" || text_val == null){
			alert("등록할 내용이 없습니다.");
			return false;
		}
		
		$("#cmtFrm").submit();
		
	});
	
	
	$(".cmt_delete").on("click", function(event){
		
		var data = {};
		var bID = $("#boardUniqueID").val();
		
		data["cID"] = $(this).attr("va");
		
		$.ajax({
			type: "POST"
			, url: "/board/deleteCmt"
			, data: data
			, dataType: "json"
			, success: function(data){
				if(data.check=='true'){
					alert("삭제 성공");
					location.href="/board/"+bID;
				} else {
					alert("삭제 실패");
				}
			}
			, error: function(){
				alert("해당 작업을 완료할수 없습니다. 관리자에 문의해주세요. 에러코드 002");
			}
		});
		
	});
	
});