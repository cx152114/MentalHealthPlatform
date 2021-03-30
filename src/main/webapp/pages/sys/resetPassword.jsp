<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-05
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>修改密码</title>
    <!-- Favicons -->
    <link href="${pageContext.request.contextPath}/img/favicon.png" rel="icon">

    <link href="${pageContext.request.contextPath}/img/apple-touch-icon.png" rel="apple-touch-icon">
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!--external css-->
    <link href="${pageContext.request.contextPath}/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-responsive.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/build.css"/>
    <!-- Bootstrap table core CSS -->
    <link href="${pageContext.request.contextPath}/lib/bootstrap-table/css/bootstrap-table.css" rel="stylesheet">
    <%--引入bootstrap用于表单验证的插件--%>
    <link href="${pageContext.request.contextPath}/lib/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">

    <link  href="${pageContext.request.contextPath}/lib/ruoyi/css/ry-ui.css" rel="stylesheet" />


    <style type="text/css">
        th{
            text-align: center;
            vertical-align: middle;
            font-size: 15px;
        }

        td{
            text-align: center;
            font-size: 14px;
        }

        .content-panel{
            padding-left: 15px;
            padding-right: 15px;
        }
    </style>

    <script type="text/javascript">
        window.onload = function(){
            $("#btn-submit").click(function(){
                var password = $("#password").val();
                var password1 = $("#password1").val();
                if(password == '' || password == 'undefined'){
                    layer.alert("请设置密码！", {icon: 5});
                    return;
                }
                if(password1 == '' || password1 == 'undefined'){
                    layer.alert("请设置密码！", {icon: 5});
                    return;
                }

                if(password1 != password1){
                    layer.alert("两次密码不一致！", {icon: 5});
                    return;
                }

                $.ajax({
                    url:'/user/resetPassword',
                    data:{password:password},
                    type:'post',
                    dataType:'json',
                    success:function(response){
                        console.log(response);
                        if (response.code == 0) {
                            layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                            window.location.href = '/login/logout';
                        } else {
                            layer.alert(response.msg, {icon: 5, offset: '0px'});
                        }
                    }
                });
            });
        }
    </script>
</head>

<body>
    <section id="container">
        <!-- **********************************************************************************************************************************************************
            TOP BAR CONTENT & NOTIFICATIONS
            *********************************************************************************************************************************************************** -->
        <!--页面头部-->
        <jsp:include page="../header.jsp"></jsp:include>
        <!--页面头部-->
        <!-- **********************************************************************************************************************************************************
            MAIN SIDEBAR MENU
            *********************************************************************************************************************************************************** -->
        <!--导航侧栏-->
        <jsp:include page="../aside.jsp"></jsp:include>
        <!--导航侧栏-->
        <!-- **********************************************************************************************************************************************************
            MAIN CONTENT
            *********************************************************************************************************************************************************** -->
        <!--内容区域-->
        <section id="main-content">
            <section class="wrapper">
                <div>
                    <div class="row">
                    <h3></h3>
                     <div class="col-md-12 mt" >
                         <div class="content-panel" style="height: 480px;overflow: auto;">
                             <h4 class="mb"><i class="fa fa-angle-right"></i> 修改密码</h4>
                             <form class="form-horizontal style-form" action="/user/editTargetUser" method="post">
                                 <div class="form-group">
                                     <label class="col-sm-2 col-sm-2 control-label">密码</label>
                                     <div class="col-sm-10">
                                         <input type="password" class="form-control" id="password" name="password" placeholder="请输入密码"  >
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-sm-2 col-sm-2 control-label">确认密码</label>
                                     <div class="col-sm-10">
                                         <input type="password" class="form-control" id="password1" name="password" placeholder="请确认密码" >
                                     </div>
                                 </div>

                                 <div class="form-group">
                                     <div class="col-lg-9 col-lg-offset-3">
                                         <button type="button" id="btn-submit" class="btn btn-primary">确认修改</button>
                                         <button type="reset" class="btn btn-default" data-dismiss="modal">取消</button>
                                     </div>
                                 </div>
                             </form>
                         </div>
                     </div>
                    </div>
                </div>
                <!-- /row -->
            </section>
        </section>
        <!--内容区域-->

        <!--底部导航-->
        <footer class="site-footer">
            <div class="text-center">
                <p>
                    &copy; Copyrights <strong>cx</strong>. All Rights Reserved
                </p>
                <a href="#" class="go-top">
                    <i class="fa fa-angle-up"></i>
                </a>
            </div>
        </footer>
        <!--底部导航-->
    </section>
    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>

    <script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
    <script class="include" type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.dcjqaccordion.2.7.js"></script>
    <script src="${pageContext.request.contextPath}/lib/jquery.scrollTo.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/jquery.nicescroll.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/lib/jquery.sparkline.js"></script>
    <!--common script for all pages-->
    <script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter/js/jquery.gritter.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/lib/gritter-conf.js"></script>
    <!--script for this page-->
    <script src="${pageContext.request.contextPath}/lib/sparkline-chart.js"></script>

    <%--layui插件--%>
    <script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>




</body>
</html>


