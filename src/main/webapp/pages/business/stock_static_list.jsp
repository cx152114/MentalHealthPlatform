<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-04-19
  Time: 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>统计分析</title>
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

        .rowSameHeight {
            white-space: nowrap;
            overflow: hidden;
        }

    </style>
</head>
<body>

<div class="row">

    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <div style="margin-top: -15px;">
            <h3>本月商品进货量排名 <small>（前20）</small></h3>
        </div>

        <div class="content-panel" style="height: 650px;overflow: auto;" >
            <table class="table table-hover rowSameHeight"
                   data-toggle="table"
                   id="staticStock"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-fullscreen="true"
                   data-show-columns="true"
                   data-show-columns-toggle-all="true"
                   data-show-export="true"
                   data-click-to-select="true"
                   data-single-select="true"
                   data-exportDataType ="basic"
                   data-show-pagination-switch="true">
            </table>
        </div>


    </div>
    <!-- /col-md-12 -->
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


<script src="${pageContext.request.contextPath}/lib/tableExport/tableExport.js"></script>

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

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>


<script>
    function resetForm(data) {
        $(data)[0].reset();
    }

    // 初始化表格数据
    var dataTable = $('#staticStock').bootstrapTable({
        url: "/business/static/staticStockSort",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        //data:StaticList,
        uniqueId: "phoneId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        showPaginationSwitch:true,
        pageList:"[5,10,25,50,100,all]",
        columns: [
            {
                field: 'SerialNumber',
                title: '进货量排名',
                formatter: function (value, row, index) {
                    return index+1;
                }
            }, {
                field: 'phoneId',
                title: '手机编号',

            }, {
                field: 'phoneName',
                title: '手机名称',
                formatter: function(value, item, index) {
                    return item.phoneInfo.phoneName;
                }
            }, {
                field: 'phoneColor',
                title: '颜色',
                formatter: function(value, item, index) {
                    return item.phoneInfo.phoneColor;
                }
            }, {
                field: 'phoneRam',
                title: '运存',
                formatter: function(value, item, index) {
                    return item.phoneInfo.phoneRam;
                }
            }, {
                field: 'phoneStorage',
                title: '内存',
                formatter: function(value, item, index) {
                    return item.phoneInfo.phoneStorage;
                }
            }, {
                field: 'phoneNetwork',
                title: '网络类型',
                formatter: function(value, item, index) {
                    return item.phoneInfo.phoneNetwork;
                }
            }, {
                field: 'number',
                title: '进货总数量'
            }]
    });


    /**
     * 设置导出文件的属性
     */
    $.extend($.fn.bootstrapTable.defaults, {
        showExport: false,
        exportDataType: 'basic', // basic, all, selected
        // 'json', 'xml', 'png', 'csv', 'txt', 'sql', 'doc', 'excel', 'powerpoint', 'pdf'
        exportTypes: ['json', 'xml', 'csv', 'txt', 'sql','doc', 'excel','pdf'],
        exportOptions: {
            // 导出数据去除第一列出现"on"
            ignoreColumn: [0]
        }
    });
</script>
</body>
</html>
