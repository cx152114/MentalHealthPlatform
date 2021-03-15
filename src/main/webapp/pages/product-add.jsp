<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-23
  Time: 17:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>添加新商品</title>
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
</head>
<body>
<section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--页面头部-->
    <jsp:include page="header.jsp"></jsp:include>
    <!--页面头部-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--导航侧栏-->
    <jsp:include page="aside.jsp"></jsp:include>
    <!--导航侧栏-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--内容区域-->
    <!--main content start-->
    <section id="main-content">
        <section class="wrapper">
            <h3><i class="fa fa-angle-right"></i> Form Components</h3>
            <!-- BASIC FORM ELELEMNTS -->
            <div class="row mt">
                <div class="col-lg-12">
                    <div class="form-panel">
                        <div style=" text-align: center">
                            <h3 class="mb" > 新增手机信息</h3>
                        </div>
                        <form class="form-horizontal style-form" action="/product/addProduct" method="post">
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">手机名称</label>
                                    <input type="text" class="form-control" name="phoneName" placeholder="手机名称" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">手机类型</label>
                                    <input type="text" class="form-control" name="phoneType" placeholder="手机类型" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">手机颜色</label>
                                    <input type="text" class="form-control" name="phoneColor" placeholder="手机颜色" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">运行内存</label>
                                    <input type="text" class="form-control" name="phoneRAM" placeholder="运行内存" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">储存容量</label>
                                    <input type="text" class="form-control" name="phoneStorage" placeholder="储存容量" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">网络类型</label>
                                    <input type="text" class="form-control" name="phoneNetwork" placeholder="网络类型" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">手机进价</label>
                                    <input type="text" class="form-control" name="phonePurchasingPrice" placeholder="手机进价" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">手机售价</label>
                                    <input type="text" class="form-control" name="phoneSellingPrice" placeholder="手机售价" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">售卖状态</label>
                                    <input type="text" class="form-control" name="phoneState" placeholder="售卖状态" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">手机描述</label>
                                    <input type="text" class="form-control" name="phoneRemark" placeholder="手机描述" style="width: 30%">
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <label class="control-label" style="font-size:19px;margin-left: 5px;">上传图片</label>
                                    <input type="text" class="form-control" name="phoneImage" placeholder="上传图片" style="width: 30%">
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">提交</button>
                            <button type="reset" class="btn btn-warning">取消</button>
                        </form>
                    </div>
                </div>
                <!-- col-lg-12-->
            </div>
            <!-- /row -->
        </section>
        <!-- /wrapper -->
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
        <div class="text-center">
            <p>
                &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
            </p>
            <div class="credits">
                More Templates <a href="http://www.cssmoban.com/" target="_blank" title="模板之家">模板之家</a> - Collect from <a href="http://www.cssmoban.com/" title="网页模板" target="_blank">网页模板</a>
            </div>
            <a href="basic_table.html#" class="go-top">
                <i class="fa fa-angle-up"></i>
            </a>
        </div>
    </footer>
    <!--footer end-->
</section>
<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.dcjqaccordion.2.7.js"></script>
<script src="${pageContext.request.contextPath}/lib/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
<!--script for this page-->
</body>
</html>
