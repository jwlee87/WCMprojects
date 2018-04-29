<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="navi" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<link rel="stylesheet" href="/bann/css/table.css?ver=1.0"/>
<link rel="stylesheet" href="/bann/css/index.css"/>

<title>광고 등록</title>

</head>
<body>
	<div class="top-blank"></div>
	
	<div class="content-con">
		
		<div class="con-header">
			<div class="title-con">
				<span>배너광고 신청내역</span>
			</div>
		</div>
		
		<div class="explain-con">
			
			<table>
				<thead>
					<tr>
						<th>요청일</th>
						<th>배너타입</th>
						<th>광고기간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					
					<c:if test="${adList ne null}">
					<!-- 유저 광고 요청 -->
					<c:forEach var="ad" items="${adList}">
					<tr>
						<!-- 요청일 -->
						<td>${ad.reqDate}</td>
						<!-- 배너타입 -->
						<td class="title">
							<c:if test="${ad.type eq 1}">
								하단배너 광고
							</c:if>
							<c:if test="${ad.type eq 2}">
								중단배너 광고
							</c:if>
							<c:if test="${ad.type eq 3}">
								상단배너 광고
							</c:if>
						</td>
						<!-- 광고기간 -->
						<td>${ad.duration} 일</td>
						
						<!-- 상태 -->
						<c:if test="${ad.state eq false}">
							<td> 처리중  /  <span class="delReq" onclick="deleteReq(${ad.memberUniqueID},${ad.adUniqueID})">취소요청</span></td>
						</c:if>
						<c:if test="${ad.state eq true}">
							<td> 완료 </td>
						</c:if>
					</tr>
					</c:forEach>
					</c:if>
				</tbody>
				
			</table>
			
		</div>
		
		<div class="type-con">
			<navi:pagination data="${pageResult}"/>
		</div>
		
		<div class="btn-con">
			<c:if test="${sessionScope.member ne null}">
				<button id="btn-logout" type="button" class="btn btn-default">로그아웃</button>
			</c:if>
			<button id="btn-req" type="button" class="btn btn-primary">광고신청</button>
		</div>
		
	</div>

<script>
	
	$("#btn-req").on("click", function(){
		location.href="/bann/adReq"
	});
	
	$("#btn-logout").on("click", function(){
		$.ajax({
			type: "POST"
			, url: "/board/logout"
			, success: function(){
				location.reload();
			}
		})
	});
	
	function deleteReq(memberUniqueID, adUniqueID) {
		
		$.ajax({
			type: "POST"
			, url: "/bann/delete/"+memberUniqueID+"/"+adUniqueID
		});
		
		location.reload();
	}
</script>

</body>
</html>