<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>   
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.reportReply {
	width : 60px;
	height : 20px;
	font-size: 10px;
	padding : 0;
	margin-left : 10px;
}

</style>
</head>
<body>

<!-- for(replyVo vo : list) -->
<c:forEach var="vo"  items="${ list }">
		<!-- 자신의 글만 삭제메뉴 활성화 -->
		
		<c:if test="${user.mem_idx eq vo.mem_idx }">
			<div style="text-align: right;">
				<img
					src="${pageContext.request.contextPath}/resources/reply/free-icon-x-button-458594.png"
					onclick="reply_delete('${vo.rpy_idx}');" width="20px"	height="20px" style="cursor:pointer;"><br>
			</div>
		</c:if>
		<div>${ vo.mem_idx }</div>
		<div>${ vo.rpy_content }</div>
		<div>${ fn:substring(vo.rpy_regdate,0,16) }
		        <span>
 	           <!-- 댓글 신고 버튼 -->
            <c:if test="${ user != null }">
	            <c:if test="${user.mem_idx ne vo.mem_idx }">
	            	<input type="button" class="btn btn-danger reportReply" value="댓글신고" id="reportNbtn" onclick="report('${vo.rpy_idx}','댓글');" />
	            </c:if>
            </c:if>
            <c:if test="${ user == null }">
            	<input type="button" class="btn btn-danger reportReply" value="댓글신고" onclick="alert('로그인 후 이용가능합니다');">
            </c:if>
        </span>
		</div>
</c:forEach>

</body>

</html>