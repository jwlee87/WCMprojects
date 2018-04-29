<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="navi" %>


<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/board/css/write.css"/>

<title>게시판</title>
</head>
<body>
<div class="top-blank"></div>

	<form id="frm" action="/board/updateAction" method="post" enctype="multipart/form-data">
		<div class="write-wrap">
			<div class="title-wrap">
				<input type="text" id="title" name="title" placeholder="제목을 입력하세요." value="${board.title}"/>
			</div>
		</div>
		<table>
			<tr>
				<td class="editor-con">
					<textarea id="contents" name="contents">${board.contents}</textarea>
				</td>
			</tr>
			<!-- 첨부파일 -->
			<c:if test="${fn:length(board.attachFileList) ne 0}">
				<c:forEach var="af" items="${board.attachFileList}">
				<!-- hidden -->
				<input type="hidden" id="fileUniqueID" value="${af.fileUniqueID}">
				<tr>
					<td class="preview-con">
						<img src="/resources/files/board/${af.fileName}">
					</td>
				</tr>
				</c:forEach>
				<tr>
					<td class="delete-btn-con">
						<input type="button" id="deleteFile" value="첨부파일 삭제">
					</td>
				</tr>
			</c:if>
			
			<c:if test="${empty board.attachFileList}">
			<tr>
				<td class="preview-con"></td>
			</tr>
			<tr>
				<td class="delete-btn-con">
					<input type="button" id="addFile" value="첨부파일 추가">
				</td>
			</tr>
			</c:if>
			
			<tr>
				<td class="button-con inputFile">
					<input type="file" id="uploadFile" name="uploadFile" value="${af.fileName}"/>
					<input type="button" id="clearFile" value="초기화">
					<span> 용량제한 4MB</span>
				</td>
			</tr>
			
			<tr>
				<td class="button-con" colspan="2">
					<input type="button" id="save" value="수정"/>
					<input type="button" id="list" value="목록" onclick="javascript:goList();"/>
				</td>
			</tr>
		</table>
		
		<!-- hidden -->
		<input type="hidden" id="boardUniqueID" name="boardUniqueID" value="${board.boardUniqueID}"/>
	</form>

<script src="/board/js/update.js?ver=1.0"></script>
<script>
$("#save").click(function(){
	
	var data = {};
	data["title"] = $("#title").val();
	data["contents"] = $("#contents").val();
	data["bID"] = $("input[name='boardUniqueID']").val();
	
	//alert(data["title"]+" = "+data["contents"]+" = "+data["bID"]);
	
	if(data["title"] != "" && data["title"] != null){
		if(data["contents"] != "" && data["contents"] != null){
			$("#frm").submit();
		}else{
			alert("내용이 올바르지 않습니다.");
			return false;
		}
	}else{
		alert("제목이 올바르지 않습니다.");
		return false;
	}
	return false;
	
});

function goList(){
	location.href = "/board";
}

</script>

</body>
</html>