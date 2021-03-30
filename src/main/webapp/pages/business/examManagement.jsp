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
    <title>试题管理</title>
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
        <shiro:hasPermission name="business:exam:add">
            <a href="javascript:void(0)" class="btn btn-success"    onclick="addExam()"><i class="fa fa-plus"></i> 新增</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:exam:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="editNotice()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:exam:batchRemove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeExam()"><i class="fa fa-trash-o"></i> 批量删除</a>
        </shiro:hasPermission>
    </div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <shiro:hasPermission name="business:exam:search">
        <div class="col-sm-12 search-collapse">
            <p class="select-title"></p>
            <form id="time-form">
                <div class="select-list">
                    <ul>
                        <li>
                            题目：<input type="text" id="title" name="title"/>
                        </li>
                        <li>
                            <!--测试试题类型的选择-->
                            <label for="selectType" class="control-label">题目类别：</label>
                            <select class="form-control"  style="width: 180px;" id="selectType" name="type">
                                <option style='display: none'></option>
                                <option value="综合测试">综合测试</option>
                                <option value="日常交往">日常交往</option>
                                <option value="人格检测">人格检测</option>
                                <option value="情感测试">情感测试</option>
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
                   id="exams"
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

<%--添加试题开始--%>
<div style="display: none;padding: 5px" id="addOrUpdateDiv">
    <div class="panel-body">
            <form class="form-horizontal style-form" id="addExamForm" action="" method="post">
                    <div class="col-sm-12" >
                        <div>
                            <label class="control-label" style="font-size:19px;margin-left: 5px;">标题</label>
                            <input type="text" class="form-control" name="title" placeholder="标题" style="width: 60%">
                        </div>
                        <div>
                            <!--测试试题类型的选择-->
                            <label for="selectExamType" class="control-label">试题类别：</label>
                            <select class="form-control"  style="width: 120px;" id="selectExamType"  name="type">
                                <option style='display: none'></option>
                                <option value="综合测试">综合测试</option>
                                <option value="日常交往">日常交往</option>
                                <option value="人格检测">人格检测</option>
                                <option value="情感测试">情感测试</option>
                            </select>
                        </div>
                        <br>
                        <div>
                            <div>
                                <label class="control-label" style="font-size:19px;margin-left: 5px;">选项一(4分)：</label>
                                <input type="text" class="form-control" name="section1" placeholder="选项一(4分)：" style="width: 60%">
                            </div>
                        </div>
                        <div>

                            <div>
                                <label class="control-label" style="font-size:19px;margin-left: 5px;">选项二(3分)：</label>
                                <input type="text" class="form-control" name="section2" placeholder="选项二(3分)：" style="width: 60%">
                            </div>
                        </div>
                        <div>

                            <div>
                                <label class="control-label" style="font-size:19px;margin-left: 5px;">选项三(2分)：</label>
                                <input type="text" class="form-control" name="section3" placeholder="选项三(2分)：" style="width: 60%">
                            </div>
                        </div>
                        <div>

                            <div>
                                <label class="control-label" style="font-size:19px;margin-left: 5px;">选项四(1分)：</label>
                                <input type="text" class="form-control" name="section4" placeholder="选项四(1分)：" style="width: 60%">
                            </div>
                        </div>
                    <button type="button" id="doSubmit" class="btn btn-primary">提交</button>
                    <button type="reset" class="btn btn-warning">重置</button>

            </form>
        </div>
    </div>
    <small class="font-bold"></small>
</div>
<%--添加测验试题结束--%>

<%--修改测验试题开始--%>
<div style="display: none;padding: 5px" id="editDiv">
    <div class="panel-body">
        <form class="form-horizontal style-form" id="editExamForm" action="" method="post">
            <div class="col-sm-12" >
                <div style="display: none">
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">测验试题编号</label>
                    <input type="text" class="form-control" id="businessId" name="businessId" placeholder="测验试题标题" style="width: 60%" >
                </div>
                <div>
                    <label class="control-label" style="font-size:19px;margin-left: 5px;">标题</label>
                    <input type="text" class="form-control" id="title1" name="title" placeholder="标题" style="width: 60%">
                </div>
                <div>
                    <!--测试试题类型的选择-->
                    <label for="selectExamType" class="control-label">试题类别：</label>
                    <select class="form-control"  style="width: 120px;" id="selectExamType1"  name="type">
                        <option style='display: none'></option>
                        <option value="综合测试">综合测试</option>
                        <option value="日常交往">日常交往</option>
                        <option value="人格检测">人格检测</option>
                        <option value="情感测试">情感测试</option>
                    </select>
                </div>
                <br>
                <div>
                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">选项一(4分)：</label>
                        <input type="text" class="form-control" id="section1" name="section1" placeholder="选项一(4分)：" style="width: 60%">
                    </div>
                </div>
                <div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">选项二(3分)：</label>
                        <input type="text" class="form-control" id="section2" name="section2" placeholder="选项二(3分)：" style="width: 60%">
                    </div>
                </div>
                <div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">选项三(2分)：</label>
                        <input type="text" class="form-control" id="section3" name="section3" placeholder="选项三(2分)：" style="width: 60%">
                    </div>
                </div>
                <div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">选项四(1分)：</label>
                        <input type="text" class="form-control" id="section4" name="section4" placeholder="选项四(1分)：" style="width: 60%">
                    </div>
                </div>
            </div>
            <button type="button" id="doSubmit1" class="btn btn-primary">提交</button>
            <button type="reset" class="btn btn-warning">重置</button>

        </form>
    </div>
</div>
<small class="font-bold"></small>
</div>
<%--修改测验试题结束--%>



<%--查看测验试题开始--%>
<div style="display: none;padding: 5px" id="showNoticeDiv">
    <h3 id="show_title" align="center"></h3>
    <div style="text-align: right;">
        发布人:<span id="show_opername"></span>&nbsp;&nbsp;&nbsp;&nbsp;
        发布时间:<span id="show_createtime"></span>
    </div>
    <hr>
    <div id="show_content" ></div>

</div>
<%--查看测验试题结束--%>


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
    var dataTable = $('#exams').bootstrapTable({
        url: "/business/exam/findAllExam",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "businessId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                title:$("#title").val(),
                type: $("#selectType").val(),
                // startTime:$("#startTime").val(),
                // endTime:$("#endTime").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'businessId',
                title: 'ID'
            }, {
                field: 'title',
                title: '题目'
            }, {
                field: 'section1',
                title: '选项一'
            }, {
                field: 'section2',
                title: '选项二'
            }, {
                field: 'section3',
                title: '选项三'
            }, {
                field: 'section4',
                title: '选项四'
            }, {
                field: 'type',
                title: '题目类型'
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:exam:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>";
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
            url: "/business/exam/findAllExam",
            pageSize: 5,
            pageNumber: 1
        });
    }


    var mainIndex;

    //iframe窗
    function addExam() {
        mainIndex=layer.open({
            type: 1,
            title: '新增测验试题',
            shadeClose: true,
            shade: false,
            maxmin: true, //开启最大化最小化按钮
            area: ['893px', '500px'],
            content: $("#addOrUpdateDiv")
        });
    }

    function editNotice(data) {
        var $table = $('#exams');
        var exam = $table.bootstrapTable('getSelections');
        if (JSON.stringify(exam) == "[]") {
            layer.alert("请先选择要进行修改的记录", {icon: 5, offset: '0px'});
        } else {
            var businessId = exam[0].businessId;
            mainIndex = layer.open({
                type: 1,
                title: '修改测验试题',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '500px'],
                content: $("#editDiv"),
                success: function () {
                    //装载新的数据
                    $("editExamForm").val("dataFrm", data);
                    $.ajax({
                        url: '/business/exam/findTargetExam',
                        dataType: 'json',
                        type: 'post',
                        data: {businessId: businessId},
                        success: function (data) {
                            if (data.code == 0) {
                                //layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                $("#businessId").val(data.exam.businessId);
                                $("#selectExamType1").val(data.exam.type);
                                $("#title1").val(data.exam.title);
                                $("#section1").val(data.exam.section1);
                                $("#section2").val(data.exam.section2);
                                $("#section3").val(data.exam.section3);
                                $("#section4").val(data.exam.section4);
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
    function removeSomeExam() {
        var exams= $('#exams').bootstrapTable('getSelections');
        // alert(notices[0].id);
        var ids = new Array();
        for (var i = 0; i <exams.length ; i++) {
            ids[i]=exams[i].businessId;
        }
        if (ids.length==0){
            layer.msg("请选择要删除的测验试题",{icon:5});
            return;
        }else {
            layer.confirm('你是否确定要删除选定的测验试题？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                ids=JSON.stringify(ids);
                $.ajax({
                    url:'/business/exam/batchDeleteExam',
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
        layer.confirm('你是否确定要删除该条测验试题？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var businessId=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/business/exam/deleteTargetExam',
                dataType:'json',
                type:'post',
                data:{businessId:businessId},
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
        var data=$("#addExamForm").serialize();
        $.post("/business/exam/addExam",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });

    $("#doSubmit1").click(function(){
        var data=$("#editExamForm").serialize();
        $.post("/business/exam/editExam",data,function(res){
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
            title:'查看测验试题',
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
</body>
</html>

