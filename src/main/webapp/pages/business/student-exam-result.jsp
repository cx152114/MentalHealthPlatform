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
    <title>测试结果</title>
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
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <shiro:hasPermission name="business:result:search">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>
                        <li>
                            <!--测试试题类型的选择-->
                            <label for="selectExamType" class="control-label">题目类别：</label>
                            <select class="form-control"  style="width: 200px;" id="selectExamType" name="examType">
                                <option style='display: none'></option>
                                <option value="综合测试">综合测试</option>
                                <option value="日常交往">日常交往</option>
                                <option value="人格检测">人格检测</option>
                                <option value="情感测试">情感测试</option>
                            </select>
                        </li>
                        <li>
                            <!--测试成绩的选择-->
                            <label for="selectResultLevel" class="control-label">结果等级：</label>
                            <select class="form-control"  style="width: 120px;" id="selectResultLevel" name="resultLevel">
                                <option style='display: none'></option>
                                <option value="合格">合格</option>
                                <option value="不合格">不合格</option>
                                <option value="良好">良好</option>
                                <option value="优秀">优秀</option>
                            </select>
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
                   id="results"
                   data-search="true"
                   data-toolbar="#toolbar"
                   data-show-refresh="true"
                   data-show-toggle="true"
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

<%--查看测试成绩管理开始--%>
<div style="display: none;padding: 5px" id="showResultDiv">
    <h3 id="showResultLevel" align="center"></h3>
    <div style="text-align: right;">
        测试人:<span id="showUsername"></span>&nbsp;&nbsp;&nbsp;&nbsp;
        测试类型:<span id="showExamType"></span>&nbsp;&nbsp;&nbsp;&nbsp;
        结果级别：<font id="showScore" color="red"></font>
    </div>
    <hr>
    <div id="showDescription" ></div>
    <hr>
    <h5 id="showSuggest"></h5>
</div>
<%--查看测试成绩管理结束--%>


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

<%--summernote插件--%>
<script src="${pageContext.request.contextPath}/lib/summernote/summernote.js"></script>

<script>

    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#results').bootstrapTable({
        url: "/business/result/findMySelfResult",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "resultId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                examType:$("#selectExamType").val(),
                resultLevel:$("#selectResultLevel").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'resultId',
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
                field: 'score',
                title: '测评分数'
            }, {
                field: 'description',
                title: '描述',
                visible:false
            }, {
                field: 'suggest',
                title: '建议',
                visible:false
            }, {
                field: 'resultLevel',
                title: '结果等级'
            }, {
                field: 'examType',
                title: '测试类型'
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:result:search"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"showResult(this)\">查看</button></shiro:hasPermission>";

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
            url: "/business/result/findMySelfResult",
            pageSize: 5,
            pageNumber: 1
        });
    }


    var mainIndex;


    //弹出查看层
    function showResult(data){
        mainIndex=layer.open({
            type:1,
            content:$("#showResultDiv"),
            area:['800px','300px'],
            title:'查看测试成绩',
            success:function(){
                var value = $(data).parent().parent().find("td");
                var resultId=value.eq(1).text().toString().trim();
                $.ajax({
                    url:'/business/result/findTargetResult',
                    dataType:'json',
                    type:'post',
                    data:{resultId:resultId},
                    success:function(data){
                        if(data.code==0){
                            var result=data.result;
                            $("#showScore").html(result.score);
                            $("#showUsername").html(result.user.username);
                            $("#showExamType").html(result.examType);
                            $("#showResultLevel").html(result.resultLevel);
                            $("#showSuggest").html("建议："+result.suggest);
                            var content="测试结果描述："+result.description;
                            $("#showDescription").html(content);
                        }else{
                            layer.alert(data.msg, {icon: 5, offset: '0px'});
                        }

                    }
                });
            }
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

