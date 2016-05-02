<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<script type="text/javascript" src="resources/js/jquery-2.2.2.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
#container{
	 font-family: "Lato","Helvetica Neue",Helvetica,Arial,sans-serif;
    font-size: 15px;
    line-height: 1.42857143;
    color: #2c3e50;
}
	.id{
		color:	#18bc9c;
		height: 5%;
		margin-bottom: 5px;
	}
	.feed{
	background-color: #f4f4f4;
    padding: 10px;
    border-radius: 5px;
    margin: 10px;
    height: 45px;
	}
	.content{
		margin-top: 20px;
	}
	.feeding{
    padding: 10px;
    border-radius: 5px;
    margin: 10px;
    height: 30px;
    width: 90%;
	}
	.feedbutton{
    border-radius: 5px;
    margin: 10px;
    height: 30px;
    background-color :#2196F3;
    width: 5%;
    color: white;
	}
</style>
</head>
<body>
	<div id="container" style="height:100%;width: 100%;">
		<div id="board" style="width: 98%; height:80%;margin: 0 auto 0 auto; padding: 10px 10px 10px 10px; border-radius: 5px; background-color: white;">
			<c:forEach var="notice" items="${noticeList }">
				<div class="feed"><div class='id'>${ notice.id}
				<span class='date'>${ notice.noticeDate}</span>
				</div>
				<div class="content">${ notice.content}
				</div>
				</div>
			</c:forEach>
		</div>
		<div style="width: 100%;margin: 10 auto 0 auto; border-radius: 5px; background-color: white;"">
		<input type="text" class ="feeding"id="content">
		<input type="button" class ="feedbutton" id="posting" value="등록">	
		</div>
		</div>
	</div>
<script type="text/javascript">
var url = window.location.href;
var arr = url.split("=")
var proNum = arr[1]
	$(function(){
		$('#posting').on('click',function(){
			var content = $('#content').val();
				var mydata={
						'content':content
						,'proNum':proNum
					};
					mydata = JSON.stringify(mydata);
					mydata=$.ajax({
						method:"post"
						,url:"noticeReg"
						,data:mydata
						,dataType:"json"
						,contentType:"application/json;charset=utf-8"
						,success:function(response){
							var x = response;
								$('#board').empty();
							for(var cnt = 0; cnt<x.length;cnt++){
							if($('#board').children().length<5){
								$('#board').append("<div class='feed'>"+
										"<div class='id'>"+x[cnt].id+"<span class='date'>"+x[cnt].noticeDate+"</span></div>"
										+"<div class='content'>"+x[cnt].content
										+"</div>"
										+"</div>")
							}else{
								$('#board').append("<div class='feed'>"+
										"<div class='id'>"+x[cnt].id+"<span class='date'>"+x[cnt].noticeDate+"</span></div>"
										+"<div class='content'>"+x[cnt].content
										+"</div>"
										+"</div>")
								$($('#board').children()[0]).remove();
							}
								
							}
							
						}
						,error:function(response){
							
						}	
					})	
					$('#content').val('');
		})
		
	
	})
		</script>
</body>
</html>