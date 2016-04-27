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
	  $(".updategantPercent").on("click",function(){
		  var li=$(this).parent();
		  var userNum=$(this).parent().attr("userNum");
		  var gantNum=$(this).parent().parent().parent().parent().attr("gantNum");
    	  alertify.prompt("완성도 갱신", function (e, str) {
				if (e && str!=""&& !isNaN(str)) {
					  var gantPercent=str
					  var string='{';
					  string+='"userNum":"'+userNum+'",'
					  string+='"gantNum":"'+gantNum+'",'
					  string+='"gantPercent":"'+gantPercent+'"}'
					  $.ajax({
					  	method:'POST',
						url:'updategantPercent',
						data: JSON.parse(string),
						success: function(data){
							li.children("span").html(gantPercent+"%")					
						}
			    	  })
				} else {
					alertify.error("You've clicked Cancel");
				}
			}, "");
	  })
	  makeCalendar()
	  makeBasicCalendar()
  })
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
  	
  </script>
</head>
<body style="background-color: #fff; overflow-y: auto; overflow-x: auto;" class="unselectable" unselectable="on">
<input type="hidden" id="proNum" value=${proNum}>


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
		<td class="gdfCell todo" style="padding-left: 18px;">${l.todo}</td>
		<td class="gdfCell tduser" style="padding-left: 18px;">	
			<ul class="uluser ui-sortable">
				<c:forEach var="m" items="${l.gantMemberList}">	
				<li usernum="${m.userNum}" style="list-style: none; width: 27px; height: 16px;" class="ui-draggable ui-draggable-handle">${m.name}</li>
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
				<li usernum="${m.userNum}"><span>${m.gantPercent}%</span><c:if test="${m.userNum==userNum}"><a href="#" class="updategantPercent">+</a></c:if></li>
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

</body>
</html>