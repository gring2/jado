<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	
	<meta charset="UTF-8">
	<meta name="description" content="Miminium Admin Template v.1">
	<meta name="author" content="Isna Nur Azis">
	<meta name="keyword" content="">
	<meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Chatting Room</title>

  <!-- start: Css -->
  <link rel="stylesheet" type="text/css" href="resources/asset/css/bootstrap.min.css">

  <!-- plugins -->
  <link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/font-awesome.min.css"/>
  <link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/simple-line-icons.css"/>
  <link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/mediaelementplayer.css"/>
  <link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/animate.min.css"/>
  <link href="resources/asset/css/style.css" rel="stylesheet">
  <!-- end: Css -->

  <link rel="shortcut icon" href="resources/asset/img/logomi.png">
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
      <![endif]-->
      
<style type="text/css">
.col-md-12 { margin: 0 }
.fa:hover {
    color: gray;
}
</style> 
<script src="http://code.jquery.com/jquery-latest.js"></script>

<script src="resources/jquery.selection.js"></script>
<script src="resources/notify.js"></script>
<script>
$(function(){
	$('#upload').on('click',function(){
		$('#saveFile').trigger('click');
	})
	$("input[type='file']").on("change", function(){
		var formData = new FormData();
		var file = this.files[0];                      //multiple 속성이 있으면 files 에는 다수의 객체가 할당됨
		formData.append("imgFile", file);
		$.ajax({
		async : true,
		method : "post",
		url : 'fileupload',
		processData : false, //true : data의 파일형태가 query String으로 전송. false : non-processed data 
		data : formData,
		contentType : false, // false : multipart/form-data 형태로 전송되기 위한 옵션값
		success : function(data){
	       	var msg = {
        			"usrName":nickname, "way":"download", "content":data
        		};
       	var jsonStr = JSON.stringify(msg);
		ws.send(jsonStr);
		}
		});
		});

	$('#hangOut').on('click',function(){
		location.href="http://203.233.196.85:8888/app/"
	})
	document.getElementById('targetId').scrollTop = document.getElementById('targetId').scrollHeight;
	connect();
	
	$('.timeline').on('mouseup',function(){
		var target = $.selection();
		if(target.length==0){
		}else{
			var msg = {
				"usrName":target, "phone":"010-1234-6543", "content":"Hello World, 감사합니다"
				
				};
			var jsonStr = JSON.stringify(msg);
			ws.send(jsonStr);
		}
	})
	$('#chat').keyup(send);
	$('#openCal').on('click',function(){
		var msg = {
    			"usrName":nickname, "way":"cal", "content":''
    		};
		var jsonStr = JSON.stringify(msg);
		
		alert(jsonStr)
		ws.send(jsonStr);
	})
	$('#openGant').on('click',function(){//지민: 간트관련추가
		var msg = {
    			"usrName":nickname, "way":"gant", "content":''
    		};
		var jsonStr = JSON.stringify(msg);
		
		alert(jsonStr)
		ws.send(jsonStr);
	})
	$('#recordStart').on('click',function(){
		$("#result").append("<h4>회의록 저장 시작</h4>")
		swap="record"
		document.getElementById('targetId').scrollTop = document.getElementById('targetId').scrollHeight;
	})
	
	$('#recordEnd').on('click',function(){
		swap="unRecord";
		$("#result").append("<h4>회의록 저장 종료</h4>")
		document.getElementById('targetId').scrollTop = document.getElementById('targetId').scrollHeight;
	})


})


//Visible api
function getHiddenProp(){
    var prefixes = ['webkit','moz','ms','o'];
    
    // if 'hidden' is natively supported just return it
    if ('hidden' in document) return 'hidden';
    
    // otherwise loop over all the known prefixes until we find one
    for (var i = 0; i < prefixes.length; i++){
        if ((prefixes[i] + 'Hidden') in document) 
            return prefixes[i] + 'Hidden';
    }
    // otherwise it's not supported
    return null;
}
function isHidden() {
    var prop = getHiddenProp();
    if (!prop) return false;
    
    return document[prop];
}
window.addEventListener("load", function simpleDemo() {
  // use the property name to generate the prefixed event name
  var visProp = getHiddenProp();
  if (visProp) {
    var evtname = visProp.replace(/[H|h]idden/,'') + 'visibilitychange';
    document.addEventListener(evtname, visChange);
  }
  else {
  }
	function visChange() {
			if (isHidden()) {
      }
			else {
		}
	}
});
</script>
<script type="text/javascript">
//NOtification Api
function pushNoti(data){
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
   //	 	var xx = data.split('\\":\\"')
   	// 	var data2 = xx[3].split('\\')
   	 	
       var myNotification = new Notify(data.sender, {
           body: data.content,
           tag: data.sender,
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
//WebSocket Api
var url = window.location.href;
	var arr = url.split("=")
var ws = null;
var nickname= "<c:out value='${sessionScope.loginName}' />";
var swap ;
var proNum = arr[1]
proNum=proNum.split("&")[0];
var theme = arr[2];
function connect() {
  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
		  var target = "ws://localhost:7070/app/echo?usr="+nickname+"&Pnum="+proNum+"&Theme="+theme; //서버에서 파라미터를 
if ('WebSocket' in window) {
     ws = new WebSocket(target);
     var x =arr[3];
     $('#meetingRoom').text(x.replace(/%20/,' '));
} else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
     
 } else {
     return;
 }
 ws.onopen = function () {
	 document.getElementById('chat').onkeydown = function(event) {
		 if (event.keyCode == 13) {
             send();
         }
     };
     document.getElementById('sendChat').onclick=function(){
    		var message = $('#chat').val();
    		if (message != '') {
    	        	var msg = {
    	        			"usrName":nickname, "way":"chat", "content":message
    	        		};
    	       	var jsonStr = JSON.stringify(msg);
    			ws.send(jsonStr);
    	            document.getElementById('chat').value = '';
    	        }
    }
 };
 

 function swapping(data){
	 swap=data
	 alert(swap)
 }
 ws.onmessage = function (event) {
	 if(event.data.match(/#cal/)){
			$("#result").append("<a href ='javascript:openCal()''>일정잡기"+'</a><br />')
	 }else if(event.data.match(/#gant/)){//지민:간트 관련 추가
			$("#result").append("<a href ='javascript:openGant()''>공정도"+'</a><br />')
	 }else{
		 var data = event.data.split(":")
		 var sender = data[1].split(",");
		 var content = data[3].substr(0,data[3].length-2);
		 if(event.data.match(/#hihioha/)){
				$("#result").append("<a href ='ajaxdownload?filename="+content+"'>다운로드" +"</a><br />");
		 }else{
			 
		 var asClass
		 
		 if(sender[0].replace(/"/g,'')==nickname) {
			asClass = "timeline-inverted";
		 }
		 if(content.match(/\[#\]/)){
		 asClass +=" result";
		 content = content.replace(/\[#\]/,'[결론]');
			$("#result").append("<li class='"+asClass+"'><div class='timeline-panel'><div class='timeline-heading'><h4 class='timeline-title'>"+sender[0].replace(/"/g,'')
					+"</h4></div><div class='timeline-body'>"+content+"<form id='myForm'><input type='radio' name='agreed' value='y'>찬성  <input type='radio' name='agreed' value='n'>반대"+"<input type='button' id='make' value='make'></form><br / ></div></div></li>");
		 
		 }else{
			$("#result").append("<li class='"+asClass+"'><div class='timeline-panel'><div class='timeline-heading'><h4 class='timeline-title'>"+sender[0].replace(/"/g,'')+
				"</h4></div><div class='timeline-body'>"+content+"<br / ></div></div></li>")
		 }
		 
			 
			notif={	"sender":sender[0].replace(/"/g,''),"content":content}
		}
	if (isHidden()) {
		if(notif==null){}
		else{
		pushNoti(notif)
		notif=null
		}
	}
		
	else {
	}
		
	 }
	document.getElementById('targetId').scrollTop = document.getElementById('targetId').scrollHeight;
	if(swap ==="record"){
		var mydata={
				"sender" : nickname,
				"content" : content
				,"proNum" : proNum
				,"thmNum" : theme.split('&')[0]
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"record"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					var json =response;
				alert(json)					
				},error:function(response){
					
				}	
			})
	}
 };
 
 
 ws.onclose = function () {
 };
}



function send() {// JSON 문자열을 서버로 전송한다
	if(event.keyCode===13){
	var message = $('#chat').val();
	if (message != '') {
        	var msg = {
        			"usrName":nickname, "way":"chat", "content":message
        		};
       	var jsonStr = JSON.stringify(msg);
		ws.send(jsonStr);
            document.getElementById('chat').value = '';
        }
	}
    //});
}
function openCal(){
//	$('#cal').attr('src','cal')
//	$('#cal').css('display','block')
	var popUrl = "cal";	//팝업창에 출력될 페이지 URL
	var popOption = "width=550, height=360, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}
function openGant(){//지민:간트 관련 추가
//	$('#cal').attr('src','cal')
//	$('#cal').css('display','block')
	var popUrl = "gantchartView?usr="+nickname+"&Pnum="+proNum+"&Theme="+theme;	//팝업창에 출력될 페이지 URL
	var popOption = "width=2000, height=800, resizable=no, scrollbars=no, status=no;";    //팝업창 옵션(optoin)
		window.open(popUrl,"",popOption);
}


</script>     
</head>

<body id="mimin" class="dashboard topnav">
<form id="frm" action="fileupload" method="post">

<input type="file" id="saveFile" style="display: none">	

</form>
      <!-- start: Content -->
          <div class="col-md-12 top-20 padding-0">
            <div class="col-md-12 padding-0">
            <div class="panel">
              <div class="panel-heading"><h3 id="meetingRoom">회의실</h3></div>
              <div class="panel-body">
                <div class="col-md-12" id="targetId" style="overflow:scroll; height: 800px">
                  <ul class="timeline" id="result">
                  </ul>
                </div>
              </div>
              
              <div class="chat_input">
	            <div class="panel-heading">
	            	<input type="text" size="95%" placeholder="please input your text here..." id="chat" />&nbsp;
	            	<input type="button" class="btn btn-round btn-primary" id="sendChat" value="send" style="height: 40px; width: auto;">
	            	<br />
	            	<!-- íìì -->
					<a><i class="fa fa-phone" id="hangOut" style="font-size: 30px;"></i></a>&nbsp;
					<!-- íì¼ ìë¡ë -->
					<a><i class="fa fa-upload" id="upload" style="font-size: 30px;"></i></a>&nbsp;
					<!-- ì¼ì ì¡ê¸° -->
					<a><i class="fa fa-calendar" id="openCal" style="font-size: 30px;"></i></a>&nbsp;
					<a><i class="fa fa-gant" id="openGant" style="font-size: 30px;">qwer</i></a>&nbsp;<!-- 지민:간트 관련 추가 일단 글자로-->
					<!-- íìë¡ ê¸°ë¡/ì¢ë£ -->
					<a><i class="fa fa-quote-left" id="recordStart"style="font-size: 30px;"></i></a>&nbsp;
					<a><i class="fa fa-quote-right" id="recordEnd" style="font-size: 30px;"></i></a>&nbsp;
					<!-- ê²°ë¡  íê·¸ -->
	            </div>
              </div>
            </div>
            </div>
          </div>
      <!-- end: content -->


      <!-- start: Mobile -->
      <div id="mimin-mobile" class="reverse">
        <div class="mimin-mobile-menu-list">
            <div class="col-md-12 sub-mimin-mobile-menu-list animated fadeInLeft">
                <ul class="nav nav-list">
                    <li class="active ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa-home fa"></span>Dashboard 
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                          <li><a href="dashboard-v1.html">Dashboard v.1</a></li>
                          <li><a href="dashboard-v2.html">Dashboard v.2</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa-diamond fa"></span>Layout
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="topnav.html">Top Navigation</a></li>
                        <li><a href="boxed.html">Boxed</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa-area-chart fa"></span>Charts
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="chartjs.html">ChartJs</a></li>
                        <li><a href="morris.html">Morris</a></li>
                        <li><a href="flot.html">Flot</a></li>
                        <li><a href="sparkline.html">SparkLine</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa fa-pencil-square"></span>Ui Elements
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="color.html">Color</a></li>
                        <li><a href="weather.html">Weather</a></li>
                        <li><a href="typography.html">Typography</a></li>
                        <li><a href="icons.html">Icons</a></li>
                        <li><a href="buttons.html">Buttons</a></li>
                        <li><a href="media.html">Media</a></li>
                        <li><a href="panels.html">Panels & Tabs</a></li>
                        <li><a href="notifications.html">Notifications & Tooltip</a></li>
                        <li><a href="badges.html">Badges & Label</a></li>
                        <li><a href="progress.html">Progress</a></li>
                        <li><a href="sliders.html">Sliders</a></li>
                        <li><a href="timeline.html">Timeline</a></li>
                        <li><a href="modal.html">Modals</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                       <span class="fa fa-check-square-o"></span>Forms
                       <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="formelement.html">Form Element</a></li>
                        <li><a href="#">Wizard</a></li>
                        <li><a href="#">File Upload</a></li>
                        <li><a href="#">Text Editor</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa fa-table"></span>Tables
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="datatables.html">Data Tables</a></li>
                        <li><a href="handsontable.html">handsontable</a></li>
                        <li><a href="tablestatic.html">Static</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a href="calendar.html">
                         <span class="fa fa-calendar-o"></span>Calendar
                      </a>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa fa-envelope-o"></span>Mail
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="mail-box.html">Inbox</a></li>
                        <li><a href="compose-mail.html">Compose Mail</a></li>
                        <li><a href="view-mail.html">View Mail</a></li>
                      </ul>
                    </li>
                    <li class="ripple">
                      <a class="tree-toggle nav-header">
                        <span class="fa fa-file-code-o"></span>Pages
                        <span class="fa-angle-right fa right-arrow text-right"></span>
                      </a>
                      <ul class="nav nav-list tree">
                        <li><a href="forgotpass.html">Forgot Password</a></li>
                        <li><a href="login.html">SignIn</a></li>
                        <li><a href="reg.html">SignUp</a></li>
                        <li><a href="article-v1.html">Article v1</a></li>
                        <li><a href="search-v1.html">Search Result v1</a></li>
                        <li><a href="productgrid.html">Product Grid</a></li>
                        <li><a href="profile-v1.html">Profile v1</a></li>
                        <li><a href="invoice-v1.html">Invoice v1</a></li>
                      </ul>
                    </li>
                     <li class="ripple"><a class="tree-toggle nav-header"><span class="fa "></span> MultiLevel  <span class="fa-angle-right fa right-arrow text-right"></span> </a>
                      <ul class="nav nav-list tree">
                        <li><a href="view-mail.html">Level 1</a></li>
                        <li><a href="view-mail.html">Level 1</a></li>
                        <li class="ripple">
                          <a class="sub-tree-toggle nav-header">
                            <span class="fa fa-envelope-o"></span> Level 1
                            <span class="fa-angle-right fa right-arrow text-right"></span>
                          </a>
                          <ul class="nav nav-list sub-tree">
                            <li><a href="mail-box.html">Level 2</a></li>
                            <li><a href="compose-mail.html">Level 2</a></li>
                            <li><a href="view-mail.html">Level 2</a></li>
                          </ul>
                        </li>
                      </ul>
                    </li>
                    <li><a href="credits.html">Credits</a></li>
                  </ul>
            </div>
        </div>       
      </div>
      <button id="mimin-mobile-menu-opener" class="animated rubberBand btn btn-circle btn-danger">
        <span class="fa fa-bars"></span>
      </button>
       <!-- end: Mobile -->

</body>
</html>