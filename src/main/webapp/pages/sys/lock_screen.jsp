<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-05-08
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <title>锁屏</title>

    <!-- Favicons -->
    <link href="${pageContext.request.contextPath}/img/favicon.png" rel="icon">
    <link href="${pageContext.request.contextPath}/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <link href="${pageContext.request.contextPath}/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />

    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-responsive.css" rel="stylesheet">

</head>
<body onload="getTime()">
<!-- **********************************************************************************************************************************************************
    MAIN CONTENT
    *********************************************************************************************************************************************************** -->
<div class="container">
    <div id="showtime"></div>
    <div class="col-lg-4 col-lg-offset-4">
        <div class="lock-screen">
            <h2><a data-toggle="modal" href="#myModal"><i class="fa fa-lock"></i></a></h2>
            <p>UNLOCK</p>
            <!-- Modal -->
            <div aria-hidden="true" aria-labelledby="myModalLabel" role="dialog" tabindex="-1" id="myModal" class="modal fade">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                            <h4 class="modal-title">欢迎回来</h4>
                        </div>
                        <div class="modal-body">
                            <p class="centered"><img class="img-circle" width="80" src="${pageContext.request.contextPath}/img/ui-sam.jpg"></p>
                            <input type="password" id="password" name="password" placeholder="Password" autocomplete="off" class="form-control placeholder-no-fix">
                        </div>
                        <div class="modal-footer centered">
                            <button data-dismiss="modal" class="btn btn-theme04" type="button">取消</button>
                            <button class="btn btn-theme03" type="button" id="btn-login">登录</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- modal -->
        </div>
        <!-- /lock-screen -->
    </div>
    <!-- /col-lg-4 -->
</div>
<!-- /container -->
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>


<script type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.backstretch.min.js"></script>
<script>
    $.backstretch("${pageContext.request.contextPath}/img/login-bg.jpg", {
        speed: 500
    });
</script>
<script>
    document.querySelector("#btn-login").onclick = function(){
        var password = $("#password").val();
        if(password == '' || password == 'undefined'){
            alert("请填写密码！");
            return;
        }

        $.ajax({
            url:'/login/unlock',
            data:{password:password},
            type:'post',
            dataType:'json',
            success:function(response){
                console.log(response);
                if (response.code == 0) {
                    layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '/login/main';
                } else {
                    layer.alert(response.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }




    function getTime() {
        var today = new Date();
        var h = today.getHours();
        var m = today.getMinutes();
        var s = today.getSeconds();
        // add a zero in front of numbers<10
        m = checkTime(m);
        s = checkTime(s);
        document.getElementById('showtime').innerHTML = h + ":" + m + ":" + s;
        t = setTimeout(function() {
            getTime()
        }, 500);
    }

    function checkTime(i) {
        if (i < 10) {
            i = "0" + i;
        }
        return i;
    }
</script>
</body>

</html>
