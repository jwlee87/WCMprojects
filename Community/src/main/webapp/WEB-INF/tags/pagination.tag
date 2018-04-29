<%@ tag body-content="empty" pageEncoding="utf-8" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ attribute name="data" type="com.cmt.domain.Tab"%>

<c:if test="${data.totalCount != 0}">
	<ul class="pagination">
		
		<li class="fn_larrow <c:if test='${data.prev eq false}'>disabled</c:if>">
			<a href="<c:if test='${data.prev eq true}'>javascript:goPage(${data.startTab-1});'</c:if>">&lt;&lt;</a>
		</li>
		
		<c:forEach var="i" begin="${data.startTab}" end="${data.endTab}">
			<c:choose>
				<c:when test="${i eq data.currentTab}">
					<li class="currentTab"><a href="#">${i}</a></li>
				</c:when>
				<c:otherwise>
					<li><a href="javascript:goPage(${i})">${i}</a></li>
				</c:otherwise>
			</c:choose>
		</c:forEach>
		
		<li class="fn_rarrow <c:if test='${data.next eq false}'>disabled</c:if>">
			<a href="<c:if test='${data.next eq true}'>javascript:goPage(${data.endTab+1});</c:if>">&gt;&gt;</a>
		</li>
		
	</ul>
</c:if>