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
<link rel="stylesheet" href="/line/css/table.css?ver=1.0"/>
<link rel="stylesheet" href="/line/css/index.css?ver=1.0"/>

<title>한줄 광고 등록</title>

</head>
<body>
	<div class="top-blank"></div>
	
	<div class="content-con">
		
		<div class="con-header">
			<div class="title-con">
				<span>한줄 광고 신청내역</span>
			</div>
		</div>
		
		<div class="explain-con">
			
			<table>
				<thead>
					<tr>
						<th>요청일</th>
						<th>한줄 내용</th>
						<th>광고기간</th>
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
					
					<c:if test="${lineList ne null}">
					<!-- 유저 광고 요청 -->
					<c:forEach var="line" items="${lineList}">
					<tr>
						<!-- 요청일 -->
						<td>${line.createDateTime}</td>
						<!-- 한줄 내용 -->
						<td class="title"><font title="${line.chat}">${line.chat}</font></td>
						<!-- 광고기간 -->
						<td>${line.useDate} 일</td>
						
						<!-- 상태 -->
						<c:if test="${line.state eq 0}">
							<td> 승인 대기중  /  <span class="delReq" onclick="deleteReq(${line.uniqueID})">취소</span></td>
						</c:if>
						<c:if test="${ad.state eq 1}">
							<td> 승인 </td>
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
		
		<input type="hidden" id="userUniqueID" value="${member.uniqueID}"/>
		
	</div>

<script>

	function goAddPage(){
		location.href="/line/add";
	}
	
	function error_msg(){
		alert("프로모션 기여도가 낮아 광고 신청을 할 수 없습니다.")
		return false;
	}
	
	$("#btn-req").on("click", function(){
		
		data = {}
		userUniqueID = $("#userUniqueID").val();
		data["userUniqueID"] = $("#userUniqueID").val();
		
		$.ajax({
			type: "post"
			, url: "/line/auth"
			, data: data
			, dataType: "json"
			, success: function(data){
				if(data.check == 'ok'){
					goAddPage();					
				}else if(data.check == 'short'){
					error_msg();
				}else if(data.check == 'not'){
					error_msg();
				}
			}
		});
		
		
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
	
	function deleteReq(uniqueID) {
		
		$.ajax({
			type: "POST"
			, url: "/line/delete/"+uniqueID
		});
		
		location.reload();
	}
</script>

</body>
</html>