<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-03
  Time: 18:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>库存查询</title>
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
         <h4 style="padding-left: 30px;"><i class="fa fa-angle-right">手机库存信息</i></h4>
                <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <div class="content-panel" style="height: 650px;overflow: auto;">

                        <div class="col-sm-12 search-collapse">
                            <form id="complex-form" >
                                <div class="select-list">
                                    <ul>
                                        <li>
                                            <label style="width: 60px">编号：</label>
                                            <input type="text" style="width: 140px;" id="phoneId" name="phoneId"/>
                                        </li>
                                        <li>
                                            <label style="width: 60px">名称：</label>
                                            <input type="text" style="width: 120px;" id="phoneName" name="phoneName"/>
                                        </li>

                                        <li>
                                            <label style="width: 60px">颜色：</label>
                                            <input type="text"  style="width: 100px;"  id="phoneColor" name="phoneColor"/>
                                        </li>
                                        <li>
                                            <label style="width: 60px">运存：</label>
                                            <select id="phoneRam" style="width: 80px;" name="phoneRam">
                                                <option value="">所有</option>
                                                <option value="4GB">4GB</option>
                                                <option value="6GB">6GB</option>
                                                <option value="8GB">8GB</option>
                                                <option value="10GB">10GB</option>
                                                <option value="12GB">12GB</option>
                                            </select>
                                        </li>
                                        <li>
                                            <label style="width: 60px">内存：</label>
                                            <select id="phoneStorage" style="width: 80px;" name="phoneStorage">
                                                <option value="">所有</option>
                                                <option value="16GB">16GB</option>
                                                <option value="32GB">32GB</option>
                                                <option value="64GB">64GB</option>
                                                <option value="128GB">128GB</option>
                                                <option value="256GB">256GB</option>
                                                <option value="512GB">512GB</option>
                                            </select>
                                        </li>

                                        <li>
                                            <label style="width: 80px">网络类型：</label>
                                            <select id="phoneNetwork"  style="width: 80px;" name="phoneNetwork">
                                                <option value="">所有</option>
                                                <option value="2G">2G</option>
                                                <option value="3G">3G</option>
                                                <option value="全网通4G">全网通4G</option>
                                                <option value="5G">5G</option>
                                            </select>
                                        </li>

                                        <li>
                                            <label style="width: 80px">仓库名称：</label>
                                            <select id="warehouseId"  style="width: 80px;" name="warehouseId">
                                                <option value=""></option>
                                            </select>
                                        </li>

                                        <li>
                                            <label style="width: 80px">库存数量：</label>
                                            <input type="number" style="width: 80px;"  id="minNumber" placeholder="最小数量" name="params[minNumber]"/>
                                            <span>-</span>
                                            <input type="number" style="width: 80px;" id="maxNumber" placeholder="最大数量" name="params[maxNumber]"/>
                                        </li>

                                        <li class="select-time">
                                            <label style="width: 100px">首次入库时间： </label>
                                            <input type="text" class="time-input" id="firstStartTime" placeholder="开始时间" name="params[firstStartTime]"/>
                                            <span>-</span>
                                            <input type="text" class="time-input" id="firstEndTime" placeholder="结束时间" name="params[firstEndTime]"/>
                                        </li>

                                        <li class="select-time">
                                            <label style="width: 100px">最近变更时间： </label>
                                            <input type="text" class="time-input" id="startTime" placeholder="开始时间" name="params[beginTime]"/>
                                            <span>-</span>
                                            <input type="text" class="time-input" id="endTime" placeholder="结束时间" name="params[endTime]"/>
                                        </li>




                                        <li>
                                            <a class="btn btn-primary btn-rounded btn-sm" id="btn-search" ><i class="fa fa-search"></i>&nbsp;搜索</a>
                                            <a class="btn btn-warning btn-rounded btn-sm" onclick="resetForm('#complex-form')"><i class="fa fa-refresh"></i>&nbsp;重置</a>
                                        </li>
                                    </ul>
                                </div>
                            </form>
                        </div>


                        <table class="table table-hover rowSameHeight"
                               data-toggle="table"
                               id="inventoryShow"
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
                            <hr>
                        </table>
                    </div>

                </div>
                <!-- /col-md-12 -->
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

<%--日期选择--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/lib/laydate/laydate.js"></script>
<script type="text/javascript">


 function resetForm(data) {
     $(data)[0].reset();
     refreshTable();
 }

 // 初始化表格数据
 var dataTable = $('#inventoryShow').bootstrapTable({
     url: "/business/inventory/findAllInventory",                      //  请求后台的URL
     method: "post",                      //  请求方式
     contentType:'application/x-www-form-urlencoded; charset=UTF-8',
     uniqueId: "orderId",                 //  每一行的唯一标识，一般为主键列
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
             // phoneId:$("#phoneId2").val(),
             // phoneName:$("#phoneName2").val(),
             // supplierId:$("#supplierId2").val(),
             // phoneType:$("#phoneType2").val(),
             // phoneColor:$("#phoneColor2").val(),
             // phoneRam:$("#phoneRam2").val(),
             // phoneStorage:$("#phoneStorage2").val(),
             // phoneNetwork:$("#phoneNetwork2").val(),
             // phoneState:$("#phoneState2").val()
         }
     },
     columns: [
         {
             checkbox: true
         },{
             field: 'phoneId',
             title: '商品编号',
             formatter: function(value, item, index) {
                 return item.phoneInfo.phoneId;
             }
         }, {
             field: 'phoneName',
             title: '商品名称',
             formatter: function(value, item, index) {
                 return item.phoneInfo.phoneName;
             }
         }, {
             field: 'warehouseId',
             title: '仓库编号',
             visible:false,
             formatter: function(value, item, index) {
                 return item.warehouse.warehouseId;
             }
         }, {
             field: 'warehouseName',
             title: '仓库名称',
             formatter: function(value, item, index) {
                 return item.warehouse.warehouseName;
             }
         }, {
             field: 'productNumber',
             title: '库存数量'
         }, {
             field: 'phoneColor',
             title: '颜色',
             formatter: function(value, item, index) {
                 return item.phoneInfo.phoneColor;
             }
         }, {
             field: 'phoneRam',
             title: '运行内存',
             formatter: function(value, item, index) {
                 return item.phoneInfo.phoneRam;
             }
         }, {
             field: 'phoneStorage',
             title: '网络类型',
             formatter: function(value, item, index) {
                 return item.phoneInfo.phoneStorage;
             }
         }, {
             field: 'firstStockTime',
             title: '第一次入库时间'
         }, {
             field: 'lastStockTime',
             title: '最近一次库存变更时间'
         }, {
             field: 'remark',
             title: '备注'
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


 var startDate1 = laydate.render({
     elem: '#firstStartTime',
     max: $('#firstStartTime').val(),
     theme: 'molv',
     trigger: 'click',
     done: function(value, date) {
         // 结束时间大于开始时间
         if (value !== '') {
             endDate2.config.min.year = date.year;
             endDate2.config.min.month = date.month - 1;
             endDate2.config.min.date = date.date;
         } else {
             endDate2.config.min.year = '';
             endDate2.config.min.month = '';
             endDate2.config.min.date = '';
         }
     }
 });

 var endDate2 = laydate.render({
     elem: '#firstEndTime',
     min: $('#firstEndTime').val(),
     theme: 'molv',
     trigger: 'click',
     done: function(value, date) {
         // 开始时间小于结束时间
         if (value !== '') {
             startDate1.config.max.year = date.year;
             startDate1.config.max.month = date.month - 1;
             startDate1.config.max.date = date.date;
         } else {
             startDate1.config.max.year = '';
             startDate1.config.max.month = '';
             startDate1.config.max.date = '';
         }
     }
 });
</script>




</body>
</html>
