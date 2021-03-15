<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-13
  Time: 22:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>添加资源</title>
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
</head>
<body>
<div class="panel panel-default" style="padding-left: 15px;">
    <div class="x_title">
        <h2>新增资源</h2>
        <div class="clear"></div>
    </div>
    <div class="x_content" style="padding-left: 15px;padding-right: 15px;">
        <form class="form-horizontal" id="addResource" onsubmit="return false" data-parsley-validate>
            <input type="hidden" name="parentId" value="${parent.resourceId}">
            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    上级资源
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" value=" ${parent.parentId}" class="form-control" readonly>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    资源名称 <span class="required">*</span>
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="resourceName" class="form-control" required>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    资源URL
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="url" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    权限名称
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="permission" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    资源类型 <span class="required">*</span>
                </label>
                <div class="col-md-3 col-sm-3 col-xs-3">
                    <select class="form-control" name="type" required>
                        <option>请选择资源类型</option>
                        <option value="0">目录</option>
                        <option value="1">菜单</option>
                        <option value="2">按钮</option>
                    </select>
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    图标名称
                </label>
                <div class="col-md-6 col-sm-6 col-xs-6">
                    <input type="text" name="icon" class="form-control">
                </div>
            </div>

            <div class="form-group">
                <label class="control-label col-md-2 col-sm-2 col-xs-2" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">
                    排序
                </label>
                <div class="col-md-2 col-sm-2 col-xs-2">
                    <input type="text" name="orderNum" class="form-control">
                </div>
            </div>

            <div class="ln_solid"></div>
            <div class="form-group">
                <div class="col-md-6 col-sm-6 col-xs-12 col-md-offset-3">
                    <button class="btn btn-primary" type="button" id="btn-back">返回</button>
                    <button type="submit" class="btn btn-primary">提交</button>
                    <button type="reset" id="resetBtn" class="btn btn-warning">重置</button>
                </div>
            </div>
        </form>
    </div>
</div>
<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
<script class="include" type="text/javascript" src="${pageContext.request.contextPath}/lib/jquery.dcjqaccordion.2.7.js"></script>
<script src="${pageContext.request.contextPath}/lib/jquery.scrollTo.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/jquery.nicescroll.js" type="text/javascript"></script>
<!--common script for all pages-->
<script src="${pageContext.request.contextPath}/lib/common-scripts.js"></script>
<!--script for this page-->
<!--bootstrap-table-->
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table.js"></script>
<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>
<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>

<script>

    $(document).ready(function(){
        $("#addResource").submit(function(){
            $.ajax({
                url: '/sys/resource/add',
                type: 'post',
                data: $("#addResource").serialize(),
                dataType: 'json',
                success: function (response) {
                    if (response.code == 0) {
                        window.parent.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                        //跳转到资源管理的初始化页面
                        window.parent.location.href = '${pageContext.request.contextPath}/sys/resource?parentId=${parent.resourceId}';
                    } else {
                        window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                    }
                }
            });
        });
    });




    /**
     * 返回按钮的实现
     */
    $('#btn-back').bind('click',function () {
        window.parent.location.href = '${pageContext.request.contextPath}/sys/resource?parentId=${parent.resourceId}';
    });
</script>





</body>
</html>
