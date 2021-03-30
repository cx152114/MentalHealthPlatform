<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-21
  Time: 23:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>大学生心理健康平台首页</title>
    <!-- Bootstrap core CSS -->
    <link href="${pageContext.request.contextPath}/lib/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!--external css-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/font-awesome/css/font-awesome.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/lib/gritter/css/jquery.gritter.css" />
    <!-- Custom styles for this template -->
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style-responsive.css" rel="stylesheet">
    <!-- Bootstrap table core CSS -->
    <link href="${pageContext.request.contextPath}/lib/bootstrap-table/css/bootstrap-table.css" rel="stylesheet">


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
    <!--内容区域-->
            <div class="row mt">
                <div class="col-lg-12" style="height: 500px;">
                    <div class="col-lg-12">
                        <h4><a href="#" class="list-group-item active">
                            最新公告 <i class="fa fa-bolt"></i></a>
                        </h4>
                        <div class="content-panel" style="padding-top: 0px;">
                            <table class="table"
                                   data-toggle="table"
                                   id="notices"
                                   data-detail-view="true"
                                   data-detail-formatter="detailFormatter"
                                   style="border: 0px solid">
                                <br>
                            </table>

                        </div>
                    </div>


                </div>
            </div>
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap/js/bootstrap.min.js"></script>
    <!--bootstrap-table-->
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>
<script type="application/javascript">
    /**
     * 初始化表格数据
     */
    var dataTable = $('#notices').bootstrapTable({
        url: "/sys/notice/findAllNotice",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "noticeId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
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
                field: 'title'
            }, {
                field: 'content',
                visible:false
            }, {
                field: 'createtime',
            }, {
                field: 'opername'
            }]
    });

    function detailFormatter(index, row) {
        var html = [];

        $.each(row, function (key, value) {
            if(key=="content"){
                html.push("<div style='height:400px;overflow:auto'><b>公告内容：</b> " + value + "</div>")
            }

        })
        return html.join('')
    }

</script>
</body>
</html>
