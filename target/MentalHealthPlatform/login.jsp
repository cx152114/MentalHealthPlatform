<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-22
  Time: 13:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>大学生心理健康平台</title>
    <!-- Favicons -->
    <link href="img/favicon.png" rel="icon">
    <link href="img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Bootstrap core CSS -->
    <link href="lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!--external css-->
    <link href="lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="css/style.css" rel="stylesheet">
    <link href="css/style-responsive.css" rel="stylesheet">
</head>
<body>
<!-- **********************************************************************************************************************************************************
  MAIN CONTENT
  *********************************************************************************************************************************************************** -->
<div id="login-page">
    <div class="container">
        <div class="form-login">
            <h2 class="form-login-heading">大学生心理健康平台</h2>
            <div class="login-wrap">
                <input type="text" class="form-control" id="username" name="username" placeholder="用户名" autofocus>
                <br>
                <input type="password" class="form-control" id="password" name="password" placeholder="密码">

                <label class="checkbox">
                    <!--<input type="checkbox" value="remember-me"> 记住密码-->
                    <span class="pull-right">
<%--            <a data-toggle="modal" href="login.html#myModal"> 忘记密码？</a>--%>
            </span>
                </label>
                <button class="btn btn-theme btn-block" id="btn-login"  type="submit"><i class="fa fa-lock"></i>登录</button>
                <hr>
            </div>
        </div>
    </div>

    <!-- modal -->
</div>
<!-- js placed at the end of the document so the pages load faster -->
<script src="lib/jquery/jquery.min.js"></script>
<script src="lib/bootstrap/js/bootstrap.min.js"></script>
<!--BACKSTRETCH-->
<!-- You can use an image of whatever size. This script will stretch to fit in any screen size.-->
<script type="text/javascript" src="lib/jquery.backstretch.min.js"></script>

<script src="lib/layer/layer.js"></script>
<script>
    $.backstretch("img/login-bg.jpg", {
        speed: 500
    });

    document.querySelector("#btn-login").onclick = function(){
        var username = $("#username").val();
        var password = $("#password").val();
        if(username == '' || username == 'undefined'){
            alert("请填写用户名！");

            return;
        }
        if(password == '' || password == 'undefined'){
            alert("请填写密码！");
            return;
        }

        $.ajax({
            url:'/login/login',
            data:{username:username,password:password},
            type:'post',
            dataType:'json',
            success:function(response){
                console.log(response);
                if (response.code == 0) {
                    layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '/login/main';
                } else {
                    layer.alert(response.msg, {icon: 5, offset: '400px'});
                }
            }
        });
    }

</script>


</body>
</html>
