<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-04
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>进货管理</title>
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
        td {
            text-align: center;
            vertical-align: middle;
        }

        th{
            text-align: center;
            vertical-align: middle;
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
            <h3><i class="fa fa-angle-right"></i></h3>
            <div class="row">
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <!-- 新增订单按钮 -->
                    <button style="width: 75px;" type="button" class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#orderStockOrderModal">新增订单</button>
                    <!-- 取消订单按钮 -->
                    <a href="javascript:void(0)" style="width: 75px;" class="btn btn-danger" onclick="cancelStockOrder()">取消订单</a>
                    <hr />
                    <div class="content-panel">
                        <table class="table table-hover" id="proTable">
                            <h4><i class="fa fa-angle-right"></i> 采购退货单信息</h4>
                            <hr>
                            <thead>
                            <tr>
                                <th></th>
                                <th>退货单号</th>
                                <th>原订货单号</th>
                                <th>商品总数量</th>
                                <th>订单时间</th>
                                <th>订单总金额</th>
                                <th>支付方式</th>
                                <th>经手人</th>
                                <th>订单状态</th>
                                <th>退货原因</th>
                                <th>操作</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:forEach items="${pageInfo.list}" var="pro">
                                <tr style="text-align: center;vertical-align: middle">
                                    <td style="text-align: center;vertical-align: middle">
                                        <div class="checkbox">
                                            <input type="checkbox" class="styled" name="checkBox1" id="singleCheckbox1" value="${amount=amount}" aria-label="Single checkbox One">
                                            <label></label>
                                        </div>
                                    </td>
                                    <td style="text-align: center;vertical-align: middle;">${pro.proId}</td>
                                    <td style="text-align: center;vertical-align: middle;">${pro.stoId}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.proNumber}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.orderTimeStr}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.totalMoney}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.payTypeStr}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.employeeId}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.proStatusStr}</td>
                                    <td style="text-align: center;vertical-align: middle">${pro.proReason}</td>
                                    <td style="text-align: center;vertical-align: middle">
                                        <button type="button" class="btn btn-info" onclick="getOrderDetail(this)">详情</button>
                                    </td>
                                </tr>
                            </c:forEach>

                            </tbody>
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
                                <a href="${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=1&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">首页</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页 <span class="sr-only"></span></a>
                            </li>
                            <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                                <li>
                                    <a href="${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=${pageNum}&size=${pageInfo.pageSize}">${pageNum} <span class="sr-only"></span></a>
                                </li>
                            </c:forEach>
                            <li >
                                <a href="${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">后一页 <span class="sr-only"></span></a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=${pageInfo.pages}&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">尾页</span>
                                </a>
                            </li>

                        </ul>
                    </nav>
                </div>
                <!-- /col-md-12 -->
            </div>


            <!-- 新增订单 -->
            <div  class="modal fade bs-example-modal-lg" id="orderStockOrderModal" style="overflow: auto " overflow="auto" tabindex="-1" role="dialog"  data-keyboard="false" aria-labelledby="stockOrderModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="stockOrderModalLabel">订单详情</h4>
                        </div>
                        <div class="content-panel" >
                            <!-- 新增订单按钮 -->
                            <button style="margin-left: 10px;" id="addProduct"  type="button" class="btn btn-success" data-toggle="modal" data-backdrop="false" onclick="getAllProducts()" >新增</button>
                            <!-- 修改按钮 -->
                            <button style="margin-left: 20px;" type="button" class="btn btn-danger" >删除</button>
                            <table id="phones"
                                   data-toggle="table"
                                   search="true"
                                   searchOnEnterKey="false"
                                   data-search="true"
                                   data-show-refresh="true"
                                   data-show-toggle="true"
                                   data-show-columns="true"
                                   toolbarAlign="right">
                                <thead>
                                <tr>
                                    <th data-field="phoneId" data-sortable="true" data-order="asc">手机编号</th>
                                    <th data-field="phoneName">手机名称</th>
                                    <th data-field="phoneType">手机类别</th>
                                    <th data-field="phoneColor">手机颜色</th>
                                    <th data-field="phoneRAM">运行内存</th>
                                    <th data-field="phoneStorage">储存容量</th>
                                    <th data-field="phoneNetwork" >网络类型</th>
                                    <th data-field="phoneNumber">进货数量</th>
                                    <th data-field="unitPrice">进货单价</th>
                                </tr>
                                </thead>
                            </table>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <!--支付方式的选择-->
                                <label for="payType" class="control-label">订单状态：</label>
                                <select class="form-control"  style="width: 100px;" id="payType">
                                    <option style='display: none'></option>
                                    <option value="0">现金</option>
                                    <option value="1">银行转账</option>
                                    <option value="2">支付宝</option>
                                    <option value="3">微信</option>
                                    <option value="4">支票</option>
                                    <option value="5">其它</option>
                                </select>
                                <!--订单状态的选择-->
                                <label for="stoStatus" class="control-label">订单状态：</label>
                                <select class="form-control"  style="width: 100px;" id="stoStatus">
                                    <option style='display: none'></option>
                                    <option value="0">未完成</option>
                                    <option value="1">已完成</option>
                                </select>

                                <hr>
                                <!--订单备注-->

                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                            <button type="button" class="btn btn-primary" onclick="submitOrder()">提交订单</button>
                        </div>
                    </div>
                </div>
            </div>

            <!--向订单中添加商品-->
            <div  class="modal fade bs-example-modal-lg" id="phoneModal" tabindex="-1" role="dialog" data-backdrop="static" data-keyboard="false" aria-labelledby="phoneModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="phoneModalLabel">订单详情</h4>
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

            <!--  打开订单详情窗口-->
            <div  class="modal fade bs-example-modal-lg" id="orderDetailModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="exampleModalLabel">订单详情</h4>
                        </div>
                        <div class="modal-body">
                            <div class="content-panel">
                                <table class="table table-hover" id="prdTable">
                                    <h4><i class="fa fa-angle-right"></i> 采购单信息</h4>
                                    <hr>
                                    <thead>
                                    <tr>
                                        <th>进货明细单号</th>
                                        <th>总订单号</th>
                                        <th>商品编号</th>
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
        </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer" >
        <div class="text-center">
            <p>
                &copy; Copyrights <strong>cx</strong>. All Rights Reserved
            </p>
            <a href="#" class="go-top">
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
<script>

    /**
     * 改变每页显示订单数目
     */
    function changePageSize() {
        //获取下拉框的值
        var pageSize = $("#changePageSize").val();
        //向服务器发送请求，改变没页显示条数
        location.href = "${pageContext.request.contextPath}/stockOrder/findAllStockOrder?page=1&size="
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
     * 获取选择订单的订单号
     */
    function getIndex(){
        var value ="";//定义一个数组
        var size=$("input:checkbox:checked").length;
        if (size<1){
            alert('请选中你要操作的记录');
            return false;
        }
        if (size>1){
            alert('请不要选择多条记录进行操作');
            return false;
        }
        $('input:checkbox:checked').each(function(){
            //遍历每一个名字为id的复选框，其中选中的执行函数
            value+=$(this).val();//将选中的值添加value中，以逗号分开
        });
        return  value;
    }



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

    /**
     * 获取订单详情
     * @param data1
     */
    function getOrderDetail(data1) {
        var value = $(data1).parent().parent().find("td");
        var proId=value.eq(1).text().toString().trim();
        //alert(stoId);
        $.ajax({
            url:'../pro/getPrdById',
            dataType:'json',
            type:'post',
            data:{proId:proId},
            success:function(data){
                //alert(11111);
                //alert(data.type);
                if(data.type == 'success'){
                    var list=data.prdList;
                    $("#prdTable tbody tr").eq(0).nextAll().remove();
                    $.each(list,function(i,item){
                        <!-- 向商品详情表中进行数据注入 -->
                        $("#prdTable tbody").append('<tr>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.prdId+'</td>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.proId+'</td>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneId+'</td>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.phoneNumber+'</td>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.unitPrice+'</td>');
                        $("#prdTable tbody").append('<td style="text-align: center;vertical-align: middle;">'+item.money+'</td>');
                        $("#prdTable tbody").append('</tr>')
                        i++;
                    });
                    $("#orderDetailModal").modal('show');
                }else{
                    parent.$.alert({
                        title: '错误',
                        content: '出现未知异常，请联系管理员'
                    });
                }

            }
        });



        //$("#orderDetailModal").modal('show');

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
        toolbarAlign: "right",//工具栏对齐方式
        /**
         * @param {点击列的 field 名称} field
         * @param {点击列的 value 值} value
         * @param {点击列的整行数据} row
         * @param {td 元素} $element
         */
        onClickCell: function(field, value, row, $element) {
            //var name = $(obj).attr('name');
            //alert();
            if(field=='phoneNumber'||field=='unitPrice'){
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
            url: "../product/findAllPhones",//数据源
            dataField: "phoneLists",//服务端返回数据键值 就是说记录放的键值是rows，分页时使用总记录数的键值为total
            height: tableHeight(),//高度调整
            contentType: "application/x-www-form-urlencoded",//请求数据内容格式 默认是 application/json 自己根据格式自行服务端处理
            dataType: "json",//期待返回数据类型
            method: "post",//请求方式
            searchOnEnterKey: false,//回车搜索
            search: true, //开启刷选
            showColumns: true,//列选择按钮
            showRefresh: true,//刷新按钮
            buttonsAlign: "right",//按钮对齐方式
            //toolbar: "#addProduct",//指定工具栏
            toolbarAlign: "right",//工具栏对齐方式
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
                    order: "desc"//默认排序方式
                },
                {
                    field: "phoneName",
                    title: "手机名称",
                    sortable: true,
                    titleTooltip: "this is name"
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
                    field: "phoneRAM",
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
        return $(window).height() - 50;
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
            var phoneRAM = info[i].phoneRAM;
            var phoneStorage = info[i].phoneStorage;
            var phoneNetwork = info[i].phoneNetwork;

            $('#phones').bootstrapTable('insertRow', {
                index: 1,
                row: {
                    phoneId: phoneId,
                    phoneName: phoneName,
                    phoneType: phoneType,
                    phoneColor: phoneColor,
                    phoneRAM: phoneRAM,
                    phoneStorage: phoneStorage,
                    phoneNetwork: phoneNetwork,
                    phoneNumber: 1,
                    unitPrice: 1
                }
            })
        }
        $('#phones').bootstrapTable({height:$(window).height()-120});
        $("#phoneModal").modal('hide');
    }

    /**
     * 提交添加好后的订单
     */
    function submitOrder() {
        var stockOrderDetails=JSON.stringify($('#phones').bootstrapTable('getData'));
        var payType=$('#payType option:selected').val();
        var stoStatus=$('#stoStatus option:selected').val();
        $.ajax({
            url:'../stockOrder/addStockOrder',
            data:{stockOrderDetails:stockOrderDetails,payType:payType,stoStatus:stoStatus},
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.type == 'success'){
                    $("#orderStockOrderModal").modal('hide');
                    alert("添加订单成功");
                    window.location.reload();
                }else{
                    parent.$.alert({
                        title: '错误',
                        content: data.msg
                    });
                }
            }
        });
    }

</script>
</body>
</html>

