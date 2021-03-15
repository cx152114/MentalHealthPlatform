<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-11
  Time: 22:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>大学生心理健康平台——error</title>
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
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3 p404 centered">
                <br><br><br><br>
                <h1 class="error-number">${code}</h1>
                <h2>${error}</h2>
                <p>${msg}</p>
                <button class="btn btn-theme mt" type="button" onclick="window.history.go(-1);">返回</button>


<%--                <img src="${pageContext.request.contextPath}/img/404.png" alt="">--%>
<%--                <h1>DON'T PANIC!!</h1>--%>
<%--                <h3>The page you are looking for doesn't exist.</h3>--%>
<%--                <br>--%>
<%--                <div class="row">--%>
<%--                    <div class="col-md-8 col-md-offset-2">--%>
<%--                        <input type="text" class="form-control" id="form1Name" name="form1Name">--%>
<%--                        <button class="btn btn-theme mt">Search</button>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <h5 class="mt">Hey, maybe you will be interested in these pages:</h5>--%>
<%--                <p><a href="index.html">Index</a> | <a href="#">Sitemap</a> | <a href="contact.html"> Contact</a></p>--%>
            </div>
        </div>
    </div>
    <!-- js placed at the end of the document so the pages load faster -->
    <script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
