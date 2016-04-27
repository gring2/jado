<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<style type="text/css">
	body{
		 font-family: "Lato","Helvetica Neue",Helvetica,Arial,sans-serif;
    	font-size: 15px;
	    line-height: 1.42857143;
	    color: #2c3e50;
	
	}
	.text textarea{
	width: 80%
	}
	.texting{
    padding: 10px;
    margin: 10px;
    height: 20px;
    display: block;
    
	}
	.user{
	width:80%;
	font-size: 13pt;
    height: 20px;	
    border-radius: 5px;
	}
	span{
    height: 20px;	
    border-radius: 5px;
	background-color: white;
	margin-right: 5px;	
	}
	textarea{
    border-radius: 5px;	
	}
	#sending{
	background-color: #2196F3;
    border-radius: 5px;	
    width: 100px;
    height: 30px;
    font-size: 15pt;	
    color: white;
	}
	</style>
	<meta charset="UTF-8">
<script type="text/javascript" src = "resources/js/jquery-2.2.2.min.js"></script>
<title>Insert title here</title>
</head>
<body>
<input type="hidden" id="success" value="${success }">
<div id="wrap" style="width: 500px">
<form id="msgForm" action="sendMsg" method="post">
<div class="text">
<div class="texting">
<span>
보낸이
</span>
<input type="text" class="user" name="sender" value="${userId}">
</div>
<div class="texting">
<span>
받는이
</span>
 <input type="text" class="user" name="receiver" value="">
</div>
</div>
<textarea style="width: 100%;margin: 20 auto 20 auto" rows="20" cols="20" name="content"></textarea>
<input id='sending' type="submit" value="전송">
</form>
</div>
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