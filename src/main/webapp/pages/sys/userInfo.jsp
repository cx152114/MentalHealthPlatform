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
    <title>用户管理</title>
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
                             <h4 class="mb"><i class="fa fa-angle-right"></i> 个人信息</h4>
                             <form class="form-horizontal style-form" action="/user/editTargetUser" method="post">
                                 <div class="form-group" style="display: none">
                                     <label class="col-sm-2 col-sm-2 control-label">编号</label>
                                     <div class="col-sm-10">
                                         <input type="text" class="form-control" id="userIdI" name="userId" value="<shiro:principal property="userId"></shiro:principal>">
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-sm-2 col-sm-2 control-label">姓名</label>
                                     <div class="col-sm-10">
                                         <input type="text" class="form-control" id="usernameI" name="username" placeholder="姓名"  value="<shiro:principal property="username"></shiro:principal>">
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-sm-2 col-sm-2 control-label">邮箱</label>
                                     <div class="col-sm-10">
                                         <input type="text" class="form-control" id="userEmailI" name="userEmail" placeholder="邮箱"  value="<shiro:principal property="userEmail"></shiro:principal>">
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <label class="col-sm-2 col-sm-2 control-label">联系电话</label>
                                     <div class="col-sm-10">
                                         <input type="text" class="form-control round-form" id="userPhoneI" name="userPhone" placeholder="联系电话" value="<shiro:principal property="userPhone"></shiro:principal>">
                                     </div>
                                 </div>
                                 <div class="form-group">
                                     <div class="col-lg-9 col-lg-offset-3">
                                         <button type="submit" class="btn btn-primary">提交</button>
                                         <button type="reset" id="resetBtn" class="btn btn-warning">重置</button>
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

<script type="text/javascript">

    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    /**
     * 获取所需要的员工信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/user/getCurrentUsers',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var user=data.user;
                    console.log(user)
                    $("#userIdI").html(user.userId);
                    $("#usernameI").html(user.username);
                    $("#userEmailI").html(user.userEmail);
                    $("#userPhoneI").html(user.userPhone);
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });
    });

</script>


</body>
</html>
