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
.fileBox{
border: 1px solid gray;
display: inline-block;
width: 100px;
height: 100px;
margin-left: 20px;
}
</style>
</head>
<body>
<input type="button" id="showStorage" value="스토리지보기">
<input type="button" id="showMeetingBookContainer" value="회의록보기">

<div id="container" style="display: none">
	<div id="themeList">
	<ul>
		<c:forEach var="theme" items="${themeList }">
		
			<li><input type="radio" name="thmNum" class="thmNum" value="${theme.thmNum }">
			
			${theme.themeName } ${theme.thmNum }</li>			
		</c:forEach>
	
	</ul>
	</div>
	
<form id="checkFile" action="deleteFile">	
	<div id="fileList" >
		
	</div>
</form>	
	
	<form id="saveFile" action="saveFile" method="post" enctype="multipart/form-data">
	<input type="hidden" name="thmNum" id="thmNum">
	<input type="hidden" name="proNum" id="proNum">
	<input type="file" name="file" id="savefile">
	</form>
	<input type="button" id="save" value="저장">
	<input type="button" id="delete" value="삭제">
</div>
<div id="meetingBookContainer" style="display:none; ">
	<div  id="themeList">
	<ul>
		<c:forEach var="theme" items="${themeList }">
		
			<li><input type="radio" name="thmNum" class="BookthmNum" value="${theme.thmNum }">
			
			${theme.themeName } ${theme.thmNum }</li>			
		</c:forEach>
	
	</ul>
	</div>
	<div id="BookList" >
	
	</div>
	<input type="hidden" name="thmNum" id="thmNum">
	<input type="hidden" name="proNum" id="proNum">
	
</div>
</body>
<script type="text/javascript">
$(function(){
	var url = window.location.href;
	var arr = url.split("=")
	var proNum = arr[1]
	$('#showStorage').on('click',function(){
		$('#meetingBookContainer').css('display', 'none')
		$('#container').css('display', 'block')
	})
	$('#showMeetingBookContainer').on('click',function(){
		$('#container').css('display', 'none')
		$('#meetingBookContainer').css('display', 'block')
	})	
	$('.BookthmNum').on('click',function(){
		thmNum = $(this).val();
		$("#thmNum").val(thmNum)
		var mydata={
				"thmNum" : thmNum
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"getBookList"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					$('#BookList').empty();
					var cnt=0;
					for(var row =0; row<Math.ceil(response.length/5);row++){					
						for(var a=0;a<5;a++ ){
						$('#BookList').append(
							"<div class = 'fileBox'><a href='viewBook?thmNum="+response[cnt].thmNum
							+"&chatDate="+response[cnt].chatDate+"'>"+response[cnt].chatDate+"</a></div>"		
					)
					cnt++;
						}
					$('#fileList').append('<br />')
					}
				},error:function(response){
					
				}	
			})
	});

	
	
	$('.thmNum').on('click',function(){
		thmNum = $(this).val();
		$("#thmNum").val(thmNum)
		var mydata={
				"thmNum" : thmNum
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"getStgList"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					var cnt=0;
					$('#fileList').empty();
					for(var row =0; row<Math.ceil(response.length/5);row++){
						for(var a=0;a<5;a++ ){
							$('#fileList').append(
									"<input type='checkbox' name='file'>"+
									"<div class = 'fileBox'><a href='download?fileName="+response[cnt].thmNum+"_"+response[cnt].fileName
									+"'>"+response[cnt].fileName+"</a></div>"		
							)
							cnt++;
						}
					$('#fileList').append('<br />')
					}
				},error:function(response){
					
				}	
			})
	});
	$('#save').on('click',function(){
		$('#savefile').trigger('click');
	     var val = $("#savefile").val();

	});
	$("#savefile").change(function(){
		var fileName = $(this).val();
		$('#proNum').val(proNum)
		$('#saveFile').submit();
	})
})
</script>
</html>