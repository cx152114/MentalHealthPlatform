<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-06
  Time: 19:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"  isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>商品管理</title>
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
        }

        td{
            text-align: center;
            vertical-align: middle;
            vertical-align: center;
        }
    </style>
</head>
<body>
<section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--页面头部-->
    <jsp:include page="header.jsp"></jsp:include>
    <!--页面头部-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--导航侧栏-->
    <jsp:include page="aside.jsp"></jsp:include>
    <!--导航侧栏-->
    <!-- **********************************************************************************************************************************************************
        MAIN CONTENT
        *********************************************************************************************************************************************************** -->
    <!--内容区域-->
    <section id="main-content">
        <section class="wrapper">
            <div class="row">
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <!-- 增加按钮 -->
                    <button style="width: 75px;" type="button" class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addCustomerModal">新增</button>
                    <!-- 修改按钮 -->

                    <a href="javascript:void(0)" style="width: 75px;" class="btn btn-warning" onclick="alterCustomer()">修改</a>
                    <!-- 删除按钮 -->
                    <%--                        <button style="width: 75px;" type="button" class="btn btn-danger" data-toggle="modal" data-backdrop="false" data-target="#removeProductModal">删除</button>--%>
                    <a href="javascript:void(0)" style="width: 75px;" class="btn btn-danger" onclick="removeSupplier()">删除</a>
                    <hr />
                    <div class="content-panel">
                        <table class="table table-hover"
                               data-toggle="table"
                               id="customers">
                        </table>
                    </div>

                    <div>
                        <div class="pull-left" style="margin-left: 15px;margin-top: 20px;margin-bottom: 15px;">
                            <div class="form-group form-inline">
                                总共${pageInfo.pages} 页，共${pageInfo.total} 条数据。 每页
                                <select class="form-control" id="changePageSize" onchange="changePageSize()">
                                    <option>5</option>
                                    <option>10</option>
                                    <option>15</option>
                                    <option>20</option>
                                    <option>25</option>
                                </select> 条
                            </div>
                        </div>
                    </div>

                    <nav aria-label="..." class="dataTables_paginate paging_bootstrap pagination">
                        <ul class="pagination pagination-lg">

                            <li>
                                <a href="${pageContext.request.contextPath}/customer/findAllCustomer?page=1&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">首页</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/customer/findAllCustomer?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页 <span class="sr-only"></span></a>
                            </li>
                            <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                                <li>
                                    <a href="${pageContext.request.contextPath}/customer/findAllCustomer?page=${pageNum}&size=${pageInfo.pageSize}">${pageNum} <span class="sr-only"></span></a>
                                </li>
                            </c:forEach>
                            <li >
                                <a href="${pageContext.request.contextPath}/customer/findAllCustomer?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">后一页 <span class="sr-only"></span></a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/customer/findAllCustomer?page=${pageInfo.pages}&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">尾页</span>
                                </a>
                            </li>

                        </ul>
                    </nav>


                </div>
                <!-- /col-md-12 -->
            </div>

            <!-- 新增客户 -->
            <div class="modal inmodal" id="addCustomerModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px"> 新增客户信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" action="/customer/addCustomer" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >

                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">客户名称</label>
                                                <input type="text" class="form-control" name="customerName" placeholder="客户名称" >
                                            </div>
                                            <div >
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">邮编</label>
                                                <input type="text" class="form-control" name="customerPostcode" placeholder="邮政编码" >
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系地址</label>
                                                <input type="text" class="form-control" name="customerAddress" placeholder="联系地址" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">公司电话</label>
                                                <input type="text" class="form-control" name="customerPhone" placeholder="公司电话" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系人</label>
                                                <input type="text" class="form-control" name="contact" placeholder="联系人" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系人电话</label>
                                                <input type="text" class="form-control" name="telephone" placeholder="联系人电话" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">银行名称</label>
                                                <input type="text" class="form-control" name="customerBank" placeholder="银行名称" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">银行账户</label>
                                                <input type="text" class="form-control" name="customerAccount" placeholder="银行账户" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">邮箱</label>
                                                <input type="text" class="form-control" name="customerEmail" placeholder="邮箱" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">传真</label>
                                                <input type="text" class="form-control" name="customerFax" placeholder="传真" style="width: 60%">
                                            </div>
                                            <!--公司状态选择-->
                                            <label for="available" class="control-label">状态：</label>
                                            <select class="form-control"  style="width: 100px;" id="available" name="available">
                                                <option value="1">合作</option>
                                                <option value="0">已取消合作</option>
                                            </select>
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


            <!-- 修改客户信息 -->
            <div class="modal inmodal" id="alterCustomerModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="mb" style="margin: 0px">修改客户信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" action="/customer/editCustomer" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >
                                            <div style="display: none">
                                                <label class="control-label">客户编号</label>
                                                <input type="text" class="form-control" name="customerId" id="customerId" placeholder="客户编号" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">客户名称</label>
                                                <input type="text" class="form-control" name="customerName" id="customerName" placeholder="客户名称" style="width: 60%">
                                            </div>
                                            <div >
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">邮编</label>
                                                <input type="text" class="form-control" id="customerPostcode" name="customerPostcode" placeholder="邮政编码" >
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系地址</label>
                                                <input type="text" class="form-control" id="customerAddress" name="customerAddress" placeholder="联系地址" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">公司电话</label>
                                                <input type="text" class="form-control" id="customerPhone" name="customerPhone" placeholder="公司电话" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系人</label>
                                                <input type="text" class="form-control" id="contact" name="contact" placeholder="联系人" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">联系人电话</label>
                                                <input type="text" class="form-control" id="telephone" name="telephone" placeholder="联系人电话" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">银行名称</label>
                                                <input type="text" class="form-control" id="customerBank" name="customerBank" placeholder="银行名称" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">银行账户</label>
                                                <input type="text" class="form-control" id="customerAccount" name="customerAccount" placeholder="银行账户" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">邮箱</label>
                                                <input type="text" class="form-control" id="customerEmail" name="customerEmail" placeholder="邮箱" style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-left: 5px;">传真</label>
                                                <input type="text" class="form-control" id="customerFax" name="customerFax" placeholder="传真" style="width: 60%">
                                            </div>
                                            <!--公司状态选择-->
                                            <label for="available" class="control-label">状态：</label>
                                            <select class="form-control"  style="width: 100px;" id="available1" name="available">
                                                <option value="1">合作</option>
                                                <option value="0">已取消合作</option>
                                            </select>
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


            <!-- 移除供应商-->

        </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
        <div class="text-center">
            <p>
                &copy; Copyrights <strong>Dashio</strong>. All Rights Reserved
            </p>
            <a href="basic_table.html#" class="go-top">
                <i class="fa fa-angle-up"></i>
            </a>
        </div>
    </footer>
    <!--footer end-->
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


<script>
    function changePageSize() {
        //获取下拉框的值
        var pageSize = $("#changePageSize").val();

        //向服务器发送请求，改变没页显示条数
        location.href = "${pageContext.request.contextPath}/product/findAllPhoneInfo?page=1&size="
            + pageSize;
    }

    //获取url中的参数
    function getUrlParam(name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); //构造一个含有目标参数的正则表达式对象
        var r = window.location.search.substr(1).match(reg);  //匹配目标参数
        if (r != null) return unescape(r[2]); return null; //返回参数值
    }

    $(document).ready(function () {
        var size = getUrlParam('size');
        if (size==null){
            $("#changePageSize").val("5");
        }else {
            $("#changePageSize").val(size);
        }
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

    function DoOnMsoNumberFormat(cell, row, col) {
        var result = "";
        if (row > 0 && col == 0)
            result = "\\@";
        return result;
    }


    $('#customers').bootstrapTable({
        url: "../customer/findAllCustomer",//数据源
        dataField: "pageInfo.list",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
        height: tableHeight(),//高度调整
        contentType: "application/x-www-form-urlencoded",//请求数据内容格式 默认是 application/json 自己根据格式自行服务端处理
        dataType: "json",//期待返回数据类型
        method: "post",//请求方式
        height:360,
        searchOnEnterKey: false,//回车搜索
        search: true, //开启刷选
        showColumns: true,//列选择按钮
        showRefresh: true,//刷新按钮
        fullscreen:true,
        showColumnsToggleAll:true,
        showExport:true,
        clickToSelect:true,
        exportDataType:'basic',
        showFooter:true,
        buttonsAlign: "right",//按钮对齐方式
        toolbarAlign: "right",//工具栏对齐方式
        exportOptions:{
            ignoreColumn: [0,1],  //忽略某一列的索引
            fileName: '客户信息表',  //文件名称设置
            worksheetName: 'customers',  //表格工作区名称
            tableName: '客户信息表',
            excelstyles: ['background-color', 'color', 'font-size', 'font-weight'],
            onMsoNumberFormat: DoOnMsoNumberFormat
        },
        columns: [
            {
                title: "全选",
                field: "select",
                checkbox: true,
                //width: 20,//宽度
                align: "center",//水平
                valign: "middle"//垂直
            },
            {
                title: "客户编号",//标题
                field: "customerId",//键名
                sortable: true,//是否可排序
                order: "desc"//默认排序方式
            },
            {
                field: "customerName",
                title: "客户名称",
                sortable: true,
            },
            {
                field: "customerPostcode",
                title: "邮编",
            },
            {
                field: "customerAddress",
                title: "公司地址",
            },
            {
                field: "customerPhone",
                title: "公司电话",
            },
            {
                field: "contact",
                title: "联系人",
            },
            {
                field: "telephone",
                title: "联系人电话",
            },
            {
                field: "customerBank",
                title: "银行名称",
            },
            {
                field: "customerAccount",
                title: "银行账户",
            },
            {
                field: "customerEmail",
                title: "邮箱",
            },
            {
                field: "customerFax",
                title: "传真",
            },
            {
                field: "available",
                title: "状态",
            },
        ],
        // onClickRow: function(row, $element) {
        //     //$element是当前tr的jquery对象
        //     $element.css("background-color", "green");
        // },//单击row事件
        locale: "zh-CN", //中文支持
        detailView: false, //是否显示详情折叠
        detailFormatter: function(index, row, element) {
            var html = '';
            $.each(row, function(key, val){
                html += "<p>" + key + ":" + val +  "</p>"
            });
            return html;
        }
    });




    /**
     * 打开修改窗口
     */
    function alterCustomer(){
        var size=$("input:checkbox:checked").length;
        alert(size);
        if (size<1){
            alert('请选中你要操作的记录');
            return false;
        }
        if (size>1){
            alert('请不要选择多条记录进行操作');
            return false;
        }
        var tbodyObj = document.getElementById('customers');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                var customerId=tbodyObj.rows[key+1].cells[1].innerHTML;
                var customerName=tbodyObj.rows[key+1].cells[2].innerHTML;
                var customerPostcode=tbodyObj.rows[key+1].cells[3].innerHTML;
                var customerAddress=tbodyObj.rows[key+1].cells[4].innerHTML;
                var customerPhone=tbodyObj.rows[key+1].cells[5].innerHTML;
                var contact=tbodyObj.rows[key+1].cells[6].innerHTML;
                var telephone=tbodyObj.rows[key+1].cells[7].innerHTML;
                var customerBank=tbodyObj.rows[key+1].cells[8].innerHTML;
                var customerAccount=tbodyObj.rows[key+1].cells[9].innerHTML;
                var customerEmail=tbodyObj.rows[key+1].cells[10].innerHTML;
                var customerFax=tbodyObj.rows[key+1].cells[11].innerHTML;
                var available=tbodyObj.rows[key+1].cells[12].innerHTML;


                $("#alterCustomerModal").modal('show');

                $("#customerId").val(customerId);
                $("#customerName").val(customerName);
                $("#customerPostcode").val(customerPostcode);
                $("#customerAddress").val(customerAddress);
                $("#customerPhone").val(customerPhone);
                $("#contact").val(contact);
                $("#telephone").val(telephone);
                $("#customerBank").val(customerBank);
                $("#customerAccount").val(customerAccount);
                $("#customerEmail").val(customerEmail);
                $("#customerFax").val(customerFax);
                $("#available1").val(available);
            }
        })
    }

</script>
</body>
</html>
