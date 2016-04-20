<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>jQuery UI Sortable - Connect lists</title>
  <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <style>
  ul {
    border: 1px solid #eee;
    width: 120px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;    
    margin-right: 10px;
  }
  ul li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 100px;
  }
  ul.connectedSortable {
    border: 1px solid #eee;
    width: 1600px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
  }
  ul.connectedSortable li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 1580px;
  }
  ul.calender {
 	border: 1px solid #eee;
    display:inline;
  }
  ul.calender li {
    margin: 0 1px 1px 1px;
    padding: 7px;
    font-size: 1em;
    width: 10px;
    display:inline;
  }
  span{
  	min-width: 100px;
  }
  
  #feedback { font-size: 1.4em; }
  .calender .ui-selecting { background: #FECA40; }
  .calender .ui-selected { background: #F39814; color: white; }
  .calender { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  .calender li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
  .calender .sun { background: #14dff3; }
  .calender .sat { background: #14dff3; }
  </style>
  <script>
  var today=new Date();
  var year=today.getFullYear()
  var month=today.getMonth() + 1;
  var date=today.getDate()
  var lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
  var days=['sun','mon','tue','wed','thu','fri','sat']
  var gantOrder=0
  $(function() {
	  if($(".todo").length!=0) gantOrder=parseInt($(".todo").last().attr("gantNum").substr(1, 2))+1;
	  $("#month").html(year+'년'+month+'월')	  
	  $( "#left" ).on("click",function(){
		  month=month-1;
		  if(month==0){
			  month=12;
			  year=year-1
		  }
		  $("#month").html(year+'년'+month+'월')	
		  lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
// 		  var html=""
// 		  for (var i=1;i<=lastday;i++){
// 			  var day=(new Date(year,month-1,i,0,0,0)).getDay()
// 				html+="<li class='"+days[day]+"'>"+i+"</li>"
//    			}
// 		  $(".calender").html(html);
		  makeCalender()
	  })
	  $( "#right" ).on("click",function(){
		  month=month+1;
		  if(month==13){
			  month=1;
			  year=year+1
		  }
		  $("#month").html(year+'년'+month+'월')	
		  lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
// 		  var html=""
// 			  for (var i=1;i<=lastday;i++){
// 				  var day=(new Date(year,month-1,i,0,0,0)).getDay()
//    				html+="<li class='"+days[day]+"'>"+i+"</li>"
// 	   			}
// 			$(".calender").html(html);
			 makeCalender()
	  })
	  
		$( "ul #draggable" ).draggable({
		  connectToSortable: ".connectedSortable",
		  helper: "clone",
		  revert: "invalid"
		});
	    
	    $("#new").on("click",function(){
	    	var gantNum='G'+("0" + gantOrder).slice(-2)+$('#proNum').val()
			var work=prompt("업무추가");
			if (work==null||"") return false;
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
					html=html+'<tr>';
					html=html+'<td class="todo" gantNum="'+gantNum+'">';		
					html=html+work;
					html=html+'<button class="deleteTodo">삭제</button>';
					html=html+'</td>';
// 					html=html+'<td  colspan="4" class="user">';
					html=html+'	<ul class="connectedSortable">';
					html=html+'	</ul>';
					html=html+'</td>';
					html=html+'</tr>';
					$("table").append(html);
					gantOrder+=1
					sortable();
				}				    
			})
			
		    
	    })
	    $('table').on('click','.deleteTodo',function(){
			var tr=$(this).parent().parent()
		    var string='{"gantNum":"'+$(this).parent().attr("gantNum")+'"}';
		    $.ajax({
				method:'POST',
				url:'deleteGantchart',
				data: JSON.parse(string),
				success: function(data){
					tr.remove();
				}
			})		    	
		});
	    $('table').on('click','.deleteMember',function(){
	    	var li=$(this).parent()
	    	var userNum=$(this).parent().attr("userNum");
        	var gantNum=$(this).parent().parent().parent().siblings('.todo').attr("gantNum");
        	var string='{';
		    string+='"userNum":"'+userNum+'",'
		    string+='"gantNum":"'+gantNum+'"}'
		    $.ajax({
		    	method:'POST',
				url:'deleteGantMember',
				data: JSON.parse(string),
				success: function(data){
					li.remove();
				}
        	})				
		});	
	    makeCalender()
		sortable();
	    selectable();
	});
	function makeCalender(){
		$(".calender").each(function(index,item){
	    	var startDate=new Date($(this).siblings(".startDate").html());
	    	var endDate=new Date($(this).siblings(".endDate").html());
			var html='';
			for (var i=1;i<=35;i++){
				var day=new Date(year,month-1,i,9,0,0)
				html+="<li date="+i+" class='"+days[day.getDay()]+" ui-selectee"
				if(day.getDay()!=0 && day.getDay()!=6){
 					if(day>=startDate && day<=endDate){
 						html+=" ui-selected"
 					}					
				} 
				html+="'>"+day.getDate()+"</li>"					
					
			}
			$(this).html(html);		  
		})
	}
  	function sortable(){
  		$( "td ul.connectedSortable" ).sortable({
    		receive: function( event, ui ) {
				var box=ui.helper;
				box.css("width: 950px;")
				box.prepend()
				box.append('&nbsp;<button class="deleteMember">삭제</button>&nbsp;<span class="startDate"></span>&nbsp;<span class="endDate"></span>&nbsp;<span class="duration"></span>&nbsp;<span class="gatPercent">0%</span>&nbsp;');
				var userNum=box.attr("userNum");
	        	var gantNum=$(this).parent().siblings('.todo').attr("gantNum");
	        	alert(userNum+"/"+gantNum)
	        	var string='{';
			    string+='"userNum":"'+userNum+'",'
			    string+='"gantNum":"'+gantNum+'"}'
	        	$.ajax({
			    	method:'POST',
					url:'insertGantMember',
					data: JSON.parse(string),
					success: function(data){
						var html="";
		    			html=html+'<ul class="calender">';
		     			for (var i=1;i<=35;i++){
		     				var day=new Date(year,month-1,i,9,0,0)
		     				html+="<li date="+i+" class='"+days[day.getDay()]+"'>"+day.getDate()+"</li>"
		     			}
		     			html=html+'</ul>';
		     			box.append(html);
		     			selectable();
					}
	        	})							    		    
    		}
    	});
  	}
  	function selectable(){
  		$( ".calender" ).each(function(index,item){
	    	 $(this).selectable({
		        stop: function() {
		        	$(".sat,.sun").removeClass("ui-selected");
		        	var select=$(this).children(".ui-selected");
		        	var userNum=$(this).parent().attr("userNum");
		        	var gantNum=$(this).parent().parent().parent().siblings('.todo').attr("gantNum");
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
							thisOne.parent().children(".startDate").html(startDate);
							thisOne.parent().children(".endDate").html(endDate);
							thisOne.parent().children(".duration").html(duration);
						}
		        	})
		        	
			    }
			});
	    })
  	}
  </script>
</head>
<body>
<input type="hidden" id="proNum" value=${proNum}>
<button id="new">업무추가</button>
<ul class="">
	<li>팀원</li>
	
	<c:forEach var="u" items="${userList}">
		<li id="draggable" class="ui-state-highlight" userNum=${u.userNum}><span class="name">${u.name}</span></li>
	</c:forEach>
</ul>

<table border="1">
<tr>
	<th>
		업무
	</th>
	<th>
		담당
	</th>
	<th>
		시작일
	</th>
	<th>
		종료일
	</th>
	<th>
		기한
	</th>
	<th>
		진행도
	</th>
	<th>
		<button id='left'>◀</button><span id="month"></span><button id='right'>▶</button>
	</th>	
</tr>
	<c:forEach var="l" items="${gantchartlist}">
	<tr>
		<td class="todo" gantNum="${l.gantNum}">${l.todo}<button class="deleteTodo">삭제</button></td>
 		<td colspan="6" class="user">
 			<ul class="connectedSortable ui-sortable">
 			<c:forEach var="m" items="${l.gantMemberList}">			
				<li class="ui-state-highlight ui-draggable ui-draggable-handle" usernum="${m.userNum}">
				<span class="name">	${m.name}</span>&nbsp;
				<button class="deleteMember">삭제</button>&nbsp;
				<span class="startDate">${m.startDate}</span>&nbsp;
				<span class="endDate">${m.endDate}</span>&nbsp;
				<span class="duration">${m.duration}</span>&nbsp;
				<span class="gantPercent">${m.gantPercent}%</span>&nbsp;
				<ul class="calender ui-selectable">
				</ul>
				</li>
			</c:forEach>
			</ul>
		</td>
	</tr>
	</c:forEach>
</table> 
</body>
</html>