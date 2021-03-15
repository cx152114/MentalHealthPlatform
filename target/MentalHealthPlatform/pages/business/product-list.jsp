<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-22
  Time: 20:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
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

    <%--引入bootstrap用于表单验证的插件--%>
    <link href="${pageContext.request.contextPath}/lib/bootstrapValidator/css/bootstrapValidator.css" rel="stylesheet">

    <link  href="${pageContext.request.contextPath}/lib/ruoyi/css/ry-ui.css" rel="stylesheet" />


    <%--    文件上传--%>
    <link href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/css/fileinput.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" crossorigin="anonymous">
    <link href="${pageContext.request.contextPath}/lib/bootstrap-fileinput/explorer-fas/theme.css" rel="stylesheet">




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
             <shiro:hasPermission name="business:product:add">
                <a class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addProductModal" ><i class="fa fa-plus"></i> 新增</a>
             </shiro:hasPermission>
             <shiro:hasPermission name="business:product:edit">
                <a href="javascript:void(0)" class="btn btn-primary" onclick="alterProduct()"><i class="fa fa-edit"></i> 修改</a>
             </shiro:hasPermission>
             <shiro:hasPermission name="business:product:remove">
                <a href="javascript:void(0)" class="btn btn-danger" onclick="removeProduct()"><i class="fa fa-remove"></i> 删除</a>
             </shiro:hasPermission>
         </div>
         <div class="col-md-12 mt">
             <shiro:hasPermission name="business:product:search">
             <div class="col-sm-12 search-collapse">
                 <form id="complex-form" >
                     <div class="select-list">
                         <ul>
                             <li>
                                 <label style="width: 60px">编号：</label>
                                 <input type="text" id="phoneId2" name="phoneId"/>
                             </li>
                             <li>
                                 <label style="width: 60px">名称：</label>
                                 <input type="text" id="phoneName2" name="phoneName"/>
                             </li>
                             <li>
                                 <label style="width: 60px">类别：</label>
                                 <select id="phoneType2"  name="phoneType">
                                     <option value="">所有</option>
                                     <option value="智能机">智能机</option>
                                     <option value="功能机">功能机</option>
                                 </select>
                             </li>
                             <li>
                                 <label style="width: 60px">颜色：</label>
                                 <input type="text" id="phoneColor2" name="phoneColor"/>
                             </li>
                             <li>
                                 <label style="width: 60px">运存：</label>
                                 <select id="phoneRam2" name="phoneRam">
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
                                 <select id="phoneStorage2" name="phoneStorage">
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
                                 <label style="width: 60px">供货商：</label>
                                 <select id="supplierId2" name="supplierId">
                                     <option value="">所有</option>
                                 </select>
                             </li>
                             <li>
                                 <label style="width: 80px">网络类型：</label>
                                 <select id="phoneNetwork2" name="phoneNetwork">
                                     <option value="">所有</option>
                                     <option value="2G">2G</option>
                                     <option value="3G">3G</option>
                                     <option value="全网通4G">全网通4G</option>
                                     <option value="5G">5G</option>
                                 </select>
                             </li>
                             <li>
                                 <label style="width: 60px">状态：</label>
                                 <select id="phoneState2" name="phoneState">
                                     <option value="">所有</option>
                                     <option value="0">在售</option>
                                     <option value="1">下架</option>
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

             <div class="content-panel" style="height: 460px;overflow: auto;">
                    <table class="table table-hover rowSameHeight"
                           id="phones"
                           data-toggle="table"
                           data-toolbar="#toolbar"
                           data-show-refresh="true"
                           data-show-toggle="true"
                           data-show-fullscreen="true"
                           data-show-columns="true"
                           data-show-columns-toggle-all="true"
                           data-click-to-select="true"
                           data-single-select="true"
                            <shiro:hasPermission name="business:product:export">
                               data-show-export="true"
                               data-exportDataType ="basic"
                            </shiro:hasPermission>
                           data-show-pagination-switch="true"style="overflow: auto;">
                    </table>
                    <div style="height: 20px"></div>
                </div>
         </div>

     </div>

     <!-- 新增商品 -->
     <div class="modal inmodal" id="addProductModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog modal-lg">
             <div class="modal-content animated bounceInRight">
                 <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                     <div class="panel-heading" style="text-align: center;">
                         <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                         <h3 class="mb" style="margin: 0px"> 新增手机信息</h3>
                     </div>
                     <div class="panel-body">
                         <form class="form-horizontal style-form" id="addProductForm" action="/business/phoneInfo/addProduct" method="post">
                             <div>
                                 <div class="form-group" style="float:left;width: 40%;">
                                     <label class="col-sm-5 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">手机名称：</label>
                                     <div class="col-sm-6">
                                         <input type="text" class="form-control" name="phoneName" placeholder="手机名称"  required>
                                     </div>
                                 </div>
                                 <div class="form-group" style="float:left;width: 30%;">
                                     <label class="col-sm-5 control-label" style="font-size:16px;">供应商：</label>
                                     <div class="col-sm-6">
                                         <select class="form-control" id="supplierId1" name="supplierId" required>
                                             <option value=""></option>
                                         </select>
                                     </div>
                                 </div>
                                 <div class="form-group" style="float:left;width: 40%;">
                                     <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">类型：</label>
                                     <div class="col-sm-6">
                                         <select class="form-control" name="phoneType">
                                             <option value=""></option>
                                             <option value="智能机">智能机</option>
                                             <option value="功能机">功能机</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>

                             <div>
                                 <div class="form-group" style="float:left;width: 40%;">
                                     <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">颜色：</label>
                                     <div class="col-sm-6">
                                         <input type="text" class="form-control" name="phoneColor" placeholder="手机颜色" required>
                                     </div>
                                 </div>

                                 <div class="form-group" style="float:left;width: 30%;">
                                     <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">运存：</label>
                                     <div class="col-sm-7">
                                         <select class="form-control" name="phoneRam">
                                             <option value="">所有</option>
                                             <option value="4GB">4GB</option>
                                             <option value="6GB">6GB</option>
                                             <option value="8GB">8GB</option>
                                             <option value="10GB">10GB</option>
                                             <option value="12GB">12GB</option>
                                         </select>
                                     </div>
                                 </div>
                                 <div class="form-group" style="float:left;width: 40%;">
                                     <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">储存容量：</label>
                                     <div class="col-sm-4">
                                         <select class="form-control" name="phoneStorage" required>
                                             <option value="">所有</option>
                                             <option value="16GB">16GB</option>
                                             <option value="32GB">32GB</option>
                                             <option value="64GB">64GB</option>
                                             <option value="128GB">128GB</option>
                                             <option value="256GB">256GB</option>
                                             <option value="512GB">512GB</option>
                                         </select>
                                     </div>
                                 </div>
                             </div>
                             <div>
                                 <div class="form-group" style="float:left;width: 50%;">
                                     <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">网络类型：</label>
                                     <div class="col-sm-4">
                                         <select class="form-control" name="phoneNetwork">
                                             <option value="">所有</option>
                                             <option value="2G">2G</option>
                                             <option value="3G">3G</option>
                                             <option value="全网通4G">全网通4G</option>
                                             <option value="5G">5G</option>
                                         </select>
                                     </div>
                                 </div>

                                 <div class="form-group" style="float:left;width: 50%;">
                                     <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">售卖状态：</label>
                                     <div class="col-sm-4">
                                         <select class="form-control" name="phoneState" required>
                                             <option value="0">在售</option>
                                             <option value="1">下架</option>
                                         </select>
                                     </div>
                                 </div>

                             </div>

                             <div class="form-group" >
                                     <div class="col-sm-7">
                                         <label>
                                             <textarea class="form-control" name="phoneRemark"  placeholder="手机描述" rows="4" data-rule="required" data-msg="手机描述"></textarea>
                                         </label>
                                     </div>
                             </div>

                             <div class="form-group">
                                 <div class="file-loading">
                                     <input id="file" name="file"  type="file" multiple data-preview-file-type="any" data-upload-url="/common/file/uploadFile" data-theme="fas">
                                 </div>
                                 <input type="text" class="form-control"  id="phoneImage" name="phoneImage" placeholder="上传图片" style="width: 60%;display: none" >

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

     <!-- 修改商品 -->
     <div class="modal inmodal" id="alterProductModal" tabindex="-1" role="dialog" aria-hidden="true" data-backdrop="static" data-keyboard="false" style="display: none;">
            <div class="modal-dialog modal-lg">
                <div class="modal-content animated bounceInRight">
                    <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                        <div class="panel-heading" style="text-align: center;">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h3 class="mb" style="margin: 0px"> 修改手机信息</h3>
                        </div>
                        <div class="panel-body">
                            <form class="form-horizontal style-form" id="editSupplierForm" action="/business/phoneInfo/editProduct" method="post">
                                <input type="text" class="form-control" id="phoneId" name="phoneId"  style="display: none">
                                <div>
                                    <div class="form-group" style="float:left;width: 40%;">
                                        <label class="col-sm-5 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">手机名称：</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" id="phoneName" name="phoneName" placeholder="手机名称"  required>
                                        </div>
                                    </div>
                                    <div class="form-group" style="float:left;width: 30%;">
                                        <label class="col-sm-5 control-label" style="font-size:16px;">供应商：</label>
                                        <div class="col-sm-6">
                                            <select class="form-control" id="supplierId" name="supplierId" required>
                                                <option value=""></option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group" style="float:left;width: 40%;">
                                        <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">类型：</label>
                                        <div class="col-sm-6">
                                            <select class="form-control" id="phoneType" name="phoneType">
                                                <option value=""></option>
                                                <option value="智能机">智能机</option>
                                                <option value="功能机">功能机</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div>
                                    <div class="form-group" style="float:left;width: 40%;">
                                        <label class="col-sm-3 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">颜色：</label>
                                        <div class="col-sm-6">
                                            <input type="text" class="form-control" id="phoneColor" name="phoneColor" placeholder="手机颜色" required>
                                        </div>
                                    </div>

                                    <div class="form-group" style="float:left;width: 30%;">
                                        <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">运存：</label>
                                        <div class="col-sm-7">
                                            <select class="form-control" id="phoneRam" name="phoneRam">
                                                <option value=""></option>
                                                <option value="4GB">4GB</option>
                                                <option value="6GB">6GB</option>
                                                <option value="8GB">8GB</option>
                                                <option value="10GB">10GB</option>
                                                <option value="12GB">12GB</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group" style="float:left;width: 40%;">
                                        <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">储存容量：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" id="phoneStorage" name="phoneStorage" required>
                                                <option value=""></option>
                                                <option value="16GB">16GB</option>
                                                <option value="32GB">32GB</option>
                                                <option value="64GB">64GB</option>
                                                <option value="128GB">128GB</option>
                                                <option value="256GB">256GB</option>
                                                <option value="512GB">512GB</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>


                                <div>
                                    <div class="form-group" style="float:left;width: 50%;">
                                        <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">网络类型：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" id="phoneNetwork" name="phoneNetwork">
                                                <option value=""></option>
                                                <option value="2G">2G</option>
                                                <option value="3G">3G</option>
                                                <option value="全网通4G">全网通4G</option>
                                                <option value="5G">5G</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="form-group" style="float:left;width: 50%;">
                                        <label class="col-sm-4 control-label" style="font-size:16px;margin-bottom: 3px;margin-left: 5px;">售卖状态：</label>
                                        <div class="col-sm-4">
                                            <select class="form-control" id="phoneState" name="phoneState" required>
                                                <option value="0">在售</option>
                                                <option value="1">下架</option>
                                            </select>
                                        </div>
                                    </div>

                                </div>

                                <div class="form-group" >
                                    <div class="col-sm-7">
                                        <textarea class="form-control" id="phoneRemark" name="phoneRemark"  placeholder="手机描述" rows="4" data-rule="required" data-msg="手机描述"></textarea>
                                    </div>
                                    <div class="col-sm-2">
                                        <img style="width: 140px;height: 100px;" id="test01" src="" />
                                    </div>

                                </div>

                                <div class="form-group">
                                    <div class="file-loading">
                                        <input id="file-6" name="file"   type="file" multiple data-preview-file-type="any" data-upload-url="/common/file/uploadFile" data-theme="fas">
                                    </div>

                                    <input type="text" class="form-control"  id="phoneImage1" name="phoneImage" placeholder="上传图片" style="width: 60%;display: none" >
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
            <small class="font-bold"></small>
        </div>

     <!-- 移除商品-->
     <div class="modal fade" id="removeProductModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                    &times;
                                </button>
                                <h4 class="modal-title" id="myModalLabel" >
                                    移除商品（此过程不可逆，谨慎操作）
                                </h4>
                            </div>
                            <div class="modal-body">
                                <h4 style="color: red;">是否移除选定商品？</h4>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-primary" onclick="remove()">提交</button>
                                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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


     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/piexif.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/plugins/sortable.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/fileinput.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/locales/zh.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/theme.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/lib/bootstrap-fileinput/js/explorer-fas/theme.js"></script>

     <script>
         function resetForm(data) {
             $(data)[0].reset();
             refreshTable();
         }

         // 初始化表格数据
         var dataTable = $('#phones').bootstrapTable({
             url: "/business/phoneInfo/findAllPhoneInfo",                      //  请求后台的URL
             method: "post",                      //  请求方式
             contentType:'application/x-www-form-urlencoded; charset=UTF-8',
             uniqueId: "phoneId",                 //  每一行的唯一标识，一般为主键列
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
                     phoneId:$("#phoneId2").val(),
                     phoneName:$("#phoneName2").val(),
                     supplierId:$("#supplierId2").val(),
                     phoneType:$("#phoneType2").val(),
                     phoneColor:$("#phoneColor2").val(),
                     phoneRam:$("#phoneRam2").val(),
                     phoneStorage:$("#phoneStorage2").val(),
                     phoneNetwork:$("#phoneNetwork2").val(),
                     phoneState:$("#phoneState2").val()
                 }
             },
             columns: [
                 {
                     checkbox: true
                 }, {
                     field: 'phoneId',
                     title: '编号'
                 }, {
                     field: 'phoneImage',
                     title: '#',
                     formatter: function(value, item, index) {
                         //return "<img src='/common/file/showImageByPath?path='+value  />";
                         return '<img style="width: 40px;height: 40px;" src=/common/file/showImageByPath?path='+value+'/>';
                     }
                 }, {
                     field: 'phoneName',
                     title: '手机名称'
                 }, {
                     field: 'supplierId',
                     title: '供应商编号',
                     visible:false,
                     formatter: function(value, item, index) {
                         return item.supplier.supplierId;
                     }
                 }, {
                     field: 'supplierName',
                     title: '供应商',
                     formatter: function(value, item, index) {
                         return item.supplier.supplierName;
                     }
                 }, {
                     field: 'phoneType',
                     title: '类别'
                 }, {
                     field: 'phoneColor',
                     title: '颜色'
                 }, {
                     field: 'phoneRam',
                     title: '运存'
                 }, {
                     field: 'phoneStorage',
                     title: '内存'
                 }, {
                     field: 'phoneNetwork',
                     title: '网络类型'
                 }, {
                     field: 'phoneState',
                     title: '状态',
                     formatter: function(value, item, index) {
                         if (value==0){
                             return "<span class=\"label label-success\">在售</span>";
                         }
                         if (value==1){
                             return "<span class=\"label label-warning\">下架</span>";
                         }
                     }
                 }, {
                     field: 'phoneRemark',
                     title: '产品描述'
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


         $(document).ready(function() {
             // Validate the form manually
             $('#validateBtn').click(function() {
                 $('#defaultForm').bootstrapValidator('validate');
             });

             $('#resetBtn').click(function() {
                 $('#addUserForm').data('bootstrapValidator').resetForm(true);
             });
         });


         /**
          * 关闭模态框之后对模态框进行重置
          */
         $(document).ready(function() {
             $('#addProductModal').on('hidden.bs.modal', function () {
                 $('#addProductForm')[0].reset();
             });

             $('#alterSupplierModal').on('hidden.bs.modal', function () {
                 //$('#editUserForm').data('bootstrapValidator').resetForm(true);
             });
         });


         $(document).ready(function() {
             $.ajax({
                 url:'/supplier/getTargetSuppliers',
                 dataType:'json',
                 type:'post',
                 success:function(data){
                     if(data.code==0){
                         var supplierList=data.supplierList;
                         $.each(supplierList,function(i,item){

                             $("#supplierId1").append("<option value='"+item.supplierId+"'>"+item.supplierName+"</option>");
                             $("#supplierId2").append("<option value='"+item.supplierId+"'>"+item.supplierName+"</option>");
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
         * 打开修改窗口
         */
        function alterProduct(){
            var $table = $('#phones');
            var phone= $table.bootstrapTable('getSelections');

            if (JSON.stringify(phone)=="[]"){
                layer.alert("请先选择要进行修改的手机信息", {icon: 5});
            }else{
                    var phoneId=phone[0].phoneId;
                    var phoneName=phone[0].phoneName;
                    var supplierId=phone[0].supplier.supplierId;
                    var phoneType=phone[0].phoneType;
                    var phoneColor=phone[0].phoneColor;
                    var phoneRam=phone[0].phoneRam;
                    var phoneStorage=phone[0].phoneStorage;
                    var phoneNetwork=phone[0].phoneNetwork;
                    var phoneState=phone[0].phoneState;
                    var phoneRemark=phone[0].phoneRemark;
                    var phoneImage=phone[0].phoneImage;

                    $("#alterProductModal").modal('show');

                    $("#phoneId").val(phoneId);
                    $("#phoneName").val(phoneName);

                    $("#supplierId").val(supplierId);

                    $("#phoneType").val(phoneType);
                    $("#phoneColor").val(phoneColor);
                    $("#phoneRam").val(phoneRam);
                    $("#phoneStorage").val(phoneStorage);
                    $("#phoneNetwork").val(phoneNetwork);
                    $("#phoneState").val(phoneState);
                    $("#phoneRemark").val(phoneRemark);
                    $("#phoneImage1").val(phoneImage);
                $("#test01").attr("src","/common/file/showImageByPath?path="+phoneImage);


                }
        }


        /**
         * 打开删除窗口
         */
        function removeProduct() {
            var $table = $('#phones');
            var phone= $table.bootstrapTable('getSelections');

            if (JSON.stringify(phone)=="[]"){
                layer.alert("请先选择要删除的手机商品信息", {icon: 5});
            }else{
                $("#removeProductModal").modal('show');
            }
        }

        function remove(){
            var phoneId;
            var tbodyObj = document.getElementById('phones');
            $("table :checkbox").each(function(key,value){
                if($(value).prop('checked')){
                    phoneId=tbodyObj.rows[key+1].cells[1].innerHTML;
                    $.ajax({
                        url:'/business/phoneInfo/removeProduct',
                        dataType:'json',
                        type:'post',
                        data:{phoneId:phoneId},
                        success:function(data){
                            if(data.code == 0){
                                layer.msg(data.msg, {icon: 1, time: 1000, offset: '0px'});
                                $("#removeProductModal").modal('hide');
                                window.location.reload();
                            }else{
                                layer.alert(data.msg, {icon: 5, offset: '0px'});
                            }

                        }
                    });
                }
            });

        }




         $(document).ready(function() {
             var projectfileoptions = {
                 language: 'zh',
                 uploadUrl: "/common/file/uploadFile",
             }


             var phoneImage1=$("#phoneImage1").val();
             var projectfileoptions1 = {
                 language: 'zh',
                 uploadUrl: "/common/file/uploadFile"
             }
             $("#file").fileinput(projectfileoptions);

             $("#file-6").fileinput(projectfileoptions1);
         });

    </script>

     <%--    图片上传--%>
    <script>
     //异步上传返回结果处理
     $("#file-6").on("fileuploaded", function (event, data) {
         //alert(JSON.stringify(data));
         if (data.response.code == 0) {

             var path=data.response.path;
             $('#phoneImage1').val(path);

         }else{
         }
     });

 //异步上传返回结果处理
 $("#file").on("fileuploaded", function (event, data) {
     //alert(JSON.stringify(data));
     if (data.response.code == 0) {

         var path=data.response.path;
         $('#phoneImage').val(path);

     }else{
     }
 });
 //     //上传前
 //     $('#file').on('filepreupload', function (event, data, previewId, index) {
 //         console.log("filepreupload");
 //     });
 // });
    </script>
</body>
</html>
