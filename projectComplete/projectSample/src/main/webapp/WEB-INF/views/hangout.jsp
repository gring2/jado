<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
    <title>Demo: Getting an email address using the Google+ Sign-in button</title>
    <!-- Include the API client and Google+ client. -->
    <script src = "https://plus.google.com/js/client:platform.js" async defer></script>
    
    <link rel="canonical" href="http://www.example.com" />
    <script src="https://apis.google.com/js/platform.js" async defer>
    </script>
    
      <script>
  /**
   * ì¬ì©ì í í¸ë¦¬ê±° ë¡ê·¸ì¸íìµëë¤ ì½ë°± ì ëí í¸ë¤ë¬ë ê³ì ì ì í.
   */
    function onSignInCallback(resp) {
    gapi.client.load('plus', 'v1', apiClientLoaded);
  } 

  /**
   * êµ¬ê¸ API í´ë¼ì´ì¸í¸ ë¡ë í API í¸ì¶ì ì¤ì í©ëë¤.
   */
   function apiClientLoaded() {
    gapi.client.plus.people.get({userId: 'me'}).execute(handleEmailResponse);
  } 

  /**
   * ì´ API ë í´ë¼ì´ì¸í¸ê° ìëµì ìì  í ê²½ì° ì ëí ìëµ ì½ë°±
   *
   * @PARAM ì¬ì©ì ì´ë©ì¼ ë° íë¡í ì ë³´ ì API ìëµ ê°ì²´ë¥¼ RESP.
   */
/*   function handleEmailResponse(resp) {
    var primaryEmail;
    for (var i=0; i < resp.emails.length; i++) {
      if (resp.emails[i].type === 'account') primaryEmail = resp.emails[i].value;
    }
    document.getElementById('responseContainer').value = 'Primary email: ' +
        primaryEmail + '\n\nFull Response:\n' + JSON.stringify(resp);
  } */
  function handleEmailResponse(resp) {
	    var primaryEmail;
	    for (var i=0; i < resp.emails.length; i++) {
	      if (resp.emails[i].type === 'account') primaryEmail = resp.emails[i].value;
	    }
	    document.getElementById('responseContainer').value =  primaryEmail;
	}
  </script>
  </head>

  <body>
    <!-- Container with the Sign-In button. -->
    <div id="gConnect" class="button">
      <button class="g-signin"
          data-scope="email"
          data-clientid="505994836255-963vtom92j9314r6hufvjou5sa705ang.apps.googleusercontent.com" 
          data-callback="onSignInCallback"
          data-theme="dark"
          data-cookiepolicy="single_host_origin">
      </button>
        <textarea id="responseContainer" style="width:100%; height:150px"></textarea>
      </div>
    </div>
    
    <g:hangout render="createhangout"></g:hangout>
 </body>



</html>