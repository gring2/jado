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
    float: left;
    margin-right: 10px;
  }
  ul li {
    margin: 0 5px 5px 5px;
    padding: 5px;
    font-size: 1.2em;
    width: 100px;
  }
  ul.calender {
  border: 1px solid #eee;
    width: 950px;
    min-height: 20px;
    list-style-type: none;
    margin: 0;
    padding: 5px 0 0 0;
    float: left;
    margin-right: 10px;
    
  }
  ul.calender li {
    margin: 0 1px 1px 1px;
    padding: 7px;
    font-size: 1em;
    width: 10px;
    display:inline;
  }
  
  #feedback { font-size: 1.4em; }
  .calender .ui-selecting { background: #FECA40; }
  .calender .ui-selected { background: #F39814; color: white; }
  .calender { list-style-type: none; margin: 0; padding: 0; width: 60%; }
  .calender li { margin: 3px; padding: 0.4em; font-size: 1.4em; height: 18px; }
  </style>
  <script>
  $(function() {
	  var today=new Date();
	  var year=today.getFullYear()
	  var month=today.getMonth() + 1;
	  var date=today.getDate()
	  var lastday=(new Date(year,month, 0, 23, 59, 59)).getDate()
	  $("th").eq(4).append((today.getMonth()+1)+'월')	   
	  
	    $( "ul #draggable" ).draggable({
	      connectToSortable: ".connectedSortable",
	      helper: "clone",
	      revert: "invalid"
	    });
	    
	    $("#new").on("click",function(){
			var work=prompt("업무추가");
			if (work==null||"") return false;
			var html='';
			html=html+'<tr>';
			html=html+'<td class="todo">';		
			html=html+work;
			html=html+'</td>';
			html=html+'<td class="user">';
			html=html+'	<ul class="connectedSortable">';
			html=html+'	</ul>';
			html=html+'</td>';
			html=html+'<td>';
			html=html+'	<input type="text" class="startDate">';
			html=html+'</td>';
			html=html+'<td>';
			html=html+'	<input type="text" class="duration">';
			html=html+'</td>';
			html=html+'<td>';
			html=html+'<ul class="calender">';
			for (var i=1;i<=lastday;i++){
				html+="<li>"+i+"</li>"
			}
			html=html+'</ul>';
			html=html+'</td>';
			html=html+'<td>';
			html=html+'<button class="delete">삭제</button';
			html=html+'</td>';
			html=html+'</tr>';
				
			$("table").append(html);
			$( "td ul.connectedSortable" ).sortable();
	    	$( "td ul.connectedSortable" ).sortable();
		    $( ".startDate" ).datepicker({
		    	  dateFormat: "yy-mm-dd"
		    });
		    
		    $( ".calender" ).each(function(index,item){
		    	 $( ".calender" ).eq(index).selectable({
			        stop: function() {
			        	var select=$(this).children(".ui-selected");
				         $(".startDate").eq(index).val(year+"/"+month+"/"+select.first().html());
				         $(".duration").eq(index).val(select.last().html()-select.first().html()+1)
				    }
				});
		    })
		    $('.delete').click(function(){
				$(this).parent().parent().remove();
			});	    
	    })
	    
	    $('#save').on("click",function(){
		    	var list={"list[0].gantNum": "G2", "list[0].proNum":"P000000001", "list[0].todo":"qwer", "list[0].startDate":"2016/04/02", "list[0].duration":8,
		    			"list[0].userNumList[0]":"U000000002"}
		    	var asdf={chatNum:"asdf",userNum:'sss'};
		    	var string='{';
		    	$('.todo').each(function(index,item){
		    		string+='"list['+index+'].todo":"'+$('.todo').eq(index).html()+'",'
		    		string+='"list['+index+'].gantNum":"G'+("0" + index).slice(-2)+$('#proNum').val()+'",'
		    		string+='"list['+index+'].proNum":"'+$('#proNum').val()+'",'
		    		string+='"list['+index+'].duration":'+$('.duration').eq(index).val()+','
		    		string+='"list['+index+'].startDate":"'+$('.startDate').eq(index).val()+'",'
		    		$('.connectedSortable').eq(index).children('.ui-state-highlight').each(function(id,item){
		    			string+='"list['+index+'].userNumList['+id+']":"'+$('.connectedSortable').eq(index).children('.ui-state-highlight').eq(id).attr('unum')+'",';
		    		})		    		
		    	})
		    	string=string.slice(0, -1);
		    	string+='}'
		    	alert(string)
// 		    	string='{"list[0].todo":"디비","list[1].todo":"디비"}'
		    	alert(string)
				$.ajax({
					method:'POST',
					url:'insertGantchart',
					data: JSON.parse(string),
// 				    dataType: 'json',
// 				    contentType:"application/json;charset=utf-8"
				})
				event.preventDefault();		
			});
	    
	});
  </script>
</head>
<body>
<input type="hidden" id="proNum" value=${proNum}>
<button id="new">업무추가</button>
<ul class="">
	<li>팀원</li>
	
	<c:forEach var="u" items="${userList}">
		<li id="draggable" class="ui-state-highlight" unum=${u.userNum}>${u.name}</li>
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
		기한
	</th>
	<th>
	</th>
	<th>
	삭제
	</th>
</tr>
</table>
<br>
<button id="save">저장</button>
 
 
</body>
</html>