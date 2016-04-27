<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>jQuery UI Sortable - Connect lists</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"> 
  <link rel="stylesheet" href="resources/themes/alertify.core.css" />
  <link rel="stylesheet" href="resources/themes/alertify.default.css" id="toggleCSS" />
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <script src="resources/themes/alertify.min.js"></script>  
  <link rel="stylesheet" href="resources/css/platform.css" type="text/css">
  <link rel="stylesheet" href="resources/css/gantt.css" type="text/css">
  
  <style>
  	fieldset ul li{
  		display:inline;  	
  	}
	.uluser,.ulstartDate,.ulendDate,.ulduration,.ulgantPercent{ 
		margin: 0 0px 0px 0px; 
		padding: 0px;
		width: 100px;
		min-height: 20px;
		list-style-type: none;
	}
     .calendar .ui-selecting { background: #FECA40; } 
     .calendar .ui-selected { background: #F39814; color: white; } 
  .resEdit {
    padding: 15px;
  }

  .resLine {
    width: 95%;
    padding: 3px;
    margin: 5px;
    border: 1px solid #d0d0d0;
  }

  body {
    overflow: hidden;
  }

  .ganttButtonBar h1{
    color: #000000;
    font-weight: bold;
    font-size: 28px;
    margin-left: 10px;
  }
  
  fieldset {
	width: 50%;
	border: 1px solid #dcdcdc;
	border-radius: 15px;
	padding: 10px;
	font-size: 20px;
}

	legend {
		background-color: #efefef;
		border: 1px solid #dcdcdc;
		border-radius: 10px;
		padding: 10px 20px;
		text-align: left;
		text-transform: uppercase;
		font-size: 20px;
}

	th {
		font-size: 18px;
	}
  
  </style>
  <script>
  var today=new Date();
  var year=today.getFullYear()
  var month=today.getMonth() + 1;
  var date=today.getDate()
  var lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
  var days=['holyH','mon','tue','wed','thu','fri','holyH']
  var gantOrder=0
  $(function() {
	  if($(".trtodo").length!=0) gantOrder=parseInt($(".trtodo").last().attr("gantNum").substr(1, 2))+1;
	  $("#month1").attr("colspan",lastday).html(year+'년'+month+'월')
	  $("#month2").attr("colspan",62-lastday).html(year+'년'+(month+1)+'월')
	  makeBasicCalendar()
	  
	  $( "#left" ).on("click",function(){
		  month=month-1;
		  if(month==0){
			  month=12;
			  year=year-1
		  }
		  $("#month1").attr("colspan",lastday).html(year+'년'+month+'월')
		  $("#month2").attr("colspan",62-lastday).html(year+'년'+(month+1)+'월')
		  lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
		  makeCalendar()
		  makeBasicCalendar()
	  })
	  $( "#right" ).on("click",function(){
		  month=month+1;
		  if(month==13){
			  month=1;
			  year=year+1
		  }
		  $("#month1").attr("colspan",lastday).html(year+'년'+month+'월')
		  $("#month2").attr("colspan",62-lastday).html(year+'년'+(month+1)+'월')
		  lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
		  makeCalendar()
		  makeBasicCalendar()
	  })
	  
		$( "ul #draggable" ).draggable({
		  connectToSortable: ".uluser",
		  helper: "clone",
		  revert: "invalid"
		});
	    
	    $("#new").on("click",function(){
	    	var gantNum='G'+("0" + gantOrder).slice(-2)+$('#proNum').val()
			var work=""
			alertify.prompt("업무추가", function (e, str) {
				if (e && str!="") {
					alertify.success("You've clicked OK and typed: " + str);
					work=str
					var string='{';
				    string+='"todo":"'+work+'",'
				    string+='"gantNum":"'+gantNum+'",'
				    string+='"proNum":"'+$('#proNum').val()+'"}'
				    $.ajax({
				    	method:'POST',
						url:'insertGantchart',
						data: JSON.parse(string),
						success: function(data){
							var html='';
							html+='<tr taskid="-1" class="taskEditRow trtodo" level="0" __template="TASKROW" gantNum="'+gantNum+'">';
							html+='<th class="gdfCell" align="right" style="cursor:pointer;"></th>'
							html+='<td class="gdfCell todo" style="padding-left: 18px;">';		
							html+=work;
							html+='<a href="#" class="deleteTodo">-</a>';
							html+='</td>';
							html+='<td class="gdfCell tduser" style="padding-left: 18px;">';
							html+='	<ul class="uluser">';
							html+='	</ul>';
							html+='</td>';
							html+='<td class="gdfCell tdstartDate">';
							html+='	<ul class="ulstartDate">';
							html+='	</ul>';
							html+='</td>';
							html+='<td class="gdfCell tdendDate">';
							html+='	<ul class="ulendDate">';
							html+='	</ul>';
							html+='</td>';
							html+='<td class="gdfCell tdduration">';
							html+='	<ul class="ulduration">';
							html+='	</ul>';
							html+='</td>';
							html+='<td class="gdfCell tdgantPercent">';
							html+='	<ul class="ulgantPercent">';
							html+='	</ul>';
							html+='</td>';
							html+='<td class="gdfCell taskAssigs"></td>'  
							html+='</tr>';
							var htmlca=''
							htmlca+='<tbody class="tbcalendar" gantNum="'+gantNum+'">'
							htmlca+='</tbody>'
							$(".gdfTable").append(html);
							$(".ganttTable").append(htmlca);
							gantOrder+=1
							sortable();
							sendObject('insertGantchart', string)
						}				    
					})
				} else {
					alertify.error("You've clicked Cancel");
				}
			}, "");
			
			
		    
	    })
	    $('table').on('click','.deleteTodo',function(){
			var gantNum=$(this).parent().parent().attr("gantNum")		    
			var string='{"gantNum":"'+$(this).parent().parent().attr("gantNum")+'"}';
		    $.ajax({
				method:'POST',
				url:'deleteGantchart',
				data: JSON.parse(string),
				success: function(data){
					$("[gantNum='"+gantNum+"']").remove()	
					sendObject('deleteGantchart', string)
				}
			})		    	
		});
	    $('table').on('click','.deleteMember',function(){
	    	var li=$(this).parent()
	    	var userNum=$(this).parent().attr("userNum");
        	var gantNum=$(this).parent().parent().parent().parent().attr("gantNum");
        	var string='{';
		    string+='"userNum":"'+userNum+'",'
		    string+='"gantNum":"'+gantNum+'"}'
		    $.ajax({
		    	method:'POST',
				url:'deleteGantMember',
				data: JSON.parse(string),
				success: function(data){
					li.remove()
					$('.trtodo[gantNum="'+gantNum+'"] .tdstartDate .ulstartDate li[userNum="'+userNum+'"]').remove()
					$('.trtodo[gantNum="'+gantNum+'"] .tdendDate .ulendDate li[userNum="'+userNum+'"]').remove()
					$('.trtodo[gantNum="'+gantNum+'"] .tdduration .ulduration li[userNum="'+userNum+'"]').remove()
					$('.trtodo[gantNum="'+gantNum+'"] .tdgantPercent .ulgantPercent li[userNum="'+userNum+'"]').remove()
					$('.tbcalendar[gantNum="'+gantNum+'"]').children('tr[userNum="'+userNum+'"]').remove()
					sendObject('deleteGantMember', string)
				}
        	})				
		});	
	    makeCalendar()
		sortable();
	    selectable();
	});
	function makeCalendar(){
		$(".calendar").each(function(index,item){			
			var userNum=$(this).attr("userNum");
        	var gantNum=$(this).parent().attr("gantNum");
        	var startDate=new Date($('.trtodo[gantNum="'+gantNum+'"] .tdstartDate .ulstartDate li[userNum="'+userNum+'"]').html())
			var endDate=new Date($('.trtodo[gantNum="'+gantNum+'"] .tdendDate .ulendDate li[userNum="'+userNum+'"]').html())
			var html="";
 			for (var i=1;i<=62;i++){
 				var day=new Date(year,month-1,i,9,0,0)
 				html+="<td date="+i+" class='"+days[day.getDay()]+" ganttBodyCell"
 				if(day.getDay()!=0 && day.getDay()!=6){
 					if(day>=startDate && day<=endDate){
 						html+=" ui-selected"
 					}					
				} 
				html+="'>&nbsp;</td>"
 			}
 			$(this).html(html)
		})
	}
	function makeBasicCalendar(){
		var html="";
		for (var i=1;i<=62;i++){
			var day=new Date(year,month-1,i,9,0,0)
			html+="<th date="+i+" class='"+days[day.getDay()]+" style='width: 25px'>"+day.getDate()+"</td>"
		}
		$("#ganttHead2").html(html)
	}
	
  	function sortable(){
  		var indexBefore = -1
  		$( "td ul.uluser" ).sortable({
  			start: function(event, ui) {
  		        indexBefore = ui.item.index();
  		    },
  			update: function( event, ui ){
  				var indexAfter = ui.item.index()
  				var gantNum=$(this).parent().parent().attr("gantNum");
  				var startDate=$($(this).parent().siblings(".tdstartDate").children(".ulstartDate").children("li")[indexBefore])
				var endDate=$($(this).parent().siblings(".tdendDate").children(".ulendDate").children("li")[indexBefore])
				var duration=$($(this).parent().siblings(".tdduration").children(".ulduration").children("li")[indexBefore])
				var gantPercent=$($(this).parent().siblings(".tdgantPercent").children(".ulgantPercent").children("li")[indexBefore])		
				var calendar=$($('.tbcalendar[gantNum="'+gantNum+'"] tr')[indexBefore])
				if (indexBefore<indexAfter) {
					startDate.insertAfter($($(this).parent().siblings(".tdstartDate").children(".ulstartDate").children("li:eq("+indexAfter+")")))
	  				endDate.insertAfter($($(this).parent().siblings(".tdendDate").children(".ulendDate").children("li:eq("+indexAfter+")")))
	  				duration.insertAfter($($(this).parent().siblings(".tdduration").children(".ulduration").children("li:eq("+indexAfter+")")))
	  				gantPercent.insertAfter($($(this).parent().siblings(".tdgantPercent").children(".ulgantPercent").children("li:eq("+indexAfter+")")))				
	  				calendar.insertAfter($('.tbcalendar[gantNum="'+gantNum+'"]').children("tr:eq("+indexAfter+")"))
				}
				else {
					startDate.insertBefore($($(this).parent().siblings(".tdstartDate").children(".ulstartDate").children("li:eq("+indexAfter+")")))
	  				endDate.insertBefore($($(this).parent().siblings(".tdendDate").children(".ulendDate").children("li:eq("+indexAfter+")")))
	  				duration.insertBefore($($(this).parent().siblings(".tdduration").children(".ulduration").children("li:eq("+indexAfter+")")))
	  				gantPercent.insertBefore($($(this).parent().siblings(".tdgantPercent").children(".ulgantPercent").children("li:eq("+indexAfter+")")))				
	  				calendar.insertBefore($('.tbcalendar[gantNum="'+gantNum+'"]').children("tr:eq("+indexAfter+")"))
				}
  			},
    		receive: function( event, ui ) {			
    			var thisOne=$(this);   			
				var box=ui.helper;
				var name=box.html()
				box.append("<a href='#' class='deleteMember'>-</a>")
				var index=box.index()
				var userNum=box.attr("userNum");
	        	var gantNum=$(this).parent().parent().attr("gantNum");	 
	        	var string='{';
			    string+='"userNum":"'+userNum+'",'
			    string+='"name":"'+name+'",'
			    string+='"gantNum":"'+gantNum+'"}'
			    
			    $.ajax({
			    	method:'POST',
					url:'insertGantMember',
					data: JSON.parse(string),
					success: function(){
						var html="";
		    			html+="<tr class='calendar ganttBody' userNum='"+userNum+"'>";
		     			for (var i=1;i<=62;i++){
		     				var day=new Date(year,month-1,i,9,0,0)
		     				html+="<td date="+i+" class='"+days[day.getDay()]+" ganttBodyCell'>&nbsp;</td>"
		     			}
		     			html+="</tr>"
						if (thisOne.children("li").length-index!=1){
							thisOne.parent().siblings(".tdstartDate").children(".ulstartDate").children("li:eq("+index+")").before("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdendDate").children(".ulendDate").children("li:eq("+index+")").before("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdduration").children(".ulduration").children("li:eq("+index+")").before("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdgantPercent").children(".ulgantPercent").children("li:eq("+index+")").before("<li userNum='"+userNum+"'>0%</li>")						
			     			$('.tbcalendar[gantNum="'+gantNum+'"]').children("tr:eq("+index+")").before(html);									
						} else{							
			     			thisOne.parent().siblings(".tdstartDate").children(".ulstartDate").append("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdendDate").children(".ulendDate").append("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdduration").children(".ulduration").append("<li userNum='"+userNum+"'>&nbsp;</li>")
							thisOne.parent().siblings(".tdgantPercent").children(".ulgantPercent").append("<li userNum='"+userNum+"'>0%</li>")		
			     			$('.tbcalendar[gantNum="'+gantNum+'"]').append(html)			     			
						}
		     			selectable();
		     			sendObject('insertGantMember', string)
					},
			    	error:function(){
			    		alertify.error("한 공정에 같은 멤버를 두번 넣을 수 없습니다")
			    		box.remove()
			    	}
	        	})							    		    
    		}
    	});
  	}
  	function selectable(){
  		$( ".calendar" ).each(function(index,item){
	    	 $(this).selectable({
		        stop: function() {
		        	$(".holyH").removeClass("ui-selected");
		        	var select=$(this).children(".ui-selected");
		        	var userNum=$(this).attr("userNum");
		        	var gantNum=$(this).parent().attr("gantNum");
		        	var startDate=(new Date(year,month-1,parseInt(select.first().attr("date")),9,0,0)).toISOString().substring(0, 10);
		        	var endDate=(new Date(year,month-1,parseInt(select.last().attr("date")),9,0,0)).toISOString().substring(0, 10);
		        	var duration=select.length		    			        	 	
		        	var string='{';
				    string+='"userNum":"'+userNum+'",'
				    string+='"gantNum":"'+gantNum+'",'
				    string+='"startDate":"'+startDate+'",'
				    string+='"endDate":"'+endDate+'",'
				    string+='"duration":'+duration+'}'
				    var thisOne=$(this);
		        	$.ajax({
				    	method:'POST',
						url:'updateGantMember',
						data: JSON.parse(string),
						success: function(data){
							$('.trtodo[gantNum="'+gantNum+'"] .tdstartDate .ulstartDate li[userNum="'+userNum+'"]').html(startDate)
							$('.trtodo[gantNum="'+gantNum+'"] .tdendDate .ulendDate li[userNum="'+userNum+'"]').html(endDate)
							$('.trtodo[gantNum="'+gantNum+'"] .tdduration .ulduration li[userNum="'+userNum+'"]').html(duration)
							sendObject('updateGantMember', string)
						}
		        	})
		        	
			    }
			});
	    })
  	}
  	
  </script>
</head>
<body style="background-color: #fff; overflow-y: auto; overflow-x: auto;" class="unselectable" unselectable="on">
<input type="hidden" id="proNum" value=${proNum}>

<fieldset>
	<legend>Member List</legend>
	<ul>	
		<c:forEach var="u" items="${userList}">
			<li id="draggable" userNum=${u.userNum} style="list-style: none;">${u.name}</li>
		</c:forEach>
	</ul>
</fieldset>
<br />



<!-- 공정도 표 -->
<div id="workSpace" style="padding: 0px; overflow-y: auto; overflow-x: hidden; border: 1px solid rgb(229, 229, 229); position: relative; margin: 0px 5px; width: 1900px; height: 847px;">
<div class="splitterContainer">
<div class="splitElement splitBox1" style="width: 580px; left: 0px;">
<div class="gdfWrapper">
<table class="gdfTable" cellspacing="0" cellpadding="0" __template="TASKSEDITHEAD" style="width: 0px;">     
	<thead>     
		<tr style="height:40px;">
			<th class="gdfColHeader" style="width:35px;"><a href="#" id="new">+</a></th>
			<th class="gdfColHeader gdfResizable" style="width:100px; font-size: 15px;">assignees</th> 
			<th class="gdfColHeader gdfResizable" style="width:100px; font-size: 15px;">name</th>       
			<th class="gdfColHeader gdfResizable" style="width:80px; font-size: 15px;">start</th>       
			<th class="gdfColHeader gdfResizable" style="width:80px; font-size: 15px;">end</th>       
			<th class="gdfColHeader gdfResizable" style="width: 90px; font-size: 15px;">dur.</th>       
			<th class="gdfColHeader gdfResizable" style="width: 90px; font-size: 15px;">pro.</th>       
		</tr>     
	</thead>   
	<tbody>	
	<c:forEach var="l" items="${gantchartlist}">
	<tr taskid="-1" class="taskEditRow trtodo" level="0" __template="TASKROW" gantnum="${l.gantNum}">
		<th class="gdfCell" align="right" style="cursor:pointer;"></th>
		<td class="gdfCell todo" style="padding-left: 18px;">${l.todo}<a href="#" class="deleteTodo">-</a></td>
		<td class="gdfCell tduser" style="padding-left: 18px;">	
			<ul class="uluser ui-sortable">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}" style="list-style: none; width: 27px; height: 16px;" class="ui-draggable ui-draggable-handle">${m.name}<a href='#' class='deleteMember'>-</a></li>
				</c:forEach>
			</ul>
		</td>
		<td class="gdfCell tdstartDate">
			<ul class="ulstartDate">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}">${m.startDate}</li>
				</c:forEach>
			</ul>
		</td>
		<td class="gdfCell tdendDate">
			<ul class="ulendDate">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}">${m.endDate}</li>
				</c:forEach>
			</ul>
		</td>
		<td class="gdfCell tdduration">
			<ul class="ulduration">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}">${m.duration}</li>
				</c:forEach>
			</ul>
		</td>
		<td class="gdfCell tdgantPercent">
			<ul class="ulgantPercent">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}">${m.gantPercent}%</li>
				</c:forEach>
			</ul>
		</td>
		<td class="gdfCell taskAssigs"></td>
	</tr>
	</c:forEach>
	</tbody>
</table>
</div>
</div>

<div class="splitElement splitBox2" style="width: 1200px; left: 575;">
<div class="gantt unselectable hasSVG" style="position: relative; width: 1524px;">
<table cellspacing="0" cellpadding="0" style="width: 1524px; height: 100px;" class="ganttTable">
<thead>
<tr id="ganttHead1">
<th colspan="31"><button id='left'>◀</button><span id="month1"></span></th>
<th colspan="31"><span id="month2"></span><button id='right'>▶</button></th>
</tr>
<tr id="ganttHead2">

</tr>
</thead>
<c:forEach var="l" items="${gantchartlist}">
<tbody class="tbcalendar" gantnum="${l.gantNum}">
	<c:forEach var="m" items="${l.gantMemberList}">			
	<tr class="calendar ganttBody trui-selectable" usernum="${m.userNum}">
	</tr>
	
	</c:forEach>
</tbody>
</c:forEach>
</table>
</div>
</div>
<div class="splitElement vSplitBar" unselectable="on" style="padding-top: 422.5px; left: 570px;">|</div>
</div>
</div>
    <script type="text/javascript">
        //WebSocketEx는 프로젝트 이름
        //websocket 클래스 이름
        var url = window.location.href;//http://localhost:7070/app/gantchartView?usr  asdf&Pnum P000000001&Theme T000000001&title
		var arr = url.split("=")
		var nickname= arr[1]
		var proNum = (arr[2].split("="))[0]
		var theme = (arr[3].split("&"))[0]        
	    var webSocket = new WebSocket("ws://localhost:7070/app/gantSocket?usr="+nickname+"&Pnum="+proNum+"&Theme="+theme);
        //웹 소켓이 연결되었을 때 호출되는 이벤트
        webSocket.onopen = function(message){
        };
        //웹 소켓이 닫혔을 때 호출되는 이벤트
        webSocket.onclose = function(message){
        };
        //웹 소켓이 에러가 났을 때 호출되는 이벤트
        webSocket.onerror = function(message){
        };
        //웹 소켓에서 메시지가 날라왔을 때 호출되는 이벤트
        webSocket.onmessage = function(message){
        };
        //Send 버튼을 누르면 실행되는 함수
        function sendObject(type, object){
            var msg={"type":type,"object":object}
            webSocket.send(JSON.stringify(msg));
        }
        //웹소켓 종료
        function disconnect(){
            webSocket.close();
        }
    </script>
</body>
</html>