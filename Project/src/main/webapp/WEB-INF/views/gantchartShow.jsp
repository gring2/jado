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
</head>
<body>
<table border="1">
<table border="1">
<tbody>
	<tr>
		<th>업무	</th><th>담당</th><th>시작일</th><th>기한</th><th>4월</th>
	</tr>
	<tr>
		<td class="todo">qwer</td>
		<td colspan="4" class="user">
			<ul class="connectedSortable ui-sortable">
				<li class="ui-state-highlight ui-draggable ui-draggable-handle" unum="U000000001" style="width: 1440px; height: 26px;">asdf
				<input type="text" class="startDate hasDatepicker" id="dp1460704576167">
				<input type="text" class="duration">
				<ul class="calender ui-selectable"><li class="ui-selectee">1</li><li class="ui-selectee">2</li><li class="ui-selectee">3</li><li class="ui-selectee ui-selected">4</li><li class="ui-selectee ui-selected">5</li><li class="ui-selectee ui-selected">6</li><li class="ui-selectee ui-selected">7</li><li class="ui-selectee ui-selected">8</li><li class="ui-selectee ui-selected">9</li><li class="ui-selectee ui-selected">10</li><li class="ui-selectee ui-selected">11</li><li class="ui-selectee ui-selected">12</li><li class="ui-selectee ui-selected">13</li><li class="ui-selectee ui-selected">14</li><li class="ui-selectee">15</li><li class="ui-selectee">16</li><li class="ui-selectee">17</li><li class="ui-selectee">18</li><li class="ui-selectee">19</li><li class="ui-selectee">20</li><li class="ui-selectee">21</li><li class="ui-selectee">22</li><li class="ui-selectee">23</li><li class="ui-selectee">24</li><li class="ui-selectee">25</li><li class="ui-selectee">26</li><li class="ui-selectee">27</li><li class="ui-selectee">28</li><li class="ui-selectee">29</li><li class="ui-selectee">30</li></ul></li><li class="ui-state-highlight ui-draggable ui-draggable-handle" unum="U000000002" style="width: 1440px; height: 26px;">qwer<span><button class="delete">삭제</button></span><input type="text" class="startDate hasDatepicker" id="dp1460704576169"><input type="text" class="duration"><ul class="calender ui-selectable"><li class="ui-selectee">1</li><li class="ui-selectee">2</li><li class="ui-selectee">3</li><li class="ui-selectee">4</li><li class="ui-selectee">5</li><li class="ui-selectee">6</li><li class="ui-selectee">7</li><li class="ui-selectee">8</li><li class="ui-selectee">9</li><li class="ui-selectee">10</li><li class="ui-selectee">11</li><li class="ui-selectee">12</li><li class="ui-selectee">13</li><li class="ui-selectee ui-selected">14</li><li class="ui-selectee ui-selected">15</li><li class="ui-selectee ui-selected">16</li><li class="ui-selectee ui-selected">17</li><li class="ui-selectee ui-selected">18</li><li class="ui-selectee ui-selected">19</li><li class="ui-selectee ui-selected">20</li><li class="ui-selectee ui-selected">21</li><li class="ui-selectee ui-selected">22</li><li class="ui-selectee ui-selected">23</li><li class="ui-selectee">24</li><li class="ui-selectee">25</li><li class="ui-selectee">26</li><li class="ui-selectee">27</li><li class="ui-selectee">28</li><li class="ui-selectee">29</li><li class="ui-selectee">30</li></ul></li></ul></td><td><button class="delete">삭제</button></td></tr><tr><td class="todo">zxcv</td><td colspan="4" class="user">	<ul class="connectedSortable ui-sortable">	<li class="ui-state-highlight ui-draggable ui-draggable-handle" unum="U000000003" style="width: 1440px; height: 26px;">zxcv<span><button class="delete">삭제</button></span><input type="text" class="startDate hasDatepicker" id="dp1460704576170"><input type="text" class="duration"><ul class="calender ui-selectable"><li class="ui-selectee">1</li><li class="ui-selectee">2</li><li class="ui-selectee">3</li><li class="ui-selectee">4</li><li class="ui-selectee">5</li><li class="ui-selectee">6</li><li class="ui-selectee">7</li><li class="ui-selectee">8</li><li class="ui-selectee">9</li><li class="ui-selectee">10</li><li class="ui-selectee">11</li><li class="ui-selectee">12</li><li class="ui-selectee">13</li><li class="ui-selectee">14</li><li class="ui-selectee">15</li><li class="ui-selectee">16</li><li class="ui-selectee">17</li><li class="ui-selectee">18</li><li class="ui-selectee">19</li><li class="ui-selectee">20</li><li class="ui-selectee">21</li><li class="ui-selectee">22</li><li class="ui-selectee ui-selected">23</li><li class="ui-selectee ui-selected">24</li><li class="ui-selectee ui-selected">25</li><li class="ui-selectee ui-selected">26</li><li class="ui-selectee ui-selected">27</li><li class="ui-selectee ui-selected">28</li><li class="ui-selectee ui-selected">29</li><li class="ui-selectee ui-selected">30</li></ul></li></ul></td><td><button class="delete">삭제</button></td></tr></tbody></table>
</table>
<br> 
</body>
</html>