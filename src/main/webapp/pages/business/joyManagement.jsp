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
    <title>笑话管理</title>
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
    <div class="btn-group-sm" id="toolbar" role="group">
        <shiro:hasPermission name="business:joy:add">
            <a href="javascript:void(0)" class="btn btn-success"    onclick="addNotice()"><i class="fa fa-plus"></i> 新增</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:joy:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="editNotice()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:joy:batchRemove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeLogInfo()"><i class="fa fa-trash-o"></i> 批量删除</a>
        </shiro:hasPermission>
    </div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <shiro:hasPermission name="business:joy:search">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>

                        <li>
                            标题：<input type="text" id="title1" name="title"/>
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
                   id="joys"
                   data-toolbar="#toolbar"
                   data-search="true"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-fullscreen="true"
                   data-show-columns="true"
                   data-show-columns-toggle-all="true"
                   data-click-to-select="true"
                    <shiro:hasPermission name="business:joy:export">
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

<%--添加公告开始--%>
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <div class="panel-body">
            <form class="form-horizontal style-form" id="addNoticeForm" action="" method="post">
                    <div class="col-sm-12" >
                        <div>
                            <label class="control-label" style="font-size:19px;margin-left: 5px;">公告标题</label>
                            <input type="text" class="form-control" name="title" placeholder="公告标题" style="width: 60%">
                        </div>
                        <br>
                        <div class="box float-e-margins">
                            <div class="box-title">
                                <h4>编辑/保存公告内容</h4>
                            </div>
                            <div class="box-body" id="eg">
                                <textarea name="content" id="content" class="form-control summernote" style="display: none;"></textarea>
                                <div id="test" class="note-editor note-frame panel panel-default"></div></div>
                            </div>
                        </div>
                    <button type="button" id="doSubmit" class="btn btn-primary">提交</button>
                    <button type="reset" class="btn btn-warning">重置</button>

            </form>
        </div>
    </div>
    <small class="font-bold"></small>
</div>
<%--添加公告结束--%>

<%--修改公告开始--%>
<div style="display: none;padding: 5px" id="editDiv">
    <div class="panel-body">
        <form class="form-horizontal style-form" id="editNoticeForm" action="" method="post">
            <div class="col-sm-12" >
                <div>
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">公告编号</label>
                    <input type="text" class="form-control" id="noticeId" name="noticeId" placeholder="公告标题" style="width: 60%" >
                </div>
                <div>
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">发布人</label>
                    <input type="text" class="form-control" id="opername" name="opername" placeholder="发布人" style="width: 60%" >
                </div>
                <div>
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">发布时间</label>
                    <input type="text" class="form-control" id="createtime" name="createtime1" placeholder="发布时间" style="width: 60%" >
                </div>
                <div>
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">公告标题</label>
                    <input type="text" class="form-control" id="title" name="title" placeholder="公告标题" style="width: 60%">
                </div>

                <br>
                <div class="box float-e-margins">
                    <div class="box-title">
                        <h4>编辑/保存公告内容</h4>
                    </div>
                    <div class="box-body" id="eg1">
                        <textarea name="content" id="content1" class="form-control summernote" style="display: none;"></textarea>
                        <div id="test1" class="note-editor note-frame panel panel-default"></div></div>
                </div>
            </div>
            <button type="button" id="doSubmit1" class="btn btn-primary">提交</button>
            <button type="reset" class="btn btn-warning">重置</button>

        </form>
    </div>
</div>
<small class="font-bold"></small>
</div>
<%--修改公告结束--%>



<%--查看公告开始--%>
<div style="display: none;padding: 5px" id="showNoticeDiv">
    <h3 id="show_title" align="center"></h3>
    <div style="text-align: right;">
        发布人:<span id="show_opername"></span>&nbsp;&nbsp;&nbsp;&nbsp;
        发布时间:<span id="show_createtime"></span>
    </div>
    <hr>
    <div id="show_content" ></div>

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
    var dataTable = $('#joys').bootstrapTable({
        url: "/business/joy/findAllJoy",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "joyId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                title:$("#title1").val(),
                sendName: $("#sendName").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'joyId',
                title: 'ID'
            }, {
                field: 'joyType',
                title: '笑话类型'
            }, {
                field: 'joyTitle',
                title: '标题'
            }, {
                field: 'joyContent',
                title: '内容',
                visible:false
            }, {
                field: 'joyDate',
                title: '时间'
            }, {
                field: 'joyUrl',
                title: 'url',
                visible:false
            }, {
                field: 'answer',
                title: '答案'
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:joy:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="sys:notice:search"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"showNotice(this)\">查看</button></shiro:hasPermission>";

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
            url: "/business/joy/findAllJoy",
            pageSize: 5,
            pageNumber: 1
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

    //iframe窗
    function addNotice() {
        mainIndex=layer.open({
            type: 1,
            title: '新增公告',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '500px'],
            content: $("#addOrUpdateDiv")
        });
    }

    function editNotice(data) {
        var $table = $('#notices');
        var notice = $table.bootstrapTable('getSelections');
        if (JSON.stringify(notice) == "[]") {
            layer.alert("请先选择要进行修改的记录", {icon: 5, offset: '0px'});
        } else {
            var noticeId = notice[0].noticeId;
            //alert(noticeId);

            mainIndex = layer.open({
                type: 1,
                title: '修改公告',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '500px'],
                content: $("#editDiv"),
                success: function () {
                    //$("#editNoticeForm")[0].reset();
                    //装载新的数据
                    $("editNoticeForm").val("dataFrm", data);
                    $.ajax({
                        url: '/sys/notice/findTargetNotice',
                        dataType: 'json',
                        type: 'post',
                        data: {noticeId: noticeId},
                        success: function (data) {
                            if (data.code == 0) {
                                //layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                $("#noticeId").val(data.notice.noticeId);
                                $("#opername").val(data.notice.opername);
                                $("#createtime").val(data.notice.createtime);
                                $("#title").val(data.notice.title);
                                $("#content1").val(data.notice.content);

                                var content="<p>"+data.notice.content+"</p>";
                                $('#test1').summernote('code',content);
                            } else {
                                layer.alert(data.msg, {icon: 5, offset: '0px'});
                            }
                        }
                    });

                    //url="/sys/notice/editNotice";
                }
            });
        }
    }



    /**
     * 批量删除
     */
    function removeSomeLogInfo() {
        var notices= $('#notices').bootstrapTable('getSelections');
        // alert(notices[0].id);
        var ids = new Array();
        for (var i = 0; i <notices.length ; i++) {
            ids[i]=notices[i].noticeId;
        }
        if (ids.length==0){
            layer.msg("请选择要删除的公告",{icon:5});
            return;
        }else {
            layer.confirm('你是否确定要删除选定的公告？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                ids=JSON.stringify(ids);
                $.ajax({
                    url:'/sys/notice/batchDeleteNotices',
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
        layer.confirm('你是否确定要删除该条公告？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var noticeId=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/sys/notice/deleteTargetNotice',
                dataType:'json',
                type:'post',
                data:{noticeId:noticeId},
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


    $(document).ready(function () {
        $("#test").summernote({
            lang: 'zh-CN',
            minHeight : 150,
            toolbar: [
                ['operate', ['undo','redo']],
                ['magic',['style']],
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['para', ['height','fontsize','ul', 'ol', 'paragraph']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['color', ['color']],
                //['insert',['picture','video','link','table','hr']],
                ['layout',['fullscreen','codeview']],
            ]
        });
    });

    $(document).ready(function () {
        $("#test1").summernote({
            lang: 'zh-CN',
            minHeight : 150,
            toolbar: [
                ['operate', ['undo','redo']],
                ['magic',['style']],
                ['style', ['bold', 'italic', 'underline', 'clear']],
                ['para', ['height','fontsize','ul', 'ol', 'paragraph']],
                ['font', ['strikethrough', 'superscript', 'subscript']],
                ['color', ['color']],
                //['insert',['picture','video','link','table','hr']],
                ['layout',['fullscreen','codeview']],
            ]
        });
    });

    $("#doSubmit").click(function(){
        //同步富文本和textarea里面的内容
        var text = $($("#test").summernote("code")).text();
        //var text = $($("#test").summernote("code"));

        $("#content").val(text);
        //return;
        var data=$("#addNoticeForm").serialize();
        $.post("/sys/notice/addNotice",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });

    $("#doSubmit1").click(function(){
        //同步富文本和textarea里面的内容
        var text01 = $($("#test1").summernote("code")).text();
        //var text = $($("#test").summernote("code"));
        $("#content1").val(text01);
        var data=$("#editNoticeForm").serialize();
        $.post("/sys/notice/editNotice",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });


    //弹出查看层
    function showNotice(data){
        mainIndex=layer.open({
            type:1,
            content:$("#showNoticeDiv"),
            area:['800px','300px'],
            title:'查看公告',
            success:function(){
                var value = $(data).parent().parent().find("td");
                var noticeId=value.eq(1).text().toString().trim();
                $.ajax({
                    url:'/sys/notice/findTargetNotice',
                    dataType:'json',
                    type:'post',
                    data:{noticeId:noticeId},
                    success:function(data){
                        if(data.code==0){
                            var notice=data.notice;
                            $("#show_title").html(notice.title);
                            $("#show_opername").html(notice.opername);
                            $("#show_createtime").html(notice.createtime);

                            var content="<lable style='font-size: 16px;'>"+notice.content+"</lable>";
                            $("#show_content").html(content);
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

