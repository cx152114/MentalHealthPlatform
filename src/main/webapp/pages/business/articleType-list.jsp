<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-10
  Time: 17:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>文章类别管理</title>
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

    <%--引入bootstrap用于表单验证的插件--%>
    <link href="${pageContext.request.contextPath}/lib/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">

    <link  href="${pageContext.request.contextPath}/lib/ruoyi/css/ry-ui.css" rel="stylesheet" />


    <style type="text/css">
        th{
            text-align: center;
            vertical-align: middle;
            font-size: 15px;
        }

        .content-panel{
            padding-left: 15px;
            padding-right: 15px;
        }

        td{
            text-align: center;
            font-size: 14px;
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
            <shiro:hasPermission name="business:articleType:add">
                <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addArticleTypeModal" ><i class="fa fa-plus"></i> 新增</a>
            </shiro:hasPermission>

            <shiro:hasPermission name="business:articleType:update">
                <a href="javascript:void(0)" class="btn btn-primary" onclick="alterArticleType()"><i class="fa fa-edit"></i> 修改</a>
            </shiro:hasPermission>

            <shiro:hasPermission name="business:articleType:delete">
                <a href="javascript:void(0)" class="btn btn-danger" onclick="removeArticleType()"><i class="fa fa-remove"></i> 删除</a>
            </shiro:hasPermission>
        </div>


        <div class="col-md-12 mt">


            <shiro:hasPermission name="business:articleType:search">
                <div class="col-sm-12 search-collapse">
                <p class="select-title"></p>
                <form id="time-form">
                    <div class="select-list">
                        <ul>
                            <li>
                                类别名称：<input type="text" id="typeName2" name="typeName"/>
                            </li>

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

            <div class="content-panel" style="height: 500px;overflow: auto;">
                <table class="table table-hover rowSameHeight"
                       data-toggle="table"
                       id="articleTypes"
                       data-search="true"
                       data-toolbar="#toolbar"
                       data-show-refresh="true"
                       data-show-toggle="true"
                       data-show-fullscreen="true"
                       data-show-columns="true"
                       data-show-columns-toggle-all="true"
                       data-click-to-select="true"
                       data-single-select="true"
                        <shiro:hasPermission name="business:articleType:export">
                               data-show-export="true"
                               data-exportDataType ="basic"
                        </shiro:hasPermission>
                       >
                    <br>
                </table>
            </div>
        </div>

    </div>

    <!-- 新增文章类别 -->
    <div class="modal inmodal" id="addArticleTypeModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                    <div class="panel-heading" style="text-align: center;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="mb" style="margin: 0px"> 新增文章类别</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal style-form" id="addArticleTypeFrom" action="/business/articleType/addArticleType" method="post">
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <div>
                                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章类别名称</label>
                                        <input type="text" class="form-control" id="typeName1" name="typeName" placeholder="文章类别名称" >
                                    </div>
                                </div>
                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <div>
                                        <textarea class="form-control" name="typeInfo"  placeholder="文章类别描述：" rows="4" data-rule="required" ></textarea>
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">提交</button>
                            <button type="reset" id="btn_reset" class="btn btn-warning">重置</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </form>
                    </div>
                </div>
            </div>
            <small class="font-bold"></small>
        </div>
        <small class="font-bold"></small>
    </div>


    <!-- 修改文章类别 -->
    <div class="modal inmodal" id="alterArticleTypeModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                    <div class="panel-heading" style="text-align: center;">
                        <h3 class="mb" style="margin: 0px">修改文章类别信息</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal style-form" action="/business/articleType/editArticleType" method="post">
                            <div class="form-group" >
                                <div class="col-sm-10" >
                                    <div style="display: none">
                                        <label class="control-label">文章类别编号</label>
                                        <input type="text" class="form-control" name="typeId" id="typeId"  style="width: 60%">
                                    </div>
                                    <div>
                                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章类别名称</label>
                                        <input type="text" class="form-control" name="typeName" id="typeName"  style="width: 60%">
                                    </div>
                                    <div >
                                        <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">文章类别描述</label>
                                        <input type="text" class="form-control" id="typeInfo" name="typeInfo" placeholder="文章类别描述" >
                                    </div>
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">提交</button>
                            <button type="reset" class="btn btn-warning">重置</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </form>
                    </div>
                </div>
            </div>
            <small class="font-bold"></small>
        </div>
        <small class="font-bold"></small>
    </div>


    <!-- 删除文章类别-->
    <div class="modal fade" id="removeArticleTypeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel" >
                        删除文章类别（此过程不可逆，谨慎操作）
                    </h4>
                </div>
                <div class="modal-body">
                    <h4 style="color: red;">是否移除选定文章类别？</h4>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="remove()">移除</button>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
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

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>


<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<script>

    /**
     * 自定义查询条件重置按钮
     */
    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    /**
     * 初始化表格数据
     */
    var dataTable = $('#articleTypes').bootstrapTable({
        url: "/business/articleType/findTargetArticleType",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "typeId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        showPaginationSwitch:true,
        pageList:"[5,10,25,50,100,all]",
        queryParamsType: '',
        queryParams: function (param) {
            return {
                //current: param.pageNumber, // 当前页 1
                //size: param.pageSize,      // 一页显示多少天 10
                typeName:$("#typeName2").val(),
                //deptStatus:$("#deptStatus2").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'typeId',
                title: '文章类别编号'
            }, {
                field: 'typeName',
                title: '文章类别名称'
            }, {
                field: 'typeInfo',
                title: '文章类别描述'
            }]
    });

    /**
     * 自定义查询
     */
    $('#btn-search').bind('click', function () {
        dataTable.bootstrapTable('removeAll');
        refreshTable();
    });

    /**
     * 刷新表格
     */
    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/business/articleType/findTargetArticleType",
            pageSize: 10,
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
     * 表单数据校验
     */
    $(document).ready(function() {
        $('#addArticleTypeFrom').bootstrapValidator({
            message: '请按规定填写文章类别信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                typeName: {
                    validators: {
                        notEmpty: {
                            message: '文章类别名称不能为空 '
                        },
                    }
                },
            }
        });
        $('#btn_reset').click(function() {
            $('#addArticleTypeFrom').data('bootstrapValidator').resetForm(true);
        });
    });



    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addArticleTypeModal').on('hide.bs.modal', function () {
            $('#addArticleTypeFrom').data('bootstrapValidator').resetForm(true);
        });
    });






    /**
     * 打开修改窗口
     */
    function alterArticleType(){
        var $table = $('#articleTypes');
        var articleTypes= $table.bootstrapTable('getSelections');

        if (JSON.stringify(articleTypes)=="[]"){
            layer.alert("请先选择要进行修改的记录", {icon: 5});
        }else{
                var typeId=articleTypes[0].typeId;
                var typeName=articleTypes[0].typeName;
                var typeInfo=articleTypes[0].typeInfo;

                $("#alterArticleTypeModal").modal('show');

                $("#typeId").val(typeId);
                $("#typeName").val(typeName);
                $("#typeInfo").val(typeInfo);
            }
    }

    /**
     * 打开删除窗口
     */
    function removeArticleType() {
        var $table = $('#articleTypes');
        var articleType= $table.bootstrapTable('getSelections');

        if (JSON.stringify(articleType)=="[]"){
            layer.alert("请先选择要删除的记录", {icon: 5});
        }else{
            $("#removeArticleTypeModal").modal('show');
        }
    }

    /**
     * 对指定文章类别进行删除
     */
    function remove(){
        var typeId;
        var tbodyObj = document.getElementById('articleTypes');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                typeId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'/business/articleType/removeArticleType',
                    dataType:'json',
                    type:'post',
                    data:{typeId:typeId},
                    success:function(data){
                        if (data.code == 0) {
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeArticleTypeModal").modal('hide');
                            window.location.reload();
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

