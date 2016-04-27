<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="resources/js/jquery-2.2.2.min.js"></script>
	<link href="https://fonts.googleapis.com/css?family=Yanone+Kaffeesatz" rel="stylesheet" type="text/css">
<style type="text/css">
body{
	background-color: white;
}
.wrap {
     width: 500px;
     margin: 0 auto;
}
.btn-holder {
     text-align: center;
     margin: 10px 0 10px 0;
}
#calendar table {
     border-collapse: collapse;
     text-align: center;
}
#calendar table thead td, th {
     height: 50px;
     font-weight: bold;
     
}  
#calendar table td, th {
     border: solid 1px white;
}
#calendar table td.date-cell {
     height: 50px;
}
#calendar table td.sun {
     color: red;
}
#calendar table td.sat {
     color: blue;
}
#calendar table td.not-this-month {
     background: #ddd;
     color: #999;
}
#btnPrev, #btnNext {
    background: #2196F3;
	width: 80px;height: 30px;
	text-align: center;
	font-size: 20px;
}
.moving{
	 display: inline-block;
}
#set{
	position: relative; right: 25%;
}
#currentDate{
	position: relative; right: 15%;
	font-family: 'Yanone Kaffeesatz', sans-serif;
    text-align: center;
    font-size: 40px;
    text-shadow: 0 0px 30px rgba(0, 0, 0, 0.2);
}
th{
    background: 	#2196F3;
}
</style>
</head>
<body>
<div class='wrap'>
     <div class='btn-holder'>
     <div class="moving" id="set" >
          <div class="moving" id='btnPrev' style=""><</div>
          <div class="moving" id='btnNext'>></div>
     </div>
          <span id='currentDate' ></span>
     </div>
     <div id="calendar"></div>
</div>
<script type="text/javascript">
var calendar = new controller();
calendar.init();
function controller(target) {

     var that = this;  
     var m_oMonth = new Date();
     m_oMonth.setDate(1);

     this.init = function() {
          that.renderCalendar();
          that.initEvent();
     }

    /* 달력 UI 생성 */
     this.renderCalendar = function() {
          var arrTable = [];

          arrTable.push("<table id='table1'><colgroup>");
          for(var i=0; i<7; i++) {
               arrTable.push('<col width="100">');
          }         
          arrTable.push('</colgroup><thead><tr>');

          var arrWeek = "일월화수목금토".split("");

          for(var i=0, len=arrWeek.length; i<len; i++) {
               var sClass = '';
               sClass += i % 7 == 0 ? 'sun' : '';
               sClass += i % 7 == 6 ? 'sat' : '';
               arrTable.push('<th class="'+sClass+'">' + arrWeek[i] + '</th>');
          }
          arrTable.push('</tr></thead>');
          arrTable.push('<tbody>');

          var oStartDt = new Date(m_oMonth.getTime());
        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
          oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());

          for(var i=0; i<100; i++) {
               if(i % 7 == 0) {
                    arrTable.push('<tr>');
               }

               var sClass = 'date-cell '
            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
               sClass += i % 7 == 0 ? 'sun' : '';
               sClass += i % 7 == 6 ? 'sat' : '';

               arrTable.push('<td class="'+sClass+'">' + oStartDt.getDate() + '</td>');
               oStartDt.setDate(oStartDt.getDate() + 1);

               if(i % 7 == 6) {
                    if(m_oMonth.getMonth() != oStartDt.getMonth()) {
                         break;
                    }
               }
          }
          arrTable.push('</tbody></table>');

          $('#calendar').html(arrTable.join(""));

          that.changeMonth();
     }

    /* Next, Prev 버튼 이벤트 */
     this.initEvent = function() {
          $('#btnPrev').click(that.onPrevCalendar);
          $('#btnNext').click(that.onNextCalendar);
     }

    /* 이전 달력 */
     this.onPrevCalendar = function() {
          m_oMonth.setMonth(m_oMonth.getMonth() - 1);
          that.renderCalendar();
     }

    /* 다음 달력 */
     this.onNextCalendar = function() {
          m_oMonth.setMonth(m_oMonth.getMonth() + 1);
          that.renderCalendar();
     }

    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
     this.changeMonth = function() {
          $('#currentDate').text(that.getYearMonth(m_oMonth));
     }

    /* 날짜 객체를 년 월 문자 형식으로 변환 */
     this.getYearMonth = function(oDate) {
    	var x = oDate.getMonth();
    	var yy;
    	switch (x) {
		case 0:
			yy= "January"
			break;
		case 1:
			yy= "Fabruary"
			break;
		case 2:
			yy= "March"
			break;
		case 3:
			yy= "April"
			break;
		case 4:
			yy= "May"
			break;
		case 5:
			yy= "June"
			break;
		case 6:
			yy= "July"
			break;
		case 7:
			yy= "Auguest"
			break;
		case 8:
			yy= "September"
			break;
		case 9:
			yy= "October"
			break;
		case 10:
			yy= "Nobember"
			break;
		case 11:
			yy= "December"
			break;
			
		}
          return yy ;
     }
}
$(function(){
	
$('body').on('click','td',function(){
	  var col = $(this).parent().children().index($(this));
	  var row = $(this).parent().parent().children().index($(this).parent());
	  $(this).css('backgroundColor',' #999')
	send(row,col);
	  var xx=  document.getElementById('table1')
});
})
function ChanColor(row,col){
	var xx=  document.getElementById('table1').rows[row].cells[col];
	$(xx).css('backgroundColor','#999')
}
</script>
<script type="text/javascript">
var ws = null;
var nickname= "<c:out value='${sessionScope.loginName}' />";
alert(nickname)
function connect() {
  // 아래의 적색 경로는 서버측의 ServerEndPoint 를 사용해야 하고 ? 표시 오른쪽에는 파라미터가 온다
var target = "ws://203.233.196.76:8666/app/cal?usr="+nickname+"&Pnum=One&Theme=Develop"; //서버에서 파라미터를 
 if ('WebSocket' in window) {
	 ws = new WebSocket(target);
 
 } else if ('MozWebSocket' in window) {
     ws = new MozWebSocket(target);
 } else {
     alert('WebSocket is not supported by this browser.');
     return;
 }
 ws.onopen = function () {

 };
 ws.onmessage = function (event) {
	 var data = event.data
	 var data2=data.split(":")
	var data3 = data2[2].split(",")

	var data2_1=data2[1].substr(1,1)
	var data3_1=data3[0].substr(0,1);
	 data2_1=Number(data2_1)+1;
	 data3_1=Number(data3_1);
	 ChanColor(data2_1,data3_1)

 };
 ws.onclose = function () {
     document.getElementById("msg").innerText = 'Info: WebSocket connection closed.';
 
 };
}
function send(row, col) {// JSON 문자열을 서버로 전송한다
	var msg = {
			"usrName":"nickname", "row":row.toString(), "col":col.toString()
		};
		var jsonStr = JSON.stringify(msg);
		ws.send(jsonStr);
        //	ws.send(msg);
    //});
}

$(function(){
	connect();

})
</script>

</body>
</html>