<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="description" content="Miminium Admin Template v.1">
<meta name="author" content="Isna Nur Azis">
<meta name="keyword" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>JADo(JoinAndDo)</title>

<!-- start: Css -->
<link rel="stylesheet" type="text/css" href="resources/asset/css/bootstrap.min.css">

<!-- plugins -->
<link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/font-awesome.min.css"/>
<link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/simple-line-icons.css"/>
<link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/animate.min.css"/>
<link rel="stylesheet" type="text/css" href="resources/asset/css/plugins/icheck/skins/flat/aero.css"/>
<link href="resources/asset/css/style.css" rel="stylesheet">
<!-- end: Css -->

<link rel="shortcut icon" href="resources/asset/img/logomi.png">
<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

  <body id="mimin" class="dashboard form-signin-wrapper">

    <div class="container">

      <form class="form-signin" action="join" method="post">
        <div class="panel periodic-login">
            <span class="atomic-number">28</span>
            <div class="panel-body text-center">
                <h1 class="atomic-symbol">Mi</h1>
                <p class="atomic-mass">14.072110</p>
                <p class="element-name">Miminium</p>

                <i class="icons icon-arrow-down"></i>
                <div class="form-group form-animate-text" style="margin-top:40px !important;">
                  <input type="text" id="userid" name="id" class="form-text" required>
                  <span class="bar"></span>
                  <label>Email</label>
                </div>
                <div class="form-group form-animate-text" style="margin-top:40px !important;">
                  <input type="text" id="username" name="name" class="form-text" required>
                  <span class="bar"></span>
                  <label>UserName</label>
                </div>
                <div class="form-group form-animate-text" style="margin-top:40px !important;">
                  <input type="password" id="userpassword" name="password" class="form-text" required>
                  <span class="bar"></span>
                  <label>Password</label>
                </div>
                <label class="pull-left">
                <input type="checkbox" class="icheck pull-left" name="checkbox1"/> &nbsp Agree the terms and policy
                </label>
                <input type="submit" class="btn col-md-12" value="SignUp"/>
            </div>
              <div class="text-center" style="padding:5px;">
                  <a href="loginView">Already have an account?</a>
              </div>
        </div>
      </form>

    </div>

    <!-- end: Content -->
    <!-- start: Javascript -->
    <script src="resources/asset/js/jquery.min.js"></script>
    <script src="resources/asset/js/jquery.ui.min.js"></script>
    <script src="resources/asset/js/bootstrap.min.js"></script>

    <script src="resources/asset/js/plugins/moment.min.js"></script>
    <script src="resources/asset/js/plugins/icheck.min.js"></script>

    <!-- custom -->
    <script src="resources/asset/js/main.js"></script>
    <script type="text/javascript">
     $(document).ready(function(){
       $('input').iCheck({
        checkboxClass: 'icheckbox_flat-aero',
        radioClass: 'iradio_flat-aero'
      });
     });
   </script>
   <!-- end: Javascript -->
 </body>
 </html>