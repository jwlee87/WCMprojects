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
<link rel="stylesheet" href="/board/css/write.css"/>

<title>게시판</title>
</head>
<body>

<div class="top-blank"></div>

<form id="frm" action="/board/writeAction" method="post" enctype="multipart/form-data">
	
	<div class="write-wrap">
		<div class="title-wrap">
			<input type="text" id="title" name="title" placeholder="제목을 입력하세요."/>
		</div>
	</div>
	<table>
		<tr>
			<td class="editor-con">
				<textarea id="contents" name="contents" placeholder="내용을 입력하세요."></textarea>
				<!-- <div id="edit-con" contentEditable="true">내용을 입력하세요.</div> -->
			</td>
		</tr>
		<tr>
			<td class="preview-con"></td>
		</tr>
		<tr>
			<td class="button-con">
				<input type="file" id="uploadFile" name="uploadFile" value="" disabled/>
				<input type="button" id="clearFile" value="초기화">
				<span> 용량제한 4MB</span>
			</td>
		</tr>
		<!-- <tr>
			<td class="button-con">
				<input type="file" id="uploadFile" name="uploadFile" value=""/>
				<input type="button" id="clearFile" value="초기화">
				<span> 용량제한 4MB</span>
			</td>
		</tr> -->
		<tr>
			<td class="button-con" colspan="2">
				<input type="button" id="save" value="저장"/>
				<input type="button" id="list" value="목록"/>
				<input type="hidden" id="tradeMark" name="tradeMark" value="${member.tradeMark}">
				<input type="hidden" id="memberUniqueID" name="memberUniqueID" value="${member.uniqueID}">
			</td>
		</tr>
	</table>
</form>

<script src="/board/js/write.js"></script>
<script>

function frm_check(){

	var re_title = /^[ㄱ-ㅎ가-힣a-z0-9]{1,150}/;
	
	var title = $("#title").val();
	var contents = $("#contents").val();
	var tradeMark = $("#tradeMark").val();
	var uploadFile = $("#uploadFile").val();

	function titleTest(){
		if(re_title.test(title) != true){
			alert("제목이 잘못되었습니다.");
			return false;
		}else{
			contentsTest();
		}
	}
	
	function contentsTest(){
		if(contents == "" || contents == null){
			alert("내용을 입력해주세요.");
			return false;
		}else{
			$("#frm").submit();
		}
	}
	titleTest();
}

</script>

</body>
</html>