<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-25
  Time: 17:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>供应商管理</title>
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
            <shiro:hasPermission name="business:supplier:add">
                <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addSupplierModal" ><i class="fa fa-plus"></i> 新增</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="business:supplier:edit">
                <a href="javascript:void(0)" class="btn btn-primary" onclick="alterSupplier()"><i class="fa fa-edit"></i> 修改</a>
            </shiro:hasPermission>
            <shiro:hasPermission name="business:supplier:remove">
                <a href="javascript:void(0)" class="btn btn-danger" onclick="removeSupplier()"><i class="fa fa-remove"></i> 删除</a>
            </shiro:hasPermission>
        </div>
                <!-- /col-md-12 -->
         <div class="col-md-12 mt">
              <div class="content-panel" style="height: 600px;overflow: auto;">
                  <table class="table table-hover rowSameHeight"
                       id="suppliers"
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
                       <shiro:hasPermission name="business:supplier:export">
                           data-show-export="true"
                           data-exportDataType ="basic"
                       </shiro:hasPermission>
                       data-show-pagination-switch="true"
                       data-pagination="true"
                       data-page-list="[5,10,25,50,100,all]"
                       data-side-pagination="client">
                    <h4><i class="fa fa-angle-right"></i> 供应商信息</h4>
                    <hr>
                    <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true"></th>
                        <th data-field="supplierId" style="display:none;">供应商编号</th>
                        <th data-field="supplierName">供应商名称</th>
                        <th data-field="supplierAddress">供应商地址</th>
                        <th data-field="supplierContacts">联系人</th>
                        <th data-field="supplierPhone">联系电话</th>
                        <th data-field="supplierEmail">邮箱</th>
                        <th data-field="supplierRemark">备注</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${supplierList}" var="supplier">
                        <tr style="text-align: center;vertical-align: middle">
                            <td style="text-align: center;vertical-align: middle">
                            </td>
                            <td style="text-align: center;vertical-align: middle;display: none">${supplier.supplierId}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierName}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierAddress}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierContacts}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierPhone}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierEmail}</td>
                            <td style="text-align: center;vertical-align: middle">${supplier.supplierRemark}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                  </table>
              </div>
         </div>
         <!-- /col-md-12 -->
    </div>

    <!-- 新增供应商 -->
    <div class="modal inmodal" id="addSupplierModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
         <div class="modal-dialog">
             <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="mb" style="margin: 0px"> 新增供货商信息</h4>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" id="addSupplierForm" action="/supplier/addSupplier" method="post">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">供应商名称：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierName" placeholder="供应商名称" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">供应商地址：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierAddress" placeholder="供应商地址" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系人：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierContacts" placeholder="联系人" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系电话：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierPhone" placeholder="联系电话" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">邮箱：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierEmail" placeholder="邮箱" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">备注：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="supplierRemark" placeholder="备注" style="width: 60%">
                                        </div>
                                    </div>
                                    <button type="submit" class="btn btn-primary">提交</button>
                                    <button type="reset" class="btn btn-warning" id="btn-reset">重置</button>
                                    <button type="button"  class="btn btn-default" data-dismiss="modal">取消</button>
                                </form>
                            </div>
                        </div>
                    </div>
             <small class="font-bold"></small>
         </div>

    </div>

    <!-- 修改商品 -->
    <div class="modal inmodal" id="alterSupplierModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                    <div class="panel-heading" style="text-align: center;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h3 class="mb" style="margin: 0px">修改供应商信息</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal style-form"  action="/supplier/editSupplier" method="post">
                            <div class="form-group" style="display: none">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">供应商编号：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierId" id="supplierId" placeholder="供应商编号" >
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">供应商名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierName" id="supplierName" placeholder="供应商名称" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">供应商地址：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierAddress" id="supplierAddress" placeholder="供应商地址" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系人：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierContacts" id="supplierContacts" placeholder="联系人" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系电话：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierPhone" id="supplierPhone" placeholder="联系电话" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">邮箱：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierEmail" id="supplierEmail" placeholder="邮箱" required>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">备注：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplierRemark" id="supplierRemark" placeholder="备注" style="width: 60%">
                                </div>
                            </div>
                            <button type="submit" class="btn btn-primary">提交</button>
                            <button type="reset" class="btn btn-warning">重置</button>
                            <button type="button"  class="btn btn-default" data-dismiss="modal">取消</button>
                        </form>
                    </div>
                </div>
            </div>
            <small class="font-bold"></small>
        </div>
    </div>

    <!-- 移除供应商-->
    <div class="modal fade" id="removeSupplierModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                移除供应商（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定供应商？</h4>
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


    /**
     * 表单校验
     */
    $(document).ready(function() {
        $('#addSupplierForm').bootstrapValidator({
            message: '请按规定填写供应商信息',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                supplierName: {
                    validators: {
                        notEmpty: {
                            message: '供应商名称不能为空 '
                        },
                    }
                },
                supplierAddress: {
                    validators: {
                        notEmpty: {
                            message: '供应商地址不能为空 '
                        },
                    }
                },

                supplierContacts: {
                    validators: {
                        notEmpty: {
                            message: '联系人不能为空 '
                        },
                    }
                },
                supplierPhone: {
                    validators: {
                        notEmpty: {
                            message: '手机号不能为空'
                        },
                        regexp: {
                            regexp: /^[1][3,4,5,7,8][0-9]{9}$/,
                            message: '手机号格式错误'
                        },
                    }
                },
                supplierEmail: {
                    validators: {
                        notEmpty: {
                            message: '邮箱地址不能为空'
                        },
                        emailAddress: {
                            message: '不是一个正确的邮箱地址'
                        }
                    }
                },
            }
        });

        $('#btn-reset').click(function() {
            $('#addSupplierForm').data('bootstrapValidator').resetForm(true);
        });
    });


    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addSupplierModal').on('hide.bs.modal', function () {
            $('#addSupplierForm').data('bootstrapValidator').resetForm(true);
            $("#btn-reset").click();
        });
    });


    /**
     * 打开修改窗口
     */
    function alterSupplier(){
        var $table = $('#suppliers');
        var supplier= $table.bootstrapTable('getSelections');

        if (JSON.stringify(supplier)=="[]"){
            layer.alert("请先选择要进行修改的记录", {icon: 5});
        }else{
            var supplierId=supplier[0].supplierId;
            var supplierName=supplier[0].supplierName;
            var supplierAddress=supplier[0].supplierAddress;
            var supplierContacts=supplier[0].supplierContacts;
            var supplierPhone=supplier[0].supplierPhone;
            var supplierEmail=supplier[0].supplierEmail;
            var supplierRemark=supplier[0].supplierRemark;

            $("#alterSupplierModal").modal('show');

            $("#supplierId").val(supplierId);
            $("#supplierName").val(supplierName);
            $("#supplierAddress").val(supplierAddress);
            $("#supplierContacts").val(supplierContacts);
            $("#supplierPhone").val(supplierPhone);
            $("#supplierEmail").val(supplierEmail);
            $("#supplierRemark").val(supplierRemark);
        }
    }


    /**
     * 打开删除窗口
     */
    function removeSupplier() {
        var $table = $('#suppliers');
        var supplier= $table.bootstrapTable('getSelections');

        if (JSON.stringify(supplier)=="[]"){
            layer.alert("请先选择要删除的记录", {icon: 5});
        }else{
            $("#removeSupplierModal").modal('show');
        }
    }

    /**
     *删除供应商
     */
    function remove(){
        var supplierId;
        var tbodyObj = document.getElementById('suppliers');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                supplierId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'../supplier/removeSupplier',
                    dataType:'json',
                    type:'post',
                    data:{supplierId:supplierId},
                    success:function(data){
                        if(data.code == 0){
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeSupplierModal").modal('hide');
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
