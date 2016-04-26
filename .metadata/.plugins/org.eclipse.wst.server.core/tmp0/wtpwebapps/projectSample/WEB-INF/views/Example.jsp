<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>WebSocket Client</title>

<script type="text/javascript">

var ws = null;

function connect() {

  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
 var target = "ws://localhost:8666/app/echo?usr=홍길동"; //서버에서 파라미터를 
 if ('WebSocket' in window) {
     ws = new WebSocket(target);
 } else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
 } else {
     alert('WebSocket is not supported by this browser.');
     return;
 }
 ws.onopen = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection opened.';
 };
 ws.onmessage = function (event) {
	 alert(event.data)
	 document.getElementById("msg").innerText = 'Received: '+event.data;
 };
 ws.onclose = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection closed.';
 };
}

function send() {// JSON 문자열을 서버로 전송한다
	var msg = {
		"usrName":"홍길동", "phone":"010-1234-6543", "content":"Hello World, 감사합니다"
	};
	var jsonStr = JSON.stringify(msg);
	ws.send(jsonStr);
}


function sendFile() {
	// Sending file as Blob
	var file = document.querySelector('input[type="file"]').files[0];
	ws.send(file);
}
</script>
</head>
<body>

<input type="button" value="Connect" onClick="javascript:connect();"><br/>
<input type="button" value="Send" onClick="javascript:send();"><br/><p/>
파일선택<input type="file" id="file1"><p/>
<input type="button" value="sendFile" onClick="javascript:sendFile();"><p/>
<div id="msg"></div>
</body>
</html>