<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
<style type="text/css">
    html, body { height:100%; overflow:hidden }
    #result {height:90%; width: 99%; overflow:auto;}
    #scrap{height:10%;width: 90%; text-align:center; font-size:30px; color:white; text-shadow: 2px 2px gray; font-weight: bold; cursor:pointer;
     background: 	#2196F3; }
    #scrap:active {
    background: #3366cc;}
    div .btn{
    float: left;
    }
    #btn{
    font-size:30pt;
    height:10%;
    background-color:white;
    line-height: 46px;
    text-align:center;
    	width: 10%
    }
    .wrap{
    	border: 0.5px solid gray;
    }
</style>
<title>WebSocket Client</title>
<link rel="stylesheet" href="resources/stickies/stickies.css" />
<link rel="stylesheet" href="resources/css/default.css" />
<script type="text/javascript" src="resources/js/jquery-2.2.2.min.js"></script>
<script type="text/javascript">
var nickname= "<c:out value='${sessionScope.userNum}' />";
var ws = null;	
var scrapWs = null;
window.onload=function connect() {
	var url = window.location.href;
	var arr = url.split("=")
  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
 var target = "ws://203.233.196.76:8666/app/echo?usr="+arr[1]+"zombie"; //서버에서 파라미터를 
 if ('WebSocket' in window) {
     ws = new WebSocket(target);
 } else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
 } else {
     return;
 }
 ws.onopen = function () {
 };
 ws.onmessage = function (event) {
	 var data = event.data;
	data = data.substring(12,data.length-2)
	data=data.replace(/\\n/g,'')
	data='\n'+data
	$("#result").val($("#result").val()+data)
	
 };
 ws.onclose = function () {
 
 };
}
$(function(){
	$('body').on('click','.getScrap',function(){
		var title = $(this).text();
		var userNum = $('#userNum').val();
		var mydata={
				"userNum" : userNum
				,"title":title
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"getScrap"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					var content = response.content
					$('#result').val(content)
				},error:function(response){
					
				}	
			})
	
		
	})
	$('#scrap').on('click',function(){
		var title = prompt('제목입력');
		var data = $('#result').val();
		var mydata={
				"data" : data
				,"title":title
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"scrap"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					var json =response;
				},error:function(response){
					
				}	
			})
	
	})
	$('#btn').on('click',function(){
		var dis = $('#scrapList').css('display');
		var userNum = $('#userNum').val();
		if(dis!='none'){
			$("#Sclist").empty();
			var mydata={
					"userNum":userNum
				};
				mydata = JSON.stringify(mydata);
				mydata=$.ajax({
					method:"post"
					,url:"readScrapList"
					,data:mydata
					,dataType:"json"
					,contentType:"application/json;charset=utf-8"
					,success:function(response){
						var json =response
						var count;
						for(count=0;count<json.length;count++){
							$('ul').append("<li><a class='getScrap'>"+json[count].title+'</a></li>')
						}
					},error:function(response){
						
					}	
				})
			
			$('#scrapList').css('display','none');
		}else{
			$('#scrapList').css('display','block');
		}
	})
})
</script>
</head>
<body>
<input type="hidden" id="userNum" value="${sessionScope.userNum }">
<div class="wrap" style="">
<div id="btn" class="btn">+</div> <div class="btn" id="scrap"> SCRAP IT</div>  
	<div id="scrapList" style=" display:none; position: absolute; border: 1px; margin-top: 47px; background-color: white; z-index: 50">
	<ul id="Sclist">
	</ul>
	</div>
</div>
<textarea id="result" ></textarea>
</body>
</html>