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
    <title>留言板管理</title>
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
        <shiro:hasPermission name="business:message:add">
            <a href="javascript:void(0)" class="btn btn-success"    onclick="addMessage()"><i class="fa fa-plus"></i> 新增</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:message:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="editMessage()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:message:batchRemove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeMessage()"><i class="fa fa-trash-o"></i> 批量删除</a>
        </shiro:hasPermission>
    </div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <shiro:hasPermission name="business:message:search">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>
                        <li>
                            留言板内容：<input type="text" id="messageContent" name="messageContent"/>
                        </li>
                        <li>
                            用户编号：<input type="text" id="uId" name="uId"/>
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
                   id="messages"
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

    <%--<div class="btn-group-sm" id="toolbar1" role="group">
        <shiro:hasPermission name="business:message:add">
            <a href="javascript:void(0)" class="btn btn-success"    onclick="addMessage()"><i class="fa fa-plus"></i> 新增</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:message:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="editMessage()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:message:batchRemove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeMessage()"><i class="fa fa-trash-o"></i> 批量删除</a>
        </shiro:hasPermission>
    </div>--%>
    <!-- /col-md-12 -->
</div>

<%--添加留言开始--%>
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <div class="panel-body">
            <form class="form-horizontal style-form" id="addMessageForm" action="" method="post">
                    <div class="col-sm-12" >
                        <div>
                            <label for="selectUserId" class="control-label">接收人：</label>
                            <select class="form-control"  style="width: 100px;" id="selectUserId" name="receiveId">
                                <option style='display: none'></option>
                            </select>
                        </div>
                        <div class="box float-e-margins">
                            <div class="box-title">
                                <h4>编辑/保存留言内容</h4>
                            </div>
                            <div class="box-body" id="eg">
                                <textarea name="messageContent" id="messageContent1" class="form-control summernote" style="display: none;"></textarea>
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
<%--添加留言结束--%>

<%--修改留言开始--%>
<div style="display: none;padding: 5px" id="editDiv">
    <div class="panel-body">
        <form class="form-horizontal style-form" id="editMessageForm" action="" method="post">
            <div class="col-sm-12" >
                <div style="display: none">
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">留言编号</label>
                    <input type="text" class="form-control" id="messageId" name="messageId" placeholder="留言编号" style="width: 60%" >
                </div>
                <div>
                    <!--联系人的选择-->
                    <label for="selUserId1" class="control-label">测试人：</label>
                    <select class="form-control"  style="width: 100px;" id="selUserId1" name="receiveId">
                        <option style='display: none'></option>
                    </select>
                </div>
                <br>
                <div class="box float-e-margins">
                    <div class="box-title">
                        <h4>编辑/保存留言内容</h4>
                    </div>
                    <div class="box-body" id="eg1">
                        <textarea name="messageContent" id="messageContent2" class="form-control summernote" style="display: none;"></textarea>
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
<%--修改留言结束--%>



<%--查看留言开始--%>
<div style="display: none;padding: 5px" id="showCommentDiv">
    <h3 id="show_title" align="center">留言板详情</h3>
    <table class="table table-hover rowSameHeight"
           data-toggle="table"
           id="comments"
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
<%--查看留言结束--%>


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
    var dataTable = $('#messages').bootstrapTable({
        url: "/business/message/findAllMessage",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "messageId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                uId:$("#uId").val(),
                messageContent:$("#messageContent").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val()
                //messageStatus:$("#messageStatus").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'messageId',
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
                title: '发布用户',
                formatter: function(value, item, index) {
                    return item.user.username;
                }
            }, {
                field: 'receiveId',
                title: '目标用户编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.receiveUser.userId;
                }
            }, {
                field: 'username',
                title: '目标用户',
                formatter: function(value, item, index) {
                    return item.receiveUser.username;
                }
            }, {
                field: 'messageContent',
                title: '内容'
            }, {
                field: 'createTime',
                title: '时间'
            }, {
                field: 'messageStatus',
                title: '状态',
                visible:false,
                formatter: function(value, item, index) {
                    if (value==0){
                        return "<span class=\"label label-default\">未审核</span>";
                    }
                    if (value==1){
                        return "<span class=\"label label-success\">审核通过</span>";
                    }
                    if (value==2){
                        return "<span class=\"label label-warning\">审核未通过</span>";
                    }
                }
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:message:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="business:message:search"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"showComment(this)\">查看</button></shiro:hasPermission>";

                }
            }]
    });


    // 初始化表格数据
    var dataTable1 = $('#comments').bootstrapTable({
        url: "/business/comment/findTargetComments",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "commentId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                messageId:param.messageId
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'commentId',
                title: 'ID'
            }, {
                field: 'messageId',
                title: '留言板编号'
            }, {
                field: 'sendUserId',
                title: '发送用户编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.sendUser.userId;
                }
            }, {
                field: 'sendUserName',
                title: '发送用户',
                formatter: function(value, item, index) {
                    return item.sendUser.username;
                }
            }, {
                field: 'content',
                title: '内容'
            }, {
                field: 'createTime',
                title: '时间'
            }, {
                field: 'receiveUserId',
                title: '接收用户编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.receiveUser.userId;
                }
            }, {
                field: 'receiveUserName',
                title: '接收用户',
                formatter: function(value, item, index) {
                    return item.receiveUser.username;
                }
            }, {
                field: 'commentStatus',
                title: '状态',
                visible:false
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:comment:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"removeComment(this)\">删除</button></shiro:hasPermission>";
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
            url: "/business/message/findAllMessage",
            pageSize: 5,
            pageNumber: 1
        });
    }

    // 刷新表格
    function refreshCommentTable(date) {
        dataTable1.bootstrapTable('refresh', {
            url: "/business/comment/findTargetComments/"+date,
            pageSize: 5,
            pageNumber: 1,
            messageId:date
        });
    }


    var mainIndex;

    //iframe窗
    function addMessage() {
        mainIndex=layer.open({
            type: 1,
            title: '新增留言',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '500px'],
            content: $("#addOrUpdateDiv")
        });
    }

    function editMessage(data) {
        var $table = $('#messages');
        var message = $table.bootstrapTable('getSelections');
        if (JSON.stringify(message) == "[]") {
            layer.alert("请先选择要进行修改的记录", {icon: 5, offset: '0px'});
        } else {
            var messageId = message[0].messageId;
            //alert(noticeId);

            mainIndex = layer.open({
                type: 1,
                title: '修改留言',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '500px'],
                content: $("#editDiv"),
                success: function () {
                    //$("#editMessageForm")[0].reset();
                    //装载新的数据
                    $("editMessageForm").val("dataFrm", data);
                    $.ajax({
                        url: '/business/message/findTargetMessage',
                        dataType: 'json',
                        type: 'post',
                        data: {messageId: messageId},
                        success: function (data) {
                            if (data.code == 0) {
                                //layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                $("#messageId").val(data.message.messageId);
                                $("#selUserId1").val(data.message.receiveId);
                                $("#messageContent2").val(data.message.messageContent);
                                var content=data.message.messageContent;
                                $('#test1').summernote('code',content);
                            } else {
                                layer.alert(data.msg, {icon: 5, offset: '0px'});
                            }
                        }
                    });

                    //url="/sys/notice/editMessage";
                }
            });
        }
    }

    /**
     * 批量删除
     */
    function removeSomeMessage() {
        var messages= $('#messages').bootstrapTable('getSelections');
        // alert(notices[0].id);
        var ids = new Array();
        for (var i = 0; i <messages.length ; i++) {
            ids[i]=messages[i].messageId;
        }
        if (ids.length==0){
            layer.msg("请选择要删除的留言",{icon:5});
            return;
        }else {
            layer.confirm('你是否确定要删除选定的留言？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                ids=JSON.stringify(ids);
                $.ajax({
                    url:'/business/message/batchDeleteMessage',
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
        layer.confirm('你是否确定要删除该条留言？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var messageId=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/business/message/deleteTargetMessage',
                dataType:'json',
                type:'post',
                data:{messageId:messageId},
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

    function removeComment(data){
        layer.confirm('你是否确定要删除该条留言？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var commentId=value.eq(1).text().toString().trim();
            var messageId=value.eq(2).text().toString().trim();
            $.ajax({
                url:'/business/comment/deleteTargetComment',
                dataType:'json',
                type:'post',
                data:{commentId:commentId},
                success:function(data){
                    if (data.code == 0) {
                        layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                        refreshCommentTable(messageId);
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
        var text = $("#test").summernote("code");
        //var text = $($("#test").summernote("code"));

        $("#messageContent1").val(text);
        //return;
        var data=$("#addMessageForm").serialize();
        $.post("/business/message/addMessage",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });

    $("#doSubmit1").click(function(){
        //同步富文本和textarea里面的内容
        var text01 = $("#test1").summernote("code");
        //var text = $($("#test").summernote("code"));
        $("#messageContent2").val(text01);
        var data=$("#editMessageForm").serialize();
        $.post("/business/message/editMessage",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });


    //弹出查看层
    function showComment(data){
        mainIndex=layer.open({
            type: 1,
            title: '新增留言',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '500px'],
            content: $("#showCommentDiv"),
            success:function(){
                var value = $(data).parent().parent().find("td");
                var messageId=value.eq(1).text().toString().trim();
                refreshCommentTable(messageId)
            }
        });
    }

    /**
     * 获取所需要的员工信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/user/getTargetUsers',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var userList=data.userList;
                    $.each(userList,function(i,item){
                        $("#selectUserId").append("<option value='"+item.userId+"'>"+item.username+"</option>");
                        $("#selUserId1").append("<option value='"+item.userId+"'>"+item.username+"</option>");
                        i++;
                    });
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });
    });
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

