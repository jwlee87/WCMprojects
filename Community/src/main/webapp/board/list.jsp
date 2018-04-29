<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="navi" %>

<link rel="stylesheet" href="/board/css/table.css?ver=1.0">
<link rel="stylesheet" href="/board/css/pagination.css?ver=1.0">

<table>
	<thead>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>글쓴이</th>
			<th>등록일</th>
			<th>조회</th>
		</tr>
	</thead>
	<tbody>
		<!-- 관리자 공지사항 -->
		<c:forEach var="board" items="${noticeList}">
		<tr class="notice">
			<!-- 게시글 번호 -->
			<td>${board.boardUniqueID}</td>
			<!-- 게시글 제목 -->
			<td class="title">
				<a href="/board/${board.boardUniqueID}" title="${board.title}">
					<span class="notice-title">[공지사항]</span> ${board.title}
				</a>
				
				<!-- 게시글 이미지 첨부 여부 -->
				<c:if test="${fn:length(board.attachFileList) ne 0}">
					<img class="ico_image" src="/resources/img/table/icon/ico_image.gif"/>
				</c:if>
				
				<!-- 게시글마다 댓글 갯수 -->
				<c:if test="${board.replyCount ne 0}">
					<a><span class="number">${board.replyCount}</span></a>
				</c:if>
				
				<!-- 게시글 신규 생성 24시간 이내 이미지 표현 -->
				<c:if test="${board.newData eq true}">
					<img class="ico_new" src="/resources/img/table/icon/ico_new.gif"/>
				</c:if>
			</td>
			<!-- 게시글 작성자 이름 -->
			<td>${board.tradeMark}</td>
			<!-- 게시글 생성일 -->
			<td>${board.dateFormat}</td>
			<!-- 게시글 조회수 -->
			<td>${board.viewCount}</td>
		</tr>
		</c:forEach>
		
		<!-- 유저 게시글 -->
		<c:forEach var="board" items="${boardList}">
		<tr>
			<!-- 게시글 번호 -->
			<td>${board.boardUniqueID}</td>
			<!-- 게시글 제목 -->
			<td class="title">
				<a href="/board/${board.boardUniqueID}" title="${board.title}">
					${board.title}
				</a>
				
				<!-- 게시글 이미지 첨부 여부 -->
				<c:if test="${fn:length(board.attachFileList) ne 0}">
					<img class="ico_image" src="/resources/img/table/icon/ico_image.gif"/>
				</c:if>
				
				<!-- 게시글마다 댓글 갯수 -->
				<c:if test="${board.replyCount ne 0}">
					<a><span class="number">${board.replyCount}</span></a>
				</c:if>
				
				<!-- 게시글 신규 생성 24시간 이내 이미지 표현 -->
				<c:if test="${board.newData eq true}">
					<img class="ico_new" src="/resources/img/table/icon/ico_new.gif"/>
				</c:if>
			</td>
			<!-- 게시글 작성자 이름 -->
			<td>${board.tradeMark}</td>
			<!-- 게시글 생성일 -->
			<td>${board.dateFormat}</td>
			<!-- 게시글 조회수 -->
			<td>${board.viewCount}</td>
		</tr>
		</c:forEach>
	</tbody>
	
</table>

<div class="section_footer">
	<div class="div_pagination">
		
		<navi:pagination data="${pageResult}"/>
		
		<ul class="wt_box gray_color">
			<!-- <li class="search_padding">
				<form action="/customer/searchList" method="post" onsubmit="returnFilter(this, search)"
					id="board_input" class="board_input">
						<select name="search_target">
							<option value="title_content">제목+내용</option>
							<option value="title">제목</option>
							<option value="content">내용</option>
							<option value="nickname">글쓴이</option>
						</select>
						<div class="search_input">
							<input type="text" name="search_keyword" title="검색" class="search_keyword"
								placeholder="검색어를 입력 하세요."></input>
						</div>
						<button type="submit" class="search_btn" onclick="xGetElementById('board_input').submit();return false;">
						검색</button>
				</form>
			</li> -->
			
			<c:if test="${member ne null}">
			<a href="javascript:void(0)" onclick="goHome();">
				<span class="right">처음으로</span>
			</a>
			<a href="javascript:void(0)" onclick="logout();">
				<span class="right">로그아웃</span>
			</a>
			<a href="javascript:void(0)" onclick="loginChk();" id="square_wirte">
				<span class="right">쓰기</span>
			</a>
			</c:if>
			
			<c:if test="${member eq null}">
			<a href="javascript:void(0)" onclick="goHome();">
				<span class="right">처음으로</span>
			</a>
			<a href="javascript:void(0)" onclick="login();" id="square_wirte">
				<span class="right">로그인</span>
			</a>
			</c:if>
			
			
			
		</ul>
		
	</div>
</div>

<input type="hidden" id="tradeMark" value="${member.tradeMark}">

<script>
	function loginChk(){
		location.href="/board/write";
	}
	
	function logout(){
		$.ajax({
			type: "POST"
			, url: "/board/logout"
			, success: function(){
				location.reload();
			}
		})
	}
	
	function login(){
		
		var data = {};
		data["tradeMark"] = $("#tradeMark").val();
		
		$.ajax({
			type: "POST"
			, url: "/board/loginChk"
			, data: data
			, dataType: "json"
			, success: function(data){
				if(data.check == 'false'){
					location.href="/board/login";
				}else if(data.check == 'true'){
					location.href="/board";
				}
			}
		})
	}
	
	function goPage(pageNo){
		location.href = "/board?pageNo="+pageNo;
	}
	
	function goHome(){
		location.href = "/"
	}
</script>
