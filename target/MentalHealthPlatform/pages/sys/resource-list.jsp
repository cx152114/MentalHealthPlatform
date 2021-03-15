<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-13
  Time: 18:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>菜单管理</title>
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
            <shiro:hasPermission name="sys:resource:add">
                <a href="${pageContext.request.contextPath}/sys/resource/add/${parent.resourceId}" class="btn btn-success" data-toggle="modal" data-backdrop="false"><i class="fa fa-plus"></i> 新增</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:resource:update">
                <a href="javascript:void(0)" class="btn btn-primary" id="editResource"><i class="fa fa-edit"></i> 修改</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="sys:resource:delete">
                <a href="javascript:void(0)" class="btn btn-danger" id="removeResource"><i class="fa fa-remove"></i> 删除</a>
            </shiro:hasPermission>

        </div>

        <!-- /col-md-12 -->
        <div style="padding-left: 15px;padding-right: 15px;">
            <div style="height: 50px;">
                <div style="padding-left: 15px;float:left;width: 50%">
                    <h3>${parent.resourceName}</h3>
                </div>

            </div>
            <hr />

            <div class="content-panel" >
                <table class="table table-hover rowSameHeight"
                       data-toggle="table"
                       id="resources"
                       data-toolbar="#toolbar"
                       data-search="true">
                    </tbody>
                </table>
            </div>
        </div>
        <!-- /col-md-12 -->
    </div>


    <!-- 删除角色-->
    <div class="modal fade" id="removeRoleModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                删除此角色（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定角色？</h4>
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
<%--<script  type="text/javascript" src="${pageContext.request.contextPath}/lib/tableExport/bootstrap-table-export.min.js"></script>--%>


<%--<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table-locale-all.min.js"></script>--%>
<%--<script  type="text/javascript" src="${pageContext.request.contextPath}/lib/tableExport/bootstrap-table-export.min.js"></script>--%>


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


<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>

<script>

    var list_url = '/sys/resource/data';
    // 初始化表格数据
    var dataTable = $('#resources').bootstrapTable({
        url: list_url,   //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "resourceId",             //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                parentId: ${parent.resourceId}
            }
        },
        columns: [{
            checkbox: true
        }, {
            field: 'icon',
            title: '图标',
            align: 'center',
            width: '20',
            formatter: function (value, row, index) {
                var icon = '<i class="' + row.icon + '"></i> '
                return icon;
            }
        }, {
            field: 'orderNum',
            title: '排序'
        }, {
            field: 'resourceName',
            title: '资源名称'
        }, {
            field: 'type',
            title: '资源类型',
            formatter: function (value, row, index) {
                if (row.type == 0) {
                    return '目录';
                }
                if (row.type == 1) {
                    return '菜单';
                }
                if (row.type == 2) {
                    return '按钮';
                }

            }
        }, {
            field: 'url',
            title: '资源路径'
        }, {
            field: 'permission',
            title: '权限'
        }]
    });




    $('#resetBtn').click(function() {
        $('#addUserForm').data('bootstrapValidator').resetForm(true);
    });






    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addRoleModal').on('hidden.bs.modal', function () {
            $('#addRoleForm').data('bootstrapValidator').resetForm(true);
        });

        $('#alterUserModal').on('hidden.bs.modal', function () {
            $('#editUserForm').data('bootstrapValidator').resetForm(true);
        });

    });



    // 修改
    $('#editResource').click(function () {
        var rows = $('#resources').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length != 1) {
            window.parent.parent.layer.msg("一次只能修改一条数据!", {icon: 2, time: 1000, offset: 't'})
        } else {
            window.location.href = '${pageContext.request.contextPath}/sys/resource/update/' + rows[0].resourceId;
        }
    });

    // 删除
    $('#removeResource').click(function () {
        var rows = $('#resources').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else if (rows.length == 1) {
            var resourceId=rows[0].resourceId;
            window.parent.parent.layer.confirm("确认删除?", {icon: 3, offset: 't'}, function () {
                $.ajax({
                    url: '/sys/resource/delete',
                    type: 'post',
                    data:{resourceId:resourceId},
                    dataType:'json',
                    success: function (response) {
                        if (response.code == 0) {
                            window.parent.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                            //跳转到资源管理的初始化页面
                            window.parent.location.href = '${pageContext.request.contextPath}/sys/resource?parentId=${parent.resourceId}';
                        } else {
                            window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                        }
                    }
                })
            })
        } else {
            window.parent.parent.layer.confirm("确认批量删除?", {icon: 3, offset: 't'}, function () {
                var ids = new Array();
                for (var i = 0; i < rows.length; i++) {
                    ids.push(rows[i].resourceId);
                }
                $.ajax({
                    url: '${pageContext.request.contextPath}/sys/resource/deletebatch',
                    contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
                    type: 'post',
                    dateType: 'json',
                    data: JSON.stringify(ids),
                    success: function (response) {
                        if (response.code == 0) {
                            window.parent.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: 't'});
                            //跳转到资源管理的初始化页面
                            window.parent.location.href = '${pageContext.request.contextPath}/sys/resource?parentId=${parent.resourceId}';
                        } else {
                            window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                        }
                    }
                })
            })
        }
    });
</script>
</body>
</html>