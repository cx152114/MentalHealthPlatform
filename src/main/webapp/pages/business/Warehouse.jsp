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
                    <shiro:hasPermission name="business:articleType:add">
                        <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addWarehouseModal" ><i class="fa fa-plus"></i> 新增</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:articleType:edit">
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="alterWarehouse()"><i class="fa fa-edit"></i> 修改</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:articleType:remove">
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="removeWarehouse()"><i class="fa fa-remove"></i> 删除</a>
                    </shiro:hasPermission>
                </div>
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <div class="content-panel" style="height: 650px;overflow: auto;">
                        <table class="table table-hover rowSameHeight"
                               id="warehouses"
                               data-toolbar="#toolbar"
                               data-toggle="table"
                               data-search="true"
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
                               data-show-pagination-switch="true"
                               data-pagination="true"
                               data-page-list="[5,10,25,50,100,all]">
                            <h4><i class="fa fa-angle-right"></i> 仓库管理</h4>
                            <hr>
                        </table>
                    </div>

                </div>
                <!-- /col-md-12 -->
            </div>

            <!-- 新增仓库 -->
            <div class="modal inmodal" id="addWarehouseModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px"> 新增仓库信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" id="addWarehouseForm" action="/business/warehouse/addWarehouse" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">仓库名称</label>
                                                <input type="text" class="form-control" name="warehouseName" placeholder="仓库名称" style="width: 60%">
                                            </div>
                                            <div>
                                                <!--联系人的选择-->
                                                <label for="selectUserId" class="control-label">联系人：</label>
                                                <select class="form-control"  style="width: 100px;" id="selectUserId" name="userId">
                                                    <option style='display: none'></option>
                                                </select>
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">仓库地址</label>
                                                <input type="text" class="form-control" ID="warehouseAddress1" name="warehouseAddress" placeholder="仓库地址" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">备注</label>
                                                <input type="text" class="form-control" name="warehouseRemark" placeholder="备注" style="width: 60%">
                                            </div>
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                    <button type="reset" id="resetBtn" class="btn btn-warning">重置</button>
                                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                                </form>
                            </div>
                        </div>
                    </div>
                    <small class="font-bold"></small>
                </div>
                <small class="font-bold"></small>
            </div>

            <!-- 修改仓库信息 -->
            <div class="modal inmodal" id="alterWarehouseModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">

                                <h3 class="mb" style="margin: 0px">修改仓库信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" action="/business/warehouse/editWarehouse" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >
                                            <div style="display: none">
                                                <label class="control-label">仓库编号</label>
                                                <input type="text" class="form-control" name="warehouseId" id="warehouseId" placeholder="仓库编号" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">仓库名称</label>
                                                <input type="text" class="form-control" name="warehouseName" id="warehouseName" placeholder="仓库名称" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">联系人</label>
                                                <select class="form-control"  style="width: 100px;" id="selUserId1" name="employeeId">
                                                </select>
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">仓库地址</label>
                                                <input type="text" class="form-control" name="warehouseAddress" id="warehouseAddress" placeholder="仓库地址" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">备注</label>
                                                <input type="text" class="form-control" name="warehouseRemark" id="warehouseRemark" placeholder="备注" style="width: 60%">
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

            <!-- 移除仓库-->
            <div class="modal fade" id="removeWarehouseModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                移除仓库（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定仓库？</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="remove()">移除</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>


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


<script type="application/javascript">
    $(document).ready(function() {
        $('#addWarehouseForm').bootstrapValidator({
            message: '请填写完整的仓库信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                warehouseName: {
                    message: 'The username is not valid',
                    validators: {
                        notEmpty: {
                            message: '仓库名不能为空 '
                        }
                    }
                },
                userId: {
                    validators: {
                        notEmpty: {
                            message: '联系人不能为空 '
                        }
                    }
                },
                warehouseAddress: {
                    validators: {
                        notEmpty: {
                            message: '仓库地址不能为空'
                        }
                    }
                }
            }
        });

        $('#resetBtn').click(function() {
            $('#addWarehouseForm').data('bootstrapValidator').resetForm(true);
        });
    });
</script>


<script>


    // 初始化表格数据
    var dataTable = $('#warehouses').bootstrapTable({
        url: "/business/warehouse/findTargetWarehouse",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "warehouseId",                 //  每一行的唯一标识，一般为主键列
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
                field: 'warehouseId',
                title: '仓库编号'
            }, {
                field: 'warehouseName',
                title: '仓库名称'
            }, {
                field: 'userId',
                title: '负责人编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.user.userId;
                }
            }, {
                field: 'userName',
                title: '负责人姓名',
                formatter: function(value, item, index) {
                    return item.user.username;
                }
            }, {
                field: 'warehouseAddress',
                title: '仓库地址'
            }, {
                field: 'warehouseRemark',
                title: '备注'
            }]
    });



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
        $('#addWarehouseModal').on('hidden.bs.modal', function () {
            document.getElementById("addWarehouseForm").reset();
        });
    });









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
                        <!-- 向商品详情表中进行数据注入 -->
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



    /**
     * 打开修改窗口
     */
    function alterWarehouse(){
        var $table = $('#warehouses');
        var warehouse = $table.bootstrapTable('getSelections');

        if (JSON.stringify(warehouse) == "[]") {
            layer.alert("请先选择要进行修改的记录", {icon: 5});
        } else {
                var warehouseId=warehouse[0].warehouseId;
                var warehouseName=warehouse[0].warehouseName;
                var userId=warehouse[0].userId;
                var warehouseAddress=warehouse[0].warehouseAddress;
                var warehouseRemark=warehouse[0].warehouseRemark;

                $("#alterWarehouseModal").modal('show');

                $("#warehouseId").val(warehouseId);
                $("#warehouseName").val(warehouseName);
                $("#selEmployeeId").val(userId);
                $("#warehouseAddress").val(warehouseAddress);
                $("#warehouseRemark").val(warehouseRemark);
            }
    }


    /**
     * 打开删除窗口
     */
    function removeWarehouse() {
        var $table = $('#warehouses');
        var warehouse= $table.bootstrapTable('getSelections');

        if (JSON.stringify(warehouse)=="[]"){
            layer.alert("请先选择要删除的记录", {icon: 5});
        }else{
            $("#removeWarehouseModal").modal('show');
        }
    }

    function remove(){
        var warehouseId;
        var tbodyObj = document.getElementById('warehouses');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                warehouseId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'/business/warehouse/removeTargetWarehouse',
                    dataType:'json',
                    type:'post',
                    data:{warehouseId:warehouseId},
                    success:function(data){
                        if(data.code == 0){
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeWarehouseModal").modal('hide');
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

