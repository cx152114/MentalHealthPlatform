<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-05-06
  Time: 23:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>活动管理</title>
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

        .rowSameHeight {
            white-space: nowrap;
            overflow: hidden;
        }

    </style>


</head>
<body>
<div class="row">
    <div class="btn-group-sm" id="toolbar" role="group"></div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <shiro:hasPermission name="business:activityApply:search">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>
                        <li>
                            活动标题：<input type="text" id="title1" name="title"/>
                        </li>
                        <li>
                            发布人：<input type="text" id="sendName1" name="sendName"/>
                        </li>
                        <li class="select-time">
                            <label>发布时间： </label>
                            <input type="text" class="time-input" id="startTime" placeholder="开始时间" name="params[beginTime]"/>
                            <span>-</span>
                            <input type="text" class="time-input" id="endTime" placeholder="结束时间" name="params[endTime]"/>
                        </li>
                        <li>
                            <a class="btn btn-primary btn-rounded btn-sm" id="btn-search"><i class="fa fa-search"></i>&nbsp;搜索</a>
                            <a class="btn btn-warning btn-rounded btn-sm" onclick="resetForm('#time-form')"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                        </li>
                    </ul>
                </div>
            </form>
        </div>
        </shiro:hasPermission>
        <div class="content-panel" style="height: 480px;overflow: auto;">
            <table class="table table-hover rowSameHeight"
                   data-toggle="table"
                   id="activities"
                   data-toolbar="#toolbar"
                   data-show-refresh="true"
                   <%-- data-show-toggle="true" --%>
<%--                   data-show-fullscreen="true"--%>
                   data-show-columns="true"
                   data-show-columns-toggle-all="true"
                   data-click-to-select="true"
                    <shiro:hasPermission name="business:activityApply:export">
                        data-show-export="true"
                        data-exportDataType ="basic"
                    </shiro:hasPermission>
                   data-show-pagination-switch="true"
                   data-pagination="true"
                   data-page-list="[5,10,25,50,100,all]">
                <hr/>
            </table>
        </div>
    </div>
    <!-- /col-md-12 -->
</div>



<%--查看报名情况开始--%>
<div style="display: none;padding: 5px" id="showActivityApplyDetailDiv">
    <h3  align="center">活动报名详情</h3>
    <table class="table table-hover rowSameHeight"
           data-toggle="table"
           id="activityApplyDetails"
           data-toolbar="#toolbar1"
           data-show-refresh="true"
           <%-- data-show-toggle="true" --%>
           data-show-fullscreen="true"
           data-show-columns="true"
           data-show-columns-toggle-all="true"
           data-click-to-select="true"
           data-show-pagination-switch="true"
           data-pagination="true"
           data-page-list="[5,10,25,50,100,all]">
        <hr/>
    </table>
</div>
<%--查看公告结束--%>


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
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

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

<%--summernote插件--%>
<script src="${pageContext.request.contextPath}/lib/summernote/summernote.js"></script>

<script>

    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#activities').bootstrapTable({
        url: "/business/activity/findAllActivity",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "activityId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                title:$("#title1").val(),
                sendName: $("#sendName1").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'activityId',
                title: 'ID'
            }, {
                field: 'title',
                title: '公告标题'
            }, {
                field: 'descr',
                title: '描述'
            }, {
                field: 'time',
                title: '时间'
            }, {
                field: 'maxCount',
                title: '最大参加人数'
            }, {
                field: 'remainingCount',
                title: '剩余名额'
            }, {
                field: 'address',
                title: '地址'
            }, {
                field: 'sendName',
                title: '发布人'
            }, {
                field: 'activityDate',
                title: '发布时间'
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="sys:activityApplyDetail:search"><button type=\"button\" class=\"btn btn-primary btn-rounded btn-xs\" onclick=\"showActivityApplyDetail(this)\">查看报名详情</button></shiro:hasPermission>";
                }
            }]
    });


    // 初始化表格数据
    var dataTable1 = $('#activityApplyDetails').bootstrapTable({
        url: "/business/activityApplyDetail/findActivityApplyDetail",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "applyId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize      // 一页显示多少天 10
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'applyId',
                title: 'ID'
            }, {
                field: 'uId',
                title: '用户编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.user.userId;
                }
            }, {
                field: 'username',
                title: '用户名',
                formatter: function(value, item, index) {
                    return item.user.username;
                }
            }, {
                field: 'activityId',
                title: '活动编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.activity.activityId;
                }
            }, {
                field: 'title',
                title: '活动名称',
                formatter: function(value, item, index) {
                    return item.activity.title;
                }
            }, {
                field: 'applyStatus',
                title: '申请状态',
                formatter: function(value, item, index) {
                    if (value==0){
                        return "<span class=\"label label-default\">待通过</span>";
                    }
                    if (value==1){
                        return "<span class=\"label label-success\">通过</span>";
                    }
                    if (value==2){
                        return "<span class=\"label label-warning\">驳回</span>";
                    }
                }
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:activityApply:agreeApply"><button type=\"button\" class=\"btn btn-success btn-rounded btn-xs\" onclick=\"agreeApply(this)\">同意</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="business:activityApply:refuseApply"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"refuseApply(this)\">驳回</button></shiro:hasPermission>";

                }
            }]
    });


    // 查询
    $('#btn-search').bind('click', function () {
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/business/activity/findAllActivity",
            pageSize: 5,
            pageNumber: 1
        });
    }


    // 刷新表格
    function refreshCommentTable(date) {
        dataTable1.bootstrapTable('refresh', {
            url: "/business/activityApplyDetail/findActivityApplyDetail/"+date,
            pageSize: 5,
            pageNumber: 1,
            messageId:date
        });
    }



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


    var mainIndex;


    //弹出查看层
    function showActivityApplyDetail(data){
        mainIndex=layer.open({
            type:1,
            content:$("#showActivityApplyDetailDiv"),
            area:['800px','400px'],
            title:'查看活动详情',
            success:function(){
                var value = $(data).parent().parent().find("td");
                var activityId=value.eq(1).text().toString().trim();
                refreshCommentTable(activityId)
            }
        });
    }

    //通过申请
    function agreeApply(data){
        var value = $(data).parent().parent().find("td");
        var applyId=value.eq(1).text().toString().trim();
        $.ajax({
            url:'/business/activityApply/agreeTargetApply',
            dataType:'json',
            type:'post',
            data:{applyId:applyId},
            success:function(res){
                if(res.code==0){
                    layer.msg(res.msg);
                    refreshTable();
                    layer.close(mainIndex);
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }


    /**
     * 拒绝申请
     * @param data
     */
    function refuseApply(data){
        var value = $(data).parent().parent().find("td");
        var applyId=value.eq(1).text().toString().trim();
        $.ajax({
            url:'/business/activityApply/refuseTargetApply',
            dataType:'json',
            type:'post',
            data:{applyId:applyId},
            success:function(res){
                if(res.code==0){
                    layer.msg(res.msg);
                    refreshTable();
                    layer.close(mainIndex);
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }
</script>
</body>
</html>

