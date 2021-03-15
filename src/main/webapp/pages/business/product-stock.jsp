<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-19
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>采购商品</title>
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
        <div class="btn-group-sm" id="toolbar1" role="group">
            <a class="btn btn-success" id="addProducts" data-toggle="modal" data-backdrop="false" onclick="getAllProducts()"><i class="fa fa-plus"></i> 新增</a>

            <button class="btn btn-danger" onclick="removeTargetProduct()"><i class="fa fa-remove"></i> 删除</button>
        </div>

                <!-- /col-md-12 -->
        <div class="col-md-12 mt" style="height: 570px;overflow: auto;">
            <div class="col-sm-12 search-collapse">
                <p class="select-title"></p>
                    <div class="select-list">
                        <ul>
                            <li id="selectSupplier">
                                    供应商：<select id="supplierId" name="supplierId">
                                    <option value=""></option>
                                </select>
                            </li>
                            <li id="selectWarehouse">
                                    仓库名称：<select id="warehouseId" name="warehouseId">
<%--                                    <option value=""></option>--%>
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
                                <option value="1">完成</option>
                                <option value="0">未完成</option>
                                <option value="2">取消</option>
                            </select>
                            </li>
                        </ul>
                    </div>
            </div>


            <div class="content-panel rowSameHeight" style="height: 420px;overflow: auto;" >
                    <table id="phones"
                           data-toggle="table"
                           data-toolbar="#toolbar1"
                           data-search="true"
                           data-show-refresh="true"
                           data-show-toggle="true"
                           data-show-fullscreen="true"
                           data-show-columns="true"
                           data-show-columns-toggle-all="true"
                           data-click-to-select="true"
                           data-single-select="true"
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
                            <th data-field="phoneRAM">运行内存</th>
                            <th data-field="phoneStorage">储存容量</th>
                            <th data-field="phoneNetwork" >网络类型</th>
                            <th data-field="phoneNumber">进货数量</th>
                            <th data-field="SN">序列号</th>
                            <th data-field="unitPrice">进货单价</th>
                        </tr>
                        </thead>
                    </table>
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
                            <h4 class="modal-title" id="phoneModalLabel">商品列表</h4>
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



    <!-- 录入商品SN -->
    <div class="modal inmodal" id="testModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content animated bounceInRight">
                <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px  ">
                    <div class="panel-heading" style="text-align: center;">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal style-form" id="addSNForm" onsubmit="return false" action="" method="post">
                            <div id="toolbar">
                                <button id="add" class="btn btn-secondary">添加行</button>

                                <button id="remove" class="btn btn-secondary">删除</button>

                            </div>
                            <div class="form-group" >
                                <div class="col-sm-10" >

                                    <table class="table table-hover rowSameHeight"
                                           id="SNS"
                                           data-toggle="table"
                                           data-search="true"
                                           data-show-refresh="true"
                                           data-show-toggle="true"
                                           data-show-fullscreen="true"
                                           data-show-columns="true"
                                           data-show-columns-toggle-all="true"
                                           data-show-export="true"
                                           data-click-to-select="false"
                                           data-single-select="true">

                                        <h4 style="text-align: center">手机序列号表</h4>
                                        <hr>
                                        <thead>
                                        <tr>
                                            <th data-field="state" data-checkbox="true"></th>
                                            <th data-field="SN">手机序列号</th>
                                            <th data-field="remark">备注</th>
                                        </tr>
                                        </thead>
                                        <tbody></tbody>
                                    </table>
                                </div>
                            </div>
                            <button type="submit" id="btn-getSNs" class="btn btn-primary">提交</button>
                            <button type="reset" id="" class="btn btn-warning">重置</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        </form>
                    </div>
                </div>
            </div>
            <small class="font-bold"></small>
        </div>
        <small class="font-bold"></small>
    </div>




    <!-- 取消还未完成的订单-->
    <div class="modal fade" id="cancelStockOrderModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                取消订单（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否取消选定订单？</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="cancel()">确定</button>
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
<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>




<script>

    var SnsListArr;



    /**
     * 打开取消订单窗口
     */
    function cancelStockOrder() {
        var size=$("input[name='checkBox1']:checkbox:checked").length;
        if (size<1){
            alert('请选中你要操作的记录');
            return false;
        }
        if (size>1){
            alert('请不要选择多条记录进行操作');
            return false;
        }
        if (size==1){
            $("#cancelStockOrderModal").modal('show');
            return;
        }
    }

    /**
     * 取消订单
     */
    function cancel(){
        var stoId;
        var tbodyObj = document.getElementById('stockOrders');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                stoId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'../stockOrder/cancelOrder',
                    dataType:'json',
                    type:'post',
                    data:{stoId:stoId},
                    success:function(data){
                        if(data.type == 'success'){
                            $("#cancelStockOrderModal").modal('hide');
                            alert("取消订单成功");
                            window.location.reload();
                        }else{
                            alert(data.msg);
                            $("#cancelStockOrderModal").modal('hide');
                        }

                    }
                });
            }
        });
    }



    $(function(){
        $("#btn1").click(function(){
            $("#orderStockOrderModal").modal("hide");
            $("body").addClass("modal-open");
        });

    });


    /**
     * 实现表格可编辑
     */
    $('#phones').bootstrapTable({
        //height: tableHeight(),//高度调整
        searchOnEnterKey: false,//回车搜索
        search: true, //开启刷选
        showColumns: true,//列选择按钮
        showRefresh: true,//刷新按钮
        buttonsAlign: "right",//按钮对齐方式
        toolbarAlign: "left",//工具栏对齐方式
        /**
         * @param {点击列的 field 名称} field
         * @param {点击列的 value 值} value
         * @param {点击列的整行数据} row
         * @param {td 元素} $element
         */
        onClickCell: function(field, value, row, $element) {
            if (field=='SN'||field=='unitPrice'){
                $element.attr('contenteditable', true);
                $element.blur(function() {
                    let index = $element.parent().data('index');
                    let tdValue = $element.html();
                    saveData(index, field, tdValue);

                });
            }

        },
        locale: "zh-CN", //中文支持
        detailView: false, //是否显示详情折叠
    });



    $('#SNS').bootstrapTable({
        /**
         * @param {点击列的 field 名称} field
         * @param {点击列的 value 值} value
         * @param {点击列的整行数据} row
         * @param {td 元素} $element
         */
        onClickCell: function(field, value, row, $element) {
            if(field=='SN'||field=='remark'){
                $element.attr('contenteditable', true);
                $element.blur(function() {
                    let index = $element.parent().data('index');
                    let tdValue = $element.html();

                    $("#SNS").bootstrapTable('updateCell', {
                        index: index,       //行索引
                        field: field,       //列名
                        value: tdValue        //cell值
                    })
                });

            }
        },
        locale: "zh-CN", //中文支持
        detailView: false, //是否显示详情折叠
    });



    /**
     * 获取供应商信息
     */
    $(document).ready(function() {
        $.ajax({
            url:'/supplier/getTargetSuppliers',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var supplierList=data.supplierList;
                    $.each(supplierList,function(i,item){
                        $("#supplierId").append("<option value='"+item.supplierId+"'>"+item.supplierName+"</option>");
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
     * 获取对应供应商的商品
     */
    function getAllProducts() {
        var supplierId=$('#supplierId').val();
        if (supplierId==null||supplierId==""){
            layer.alert("请先指定供应商", {icon: 5});
            return;
        }
        //根据窗口调整表格高度
        $(window).resize(function() {
            $('#products').bootstrapTable('resetView', {
                height: tableHeight()
            })
        })

        $('#products').bootstrapTable({
            url: "/business/phoneInfo/findTargetPhones",//数据源
            dataField: "phoneLists",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
            height: 0. ,//高度调整
            contentType: "application/x-www-form-urlencoded",//请求数据内容格式 默认是 application/json 自己根据格式自行服务端处理
            dataType: "json",//期待返回数据类型
            method: "post",//请求方式
            pageNumber : 1, //初始化加载第一页
            pagination : true,//是否分页
            sidePagination : 'client',//server:服务器端分页|client：前端分页
            pageSize:10,//单页记录数
            pageList:[5,10,20,30,50],//分页步进值

            searchOnEnterKey: false,//回车搜索
            search: true, //开启刷选
            showColumns: true,//列选择按钮
            showRefresh: true,//刷新按钮
            buttonsAlign: "right",//按钮对齐方式
            toolbarAlign: "right",//工具栏对齐方式
            queryParamsType: '',
            queryParams: function (param) {
                return {
                    supplierId:$("#supplierId").val(),
                }
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
                    title: "手机编号",//标题
                    field: "phoneId",//键名
                    sortable: true,//是否可排序
                    order: "asc"//默认排序方式
                },
                {
                    field: "phoneName",
                    title: "手机名称",
                    sortable: true,
                },
                {
                    field: "phoneType",
                    title: "手机类别",
                },
                {
                    field: "phoneColor",
                    title: "手机颜色",
                },
                {
                    field: "phoneRam",
                    title: "运行内存",
                },
                {
                    field: "phoneStorage",
                    title: "内存容量",
                },
                {
                    field: "phoneNetwork",
                    title: "网络类型",
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
        $("#phoneModal").modal('show');
    }


    // 查询
    $("#selectSupplier").click(function(){
        refreshTable();
    });

    // 刷新表格
    function refreshTable() {
        $('#products').bootstrapTable('refresh', {
            url: "/business/phoneInfo/findTargetPhones",
            pageSize: 10,
            pageNumber: 1
        });

    }

    $(function() {
        $('#addProducts').click(function () {
            $('#products').bootstrapTable('refresh')
        })
    });


    /**
     * 保存表格编辑之后的数据，并进行注入
     */
    function saveData(index, field, value) {
        $("#phones").bootstrapTable('updateCell', {
            index: index,       //行索引
            field: field,       //列名
            value: value        //cell值
        })
    }


    /**
     * 进行表格高度调整
     */
    function tableHeight() {
        return $(window).height() - 170;
    }


    /**
     * 获取选中商品，并将相关信息传入订单详情表中
     */
    function getSelectedProduct(){
        //根据窗口调整表格高度
        var info=$('#products').bootstrapTable('getAllSelections');
        //var selectInfos=JSON.stringify(info);
        for (var i=0;i<info.length;i++){
            var phoneId=info[i].phoneId;
            var phoneName = info[i].phoneName;
            var phoneType = info[i].phoneType;
            var phoneColor = info[i].phoneColor;
            var phoneRAM = info[i].phoneRam;
            var phoneStorage = info[i].phoneStorage;
            var phoneNetwork = info[i].phoneNetwork;

            $('#phones').bootstrapTable('insertRow', {
                index: $('#phones').bootstrapTable('getOptions').totalRows,
                row: {
                    phoneId: phoneId,
                    phoneName: phoneName,
                    phoneType: phoneType,
                    phoneColor: phoneColor,
                    phoneRAM: phoneRAM,
                    phoneStorage: phoneStorage,
                    phoneNetwork: phoneNetwork,
                    phoneNumber: 1,
                    SN:'',
                    unitPrice: 0.00
                }
            })
        }
        $('#phones').bootstrapTable({height:$(window).height()-120});
        $("#phoneModal").modal('hide');
    }


    /**
     * 移除指定行
     */
    function removeTargetProduct() {
        var $table = $('#phones');

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
        var stockOrderDetails=JSON.stringify($('#phones').bootstrapTable('getData'));
        var warehouseId=$('#warehouseId option:selected').val();
        var payType=$('#payType option:selected').val();
        var stoStatus=$('#stoStatus option:selected').val();

        if (stockOrderDetails==="[]"){
            layer.alert("还未选择商品，请先选择商品后再提交订单", {icon: 5});
            return;
        }
        if (payType===""){
            layer.alert("还未选择支付方式", {icon: 5});
            return;
        }
        if (stoStatus==="[]"){
            layer.alert("还未指定订单状态", {icon: 5});
            return;
        }


        var orders= $('#phones').bootstrapTable('getData');
        //alert(orders);
        var SNs = new Array();
        for (var i = 0; i <orders.length ; i++) {
            if (JSON.stringify(orders[i].SN).length<=2){
                layer.alert("第"+(i+1)+"条订单的手机序列号还未填写，请填写完整", {icon: 5});
                return;
            }
            if (JSON.stringify(orders[i].unitPrice)<=0){
                layer.alert("第"+(i+1)+"条订单的进货单价还未填写，请填写完整", {icon: 5});
                return;
            }
        }

        $.ajax({
            url:'/business/stockOrder/addStockOrder',
            data:{stockOrderDetails:stockOrderDetails,warehouseId:warehouseId,payType:payType,stoStatus:stoStatus},
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                    window.location.reload();
                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }





</script>
    <script>
        var $table = $('#SNS')
        $(function() {
            $('#add').click(function () {
                $table.bootstrapTable('insertRow', {
                    index: 1,
                    row: {
                        SN:'',
                        remark:''
                    }
                })
            })
        })


        $(function() {
            $('#remove').click(function () {
                var ids = $.map($table.bootstrapTable('getSelections'), function (row) {
                    return row.SN
                })
                $table.bootstrapTable('remove', {
                    field: 'SN',
                    values: ids
                })
            })
        });


        var SNList;
        $(function() {
            $('#btn-getSNs').click(function () {
                SNList=$table.bootstrapTable('getData');
                $("#testModal").modal('hide');

            })
        });



    </script>
</body>
</html>

