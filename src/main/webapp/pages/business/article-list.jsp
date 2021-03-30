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
    <title>文章管理</title>
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

        .rowSameHeight {
            white-space: nowrap;
            overflow: hidden;
        }

    </style>
</head>
<body>
<section id="container">

            <div class="row">
                <div class="btn-group-sm" id="toolbar" role="group">
                    <shiro:hasPermission name="business:article:add">
                        <a href="javascript:void(0)" class="btn btn-success"    onclick="addArticle()"><i class="fa fa-plus"></i> 新增</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:article:edit">
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="editArticle()"><i class="fa fa-edit"></i> 修改</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:article:batchRemove">
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSomeArticleInfo()"><i class="fa fa-trash-o"></i> 批量删除</a>
                    </shiro:hasPermission>
                </div>
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <div class="content-panel" style="height: 650px;overflow: auto;">
                        <table class="table table-hover rowSameHeight"
                               id="articles"
                               data-toolbar="#toolbar"
                               data-toggle="table"
                               data-search="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-show-fullscreen="true"
                               data-show-columns="true"
                               data-show-columns-toggle-all="true"
                               data-click-to-select="true"
                                <shiro:hasPermission name="business:article:export">
                                   data-show-export="true"
                                   data-exportDataType ="basic"
                                </shiro:hasPermission>
                               data-show-pagination-switch="true"
                               data-pagination="true"
                               data-page-list="[5,10,25,50,100,all]">
                            <h4><i class="fa fa-angle-right"></i> 文章管理</h4>
                            <hr>
                        </table>
                    </div>

                </div>
                <!-- /col-md-12 -->
            </div>

    <div style="display: none;padding: 5px" id="addOrUpdateDiv">
        <div class="panel-body">
            <form class="form-horizontal style-form" id="addArticleForm" action="" method="post">
                <div class="col-sm-12" >
                    <div>
                        <!--文章类别的选择-->
                        <label for="selectArticleTypeId" class="control-label">文章类别：</label>
                        <select class="form-control"  style="width: 100px;" id="selectArticleTypeId" name="typeId">
                            <option style='display: none'></option>
                        </select>
                    </div>
                    <div>
                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章标题</label>
                        <input type="text" class="form-control" name="articleTitle" placeholder="文章标题" style="width: 60%">
                    </div>
                    <div class="box float-e-margins">
                        <div class="box-title">
                            <h4>文章内容</h4>
                        </div>
                        <div class="box-body" id="eg">
                            <textarea name="articleContent" id="articleContent1" class="form-control summernote" style="display: none;"></textarea>
                            <div id="test" class="note-editor note-frame panel panel-default"></div></div>
                    </div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">作者</label>
                        <input type="text" class="form-control"  name="author" placeholder="作者" style="width: 60%">
                    </div>
                </div>
                <button type="button" id="doSubmit" class="btn btn-primary">提交</button>
                <button type="reset" class="btn btn-warning">重置</button>

            </form>
        </div>
    </div>
    <small class="font-bold"></small>
    </div>


    <div style="display: none;padding: 5px" id="editDiv">
        <div class="panel-body">
            <form class="form-horizontal style-form" id="editArticleForm" action="" method="post">
                <div class="col-sm-12" >
                    <div style="display: none">
                        <label class="control-label">文章编号</label>
                        <input type="text" class="form-control" name="articleId" id="articleId" placeholder="文章编号" style="width: 60%">
                    </div>
                    <div>
                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章类别</label>
                        <select class="form-control"  style="width: 100px;" id="selectArticleType1" name="typeId">
                        </select>
                    </div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章标题</label>
                        <input type="text" class="form-control" name="articleTitle" id="articleTitle" placeholder="文章标题" style="width: 60%">
                    </div>
                    <br>
                    <div class="box float-e-margins">
                        <div class="box-title">
                            <h4>文章内容</h4>
                        </div>
                        <div class="box-body" id="eg1">
                            <textarea name="articleContent" id="articleContent3" class="form-control summernote" style="display: none;"></textarea>
                            <div id="test1" class="note-editor note-frame panel panel-default"></div></div>
                    </div>

                    <div>
                        <label class="control-label" style="font-size:19px;margin-left: 5px;">作者</label>
                        <input type="text" class="form-control" name="author" id="author" placeholder="作者" style="width: 60%">
                    </div>
                    <br>
                </div>
                <button type="button" id="doSubmit1" class="btn btn-primary">提交</button>
                <button type="reset" class="btn btn-warning">重置</button>

            </form>
        </div>
    </div>
    <small class="font-bold"></small>
    </div>



    <%--查看文章开始--%>
    <div style="display: none;padding: 5px" id="showArticleDiv">
        <h3 id="articleTitle2" align="center"></h3>
        <div style="text-align: right;">
            文章类别:<span id="typeName"></span>&nbsp;&nbsp;&nbsp;&nbsp;
            发布时间:<span id="articleDate"></span>
        </div>
        <hr>
        <div id="articleContent2" ></div>
        <hr>
        <div style="text-align: right;">
            作者:<span id="author2"></span>&nbsp;&nbsp;&nbsp;&nbsp;
            点赞数:<span id="articleCount"></span>
        </div>
    </div>
    <%--查看公告结束--%>
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
    $(document).ready(function() {
        $('#addArticleForm').bootstrapValidator({
            message: '请填写完整的文章信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                typeId: {
                    message: 'The typeId is not valid',
                    validators: {
                        notEmpty: {
                            message: '文章类别不能为空 '
                        }
                    }
                },
                articleTitle: {
                    validators: {
                        notEmpty: {
                            message: '文章标题不能为空 '
                        }
                    }
                },
                articleContent: {
                    validators: {
                        notEmpty: {
                            message: '文章内容不能为空'
                        }
                    }
                }
            }
        });

        $('#resetBtn').click(function() {
            $('#addArticleForm').data('bootstrapValidator').resetForm(true);
        });
    });
</script>


<script>


    // 初始化表格数据
    var dataTable = $('#articles').bootstrapTable({
        url: "/business/article/findTargetArticle",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "articleId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        showPaginationSwitch:true,
        pageList:"[5,10,25,50,100,all]",
        columns: [
            {
                checkbox: true
            }, {
                field: 'articleId',
                title: '文章编号'
            }, {
                field: 'typeId',
                title: '文章类别编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.articleType.typeId;
                }
            }, {
                field: 'typeName',
                title: '文章类别',
                formatter: function(value, item, index) {
                    return item.articleType.typeName;
                }
            }, {
                field: 'articleTitle',
                title: '文章标题'
            }, {
                field: 'articleDate',
                title: '文章添加时间'
            }, {
                field: 'articleCount',
                title: '点赞数'
            }, {
                field: 'author',
                title: '作者'
            },{
                title:'操作',
                field: 'active',
                formatter: function(value, item, index) {
                    return "<shiro:hasPermission name="business:article:remove"><button type=\"button\" class=\"btn btn-danger btn-rounded btn-xs\" onclick=\"remove(this)\">删除</button></shiro:hasPermission>"+"&nbsp;&nbsp;&nbsp;<shiro:hasPermission name="business:article:search"><button type=\"button\" class=\"btn btn-default btn-rounded btn-xs\" onclick=\"showArticle(this)\">查看</button></shiro:hasPermission>";

                }
            }]
    });


    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/business/article/findTargetArticle",
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

    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addArticleModal').on('hidden.bs.modal', function () {
            document.getElementById("addArticleForm").reset();
        });
    });



    /**
     * 获取所需要的文章类别信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/business/articleType/getTargetArticleTypes',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var articleTypeList=data.articleTypeList;
                    $.each(articleTypeList,function(i,item){
                        <!-- 向文章类别中进行数据注入 -->
                        $("#selectArticleTypeId").append("<option value='"+item.typeId+"'>"+item.typeName+"</option>");
                        $("#selectArticleType1").append("<option value='"+item.typeId+"'>"+item.typeName+"</option>");
                        i++;
                    });
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });
    });




    var mainIndex;

    //iframe窗
    function addArticle() {
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



    //弹出查看层
    function showArticle(data){
        mainIndex=layer.open({
            type:1,
            content:$("#showArticleDiv"),
            area:['800px','400px'],
            title:'查看文章内容',
            success:function(){
                var value = $(data).parent().parent().find("td");
                var articleId=value.eq(1).text().toString().trim();
                $.ajax({
                    url:'/business/article/findByTargetArticle',
                    dataType:'json',
                    type:'post',
                    data:{articleId:articleId},
                    success:function(data){
                        if(data.code==0){
                            var article=data.article;
                            $("#articleTitle2").html(article.articleTitle);
                            $("#typeName").html(article.articleType.typeName);
                            $("#articleDate").html(article.articleDate);
                            $("#author2").html(article.author);
                            $("#articleCount").html(article.articleCount);



                            var articleContent=article.articleContent;
                            $("#articleContent2").html(articleContent);
                            //$('#articleContent2').summernote('code',articleContent);
                        }else{
                            layer.alert(data.msg, {icon: 5, offset: '0px'});
                        }

                    }
                });
            }
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

        $("#articleContent1").val(text);
        //return;
        var data=$("#addArticleForm").serialize();
        $.post("/business/article/addArticle",data,function(res){
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
        $("#articleContent3").val(text01);
        var data=$("#editArticleForm").serialize();
        $.post("/business/article/editArticle",data,function(res){
            if(res.code==0){
                layer.msg(res.msg);
                refreshTable();
                layer.close(mainIndex);
            }
        });
    });

    function editArticle(data) {
        var $table = $('#articles');
        var article = $table.bootstrapTable('getSelections');
        if (JSON.stringify(article) == "[]") {
            layer.alert("请先选择要进行修改的记录", {icon: 5, offset: '0px'});
        } else {
            var articleId = article[0].articleId;
            //alert(noticeId);

            mainIndex = layer.open({
                type: 1,
                title: '修改活动信息',
                shadeClose: true,
                shade: false,
                maxmin: true, //开启最大化最小化按钮
                area: ['893px', '500px'],
                content: $("#editDiv"),
                success: function () {
                    //$("#editActivityForm")[0].reset();
                    //装载新的数据
                    $("editArticleForm").val("dataFrm", data);
                    $.ajax({
                        url: '/business/article/findByTargetArticle',
                        dataType: 'json',
                        type: 'post',
                        data: {articleId: articleId},
                        success: function (data) {
                            if (data.code == 0) {
                                //layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                $("#articleId").val(data.article.articleId);
                                $("#selectArticleType1").val(data.article.typeId);
                                $("#articleTitle").val(data.article.articleTitle);
                                $("#author").val(data.article.author);

                                $("#articleContent").val(data.article.articleContent);
                                var articleContent=data.article.articleContent;
                                $("#test1").summernote('code',articleContent);

                            } else {
                                layer.alert(data.msg, {icon: 5, offset: '0px'});
                            }
                        }
                    });

                    //url="/sys/notice/editActivity";
                }
            });
        }
    }

    /**
     * 批量删除
     */
    function removeSomeArticleInfo() {
        var articles= $('#articles').bootstrapTable('getSelections');
        // alert(notices[0].id);
        var ids = new Array();
        for (var i = 0; i <articles.length ; i++) {
            ids[i]=articles[i].articleId;
        }
        if (ids.length==0){
            layer.msg("请选择要删除的文章信息",{icon:5});
            return;
        }else {
            layer.confirm('你是否确定要删除选定的文章？', {
                btn: ['确定','取消'] //按钮
            }, function(){
                ids=JSON.stringify(ids);
                $.ajax({
                    url:'/business/article/batchDeleteArticle',
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
        layer.confirm('你是否确定要删除该条文章信息？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            var value = $(data).parent().parent().find("td");
            var articleId=value.eq(1).text().toString().trim();
            $.ajax({
                url:'/business/article/removeTargetArticle',
                dataType:'json',
                type:'post',
                data:{articleId:articleId},
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
</body>
</html>

