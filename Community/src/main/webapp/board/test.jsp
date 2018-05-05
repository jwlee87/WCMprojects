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
<link rel="stylesheet" href="/board/css/read.css?ver=1.0"/>

<title>게시판</title>
</head>
<body>
<div class="top-blank"></div>

	<div class="board_read">
	
		<input type="hidden" id="boardUniqueID" name="boardUniqueID" value="${board.boardUniqueID}"/>
		
		<div class="section_wrap">
			<div class="read_headr">
				<h1>
					<a href="#" title="${board.title}">
						${board.title}
					</a>
				</h1>
			</div>
			<div class="read_middle">
				<ul class="read_box">
					<li class="writer">글쓴이  <b>${board.tradeMark}</b></li>
					<%-- <li>
						댓글 <span><b>1220</b></span>
					</li>
					--%>
					<li class="right">
						조회 수 <span><b>${board.viewCount}</b></span>
					</li>
					<li class="right">
						등록일 <span>${board.dateFormat}</span>
					</li>
				</ul>
			</div>
			
			<!-- 첨부파일 -->
			<div class="read_content">
				<c:if test="${fn:length(board.attachFileList) ne 0}">
					<c:forEach var="af" items="${board.attachFileList}">
						<div class="attach_file">
							<img src="/resources/files/board/${af.fileName}">
						</div>
					</c:forEach>
				</c:if>
				<div>${board.contents}</div>
			</div>
		</div>
		
		<div class="button-con">
			<c:if test="${member ne null}">
			<c:if test="${member.uniqueID eq board.memberUniqueID}">
				<input type="button" id="modify" value="수정"/>
				<input type="button" id="delete" value="삭제"/>
			</c:if>
			</c:if>
			<!-- <input type="button" id="list" value="목록" onclick="javascript:history.go(-1);"/> -->
			<input type="button" id="list" value="목록" onclick="javascript:goList();"/>
		</div>
		
	</div>
	
	
	<c:if test="${member.tradeMark ne null}">
	<div class="reply-con">
	<form id="cmtFrm" action="/board/cmtAction" method="POST">
	
		<div class="reply-con-top">
			<span class="cmt_count">
				<span>댓글</span>
				<span>${board.replyCount}</span>
				<span class="user_id">${member.tradeMark}</span>
			</span>
		</div>
		<div class="reply-cmt-box">
			<textarea id="replyContents" name="comment" placeholder="권리침해, 욕설, 특정 대상을 비하하는 내용을 게시할 경우 이용약관 및 관련 법률에 의해 제재될 수 있습니다.
공용기기에서는 사용 후 로그아웃 해주세요."></textarea>
		</div>
		<div class="reply-con-bottom">
			<span class="text-size"></span>
			<span> / 300</span>
			<span id="save_cmt" class="save_cmt">등록</span>
		</div>
	
	
	<input type="hidden" name="boardUniqueID" value="${board.boardUniqueID}"/>
	<input type="hidden" name="memberUniqueID" value="${member.uniqueID}"/>
	<input type="hidden" name="tradeMark" value="${member.tradeMark}"/>
	
	</form>
	</div>
	</c:if>
	
	<!-- 리플 -->
	<c:if test="${board.replyCount ne 0}">
	<c:forEach var="comment" items="#{board.commentList}">
	<div class="reply-con">
		<div class="reply-con-top">
			<span class="cmt_writer">${comment.tradeMark}</span>
			<span class="cmt_regDate">${comment.dateFormat}</span>
			<c:if test="${comment.memberUniqueID eq member.uniqueID}">
				<span id="cmt_delete" class="cmt_delete" va="${comment.commentUniqueID}">삭제</span>
			</c:if>
		</div>
		<div class="reply-con-middle">
			<div class="cmt-box">${comment.comment}</div>
		</div>
	</div>
	</c:forEach>
	
	<!-- 종료 구분선 -->
	<div class="end-line"></div>
	
	<div class="reply-navi-con">
		<c:if test="${pageResult.totalCount != 0}">
		<ul class="pagination">
			<li class="fn_larrow <c:if test='${pageResult.prev eq false}'>disabled</c:if>">
				<a href="<c:if test='${pageResult.prev eq true}'>javascript:goPage(${pageResult.startTab-1});'</c:if>">&lt;&lt;</a>
			</li>
			
			<c:forEach var="i" begin="${pageResult.startTab}" end="${pageResult.endTab}">
				<c:choose>
					<c:when test="${i eq pageResult.currentTab}">
						<li class="currentTab"><a href="#">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="javascript:goPage(${i})">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
			
			<li class="fn_rarrow <c:if test='${pageResult.next eq false}'>disabled</c:if>">
				<a href="<c:if test='${pageResult.next eq true}'>javascript:goPage(${pageResult.endTab+1});</c:if>">&gt;&gt;</a>
			</li>
		</ul>
		</c:if>
	</div>
	</c:if>
	
	





<script src="/board/js/read.js?ver=1.0"></script>
<script>
$("#modify").click(function(){
	
	var data = {};
	data["bID"] = $("#boardUniqueID").val();
	
	location.href = "/board/update/"+data["bID"];
	
});

$("#delete").on("click", function(){
	
	var data = {};
	data["bID"] = $("#boardUniqueID").val();
	
	$.ajax({
		type: "POST"
		, url: "/board/delete"
		, data: data
		, dataType: "json"
		, success: function(data){
			if(data=='comment') alert("댓글이 달린 게시물은 삭제할 수 없습니다.");
			location.href="/board"
		}
		, error: function(){
			alert("실패! 관리자 문의 요망");
			location.href="/board"
		}
	})
});

function goList(){
	location.href = "/board";
}

function goPage(pageNo){
	var boardUniqueID = $("#boardUniqueID").val();
	location.href = "/board/"+boardUniqueID+"?pageNo="+pageNo;
}
</script>

</body>
</html>