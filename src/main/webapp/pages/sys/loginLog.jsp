<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-17
  Time: 18:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>登录日志</title>
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
    <div class="btn-group-sm" id="toolbar" role="group">
        <shiro:hasPermission name="sys:log:list">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeLogInfo()"><i class="fa fa-trash-o"></i> 批量删除</a>
        </shiro:hasPermission>
    </div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">

        <shiro:hasPermission name="sys:log:list">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>
                        <li>
                            登录名称：<input type="text" id="loginName" name="loginName"/>
                        </li>
                        <li>
                            登录地址：<input type="text" id="loginIp" name="loginIp"/>
                        </li>
                        <li class="select-time">
                            <label>登录时间： </label>
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
                   id="loginLog"
                   data-toolbar="#toolbar"
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
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>



<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>



<script>

    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }
    // 初始化表格数据
    var dataTable = $('#loginLog').bootstrapTable({
        url: "/sys/logLogin/loadAllLoginInfo",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "id",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                loginName: $("#loginName").val(),
                loginIp: $("#loginIp").val(),
                startTime: $("#startTime").val(),
                endTime: $("#endTime").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'id',
                title: 'ID'
            }, {
                field: 'loginName',
                title: '登录名称'
            }, {
                field: 'loginIp',
                title: '登录地址'
            }, {
                field: 'loginTime',
                title: '登录时间',
            }, {
                title: '操作',
                field: 'active',
                formatter: function (value, item, index) {
                    return "<shiro:hasPermission name="
                    sys:log:remove
                    "><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>";

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
            url: "/sys/logLogin/loadAllLoginInfo",
            pageSize: 5,
            pageNumber: 1
        });
    }



    /**
     * 批量删除
     */
    function removeSomeLogInfo() {
        var loginLog= $('#loginLog').bootstrapTable('getSelections');
        //alert(loginLog[0].id);
        var ids = new Array();
        for (var i = 0; i <loginLog.length ; i++) {
            ids[i]=loginLog[i].id;
        }
        if (ids.length==0){
            layer.msg("请选择要删除的日志",{icon:5});
            return;
        }else {
            var msg="你是否确定要删除这"+loginLog.length+"条登录日志信息？"
            layer.confirm(msg, {
                btn: ['确定','取消'] //按钮
            }, function(){
                    ids=JSON.stringify(ids);
                    $.ajax({
                        url:'/sys/logLogin/batchDeleteLoginLog',
                        dataType:'json',
                        type:'post',
                        data:{ids:ids},
                        success:function(data){
                            if (data.code == 0) {
                                layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                refreshTable();
                            } else {
                                layer.alert(data.msg, {icon: 5, offset: '0px'});
                            }
                        }
                    });
            }, function(){
            });
        }
    }

    function remove(data){
        layer.confirm('你是否确定要删除该条日志？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var id=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/sys/logLogin/deleteTargetLoginInfo',
                dataType:'json',
                type:'post',
                data:{id:id},
                success:function(data){
                    if (data.code == 0) {
                        layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                        refreshTable();
                    } else {
                        layer.alert(data.msg, {icon: 5, offset: '0px'});
                    }
                }
            });
        }, function(){

        });


    }


</script>

<%--日期选择--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/laydate/laydate.js"></script>
<script type="text/javascript">

    var startDate = laydate.render({
        elem: '#startTime',
        max: $('#endTime').val(),
        theme: 'molv',
        trigger: 'click',
        done: function(value, date) {
            // 结束时间大于开始时间
            if (value !== '') {
                endDate.config.min.year = date.year;
                endDate.config.min.month = date.month - 1;
                endDate.config.min.date = date.date;
            } else {
                endDate.config.min.year = '';
                endDate.config.min.month = '';
                endDate.config.min.date = '';
            }
        }
    });

    var endDate = laydate.render({
        elem: '#endTime',
        min: $('#startTime').val(),
        theme: 'molv',
        trigger: 'click',
        done: function(value, date) {
            // 开始时间小于结束时间
            if (value !== '') {
                startDate.config.max.year = date.year;
                startDate.config.max.month = date.month - 1;
                startDate.config.max.date = date.date;
            } else {
                startDate.config.max.year = '';
                startDate.config.max.month = '';
                startDate.config.max.date = '';
            }
        }
    });
</script>

</body>
</html>
