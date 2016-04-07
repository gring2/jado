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
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script src="resources/jquery.selection.js"></script>
<script src="resources/notify.js"></script>
<script type="text/javascript">
var ws = null;
var nickname=null
function connect() {
nickname = document.getElementById("nick").value
  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
 var target = "ws://localhost:8666/app/echo?usr="+nickname; //서버에서 파라미터를 
 if ('WebSocket' in window) {
     ws = new WebSocket(target);
 } else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
 } else {
     alert('WebSocket is not supported by this browser.');
     return;
 }
 ws.onopen = function () {
	 document.getElementById("if").setAttribute("src","zombie?usr="+nickname)
	 	 document.getElementById("Stickif").setAttribute("src","sticky")
	 document.getElementById("msg").innerText = 'Info: WebSocket connection opened.';
	 document.getElementById('chat').onkeydown = function(event) {
		 alert('ssss')
		 if (event.keyCode == 13) {
             send();
         }
     };
 };
 ws.onmessage = function (event) {
	$("#result").append('Received: '+event.data)
	 function onShowNotification () {
         console.log('notification is shown!');
     }
     function onCloseNotification () {
         console.log('notification is closed!');
     }
     function onClickNotification () {
         console.log('notification was clicked!');
     }
     function onErrorNotification () {
         console.error('Error showing notification. You may need to request permission.');
     }
     function onPermissionGranted () {
         console.log('Permission has been granted by the user');
         doNotification();
     }
     function onPermissionDenied () {
         console.warn('Permission has been denied by the user');
     }
     function doNotification () {
     	var x = "test push"
         var myNotification = new Notify('pak', {
             body: event.data,
             tag: 'pak',
             notifyShow: onShowNotification,
             notifyClose: onCloseNotification,
             notifyClick: onClickNotification,
             notifyError: onErrorNotification,
             timeout: 4
         });
         myNotification.show();
     }
     if (!Notify.needsPermission) {
         doNotification();
     } else if (Notify.isSupported()) {
         Notify.requestPermission(onPermissionGranted, onPermissionDenied);
     }    
	
 };
 ws.onclose = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection closed.';
 
 };
}

function send(event) {// JSON 문자열을 서버로 전송한다
	nickname = document.getElementById("nick").value
	if(event.keyCode===13){
	var message = document.getElementById('chat').value;
        if (message != '') {
        	var msg = {
        			"usrName":nickname, "way":"chat", "content":message
        		};
       	var jsonStr = JSON.stringify(msg);
		ws.send(jsonStr);
		alert(msg.usrName+msg.way+msg.content)
        //	ws.send(msg);
            document.getElementById('chat').value = '';
        }
	}
    //});
}


function sendFile() {
	// Sending file as Blob
	var file = document.querySelector('input[type="file"]').files[0];
	ws.send(file);
}

$(function(){
	$('body').on('mouseup',function(){
		var target = $.selection();
		var msg = {
			"usrName":target, "phone":"010-1234-6543", "content":"Hello World, 감사합니다"
			};
		var jsonStr = JSON.stringify(msg);
		ws.send(jsonStr);

	})

})
</script>
</head>
<body>
<input type="text" id="nick"> 
<input type="button" value="Connect" onClick="javascript:connect();"><span id="result"style=" border: 5px solid red;"> dadasdasdasd</span><br/>
<input type="text" id="chat" onkeydown="javascript:send(event)"><br/><p/>
파일선택 user00
<input type="file" id="file1"><p/>
<input type="button" value="sendFile" onClick="javascript:sendFile();"><p/>
<iframe id="if"src="" width="600px" height="800px"></iframe>
<iframe id="Stickif"src="" width="600px" height="800px"></iframe>
</body>
</html>