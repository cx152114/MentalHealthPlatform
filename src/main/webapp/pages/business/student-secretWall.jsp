<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-02
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>私密公开墙</title>
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

    <link  href="${pageContext.request.contextPath}/lib/summernote/summernote.css" rel="stylesheet" />


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

    <style type="text/css">
        /*//body{background:#d4d0c8;}*/
        td{
            border-left: 1px solid transparent !important;
            border-right: 1px solid transparent !important;
        }
        th{border: 1px solid transparent !important;}
    </style>
</head>
<body>
<section id="container">
    <!--内容区域-->
    <div class="row mt">
        <div class="col-lg-12" style="height: 500px;">
            <div class="col-lg-12">
                <h4><a href="#" class="list-group-item active">
                    私密公开墙</a>
                </h4>
                <div class="content-panel" style="padding-top: 0px;">
                    <table class="table"
                           data-toggle="table"
                           id="secrets"
                           data-detail-view="false"
                           data-detail-formatter="detailFormatter"
                           style="border: 0px solid">
                        <br>
                    </table>
                </div>
            </div>
        </div>
    </div>
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
<!--bootstrap-table-->
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table.js"></script>

<script src="${pageContext.request.contextPath}/lib/tableExport/tableExport.js"></script>
<%--<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>--%>
<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table-locale-all.min.js"></script>
<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/extensions/export/bootstrap-table-export.min.js"></script>


<!-- 数据导出 -->
<script src="${pageContext.request.contextPath}/lib/tableExport/FileSaver.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/xlsx.core.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.plugin.autotable.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/es6-promise.auto.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/html2canvas.min.js"></script>

<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>



<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>

<%--summernote插件--%>
<script src="${pageContext.request.contextPath}/lib/summernote/summernote.js"></script>

<script type="application/javascript">
    /**
     * 初始化表格数据
     */
    var dataTable = $('#secrets').bootstrapTable({
        url: "/business/secret/findAllSecret",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "secretId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 10,                       //  每页的记录行数
        pageList:"[5,10,25,50,100,all]",
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
            }
        },
        columns: [
            {
                field: 'secretId'
            }, {
                field: 'secretMessage'
            }, {
                field: 'createDate'
            }, {
                field: 'hitCount'
            },{
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="sys:secret:search"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"pointLike(this)\">点赞</button></shiro:hasPermission>";

                }
            }]
    });

    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            if(key=="joyContent"){
                html.push("<div style='height:200px;overflow:auto'><b>文章内容：</b> " + value + "</div>")
            }
            if(key=="answer"){
                if (value != null){
                    html.push("<div><b>--</b> " + value + "</div>")
                }
            }
        })
        return html.join('')
    }

    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/business/secret/findAllSecret",
            pageSize: 5,
            pageNumber: 1
        });
    }

    function pointLike(data){
        var value = $(data).parent().parent().find("td");
        var secretId=value.eq(0).text().toString().trim();
        $.ajax({
            url:'/business/secret/pointLikeTargetSecret',
            dataType:'json',
            type:'post',
            data:{secretId:secretId},
            success:function(data){
                if (data.code == 0) {
                    layer.msg("点赞成功", {icon: 1, time: 1000, offset: '0px'});
                    refreshTable();
                } else {
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }
</script>


</body>
</html>

