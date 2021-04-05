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
    <title>活动申请情况管理</title>
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
        <div class="content-panel" style="height: 480px;overflow: auto;">
            <table class="table table-hover rowSameHeight"
                   data-toggle="table"
                   id="activityApplys"
                   data-search="true"
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

<%--summernote插件--%>
<script src="${pageContext.request.contextPath}/lib/summernote/summernote.js"></script>

<script>

    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#activityApplys').bootstrapTable({
        url: "/business/activityApply/findAllActivityApply",                      //  请求后台的URL
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
                //applyStatus:$("#applyStatus").val()
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
                    return "<shiro:hasPermission name="business:activityApply:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="business:activityApply:agreeApply"><button type=\"button\" class=\"btn btn-success btn-rounded btn-xs\" onclick=\"agreeApply(this)\">同意</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="business:activityApply:refuseApply"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"refuseApply(this)\">驳回</button></shiro:hasPermission>";

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
            url: "/business/activityApply/findAllActivityApply",
            pageSize: 5,
            pageNumber: 1
        });
    }


    var mainIndex;

    //iframe窗
    /*function addNotice() {
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
*/
    /*function editNotice(data) {
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
*/


    /**
     * 批量删除
     */
    /*function removeSomeLogInfo() {
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
    }*/

    function remove(data){
        layer.confirm('你是否确定要删除该条申请？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var applyId=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/business/activityApply/deleteTargetActivityApply',
                dataType:'json',
                type:'post',
                data:{applyId:applyId},
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

    /*$(document).ready(function () {
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
    });*/

    /*$(document).ready(function () {
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
*/

    /*$("#doSubmit").click(function(){
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
*/

    /*$("#doSubmit1").click(function(){
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
*/

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

