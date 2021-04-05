<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-06
  Time: 12:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>客户管理</title>
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
                    <shiro:hasPermission name="business:customer:add">
                        <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addCustomerModal" ><i class="fa fa-plus"></i> 新增</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:customer:edit">
                        <a href="javascript:void(0)" class="btn btn-primary" onclick="alterCustomer()"><i class="fa fa-edit"></i> 修改</a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="business:customer:remove">
                        <a href="javascript:void(0)" class="btn btn-danger" onclick="removeCustomer()"><i class="fa fa-remove"></i> 删除</a>
                    </shiro:hasPermission>
                </div>
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <shiro:hasPermission name="business:customer:search">
                    <div class="col-sm-12 search-collapse">
                        <p class="select-title"></p>
                        <form id="time-form">
                            <div class="select-list">
                                <ul>
                                    <li>
                                        客户名称：<input type="text" id="customerName2" name="customerName"/>
                                    </li>
                                    <li>
                                        客户状态：<select id="available2" name="available">
                                        <option value="">所有</option>
                                        <option value="0">正常</option>
                                        <option value="1">取消合作</option>
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
                    <div class="content-panel" style="height: 650px;overflow: auto;" >
                        <table class="table table-hover rowSameHeight"
                               data-toggle="table"
                               id="customers"
                               data-toolbar="#toolbar"
                               data-search="true"
                               data-show-refresh="true"
                               <%-- data-show-toggle="true" --%>
                               data-show-fullscreen="true"
                               data-show-columns="true"
                               data-show-columns-toggle-all="true"
                               data-click-to-select="true"
                               data-single-select="true"
                               <shiro:hasPermission name="business:customer:export" >
                               data-show-export="true"
                               data-exportDataType ="basic"
                               </shiro:hasPermission>
                               data-show-pagination-switch="true">
                        </table>
                    </div>


                </div>
                <!-- /col-md-12 -->
            </div>

            <!-- 新增客户 -->
            <div class="modal inmodal" id="addCustomerModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="mb" style="margin: 0px"> 新增客户信息</h4>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" id="addCustomerForm" action="/customer/addCustomer" method="post">
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">客户名称：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="customerName" placeholder="客户名称" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系地址：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="customerAddress" placeholder="联系地址" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">公司电话：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="customerPhone" placeholder="公司电话" required>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-5 control-label" style="font-size:16px;">联系人：</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" name="contact" placeholder="联系人" required>
                                            </div>
                                        </div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-5 control-label" style="font-size:16px;">手机号：</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" name="telephone" placeholder="联系人电话" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">银行名称：</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" name="customerBank" placeholder="银行名称" required>
                                            </div>
                                        </div>

                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">银行账户：</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" name="customerAccount" placeholder="银行账户" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div style="float:left;width: 50%;">
                                            <label class="col-sm-3 control-label" style="font-size:16px;">邮箱：</label>
                                            <div >
                                                <input type="text" class="form-control" name="customerEmail" placeholder="邮箱" style="width: 60%">
                                            </div>
                                        </div>
                                        <div style="float:left; width: 50%;">
                                            <label class="col-sm-3 control-label" style="font-size:16px;">状态：</label>
                                            <div class="col-sm-4">
                                                <select class="form-control"  style="width: 100px;"  name="available" >
                                                    <option value="0">合作</option>
                                                    <option value="1">已取消合作</option>
                                                </select>
                                            </div>
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


            <!-- 修改客户信息 -->
            <div class="modal inmodal" id="alterCustomerModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h4 class="mb" style="margin: 0px"> 修改客户信息</h4>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" id="editCustomerForm" action="/customer/editCustomer" method="post">

                                    <div class="form-group" style="display: none">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">客户编号：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="customerId" name="customerId" placeholder="客户编号" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">客户名称：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="customerName" name="customerName" placeholder="客户名称" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">联系地址：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="customerAddress" name="customerAddress" placeholder="联系地址" required>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">公司电话：</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" id="customerPhone" name="customerPhone" placeholder="公司电话" required>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-5 control-label" style="font-size:16px;">联系人：</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="contact1" name="contact" placeholder="联系人" required>
                                            </div>
                                        </div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-5 control-label" style="font-size:16px;">手机号：</label>
                                            <div class="col-sm-6">
                                                <input type="text" class="form-control" id="telephone" name="telephone" placeholder="联系人电话" required>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">银行名称：</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" id="customerBank" name="customerBank" placeholder="银行名称" required>
                                            </div>
                                        </div>

                                        <div class="form-group" style="float:left;width: 50%;">
                                            <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">银行账户：</label>
                                            <div class="col-sm-7">
                                                <input type="text" class="form-control" id="customerAccount" name="customerAccount" placeholder="银行账户" required>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div style="float:left;width: 50%;">
                                            <label class="col-sm-3 control-label" style="font-size:16px;">邮箱：</label>
                                            <div >
                                                <input type="text" class="form-control" id="customerEmail" name="customerEmail" placeholder="邮箱" style="width: 60%">
                                            </div>
                                        </div>
                                        <div style="float:left; width: 50%;">
                                            <label class="col-sm-3 control-label" style="font-size:16px;">状态：</label>
                                            <div class="col-sm-4">
                                                <select class="form-control"  style="width: 100px;" id="available" name="available" >
                                                    <option value="0">合作</option>
                                                    <option value="1">已取消合作</option>
                                                </select>
                                            </div>
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


            <!-- 删除客户-->
            <div class="modal fade" id="removeCustomerModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                移除客户（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定客户？</h4>
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


<script>
    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#customers').bootstrapTable({
        url: "/customer/findAllCustomer",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "customerId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "server",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        showPaginationSwitch:true,
        pageList:"[5,10,25,50,100,all]",
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
                customerName:$("#customerName2").val(),
                available:$("#available2").val()
            }
        },
        columns: [
            {
                checkbox: true
            }, {
                field: 'customerId',
                title: '编号'
            }, {
                field: 'customerName',
                title: '客户名称'
            }, {
                field: 'customerAddress',
                title: '公司地址'
            }, {
                field: 'customerPhone',
                title: '公司电话'
            }, {
                field: 'contact',
                title: '联系人'
            }, {
                field: 'telephone',
                title: '联系人电话'
            }, {
                field: 'customerBank',
                title: '银行名称'
            }, {
                field: 'customerAccount',
                title: '银行账号'
            }, {
                field: 'available',
                title: '状态',
                formatter: function(value, item, index) {
                    if (value==0){
                        return "<span class=\"label label-success\">合作</span>";
                    }else {
                        return "<span class=\"label label-danger\">取消合作</span>";
                    }
                }
            }]
    });

    // 查询
    $('#btn-search').bind('click', function () {
        dataTable.bootstrapTable('removeAll');
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        dataTable.bootstrapTable('refresh', {
            url: "/customer/findAllCustomer",
            pageSize: 10,
            pageNumber: 1
        });
    }

    /**
     * 关闭模态框之后对模态框进行重置
     */
    $(document).ready(function() {
        $('#addCustomerModal').on('hidden.bs.modal', function () {
            //$('#addS').data('bootstrapValidator').resetForm(true);
            $('#addCustomerForm')[0].reset();
        });
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
     * 打开修改窗口
     */
    function alterCustomer() {
        var $table = $('#customers');
        var customer = $table.bootstrapTable('getSelections');

        if (JSON.stringify(customer) == "[]") {
            layer.alert("请先选择要进行信息修改的客户", {icon: 5});
        } else {
            var customerId = customer[0].customerId;
            var customerName = customer[0].customerName;
            var customerAddress = customer[0].customerAddress;
            var customerPhone = customer[0].customerPhone;
            var contact = customer[0].contact;
            var telephone = customer[0].telephone;
            var customerBank = customer[0].customerBank;
            var customerAccount = customer[0].customerAccount;
            var customerEmail = customer[0].customerEmail;
            var availableStr = customer[0].available;


            $("#alterCustomerModal").modal('show');

            $("#customerId").val(customerId);
            $("#customerName").val(customerName);
            $("#customerAddress").val(customerAddress);
            $("#customerPhone").val(customerPhone);
            $("#contact1").val(contact);
            $("#telephone").val(telephone);
            $("#customerBank").val(customerBank);
            $("#customerAccount").val(customerAccount);
            $("#customerEmail").val(customerEmail);

            var available;
            if (availableStr == "合作") {
                $(" select option[value='0']").attr("selected", "selected");
            } else if (availableStr == "已取消合作") {
                $(" select option[value='1']").attr("selected", "selected");
            }
        }
    }

    /**
     * 打开删除窗口
     */
    function removeCustomer() {
        var $table = $('#customers');
        var customer= $table.bootstrapTable('getSelections');

        if (JSON.stringify(customer)=="[]"){
            layer.alert("请先选择要删除的客户", {icon: 5});
        }else{
            $("#removeCustomerModal").modal('show');
        }
    }

    function remove(){
        var customerId;
        var tbodyObj = document.getElementById('customers');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                customerId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'../customer/removeTargetCustomer',
                    dataType:'json',
                    type:'post',
                    data:{customerId:customerId},
                    success:function(data){
                        if(data.code == 0){
                            layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                            $("#removeCustomerModal").modal('hide');
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

