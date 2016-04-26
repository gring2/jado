var ws = null;
var nickname=null
var notif = null;
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
	 document.getElementById('chat').onkeydown = function(event) {
		 alert('ssss')
		 if (event.keyCode == 13) {
             send();
         }
     };
 };
 
   
 ws.onmessage = function (event) {
	notif=event.data
	$("#result").append('Received: '+event.data)

 };
 ws.onclose = function () {
 
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

function pushNoti(data){
	$("#result").append('Received: '+data)

	 function onShowNotification () {
   }
   function onCloseNotification () {
   }
   function onClickNotification () {
   }
   function onErrorNotification () {
   }
   function onPermissionGranted () {
       doNotification();
   }
   function onPermissionDenied () {
   }
   
   function doNotification () {
   	var x = "test push"
       var myNotification = new Notify('pak', {
           body: data,
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
}