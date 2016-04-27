<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE>
<html>
<meta charset="UTF-8">
<head>
<link href="resources/asset/css/style_storage.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="resources/asset/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/simple-line-icons.css"/>
<script type="text/javascript" src="resources/js/jquery-2.2.2.min.js"></script>
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<link rel="stylesheet" type="text/css" href="resources/css/jquery-ui.css">  
<title>Insert title here</title>
<style type="text/css">
	td{
		vertical-align: top;
	}
	.leftbar{
		 padding:0; 
		 vertical-align: top;
		 background: #f2f2f2;
	}
	.fileBox{
		font-size: 8pt;	
		float: left;
		border: 1px dotted #5D8AA8;
		display: inline-block;
		width: 100px;
		height: 100px;
		margin: 20px;
		word-break: break-all;
		background-image: url(resources/img/docs2.png);
		background-size: 100% 100%;
		
	}
		.fileimg{
		font-size: 8pt;	
		float: left;
		border: 1px dotted #5D8AA8;
		display: inline-block;
		width: 100px;
		height: 100px;
		margin: 20px;
		word-break: break-all;
		background-image: url(resources/img/img-icon.png);
		background-size: 100% 100%;
		
	}
	
	.BookBox{
		float: left;
		border: 1px dotted #5D8AA8;
		display: inline-block;
		width: 100px;
		height: 100px;
		margin: 20px;
		word-break: break-all;
		background-image: url(resources/img/docs2.png);
		background-size: 100% 100%;
		background-color:#f2f2f2;
		font-size: 8pt;
	}
	  .fixsize {
	  width: 200px;
      height: 46px;
      padding: 0 1em;
      font-size: 18px;
      font-weight: 600;
      line-height: 46px;
      margin-bottom: 2px;
   }
</style>
<script>
  $(function() {
    $( "#tabs" ).tabs();
  });
  </script>
</head>
<body style="width: 700px; height: 650px;">

<div id="tabs">
  <ul>
    <li><a href="#tabs-1" id="showStorage">스토리지</a></li>
    <li><a href="#tabs-2" id="showMeetingBookContainer">회의록</a></li>
  </ul>
  <div id="tabs-1">
  <table style="padding: 5px 5px 5px 0px; margin: auto; width: 100%; height: 80%; border: none;">
	<tr>
		<td width="30%" style="margin: auto; display: inline;" class="leftbar">
		<div id="container" style="display: none">
		<div id="themeList">
		<ul class="nav nav-list">
		<c:forEach var="theme" items="${themeList }">
		<li>
			<button class="btn btn-3d btn-primary thmNum fixsize" type="button" name="thmNum" value="${theme.thmNum }">
            ${theme.themeName }
            </button>
        </li>
		</c:forEach>
		</ul>
		</div>
		<form id="saveFile" action="saveFile" method="post" enctype="multipart/form-data">
		<input type="hidden" name="thmNum" id="thmNum">
		<input type="hidden" name="proNum" id="proNum">
		<input type="file" name="file" id="savefile" style="display: none;">
		</form>
		</div>
		</td>
		<td style="overflow-x: auto; overflow-y: auto;">
			<form id="checkFile" action="deleteFile">
				<div id="fileList" >
				</div>
			</form>
		</td>
	</tr>
</table>
	<div style="padding: 10px;" align="center">
		<input type="button" class="btn btn-3d btn-primary" id="save" value="업로드">
		<input type="button" class="btn btn-3d btn-primary" id="delete" value="삭제">
	</div>
  
  </div>
  <div id="tabs-2">
  <table style="padding: 5px 5px 5px 0px; margin: auto; width: 100%; height: 80%; border: none;">
	<tr>
		<td width="30%" style="margin: auto; display: inline;" class="leftbar">
		<div id="meetingBookContainer" style="display:none; ">
			<div id="themeList">
			<ul class="nav nav-list">
				<c:forEach var="theme" items="${themeList }">
					<button class="btn btn-3d btn-primary BookthmNum fixsize" type="button" name="thmNum" value="${theme.thmNum }">
         	 		  ${theme.themeName }
          			  </button>
				</c:forEach>
			</ul>
			</div>
			<input type="hidden" name="thmNum" id="thmNum">
			<input type="hidden" name="proNum" id="proNum">
			
		</div>		
		</td>
		<td style="overflow-x: auto; overflow-y: auto;">
			<div id="BookList" >
			
			</div>
		</td>
	</tr>
</table>
  </div>
</div>

<%-- <div style="padding: 10px;" align="center">
	<input type="button" class="btn btn-3d btn-primary" id="showStorage" value="스토리지보기">
	<input type="button" class="btn btn-3d btn-primary" id="showMeetingBookContainer" value="회의록보기">
</div>

<table style="padding: 5px; margin: auto; width: 100%; height: 80%; border: none;">
	<tr>
		<td width="30%" style="margin: auto; display: inline;">
		<div id="container" style="display: none">
		<div id="themeList">
		<ul class="nav nav-list">
		<c:forEach var="theme" items="${themeList }">
		<li>
			<button style="margin: 10px; padding: 10px;" class="btn btn-3d btn-primary thmNum" type="button" name="thmNum" value="${theme.thmNum }">
            ${theme.themeName } ${theme.thmNum }
            </button>
        </li>   
		</c:forEach>
		</ul>
		</div>
		<form id="saveFile" action="saveFile" method="post" enctype="multipart/form-data">
		<input type="hidden" name="thmNum" id="thmNum">
		<input type="hidden" name="proNum" id="proNum">
		<input type="file" name="file" id="savefile" style="display: none;">
		</form>
		</div>
		
		<div id="meetingBookContainer" style="display:none; ">
			<div  id="themeList">
			<ul class="nav nav-list">
				<c:forEach var="theme" items="${themeList }">
					<button style="margin: 10px; padding: 10px;" class="btn btn-3d btn-primary BookthmNum" type="button" name="thmNum" value="${theme.thmNum }">
         	 		  ${theme.themeName } ${theme.thmNum }<!-- <span class="badge">4</span> -->
          			  </button>
				</c:forEach>
			</ul>
			</div>
			
			<input type="hidden" name="thmNum" id="thmNum">
			<input type="hidden" name="proNum" id="proNum">
			
		</div>		
		</td>
		<td style="overflow-x: auto; overflow-y: auto;">
			<form id="checkFile" action="deleteFile">
				<div id="fileList" >
				</div>
			</form>
			
			<div id="BookList" >
			
			</div>
		</td>
	</tr>
</table>
	<div style="padding: 10px;" align="center">
		<input type="button" class="btn btn-3d btn-primary" id="save" value="업로드">
		<input type="button" class="btn btn-3d btn-primary" id="delete" value="삭제">
	</div> --%>
</body>
<script type="text/javascript">
$(function(){
	
	$('#save').hide();
	$('#delete').hide();
	
	var url = window.location.href;
	var arr = url.split("=")
	var proNum = arr[1]
	$('#showStorage').on('click',function(){
		$('#meetingBookContainer').css('display', 'none')
		$('#container').css('display', 'block')
	})
	$('#showMeetingBookContainer').on('click',function(){
		$('#container').css('display', 'none')
		$('#meetingBookContainer').css('display', 'block')
	})	
	$('.BookthmNum').on('click',function(){
		$('#save').show();
		$('#delete').show();
		thmNum = $(this).val();
		$("#thmNum").val(thmNum)
		var mydata={
				"thmNum" : thmNum
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"getBookList"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					$('#BookList').empty();
					var cnt=0;
					for(var row =0; row<Math.ceil(response.length/3);row++){					
						for(var a=0;a<3;a++ ){
						$('#BookList').append(
							"<div class = 'BookBox'><span><input type='checkbox' name='check'></span><a href='viewBook?thmNum="+response[cnt].thmNum
							+"&chatDate="+response[cnt].chatDate+"'>"+response[cnt].chatDate+"</a></div>"		
					)
					cnt++;
						}
					$('#fileList').append('<br />')
					}
				},error:function(response){
					
				}
			})
	});

	
	
 	$('.thmNum').on('click',function(){
 		$('#save').show();
		$('#delete').show();
		thmNum = $(this).val();
		$("#thmNum").val(thmNum)
		var mydata={
				"thmNum" : thmNum
			};
			mydata = JSON.stringify(mydata);
			mydata=$.ajax({
				method:"post"
				,url:"getStgList"
				,data:mydata
				,dataType:"json"
				,contentType:"application/json;charset=utf-8"
				,success:function(response){
					var cnt=0;
					$('#fileList').empty();
					var filename;
					var reg = /[.jpg .png .bmp]$/;
					for(var row =0; row<Math.ceil(response.length/3);row++){
						for(var a=0;a<3;a++ ){
							filename = response[cnt].fileName;
							if(!reg.test(filename)){
								$('#fileList').append(
										
										"<div class = 'fileBox' ><span><input type='checkbox' name='check' value='" + response[cnt].fileName
										+ "'></span><a href='download?fileName="+response[cnt].thmNum+"_"+response[cnt].fileName
										+"'>"+response[cnt].fileName+"</a></div>"	
								)
								
							}else{
								
							$('#fileList').append(
									
									"<div class = 'fileimg'><span><input type='checkbox' name='check' value='" + response[cnt].fileName
									+ "'></span><a href='download?fileName="+response[cnt].thmNum+"_"+response[cnt].fileName
									+"'>"+response[cnt].fileName+"</a></div>"	
							)
							}
							cnt++;
						}
					$('#fileList').append('<br />')
					}
				},error:function(response){
					
				}	
			})
	});
	
	$('#save').on('click',function(){
		$('#savefile').trigger('click');
	     var val = $("#savefile").val();

	});
	$("#savefile").change(function(){
		var fileName = $(this).val();
		$('#proNum').val(proNum)
		$('#saveFile').submit();
	})
	
 	$('#delete').on('click',function(){
		alert("삭제버튼클릭");
		$('input:checkbox[name="check"]').each(function() {
			if(this.checked) {
				var fileName = this.value;
			 	var mydata={
						"fileName" : fileName
					};
			 	mydata = JSON.stringify(mydata);
			 	mydata=$.ajax({
						method:"post"
						, url:"deleteFile"
						, data:mydata
						, dataType:"json"
						, contentType:"application/json;charset=utf-8"
						, success:function(response){
							alert("success");
							alert(response);
						 	var cnt=0;
							$('#fileList').empty();
							for(var row =0; row<Math.ceil(response.length/3);row++){
								for(var a=0;a<3;a++ ){
									$('#fileList').append(
											"<div class = 'fileBox'><span><input type='checkbox' name='check' value='" + response[cnt].fileName
											+ "'></span><a href='download?fileName="+response[cnt].thmNum+"_"+response[cnt].fileName
											+"'>"+response[cnt].fileName+"</a></div>"	
									)
									cnt++;
								}
							$('#fileList').append('<br />')
							}
						}, error:function(response){
							
						}	
					})
			}
		});

	});
	
})
</script>
</html>