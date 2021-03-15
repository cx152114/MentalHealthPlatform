<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-21
  Time: 16:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>销售管理</title>
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
            <a class="btn btn-success" id="addProducts" data-toggle="modal" data-backdrop="false" onclick="getAllProducts()"><i class="fa fa-plus"></i> 新增</a>
            <button class="btn btn-danger" onclick="removeTargetProduct()"><i class="fa fa-remove"></i> 删除</button>
        </div>
        <!-- /col-md-12 -->
        <div class="col-md-12 mt" style="height: 570px;overflow: auto;">
            <h4><i class="fa fa-angle-right">商品销售单</i></h4>
            <div class="col-sm-12 search-collapse">
                <p class="select-title"></p>
                <div class="select-list">
                    <ul>
                        <li id="selectSupplier">
                            客户名称：<select  id="customerId">
                            <option value="-1" style='display: none'></option>
                        </select>
                        </select>
                        </li>
                        <li>
                            支付方式：<select id="payType" name="payType">
                            <option value="0">银行转账</option>
                            <option value="1">微信</option>
                            <option value="2">支付宝</option>
                            <option value="3">现金</option>
                        </select>
                        </li>
                        <li>
                            状态：<select id="stoStatus" name="stoStatus">
                            <option value="0">完成</option>
                            <option value="1">未完成</option>
                            <option value="2">取消</option>
                        </select>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="content-panel rowSameHeight" style="height: 390px;overflow: auto;" >
                <table id="addSaleOrder"
                       data-toggle="table"
                       data-toolbar="#toolbar"
                       data-search="true"
                       data-show-refresh="true"
                       data-show-toggle="true"
                       data-show-columns="true"
                       data-show-pagination-switch="true"
                       data-pagination="true"
                       data-page-list="[5,10,25,50,100,all]"
                       data-side-pagination="client">
                    <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true">#</th>
                        <th data-field="phoneId" data-sortable="true" data-order="asc">手机编号</th>
                        <th data-field="phoneName">手机名称</th>
                        <th data-field="phoneType">手机类别</th>
                        <th data-field="phoneColor">手机颜色</th>
                        <th data-field="phoneRam">运行内存</th>
                        <th data-field="phoneStorage">储存容量</th>
                        <th data-field="phoneNetwork" >网络类型</th>
                        <th data-field="id" data-visible="false">序列号</th>
                        <th data-field="sn">序列号</th>
                        <th data-field="warehouseId" data-visible="false">仓库号</th>
                        <th data-field="warehouseName">仓库</th>
                        <th data-field="unitPrice">销售单价</th>
                    </tr>
                    </thead>
                </table>
                <div class="form-group" style="padding-bottom: 10px;">
                    <hr>
                    <!--退货理由-->
                    <div>
                        <textarea class="form-control" name="orderRemark" id="orderRemark" placeholder="备注：" rows="2" data-rule="required" data-msg="备注"></textarea>
                    </div>
                </div>
            </div>


            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="submitOrder()">提交订单</button>
            </div>
        </div>
        <!-- /col-md-12 -->
    </div>


    <!--向订单中添加商品-->
    <div  class="modal fade bs-example-modal-lg" id="phoneModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="phoneModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="phoneModalLabel">可销售商品列表</h4>
                        </div>
                        <div class="content-panel" >
                            <table class="table table-hover" id="products"
                                   data-click-to-select="true">
                            </table>
                        </div>

                        <div class="modal-footer">
                            <button type="button" id="btn1" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="getSelectedProduct()">确认</button>
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


<script>



    /**
     * 实现表格可编辑
     */
    $('#addSaleOrder').bootstrapTable({
        searchOnEnterKey: false,//回车搜索
        search: true, //开启刷选
        showColumns: true,//列选择按钮
        showRefresh: true,//刷新按钮
        buttonsAlign: "right",//按钮对齐方式
        /**
         * @param {点击列的 field 名称} field
         * @param {点击列的 value 值} value
         * @param {点击列的整行数据} row
         * @param {td 元素} $element
         */
        onClickCell: function(field, value, row, $element) {
            //var name = $(obj).attr('name');
            //alert();
            if(field=='unitPrice'){
                $element.attr('contenteditable', true);
                $element.blur(function() {
                    let index = $element.parent().data('index');
                    let tdValue = $element.html();

                    saveData(index, field, tdValue);
                })
            }
        },
        locale: "zh-CN", //中文支持
        detailView: false, //是否显示详情折叠
    });


    /**
     * 获取客户信息
     */
    $(document).ready(function(){
        $.ajax({
            url:'/customer/findCustomerInfo',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var customerList=data.customerList;
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

    /**
     * 获取仓库信息
     */
    $(document).ready(function() {
        $.ajax({
            url:'/business/warehouse/getTargetWarehouses',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var warehouseList=data.warehouseList;
                    $.each(warehouseList,function(i,item){
                        $("#warehouseId").append("<option value='"+item.warehouseId+"'>"+item.warehouseName+"</option>");
                        i++;
                    });
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });
    });

    /**
     * 进行表格高度调整
     */
    function tableHeight() {
        return $(window).height() - 170;
    }




    /**
     * 获取所有商品
     */
    function getAllProducts() {
        //根据窗口调整表格高度
        $(window).resize(function() {
            $('#products').bootstrapTable('resetView', {
                height: tableHeight()
            })
        })

        $('#products').bootstrapTable({
            url: "/business/serialNumber/getCanSalesPhoneInfo",//数据源
            dataField: "canSalesPhoneInfo",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
            contentType: "application/x-www-form-urlencoded",//请求数据内容格式 默认是 application/json 自己根据格式自行服务端处理
            dataType: "json",//期待返回数据类型
            method: "post",//请求方式

            pageNumber : 1, //初始化加载第一页
            pagination : true,//是否分页
            sidePagination : 'client',//server:服务器端分页|client：前端分页
            pageSize:10,//单页记录数
            pageList:[5,10,20,30],//分页步进值

            searchOnEnterKey: false,//回车搜索
            search: true, //开启刷选
            showColumns: true,//列选择按钮
            showRefresh: true,//刷新按钮
            buttonsAlign: "right",//按钮对齐方式
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
                    title: "手机编号",//标题
                    field: "phoneId",//键名
                    sortable: true,//是否可排序
                    order: "desc",//默认排序方式
                    visible:false,
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneId;
                    }
                },
                {
                    field: "phoneName",
                    title: "手机名称",
                    sortable: true,
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneName;
                    }
                },
                {
                    field: "phoneType",
                    title: "手机类别",
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneType;
                    }
                },
                {
                    field: "phoneColor",
                    title: "手机颜色",
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneColor;
                    }
                },
                {
                    field: "phoneRam",
                    title: "运行内存",
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneRam;
                    }
                },
                {
                    field: "phoneStorage",
                    title: "内存容量",
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneStorage;
                    }
                },
                {
                    field: "phoneNetwork",
                    title: "网络类型",
                    formatter:function(value, row, index){
                        return row.phoneInfo.phoneNetwork;
                    }
                },
                {
                    field: "id",
                    title: "序列号编号",
                    visible:false,
                },
                {
                    field: "sn",
                    title: "序列号",
                },
                {
                    field: "warehouseId",
                    title: "仓库号",
                    visible:false,
                    formatter:function(value, row, index){
                        return row.warehouse.warehouseId;
                    }
                },
                {
                    field: "warehouseName",
                    title: "仓库",
                    formatter:function(value, row, index){
                        return row.warehouse.warehouseName;
                    }
                },
                {
                    field: "unitPrice",
                    title: "进价",
                    formatter:function(value, row, index) {
                        return row.sorderDetail.unitPrice;
                    }
                }

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
        $("#phoneModal").modal('show');
    }



    /**
     * 保存表格编辑之后的数据，并进行注入
     */
    function saveData(index, field, value) {
        $("#addSaleOrder").bootstrapTable('updateCell', {
            index: index,       //行索引
            field: field,       //列名
            value: value        //cell值
        })
    }




    /**
     * 获取选中商品，并将相关信息传入订单详情表中
     */
    function getSelectedProduct(){
        //根据窗口调整表格高度
        var info=$('#products').bootstrapTable('getAllSelections');
        //var selectInfos=JSON.stringify(info);

        for (var i=0;i<info.length;i++){
            var phoneId=info[i].phoneInfo.phoneId;
            var phoneName = info[i].phoneInfo.phoneName;
            var phoneType = info[i].phoneInfo.phoneType;
            var phoneColor = info[i].phoneInfo.phoneColor;
            var phoneRam = info[i].phoneInfo.phoneRam;
            var phoneStorage = info[i].phoneInfo.phoneStorage;
            var phoneNetwork=info[i].phoneInfo.phoneNetwork;
            var id=info[i].id;
            var sn=info[i].sn;
            var warehouseId=info[i].warehouse.warehouseId;
            var warehouseName=info[i].warehouse.warehouseName;

            $('#addSaleOrder').bootstrapTable('insertRow', {
                index: $('#addSaleOrder').bootstrapTable('getOptions').totalRows,
                row: {
                    phoneId: phoneId,
                    phoneName: phoneName,
                    phoneType:phoneType,
                    phoneColor: phoneColor,
                    phoneRam: phoneRam,
                    phoneStorage: phoneStorage,
                    phoneNetwork:phoneNetwork,
                    phoneNumber: 1,
                    id:id,
                    sn:sn,
                    warehouseId:warehouseId,
                    warehouseName:warehouseName,
                    unitPrice: 0.00,
                }
            })
        }
        $('#addSaleOrder').bootstrapTable({height:$(window).height()-120});
        $("#phoneModal").modal('hide');
    }


    /**
     * 移除指定行
     */
    function removeTargetProduct() {
        var $table = $('#addSaleOrder');

        var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
            return row.phoneId;
        });

        $table.bootstrapTable('remove', {
            field: 'phoneId',
            values: ids
        });


    }


    /**
     * 提交添加好后的订单
     */
    function submitOrder() {
        var customerId=$('#customerId option:selected').val();
        var salesOrderDetails=JSON.stringify($('#addSaleOrder').bootstrapTable('getData'));

        var orderRemark=$("#orderRemark").val();
        if(customerId==-1){
            layer.alert("客户名称为必填项，请选择客户", {icon: 5});
            return;
        }
        if (salesOrderDetails=="[]"){
            layer.alert("请选择商品", {icon: 5});
            return;
        }
        $.ajax({
            url:'/business/salesOrder/addSalesOrder',
            data:{salesOrderDetails:salesOrderDetails,customerId:customerId,orderRemark:orderRemark},
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    layer.msg(data.msg, {icon: 1, time: 1000});
                    setTimeout(function () {
                        window.location.reload();
                    }, 800);
                }else{
                    layer.alert(data.msg, {icon: 5});
                }
            }
        });
    }


</script>
</body>
</html>

