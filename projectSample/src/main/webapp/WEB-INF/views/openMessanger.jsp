<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<script type="text/javascript" src = "resources/js/jquery-2.2.2.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="success" value="${success }">
<form id="msgForm" action="sendMsg" method="post">
보낸이: <input type="text" name="sender" value="${userId}">
받는이: <input type="text" name="receiver" value="">
<textarea rows="20" cols="20" name="content"></textarea>
<input id='sending' type="submit" value="전송">
</form>
<script type="text/javascript">
$(function(){
	var fig = $('#success').val();
	if(fig=='suceess'){
		window.close();
	}
})
</script>
</body>
</html>