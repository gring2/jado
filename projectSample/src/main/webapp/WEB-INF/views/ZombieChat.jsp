<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>WebSocket Client</title>
<meta name="description" content="" />
<meta name="author" content="" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="robots" content="noindex, nofollow" />
<link rel="stylesheet" href="resources/stickies/stickies.css" />
<link rel="stylesheet" href="resources/css/default.css" />
<script type="text/javascript" src="resources/js/jquery-2.2.2.min.js"></script>
<script type="text/javascript">

var ws = null;
var scrapWs = null;
window.onload=function connect() {
	var url = window.location.href;
	var arr = url.split("=")
  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
 var target = "ws://203.233.196.76:8666/app/echo?usr="+arr[1]+"zombie"; //서버에서 파라미터를 
 var target2 = "ws://203.233.196.76:8666/app/scrap?usr="+arr[1]+"zombie"; //서버에서 파라미터를 
 if ('WebSocket' in window) {
     ws = new WebSocket(target);
     scrapWs = new WebSocket(target2)
 } else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
     scrapWs = new MozWebSocket(target2)
 } else {
     return;
 }
 ws.onopen = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection opened.';
     document.getElementById("msg").innerText = 'Info: WebSocket connection opened.';
 };
 ws.onmessage = function (event) {
	 var data = event.data;
	data = data.substring(12,data.length-2)
	var mydata={
			"id" : data,
			"name" : data,
			"age" : data			
		};
		mydata = JSON.stringify(mydata);
		mydata=$.ajax({
			method:"post"
			,url:"doAjax"
			,data:mydata
			,dataType:"json"
			,contentType:"application/json;charset=utf-8"
			,success:function(response){
				var json =response
				$('#result').html(json.usrid+", "+json.userage+", "+json.username)
				
			},error:function(response){
				
			}	
		})
 $("#result").append('Received: '+data)
 };
 ws.onclose = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection closed.';
 
 };
}

</script>
</head>
<body>

hi there
<div id="result"></div>
</body>
</html>