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
    width: 1450px;
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
    width: 1440px;
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
			html=html+'<td  colspan="4" class="user">';
			html=html+'	<ul class="connectedSortable">';
			html=html+'	</ul>';
			html=html+'</td>';
			html=html+'</td>';
			html=html+'<td>';
			html=html+'<button class="delete">삭제</button>';
			html=html+'</td>';
			html=html+'</tr>';
				
			$("table").append(html);
			
	    	$( "td ul.connectedSortable" ).sortable({
	    		receive: function( event, ui ) {
					var box=ui.helper;
					box.css("width: 950px;")
					box.prepend()
					box.append('<span><button class="delete">삭제</button></span><input type="text" class="startDate"><input type="text" class="duration">');
					var html="";
	    			html=html+'<ul class="calender">';
	     			for (var i=1;i<=lastday;i++){
	     				html+="<li>"+i+"</li>"
	     			}
	     			html=html+'</ul>';
	     			box.append(html);
					$( ".startDate" ).datepicker({
				    	  dateFormat: "yy/mm/dd"
				    });
	     			$( ".calender" ).each(function(index,item){
	    		    	 $(this).selectable({
	    			        stop: function() {
	    			        	var select=$(this).children(".ui-selected");
	    			        	$(this).parent().children(".startDate").val(year+"/"+month+"/"+select.first().html());
	    			        	$(this).parent().children(".duration").val(select.last().html()-select.first().html()+1);
	    				    }
	    				});
	    		    })
	    		    $('.delete').click(function(){
	    				$(this).parent().parent().remove();
	    			});	
	     			$('.startDate').focusout(function(){
	     				$(this).parent().children(".calender").children("li").removeClass()
	     			    var start=parseInt($(this).val().substr(-2,2));
	     				$(this).parent().children(".duration").val(1);
	     			    $(this).parent().children(".calender").children("li").eq(start-1).addClass("ui-selected")	     			    
	     			});
	     			$('.duration').focusout(function(){
	     				$(this).parent().children(".calender").children("li").removeClass()
	     				var st=parseInt($(this).parent().children('.startDate').val().substr(-2,2));
	     				var du=parseInt($(this).val());
	     				if(isNaN(du)){
	     					alert("기한을 제대로 입력하세요")
	     					return;
	     				}
	     				$(this).parent().children(".calender").children("li").each(function(index,item){
	     					if (index>=st-1 && index<st-1+du){
	     						$(this).addClass("ui-selected");
	     					}
	     				})	    
	     			});
	    		}
	    	});
		    
		    
		   
// 		    $('.delete').click(function(){
// 				$(this).parent().parent().remove();
// 			});	
		    
	    })
	    
	    $('#save').on("click",function(){
		       	var string='{';
		    	$('.todo').each(function(index,item){
		    		var gantNum='G'+("0" + index).slice(-2)+$('#proNum').val()
		    		string+='"list['+index+'].todo":"'+$(this).html()+'",'
		    		string+='"list['+index+'].gantNum":"'+gantNum+'",'
		    		string+='"list['+index+'].proNum":"'+$('#proNum').val()+'",'		    		
		    		var ul=$(this).parent().children(".user").children(".ui-sortable");
		    		ul.children('li').each(function(id,item){		    			
		    			string+='"list['+index+'].gantMemberList['+id+'].userNum":"'+$(this).attr('unum')+'",';
		    			string+='"list['+index+'].gantMemberList['+id+'].gantNum":"'+gantNum+'",';
		    			string+='"list['+index+'].gantMemberList['+id+'].startDate":"'+$(this).children('.startDate').val()+'",'		    			
		    			string+='"list['+index+'].gantMemberList['+id+'].duration":'+$(this).children('.duration').val()+','
		    		})		    		
		    	})
		    	string=string.slice(0, -1);
		    	string+='}'
		    	alert(string)
				$.ajax({
					method:'POST',
					url:'insertGantchart',
					data: JSON.parse(string),
					success: function(data){
						window.location = 'gantchartShowView';
						}
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