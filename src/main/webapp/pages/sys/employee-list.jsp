<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-05
  Time: 17:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>用户管理</title>
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
                    <shiro:hasPermission name="sys:user:add">
                        <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addUserModal" ><i class="fa fa-plus"></i> 新增</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="sys:user:update">
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="alterUser()"><i class="fa fa-edit"></i> 修改</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="sys:user:delete">
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="removeUser()"><i class="fa fa-remove"></i> 删除</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="sys:user:assign:role">
                        <a href="javascript:void(0)" class="btn btn-info" id="btn-assign-role"><i class="fa fa-chain"></i> 分配角色</a>
                    </shiro:hasPermission>
                </div>

                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <shiro:hasPermission name="sys:user:list">
                    <div class="col-sm-12 search-collapse">
                        <form id="complex-form" >
                            <div class="select-list">
                                <ul>
                                    <li>
                                        <label style="width: 80px">员工编号：</label>
                                        <input type="text" style="width: 80px;" id="userId2" name="userId"/>
                                    </li>
                                    <li>
                                        <label style="width: 80px">员工名称：</label>
                                        <input type="text" style="width: 80px;" id="userName2" name="userName"/>
                                    </li>
                                    <%--<li>
                                        <label style="width: 80px">所属部门：</label>
                                        <select id="deptId1" style="width: 100px;"  name="deptId1">
                                            <option value=""></option>
                                        </select>
                                    </li>--%>

                                    <li class="select-time">
                                        <label>创建时间： </label>
                                        <input type="text" class="time-input" id="startTime" placeholder="开始时间" name="params[beginTime]"/>
                                        <span>-</span>
                                        <input type="text" class="time-input" id="endTime" placeholder="结束时间" name="params[endTime]"/>
                                    </li>



                                    <li>
                                        <label style="width: 40px">状态：</label>
                                        <select id="userStatus" style="width: 80px;" name="userStatus">
                                            <option value="">所有</option>
                                            <option value="0">正常</option>
                                            <option value="1">禁用</option>
                                            <option value="2">锁定</option>
                                        </select>
                                    </li>

                                    <li>
                                        <a class="btn btn-primary btn-rounded btn-sm" id="btn-search"><i class="fa fa-search"></i>&nbsp;搜索</a>
                                        <a class="btn btn-warning btn-rounded btn-sm" onclick="resetForm('#complex-form')"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                    </shiro:hasPermission>

                    <div class="content-panel" style="height: 650px;overflow: auto;"  >
                        <table class="table table-hover rowSameHeight"
                               data-toggle="table"
                               id="users"
                               data-toolbar="#toolbar"
                               data-search="true"
                               data-show-refresh="true"
                               data-show-toggle="true"
                               data-show-fullscreen="true"
                               data-show-columns="true"
                               data-show-columns-toggle-all="true"
                               data-click-to-select="true"
                               data-single-select="true"
                                <shiro:hasPermission name="sys:user:export">
                                   data-show-export="true"
                                   data-exportDataType ="basic"
                                </shiro:hasPermission>
                               data-show-pagination-switch="true"
                               data-pagination="true"
                               data-page-list="[5,10,25,50,100,all]"
                               data-side-pagination="client">
                            <hr/>
                        </table>
                    </div>

                </div>
                <!-- /col-md-12 -->
            </div>

            <!-- 添加用户 -->
            <div class="modal inmodal" id="addUserModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">

                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px">新增用户</h3>
                            </div>
                            <div><p></p><p></p></div>
                            <form class="form-horizontal style-form" id="addUserForm" action="/user/addUser" method="post">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">姓名：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" name="username" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">邮箱：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" name="userEmail" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">手机号：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" name="userPhone" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">密码：</label>
                                    <div class="col-lg-5">
                                        <input type="password" class="form-control" name="password" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">确认密码：</label>
                                    <div class="col-lg-5">
                                        <input type="password" class="form-control" name="confirmPassword" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">状态：</label>
                                    <div class="col-lg-5">
                                        <label class="radio-inline" >
                                            <input type="radio"  name="userStatus" checked="checked"  value="0">
                                            正常
                                        </label>
                                        <label class="radio-inline" >
                                            <input type="radio"   name="userStatus" value="1">
                                            禁用
                                        </label>
                                        <label class="radio-inline" >
                                            <input type="radio"   name="userStatus" value="2">
                                           锁定
                                        </label>
                                    </div>
                                </div>

                                <%--<div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">部门：</label>
                                    <div class="col-lg-5">
                                        <select class="form-control"  style="width: 100px;" id="deptId" name="deptId">
                                            <option style='display: none'></option>
                                        </select>
                                    </div>
                                </div>--%>
                                <div class="form-group">
                                    <div class="col-lg-9 col-lg-offset-3">
                                        <button type="submit" class="btn btn-primary">提交</button>
                                        <button type="reset" id="resetBtn" class="btn btn-warning">重置</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        </div>
                    </div>
                    <small class="font-bold"></small>
                </div>
                <small class="font-bold"></small>
            </div>


            <!-- 修改用户信息 -->
            <div class="modal inmodal" id="alterUserModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="mb" style="margin: 0px">修改用户信息</h3>
                            </div>

                            <div><p></p><p></p></div>
                            <form class="form-horizontal style-form" id="editUserForm" action="/user/editUser" method="post">
                                <div class="form-group" style="display: none">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">编号：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="userId" name="userId" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">姓名：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="username" name="username" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">邮箱：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="userEmail" name="userEmail" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">手机号：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="userPhone" name="userPhone" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">密码：</label>
                                    <div class="col-lg-5">
                                        <input type="password" class="form-control"  name="password" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">确认密码：</label>
                                    <div class="col-lg-5">
                                        <input type="password" class="form-control"   name="confirmPassword" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">状态：</label>
                                    <div class="col-lg-5">
                                        <label class="radio-inline" >
                                            <input type="radio" id="userStatus1"  name="userStatus"  value="0">
                                            正常
                                        </label>
                                        <label class="radio-inline" >
                                            <input type="radio" id="userStatus2"  name="userStatus" value="1">
                                            禁用
                                        </label>
                                        <label class="radio-inline" >
                                            <input type="radio" id="userStatus3"   name="userStatus" value="2">
                                            锁定
                                        </label>
                                    </div>
                                </div>
                                <%--<div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">部门：</label>
                                    <div class="col-lg-5">
                                        <select class="form-control"  style="width: 100px;" id="deptId2" name="deptId">
                                            <option style='display: none'></option>
                                        </select>
                                    </div>
                                </div>--%>
                                <div class="form-group">
                                    <div class="col-lg-9 col-lg-offset-3">
                                        <button type="submit" class="btn btn-primary">提交</button>
                                        <button type="reset"  class="btn btn-warning">重置</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <small class="font-bold"></small>
                </div>
                <small class="font-bold"></small>
            </div>


            <!-- 删除用户信息-->
            <div class="modal fade" id="removeUserModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                删除用户信息（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定用户？</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="remove()">移除</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>


            <div class="modal inmodal" id="allocationRoleModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">

                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px">分配角色</h3>
                            </div>
                            <div><p></p><p></p></div>
                            <form class="form-horizontal style-form"  id="allocationRole" onsubmit="return false">
                                    <div class="form-group" >
                                        <input type="hidden" name="userId" id="targetUserId" value="${userId}">
                                        <div class="col-lg-9 col-lg-offset-3"id="roleList">

                                        </div>
                                    </div>
                                <div class="form-group">
                                    <div class="col-lg-9 col-lg-offset-3">
                                        <button type="submit" id="btn-submit" class="btn btn-primary">提交</button>
                                        <button type="reset"  class="btn btn-warning">重置</button>
                                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <small class="font-bold"></small>
            </div>
            <small class="font-bold"></small>
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


<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>

<script type="application/javascript">
    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#users').bootstrapTable({
        url: "/user/showAllUser",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "userId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        //sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        showPaginationSwitch:true,
        pageList:"[5,10,25,50,100,all]",
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                userId:$("#userId2").val(),
                username:$("#userName2").val(),
                userStatus:$("#userStatus").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val(),
            }
        },
        columns: [
            {
                checkbox: true
            },{
                field: 'userId',
                title: '编号'
            }, {
                field: 'username',
                title: '姓名'
            }, {
                field: 'userEmail',
                title: '邮箱'
            }, {
                field: 'userPhone',
                title: '手机号'
            /*}, {
                field: 'deptId',
                title: '部门编号',
                visible:false,
                formatter: function(value, item, index) {
                    if (item.dept!=null){
                        return item.dept.deptId;
                    }
                }
            }, {
                field: 'deptName',
                title: '所属部门',
                formatter: function(value, item, index) {
                    if (item.dept!=null){
                        return item.dept.deptName;
                    }
                    //alert(item.dept);
                }*/
            }, {
                field: 'userStatus',
                title: '状态',
                formatter: function(value, item, index) {
                    if (value==0){
                        return "<span class=\"label label-success\">正常</span>";
                    }else if (value==1){
                        return "<span class=\"label label-danger\">禁用</span>";
                    }else{
                        return "<span class=\"label label-warning\">锁定</span>";
                    }
                }
            }, {
                field: 'createTime',
                title: '创建时间'
            }]
    });

    // 查询
    $('#btn-search').bind('click', function () {
        dataTable.bootstrapTable('removeAll');
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        dataTable.bootstrapTable('refresh');
    }
</script>


<script>

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

    $(document).ready(function() {
        $('#addUserForm').bootstrapValidator({
            message: '请填写正确的用户信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空 '
                        },
                        different: {
                            field: 'password,confirmPassword',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                userEmail: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空 '
                        },
                        emailAddress: {
                            message: '这不是一个正确的邮箱'
                        }
                    }
                },
                userPhone: {
                    validators: {
                        notEmpty: {
                            message: '手机号不能为空'
                        },
                        regexp: {
                            regexp: /^1\d{10}$/,
                            message: '手机号格式错误'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'confirmPassword',
                            message: '两次填写的密码不一致，请重新确认'
                        },
                        different: {
                            field: 'username',
                            message: '请不要使用用户名作为密码'
                        }
                    }
                },
                confirmPassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次填写的密码不一致'
                        },
                        different: {
                            field: 'username',
                            message: '请不要使用用户名作为密码'
                        }
                    }
                },
            }
        });

        // Validate the form manually
        $('#validateBtn').click(function() {
            $('#defaultForm').bootstrapValidator('validate');
        });

        $('#resetBtn').click(function() {
            $('#addUserForm').data('bootstrapValidator').resetForm(true);
        });
    });

    $(document).ready(function() {
        $('#editUserForm').bootstrapValidator({
            message: '请填写正确的用户信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                username: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '用户名不能为空 '
                        },
                        different: {
                            field: 'password,confirmPassword',
                            message: 'The username and password cannot be the same as each other'
                        }
                    }
                },
                userEmail: {
                    validators: {
                        notEmpty: {
                            message: '邮箱不能为空 '
                        },
                        emailAddress: {
                            message: '这不是一个正确的邮箱'
                        }
                    }
                },
                userPhone: {
                    validators: {
                        notEmpty: {
                            message: '手机号不能为空'
                        },
                        regexp: {
                            regexp: /^1\d{10}$/,
                            message: '手机号格式错误'
                        }
                    }
                },
                password: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'confirmPassword',
                            message: '两次填写的密码不一致，请重新确认'
                        },
                        different: {
                            field: 'username',
                            message: '请不要使用用户名作为密码'
                        }
                    }
                },
                confirmPassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'password',
                            message: '两次填写的密码不一致'
                        },
                        different: {
                            field: 'username',
                            message: '请不要使用用户名作为密码'
                        }
                    }
                },
            }
        });

        // Validate the form manually
        $('#validateBtn').click(function() {
            $('#defaultForm').bootstrapValidator('validate');
        });

        $('#resetBtn').click(function() {
            $('#editUserForm').data('bootstrapValidator').resetForm(true);
        });
    });

    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addUserModal').on('hidden.bs.modal', function () {
            $('#addUserForm').data('bootstrapValidator').resetForm(true);
        });

        $('#alterUserModal').on('hidden.bs.modal', function () {
            $('#editUserForm').data('bootstrapValidator').resetForm(true);
        });

        $('#allocationRoleModal').on('hidden.bs.modal', function () {
            $("#roleList").empty();
        });


    });


    /**
     * 加载部门
     */
    /*$(document).ready(function() {
            $.ajax({
                url: '/dept/showAllDept',
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        var depts = data.rows;
                        $.each(depts, function (i, item) {
                            <!-- 向商品详情表中进行数据注入 -->

                            $("#deptId").append("<option value='" + item.deptId + "'>" + item.deptName + "</option>");
                            $("#deptId1").append("<option value='" + item.deptId + "'>" + item.deptName + "</option>");
                            $("#deptId2").append("<option value='" + item.deptId + "'>" + item.deptName + "</option>");
                            i++;
                        });
                    } else {
                        layer.alert(data.msg, {icon: 5, offset: '0px'});
                    }
                }
            });
    });*/



    /**
     * 打开修改窗口
     */
    function alterUser(){
        var $table = $('#users');
        var user= $table.bootstrapTable('getSelections');

        var userId=user[0].userId;
        var username=user[0].username;
        var userEmail=user[0].userEmail;
        var userPhone=user[0].userPhone;
        var userStatusStr=user[0].userStatus;

        $("#alterUserModal").modal('show');

        $("#userId").val(userId);
        $("#username").val(username);
        $("#userEmail").val(userEmail);
        $("#userPhone").val(userPhone);

        // $(" select option[value='"+deptId+"']").attr("selected","selected");

        var userStatus;
        if (userStatusStr=="正常"){
            $("#userStatus1").attr("checked","checked");
        }else if (userStatusStr=="禁用"){
            $("#userStatus2").attr("checked","checked");
        }else if (userStatusStr=="锁定"){
            $("#userStatus3").attr("checked","checked");
        }
    }

    /**
     * 打开删除窗口
     */
    function removeUser() {
        var $table = $('#users');
        var user= $table.bootstrapTable('getSelections');

        if (JSON.stringify(user)=="[]"){
            layer.alert("请先选择要进行修改的记录", {icon: 5, offset: '0px'});
        }else {
            $("#removeUserModal").modal('show');
        }
    }

    function remove(){
        var userId;
        var tbodyObj = document.getElementById('users');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                userId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'../user/removeUser',
                    dataType:'json',
                    type:'post',
                    data:{userId:userId},
                    success:function(data){
                        if (data.code == 0) {
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeUserModal").modal('hide');
                            window.location.reload();
                        } else {
                            layer.alert(data.msg, {icon: 5, offset: '0px'});
                        }
                    }
                });
            }
        });
    }

    $(document).ready(function() {
        $('#btn-assign-role').click(function () {
            var $table = $('#users');
            var user= $table.bootstrapTable('getSelections');
            var userId=user[0].userId;
            $.ajax({
                url: '../user/getRoleList',
                data:{userId:userId},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    console.log(data);
                    if (data.code == 0) {
                        var userRoleList = data.userRoleList;
                        var  targetUserId=data.userId;
                        $("#targetUserId").val(targetUserId);
                        $.each(userRoleList, function (i, item) {
                            if (item.userId!=null){
                                <!-- 向商品详情表中进行数据注入 -->
                                $("#roleList").append("<div class='chexkbox' style='padding-left: 30px;'></div>");
                                $("#roleList").append("<label>");
                                $("#roleList").append("<input type='checkbox' name='roleId' value='"+item.roleId+"' checked=checked >"+item.roleName+"");

                                $("#roleList").append("</label>");
                                $("#roleList").append("</div>");
                            }else {
                                <!-- 向商品详情表中进行数据注入 -->
                                $("#roleList").append("<div class='chexkbox' style='padding-left: 30px;'></div>");
                                $("#roleList").append("<label>");
                                $("#roleList").append("<input type='checkbox' name='roleId' value='"+item.roleId+"'>"+item.roleName+"");

                                $("#roleList").append("</label>");
                                $("#roleList").append("</div>");
                            }
                            i++;
                        });
                    } else {
                        layer.alert(data.msg, {icon: 5, offset: '0px'});
                    }
                }
            });
        });

    });



    // 分配角色
    $('#btn-assign-role').click(function () {
        var rows = $('#users').bootstrapTable('getSelections');
        if (rows.length == 0) {
            window.parent.layer.msg("请选择要分配角色的用户!", {icon: 2, time: 1000})
        }else{
            $("#allocationRoleModal").modal('show');
        }
    });


    $('#btn-submit').click(function () {
        $.ajax({
            url: '/user/assignRole',
            type: 'post',
            data: $("#allocationRole").serialize(),
            dataType: 'json',
            success: function (response) {
                if (response.code == 0) {
                    window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '/user/userManagement';
                } else {
                    window.parent.layer.alert(response.msg, {icon: 5, offset: '0px'});
                }
            }
        })
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
