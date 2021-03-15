<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-27
  Time: 19:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>库存报损单</title>
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
        <shiro:hasPermission name="business:productDamageOrder:edit">
            <a href="javascript:void(0)" class="btn btn-primary" onclick="alterCustomer()"><i class="fa fa-edit"></i> 修改</a>
        </shiro:hasPermission>
        <shiro:hasPermission name="business:productDamageOrder:remove">
            <a href="javascript:void(0)" class="btn btn-danger" onclick="removeCustomer()"><i class="fa fa-remove"></i> 删除</a>
        </shiro:hasPermission>
    </div>
    <!-- /col-md-12 -->
    <div class="col-md-12 mt">

        <div class="content-panel">
            <h4><i class="fa fa-angle-right"></i> 库存报损单信息</h4>

            <shiro:hasPermission name="business:productDamageOrder:search">
            <div class="col-sm-12 search-collapse">
                <form id="complex-form" >
                    <div class="select-list">
                        <ul>
                            <li>
                                <label style="width: 80px">报损单号：</label>
                                <input type="text" style="width: 100px;" id="pdoId" name="pdoId"/>
                            </li>
                            <li>
                                <label style="width: 80px">报损仓库：</label>
                                <select id="warehouseId" style="width: 90px;"  name="warehouseId">
                                    <option value=""></option>
                                </select>
                            </li>


                            <li class="select-time">
                                <label>调拨时间： </label>
                                <input type="text" class="time-input" id="startTime" placeholder="开始时间" name="params[beginTime]"/>
                                <span>-</span>
                                <input type="text" class="time-input" id="endTime" placeholder="结束时间" name="params[endTime]"/>
                            </li>

                            <li>
                                <label style="width: 60px">经手人：</label>
                                <select id="userId" style="width: 70px"  name="userId">
                                    <option value=""></option>
                                </select>
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
                                <a class="btn btn-primary btn-rounded btn-sm" id="btn-search" ><i class="fa fa-search"></i>&nbsp;搜索</a>
                                <a class="btn btn-warning btn-rounded btn-sm" onclick="resetForm('#complex-form')"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                            </li>
                        </ul>
                    </div>
                </form>
            </div>
            </shiro:hasPermission>

            <table class="table table-hover rowSameHeight"
                   id="productDamageOrders"
                   data-toggle="table"
                   data-toolbar="#toolbar"
                   data-search="true"
                   data-show-refresh="true"
                   data-show-toggle="true"
                   data-show-fullscreen="true"
                   data-show-columns="true"
                   data-show-columns-toggle-all="true"
                   data-click-to-select="true"
                   data-single-select="true"
                    <shiro:hasPermission name="business:productDamageOrder:export">
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
<div  class="modal fade bs-example-modal-lg" id="productDamageDetailsModal" tabindex="-1" role="dialog" aria-labelledby="productDamageDetailsModalLabel">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="productDamageDetailsLabel">订单详情</h4>
            </div>
            <div class="modal-body">
                <div class="content-panel">
                    <table class="table table-hover" id="productDamageDetails">
                        <h4><i class="fa fa-angle-right"></i> 库存报损详情单信息</h4>
                        <hr>
                        <thead>
                        <tr>
                            <th>库存报损单单号</th>
                            <th>商品编号</th>
                            <th>商品名称</th>
                            <th>商品数量</th>
                            <th>商品单价</th>
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
    var dataTable = $('#productDamageOrders').bootstrapTable({
        url: "/business/productDamageOrder/findAllProductDamageOrder",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "proId",                 //  每一行的唯一标识，一般为主键列
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
                pdoId:$("#pdoId").val(),
                warehouseId:$("#warehouseId").val(),
                userId:$("#userId").val(),
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
                field: 'pdoId',
                title: '报损单号'
            }, {
                field: 'warehouseId',
                title: '仓库编号',
                visible:false,
                formatter: function(value, item, index) {
                    return item.warehouse.warehouseId;
                }
            }, {
                field: 'warehouseName',
                title: '报损仓库',
                formatter: function(value, item, index) {
                    return item.warehouse.warehouseName;
                }
            }, {
                field: 'pdoTime',
                title: '报损时间'
            }, {
                field: 'userId',
                title: '员工编号',
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
                field: 'pdoNumber',
                title: '总数量'
            }, {
                field: 'totalMoney',
                title: '总金额'
            }, {
                field: 'pdoRemark',
                title: '备注'
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
     * 获取仓库信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/business/warehouse/getTargetWarehouses',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var warehouseList=data.warehouseList;
                    $.each(warehouseList,function(i,item){
                        <!-- 向商品详情表中进行数据注入 -->
                        $("#warehouseId").append("<option value='"+item.warehouseId+"'>"+item.warehouseName+"</option>");
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
        var pdoId=value.eq(1).text().toString().trim();
        $.ajax({
            url:'/business/productDamageOrder/getProductDamageDetailsByPdoId',
            dataType:'json',
            type:'post',
            data:{pdoId:pdoId},
            success:function(data){
                if(data.code==0){
                    var list=data.productDamageDetails;
                    $("#productDamageDetails tbody tr").eq(0).nextAll().remove();
                    $.each(list,function(i,item){
                        <!-- 向商品详情表中进行数据注入 -->
                        $("#productDamageDetails tbody").append('<tr>');
                        $("#productDamageDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.pdoId+'</td>');
                        $("#productDamageDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneInfo.phoneId+'</td>');
                        $("#productDamageDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneInfo.phoneName+'</td>');
                        $("#productDamageDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.productNumber+'</td>');
                        $("#productDamageDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.unitPrice+'</td>');

                        // $("#inventoryMovementDetails tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.money+'</td>');
                        $("#productDamageDetails tbody").append('</tr>')
                        i++;
                    });
                    $("#productDamageDetailsModal").modal('show');
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
