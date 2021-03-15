<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-21
  Time: 23:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>商品销售退货单</title>
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
    <h4 style="padding-left: 40px"><i class="fa fa-angle-right"></i> 销售退货单信息</h4>
    <div class="btn-group-sm" id="toolbar" role="group">
        <shiro:hasPermission name="business:salesBackOrder:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="alterCustomer()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:salesBackOrder:remove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeCustomer()"><i class="fa fa-remove"></i> 删除</a>
        </shiro:hasPermission>
    </div>

    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <div class="content-panel">

            <shiro:hasPermission name="business:salesBackOrder:search">
                <div class="col-sm-12 search-collapse">
                <form id="complex-form" >
                    <div class="select-list">
                        <ul>
                            <li>
                                <label style="width: 60px">订单号：</label>
                                <input type="text" id="sboId" name="sboId"/>
                            </li>
                            <li>
                                <label style="width: 80px">客户名称：</label>
                                <select id="customerId" style="width: 160px;"  name="customerId">
                                    <option value=""></option>
                                </select>
                            </li>

                            <li class="select-time">
                                <label>订单时间： </label>
                                <input type="text" class="time-input" id="startTime" placeholder="开始时间" name="params[beginTime]"/>
                                <span>-</span>
                                <input type="text" class="time-input" id="endTime" placeholder="结束时间" name="params[endTime]"/>
                            </li>


                            <li>
                                <label style="width: 60px">总数量：</label>
                                <input type="number" style="width: 80px;"  id="minNumber" placeholder="最小数量" name="params[minNumber]"/>
                                <span>-</span>
                                <input type="number" style="width: 80px;" id="maxNumber" placeholder="最大数量" name="params[maxNumber]"/>
                            </li>

                            <li>
                                <label style="width: 60px">总金额：</label>
                                <input type="number" style="width: 100px;" id="minAccount" placeholder="最小金额" name="params[minAccount]"/>
                                <span>-</span>
                                <input type="number"  style="width: 100px;" id="maxAccount" placeholder="最大金额" name="params[maxAccount]"/>
                            </li>

                            <li>
                                <label style="width: 80px">支付方式：</label>
                                <select id="payType" style="width: 80px"  name="payType">
                                    <option value="">所有</option>
                                    <option value="0">现金</option>
                                    <option value="1">银行转账</option>
                                    <option value="2">微信</option>
                                    <option value="3">支付宝</option>
                                    <option value="4">支票</option>
                                </select>
                            </li>

                            <li>
                                <label style="width: 60px">经手人：</label>
                                <select id="userId" style="width: 100px"  name="userId">
                                    <option value=""></option>
                                </select>
                            </li>



                            <li>
                                <label style="width: 80px">订单状态：</label>
                                <select id="sboStatus" style="width: 100px" name="sboStatus">
                                    <option value="">所有</option>
                                    <option value="0">已完成</option>
                                    <option value="1">未完成</option>
                                </select>
                            </li>

                            <li>
                                <a class="btn btn-primary btn-rounded btn-sm" id="btn-search" ><i class="fa fa-search"></i>&nbsp;搜索</a>
                                <a class="btn btn-warning btn-rounded btn-sm" onclick="resetForm('#complex-form')"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>
            </shiro:hasPermission>
            <table class="table table-hover rowSameHeight"
                   id="salesBackOrders"
                   data-toggle="table"
                   data-toolbar="#toolbar"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-fullscreen="true"
                   data-show-columns="true"
                   data-show-columns-toggle-all="true"
                   data-click-to-select="true"
                   data-single-select="true"
                    <shiro:hasPermission name="business:salesBackOrder:export">
                   data-show-export="true"
                   data-exportDataType ="basic"
                    </shiro:hasPermission>
                   data-show-pagination-switch="true"
                   data-pagination="true"
                   data-page-list="[5,10,25,50,100,all]"
                   data-side-pagination="client">
            </table>
        </div>
    </div>
    <!-- /col-md-12 -->
</div>


<!--  打开订单详情窗口-->
<div  class="modal fade bs-example-modal-lg" id="salesOrderDetailModal" tabindex="-1" role="dialog" aria-labelledby="salesOrderDetailModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="salesOrderDetailModalLabel">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="content-panel">
                    <table class="table table-hover" id="salesOrderDetail">
                        <h4><i class="fa fa-angle-right"></i> 销售退货详情单信息</h4>
                        <hr>
                        <thead>
                        <tr>
                            <th>总订单号</th>
                            <th>商品编号</th>
                            <th>商品名称</th>
                            <th>商品数量</th>
                            <th>单价</th>
                            <th>总价格</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
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



<script src="${pageContext.request.contextPath}/lib/tableExport/tableExport.js"></script>
<%--<script src="https://unpkg.com/tableexport.jquery.plugin/tableExport.min.js"></script>--%>
<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/bootstrap-table-locale-all.min.js"></script>
<script src="https://unpkg.com/bootstrap-table@1.16.0/dist/extensions/export/bootstrap-table-export.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<!-- 数据导出 -->
<script src="${pageContext.request.contextPath}/lib/tableExport/FileSaver.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/xlsx.core.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.plugin.autotable.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/es6-promise.auto.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/html2canvas.min.js"></script>

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>

<script type="application/javascript">
    function resetForm(data) {
        $(data)[0].reset();
        refreshTable();
    }

    // 初始化表格数据
    var dataTable = $('#salesBackOrders').bootstrapTable({
        url: "/business/salesBackOrder/findAllSalesBackOrder",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "sboId",                 //  每一行的唯一标识，一般为主键列
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
                sboId:$("#sboId").val(),
                userId:$("#userId").val(),
                customerId:$("#customerId").val(),
                payType:$("#payType").val(),
                sboStatus:$("#sboStatus").val(),
                minNumber:$("#minNumber").val(),
                maxNumber:$("#maxNumber").val(),
                startTime:$("#startTime").val(),
                endTime:$("#endTime").val(),
                minAccount:$("#minAccount").val(),
                maxAccount:$("#maxAccount").val()
            }
        },
        columns: [
            {
                checkbox: true
            },{
                field: 'sboId',
                title: '订单号'
            }, {
                field: 'customerId',
                title: '客户编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.customer.customerId;
                }
            }, {
                field: 'customerName',
                title: '客户名',
                formatter: function(value, item, index) {
                    return item.customer.customerName;
                }
            }, {
                field: 'orderTime',
                title: '订单时间'
            }, {
                field: 'sboNumber',
                title: '总数量'
            }, {
                field: 'totalMoney',
                title: '总金额'
            }, {
                field: 'payType',
                title: '支付方式',
                formatter: function(value, item, index) {
                    if(value==0){
                        return "现金";
                    }else if(value==1){
                        return "银行转账";
                    }else if(value==2){
                        return "支付宝";
                    }else if(value==3){
                        return "微信";
                    }else if(value==4){
                        return "其他";
                    }
                }
            }, {
                field: 'userId',
                title: '经手人编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.user.userId;
                }
            }, {
                field: 'username',
                title: '经手人',
                formatter: function(value, item, index) {
                    return item.user.username;
                }
            }, {
                field: 'sboStatus',
                title: '订单状态',
                formatter: function(value, item, index) {
                    if(value==0){
                        return "<span class=\"label label-success\">已完成</span>";
                    }else if(value==1){
                        return "<span class=\"label label-info\">未完成</span>";
                    }else if(value==2) {
                        return "<span class=\"label label-warning\">已取消</span>";
                    }
                }
            }, {
                field: 'sboReason',
                title: '退货原因'
            },{
                field: 'action',
                title: '操作',
                formatter: function(value, item, index) {
                    return "<button type=\"button\" class=\"btn btn-info btn-rounded btn-xs\" onclick=\"getOrderDetail(this)\">详情</button>";
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
        dataTable.bootstrapTable('refresh');
    }

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
                        $("#userId").append("<option value='"+item.userId+"'>"+item.username+"</option>");
                        i++;
                    });
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    });

    /**
     * 获取所需要的客户信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/customer/findAllCustomer',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var customerList=data.rows;
                    $.each(customerList,function(i,item){
                        <!-- 向商品详情表中进行数据注入 -->
                        $("#customerId").append("<option value='"+item.customerId+"'>"+item.customerName+"</option>");
                        i++;
                    });
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    });
</script>



<script>
    /**
     * 获取订单详情
     * @param data1
     */
    function getOrderDetail(data1) {
        var value = $(data1).parent().parent().find("td");
        var sboId=value.eq(1).text().toString().trim();
        //alert(stoId);
        $.ajax({
            url:'/business/salesBackOrder/getSalesBackOrderBySboId',
            dataType:'json',
            type:'post',
            data:{sboId:sboId},
            success:function(data){
                if(data.code==0){
                    var list=data.salesBackDetails;
                    $("#salesOrderDetail tbody tr").eq(0).nextAll().remove();
                    $.each(list,function(i,item){
                        <!-- 向商品详情表中进行数据注入 -->
                        $("#salesOrderDetail tbody").append('<tr>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.sboId+'</td>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneInfo.phoneId+'</td>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneInfo.phoneName+'</td>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.productNumber+'</td>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.unitPrice+'</td>');
                        $("#salesOrderDetail tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.money+'</td>');
                        $("#salesOrderDetail tbody").append('</tr>')
                        i++;
                    });
                    $("#salesOrderDetailModal").modal('show');
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });

    }


    $(function(){
        $("#btn1").click(function(){
            $("#orderStockOrderModal").modal("hide");
            $("body").addClass("modal-open");
        });

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