<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE>
<html>
<head>
<c:import url="/resources/jsp/defaultSetting.jsp"></c:import>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>

</head>
<body>

	<input class="form-control input-lg" id="url" type="text" placeholder="url" value="http://192.168.0.12">
	<input class="form-control input-lg" id="param1" name="param1" type="text" placeholder="param1">
	<input class="form-control input-lg" id="param2" name="param2" type="text" placeholder="param2">
	<input class="form-control input-lg" id="param3" name="param3" type="text" placeholder="param3">
	<input class="form-control input-lg" id="param4" name="param4" type="text" placeholder="param4">
	<input class="form-control input-lg" id="param5" name="param5" type="text" placeholder="param5">
	<button id="senb_btn" type="button" class="btn btn-primary btn-block">전송</button>
	
	<div id="contents"></div>


<script>

	$("#senb_btn").on("click", function(){
	
		var data = {}
		data["url"] = $("#url").val();
		data["param1"] = $("#param1").val();
		data["param2"] = $("#param2").val();
		data["param3"] = $("#param3").val();
		data["param4"] = $("#param4").val();
		data["param5"] = $("#param5").val();
		
		$.ajax({
			type: "POST"
			, url: "/httpTest"
			, data: data
			, dataType: "json"
			, success: function(resultMap){
				alert("성공");
				$("#contents").val(resultMap.param1+", "+resultMap.param2+", "+resultMap.param3+", "+resultMap.param4+", "+resultMap.param5);
			}
		});
	});
</script>
</body>
</html>