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
  <script type="text/javascript">
  $(function() {
	  makeCalender()
  })
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
  </script>
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
    width: 1500px;
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
  	width : 100px;
  }
  
  #feedback { font-size: 1.4em; }
  .calender .ui-selecting { background: #FECA40; }
  .calender .ui-selected { background: #F39814; color: white; }
  .calender { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  .calender li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
  </style>
</head>
<body>
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
		기한
	</th>
	<th>
		<button id='left'>◀</button><span id="month"></span><button id='right'>▶</button>
	</th>	
	<th>
	삭제
	</th>
</tr>
	<c:forEach var="l" items="${gantchartlist}">
	<tr>
		<td class="todo" gantNum="${l.gantNum}">${l.todo}</td>
 		<td colspan="4" class="user">
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
		<td>
			<button class="deleteTodo">삭제</button>
		</td>
	</tr>
	</c:forEach>
</table> 
</body>
</html>