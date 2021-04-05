<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-13
  Time: 9:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>角色管理</title>
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
    <!-- 引入bootstrap-treeView -->
    <link  href="${pageContext.request.contextPath}/lib/bootstrap-treeview/bootstrap-treeview.css">

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
             <shiro:hasPermission name="sys:role:add">
                <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addRoleModal"><i class="fa fa-plus"></i> 新增</a>
             </shiro:hasPermission>
             <shiro:hasPermission name="sys:role:update">
                <a href="javascript:void(0)" class="btn btn-primary" onclick="alterRole()"><i class="fa fa-edit"></i> 修改</a>
             </shiro:hasPermission>
             <shiro:hasPermission name="sys:role:delete">
                <a href="javascript:void(0)" class="btn btn-danger" onclick="removeRole()"><i class="fa fa-remove"></i> 删除</a>
             </shiro:hasPermission>
             <shiro:hasPermission name="sys:role:assign:resource">
                <a href="javascript:void(0)" class="btn btn-info" id="btn-assign-resource"><i class="fa fa-chain"></i> 分配权限</a>
             </shiro:hasPermission>
         </div>
                <!-- /col-md-12 -->
            <div class="col-md-12 mt">
                <shiro:hasPermission name="sys:role:list">
                    <div class="col-sm-12 search-collapse">
                    <p class="select-title"></p>
                    <form id="time-form">
                        <div class="select-list">
                            <ul>
                                <li>
                                    角色编号：<input type="text" id="roleId2" name="roleId"/>
                                </li>
                                <li>
                                    角色名称：<input type="text" id="roleName2" name="roleName"/>
                                </li>
                                <li class="select-time">
                                    <label>创建时间： </label>
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
                <div class="content-panel" >
                    <table class="table table-hover rowSameHeight"
                           data-toggle="table"
                           id="roles"
                           data-toolbar="#toolbar"
                           data-search="true"
                           data-show-refresh="true"
                           <%-- data-show-toggle="true" --%>
                           data-show-fullscreen="true"
                           data-show-columns="true"
                           data-show-columns-toggle-all="true"
                           data-click-to-select="true"
                           data-single-select="true"
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

     <!-- 添加角色 -->
     <div class="modal inmodal" id="addRoleModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px">新增角色</h3>
                            </div>
                            <div><p></p><p></p></div>
                            <form class="form-horizontal style-form" id="addRoleForm" action="/role/addRole" method="post">
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">角色名称：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" name="roleName" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">角色描述：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" name="roleRemark" />
                                    </div>
                                </div>
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


     <!-- 修改角色信息 -->
     <div class="modal inmodal" id="alterRoleModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="mb" style="margin: 0px">修改角色信息</h3>
                            </div>
                            <div><p></p><p></p></div>
                            <form class="form-horizontal style-form" id="editRoleForm" action="/role/editRole" method="post">
                                <div class="form-group" style="display: none">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">编号：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="roleId" name="roleId" />
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">角色名称：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="roleName" name="roleName" />
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-lg-3 control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;text-align: right">角色描述：</label>
                                    <div class="col-lg-5">
                                        <input type="text" class="form-control" id="roleRemark" name="roleRemark" />
                                    </div>
                                </div>
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


     <!-- 分配资源-->
     <div class="modal inmodal" id="allocationResourceModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="mb" style="margin: 0px">分配资源</h3>
                            </div>
                            <div><p></p><p></p></div>

                            <div class="x_content">
                                <input type="hidden" value="${roleId}" id="roleId1" name="roleId">
                                <div class="form-group">
                                    <button class="btn btn-primary btn-sm" type="button" id="btn-back">返回</button>
                                    <button type="button" class="btn btn-success btn-sm" id="btn-save">保存</button>
                                    <button class="btn btn-info btn-sm" type="button" id="expandAll">全部展开</button>
                                    <button class="btn btn-info btn-sm" type="button" id="collapseAll">全部收起</button>
                                </div>
                                <div class="form-group">
                                    <div id="data-tree"></div>
                                </div>
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
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>


<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>

<!-- 引入bootstrap-treeView -->
<script src="${pageContext.request.contextPath}/lib/bootstrap-treeview/bootstrap-treeview.js"></script>


<script>

    // 初始化表格数据
    var dataTable = $('#roles').bootstrapTable({
        url: "/role/data",                      //  请求后台的URL
        method: "get",                      //  请求方式
        uniqueId: "roleId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 10,                       //  每页的记录行数
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                roleId:$("#roleId2").val(),
                roleName: $("#roleName2").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val()
            }
        },
        columns: [
            {
            checkbox: true
            }, {
            field: 'roleId',
            title: '角色编号'
        }, {
            field: 'roleName',
            title: '角色名称'
        }, {
            field: 'roleRemark',
            title: '角色描述'
        }, {
           field: 'createTime',
           title: '创建时间'
        },{
            field: 'updateTime',
            title: '最后更新时间'
        }]
    });

    // 查询
    $('#btn-search').bind('click', function () {
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/role/data",
            pageSize: 10,
            pageNumber: 1
        });
    }



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

    /**
     * 角色信息校验
     */
    $(document).ready(function() {
        $('#addRoleForm').bootstrapValidator({
            message: '请填写正确的角色信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                roleName: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '角色名称不能为空 '
                        }
                    }
                },
                roleRemark: {
                    validators: {
                        notEmpty: {
                            message: '角色描述不能为空 '
                        }
                    }
                }
            }
        });

        $('#resetBtn').click(function () {
            $('#addRoleForm').data('bootstrapValidator').resetForm(true);
        });
    });

    /**
     * 打开修改窗口
     */
    function alterRole(){
        var $table = $('#roles');
        var role= $table.bootstrapTable('getSelections');

        var roleId=role[0].roleId;
        var roleName=role[0].roleName;
        var roleRemark=role[0].roleRemark;

        $("#alterRoleModal").modal('show');

        $("#roleId").val(roleId);
        $("#roleName").val(roleName);
        $("#roleRemark").val(roleRemark);
    }

    /**
     * 打开删除窗口
     */
    function removeRole() {
        var role= $('#roles').bootstrapTable('getSelections');
        role=JSON.stringify(role);
        if (role=="[]"){
            layer.msg("请选择要删除的角色");
        }else{
            $("#removeRoleModal").modal('show');
        }
    }

    function remove(){
        var roleId;
        var tbodyObj = document.getElementById('roles');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                roleId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'/role/removeRole',
                    dataType:'json',
                    type:'post',
                    data:{roleId:roleId},
                    success:function(data){
                        if (data.code == 0) {
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeRoleModal").modal('hide');
                            window.location.reload();
                        } else {
                            layer.alert(data.msg, {icon: 5, offset: '0px'});
                        }
                    }
                });
            }
        });
    }


    // 分配资源
    $('#btn-assign-resource').click(function () {
        var rows = $('#roles').bootstrapTable('getSelections');
        var roleId=rows[0].roleId;
        if (rows.length == 0) {
            window.parent.layer.msg("请选择数据行!", {icon: 2, time: 1000, offset: 't'})
        } else {
            $.ajax({
                url: '/role/assign/resourceTree',
                data:{roleId:roleId},
                dataType: 'json',
                type: 'post',
                success: function (response) {
                    console.log(response);
                    if (response.code == 0) {
                        $("#roleId1").val(response.roleId);

                        $('#data-tree').treeview({
                                //data: new Array(response.data),
                                data: response.data.nodes,
                                levels: 4,
                                showCheckbox: true,       //启用复选按钮
                                hierarchicalCheck: true   //级联勾选
                        });
                        $("#allocationResourceModal").modal('show');

                    } else {
                        layer.alert(response.msg, {icon: 5, offset: '0px'});
                    }
                }
            });
        }
    });


    $("#btn-back").click(function () {
        window.location.href = '${pageContext.request.contextPath}/role/showAllRoles/';
    });

    $('#btn-save').bind('click', function () {
        // 角色id
        var roleId = $('#roleId1').val();
        //node-checked
        //node-checked-partial
        var roleResourceList = [];
        $('.node-checked,.node-checked-partial').each(function () {
            var roleResource = {
                roleId:roleId,
                resourceId:$(this).attr('id')
            };
            //将对象放入到数组中
            roleResourceList.push(roleResource);
        });
        console.log(roleResourceList);

        $.ajax({
            url: '/role/assign/resource/'+roleId,
            contentType: "application/json; charset=UTF-8",//发送给服务器的是json数据
            type: 'post',
            data: JSON.stringify(roleResourceList),
            dataType: 'json',
            success: function (response) {
                if (response.code == 0) {
                    window.parent.layer.msg(response.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.href = '${pageContext.request.contextPath}/role/showAllRoles';
                } else {
                    window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                }
            }
        });
    });



</script>

<%--日期选择--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/laydate/laydate.js"></script>
<script type="text/javascript">



    function resetForm(data) {
        $(data)[0].reset();
    }




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
