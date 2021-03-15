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
    <title>404</title>
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
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-lg-offset-3 p404 centered">
                <img src="img/404.png" alt="">
                <h1>DON'T PANIC!!</h1>
                <h3>The page you are looking for doesn't exist.</h3>
                <br>
                <div class="row">
                    <div class="col-md-8 col-md-offset-2">
                        <input type="text" class="form-control" id="form1Name" name="form1Name">
                        <button class="btn btn-theme mt">Search</button>
                    </div>
                </div>
                <h5 class="mt">Hey, maybe you will be interested in these pages:</h5>
                <p><a href="index.html">Index</a> | <a href="#">Sitemap</a> | <a href="contact.html"> Contact</a></p>
            </div>
        </div>
    </div>
    <!-- js placed at the end of the document so the pages load faster -->
    <script src="lib/jquery/jquery.min.js"></script>
    <script src="lib/bootstrap/js/bootstrap.min.js"></script>
</body>
</html>
