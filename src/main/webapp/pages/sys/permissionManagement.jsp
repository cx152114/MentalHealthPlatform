<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-10
  Time: 20:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>权限资源管理</title>
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

        .rowSameHeight {
            white-space: nowrap;
            overflow: hidden;
        }

    </style>
</head>
<body>
<section id="container">
    <!-- **********************************************************************************************************************************************************
        TOP BAR CONTENT & NOTIFICATIONS
        *********************************************************************************************************************************************************** -->
    <!--页面头部-->
    <jsp:include page="../header.jsp"></jsp:include>
    <!--页面头部-->
    <!-- **********************************************************************************************************************************************************
        MAIN SIDEBAR MENU
        *********************************************************************************************************************************************************** -->
    <!--导航侧栏-->
    <jsp:include page="../aside.jsp"></jsp:include>
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
                    <button style="width: 75px;" type="button" class="btn btn-success" data-toggle="modal" data-backdrop="false" data-target="#addPermissionModal">新增</button>
                    <!-- 修改按钮 -->

                    <a href="javascript:void(0)" style="width: 75px;" class="btn btn-warning" onclick="alterDept()">修改</a>
                    <!-- 删除按钮 -->
                    <%--                        <button style="width: 75px;" type="button" class="btn btn-danger" data-toggle="modal" data-backdrop="false" data-target="#removeProductModal">删除</button>--%>
                    <a href="javascript:void(0)" style="width: 75px;" class="btn btn-danger" onclick="removeDept()">删除</a>
                    <hr />
                    <div class="content-panel" >
                        <table class="table table-hover rowSameHeight"
                               data-toggle="table"
                               id="permissions"
                               data-search="true"
                               data-show-refresh="true"
                               <%-- data-show-toggle="true" --%>
                               data-show-fullscreen="true"
                               data-show-columns="true"
                               data-show-columns-toggle-all="true"
                               data-show-export="true"
                               data-click-to-select="true"
                               data-exportDataType ="basic">
                            <hr/>
                            <thead>
                            <tr>
                                <th data-field="select" >#</th>
                                <th data-field="permissionId">编号编号</th>
                                <th data-field="permissionName">名称</th>
                                <th data-field="url">路径</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${pageInfo.list}" var="permission">
                                <tr style="text-align: center;vertical-align: middle">
                                    <td style="text-align: center;vertical-align: middle">
                                        <div class="checkbox">
                                            <input type="checkbox" class="styled" id="singleCheckbox1" name="dept" aria-label="Single checkbox One">
                                            <label></label>
                                        </div>
                                    </td>

                                    <td style="text-align: center;vertical-align: middle;display: none">${permission.permissionId}</td>
                                    <td style="text-align: center;vertical-align: middle">${permission.permissionName}</td>
                                    <td style="text-align: center;vertical-align: middle">${permission.url}</td>
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
                                <a href="${pageContext.request.contextPath}/permission/showAllPermission?page=1&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">首页</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/permission/showAllPermission?page=${pageInfo.pageNum-1}&size=${pageInfo.pageSize}">上一页 <span class="sr-only"></span></a>
                            </li>
                            <c:forEach begin="1" end="${pageInfo.pages}" var="pageNum">
                                <li>
                                    <a href="${pageContext.request.contextPath}/permission/showAllPermission?page=${pageNum}&size=${pageInfo.pageSize}">${pageNum} <span class="sr-only"></span></a>
                                </li>
                            </c:forEach>
                            <li >
                                <a href="${pageContext.request.contextPath}/permission/showAllPermission?page=${pageInfo.pageNum+1}&size=${pageInfo.pageSize}">后一页 <span class="sr-only"></span></a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/permission/showAllPermission?page=${pageInfo.pages}&size=${pageInfo.pageSize}" aria-label="Previous">
                                    <span aria-hidden="true">尾页</span>
                                </a>
                            </li>

                        </ul>
                    </nav>


                </div>
                <!-- /col-md-12 -->
            </div>

            <!-- 新增部门 -->
            <div class="modal inmodal" id="addDeptModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                                <h3 class="mb" style="margin: 0px"> 新增部门信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" action="/dept/addDept" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">部门名称</label>
                                                <input type="text" class="form-control" name="deptName" placeholder="部门名称" >
                                            </div>
                                            <div>
                                                <textarea class="form-control" name="deptRemark"  placeholder="备注：" rows="4" data-rule="required" ></textarea>
                                            </div>
                                            <div>
                                                <label class="radio-inline" >
                                                    <input type="radio"  name="deptStatus" checked="checked" value="1">
                                                    正常使用
                                                </label>
                                                <label class="radio-inline" >
                                                    <input type="radio"  name="deptStatus" value="0">
                                                    停用
                                                </label>
                                            </div>
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


            <!-- 修改部门信息 -->
            <div class="modal inmodal" id="alterDeptModal" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
                <div class="modal-dialog">
                    <div class="modal-content animated bounceInRight">
                        <div class="panel  form-panel "  style="margin:0 auto; width:100%; border:1px solid #F00; ">
                            <div class="panel-heading" style="text-align: center;">
                                <h3 class="mb" style="margin: 0px">修改部门信息</h3>
                            </div>
                            <div class="panel-body">
                                <form class="form-horizontal style-form" action="/dept/editDept" method="post">
                                    <div class="form-group" >
                                        <div class="col-sm-10" >
                                            <div style="display: none">
                                                <label class="control-label">部门编号</label>
                                                <input type="text" class="form-control" name="deptId" id="deptId"  style="width: 60%">
                                            </div>
                                            <div>
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">部门名称</label>
                                                <input type="text" class="form-control" name="deptName" id="deptName"  style="width: 60%">
                                            </div>
                                            <div >
                                                <label class="control-label" style="font-size:19px;margin-bottom: 3px;margin-left: 5px;">备注</label>
                                                <input type="text" class="form-control" id="deptRemark" name="deptRemark" placeholder="备注" >
                                            </div>
                                            <div>
                                                <label class="radio-inline" >
                                                    <input type="radio" id="radio1" name="deptStatus"  value="1">
                                                    正常使用
                                                </label>
                                                <label class="radio-inline" >
                                                    <input type="radio" id="radio2"  name="deptStatus" value="0">
                                                    停用
                                                </label>
                                            </div>
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


            <!-- 删除部门-->
            <div class="modal fade" id="removeDeptModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                                &times;
                            </button>
                            <h4 class="modal-title" id="myModalLabel" >
                                删除部门（此过程不可逆，谨慎操作）
                            </h4>
                        </div>
                        <div class="modal-body">
                            <h4 style="color: red;">是否移除选定部门？</h4>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                            <button type="button" class="btn btn-primary" onclick="remove()">移除</button>
                        </div>
                    </div><!-- /.modal-content -->
                </div><!-- /.modal -->
            </div>


        </section>
    </section>
    <!-- /MAIN CONTENT -->
    <!--main content end-->
    <!--footer start-->
    <footer class="site-footer">
        <div class="text-center">
            <p>
                &copy; Copyrights <strong>cx</strong>. All Rights Reserved
            </p>
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
        location.href = "${pageContext.request.contextPath}/permission/showAllPermission?page=1&size="
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

    /**
     * 打开修改窗口
     */
    function alterDept(){
        var size=$("input[name='dept']:checkbox:checked").length;
        if (size<1){
            alert('请选中你要操作的记录');
            return false;
        }
        if (size>1){
            alert('请不要选择多条记录进行操作');
            return false;
        }
        var tbodyObj = document.getElementById('depts');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                var deptId=tbodyObj.rows[key+1].cells[1].innerHTML;
                var deptName=tbodyObj.rows[key+1].cells[2].innerHTML;
                var deptStatur=tbodyObj.rows[key+1].cells[3].innerHTML;
                var deptReamrk=tbodyObj.rows[key+1].cells[4].innerHTML;


                $("#alterDeptModal").modal('show');

                $("#deptId").val(deptId);
                $("#deptName").val(deptName);
                $("#deptRemark").val(deptReamrk);

                if (deptStatur==0){
                    $("#radio2").attr("checked","checked");
                }else{
                    $("#radio1").attr("checked","checked");
                }

            }
        })
    }

    /**
     * 打开删除窗口
     */
    function removeDept() {
        var size=$("input[name='dept']:checkbox:checked").length;
        if (size<1){
            alert('请选中你要操作的记录');
            return false;
        }
        if (size>1){
            alert('请不要选择多条记录进行操作');
            return false;
        }
        if (size==1){
            $("#removeDeptModal").modal('show');
            return;
        }
    }

    function remove(){
        var deptId;
        var tbodyObj = document.getElementById('depts');
        $("table :checkbox").each(function(key,value){
            if($(value).prop('checked')){
                deptId=tbodyObj.rows[key+1].cells[1].innerHTML;
                $.ajax({
                    url:'../dept/removeTargetDept',
                    dataType:'json',
                    type:'post',
                    data:{deptId:deptId},
                    success:function(data){
                        if(data.type == 'success'){
                            alert("删除成功！");
                            $("#removeDeptModal").modal('hide');
                            window.location.reload();
                        }else{
                            //$.messager.alert('信息提示',data.msg,'warning');
                            parent.$.alert({
                                title: '${data.type}',
                                content: '${data.msg}'
                            });
                        }
                    }
                });
            }
        });
    }
</script>
</body>
</html>
