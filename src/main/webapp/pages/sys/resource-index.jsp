<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-13
  Time: 14:03
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
    <!-- 引入bootstrap-treeView -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/lib/bootstrap-treeview/bootstrap-treeview.css">

    <style type="text/css">
        th{
            text-align: center;
            vertical-align: middle;
        }

        td{
            text-align: center;

        }

        .rowSameHeight {
            white-space: nowrap;
            overflow: hidden;
        }

    </style>
</head>
<body>
     <div class="row" style="overflow: auto;">
               <!-- /col-md-12 -->
                <div class="col-md-12 mt">
                    <div class="page-title">
                        <div class="title_left">
                            <h3>资源管理</h3>
                            <hr/>
                        </div>
                    </div>
                    <div class="x_content">
                        <div class="col-md-3"  style="height: 500px;overflow: auto;">
                            <%--树形菜单--%>
                            <div id="data-tree"></div>
                        </div>
                        <div class="col-md-9">
                            <%--数据表格--%>
                            <iframe frameborder="0" scrolling="no" id="data-resource-list"  width="100%" height="600px"
                                    src="${pageContext.request.contextPath}/sys/resource/list?parentId=${parentId}"
    <%--                                frameborder="0"--%>
    <%--                                scrolling="no"--%>
    <%--                                id="data-resource-list"--%>
    <%--                                width="100%"--%>
                                    >
                            </iframe>
                        </div>
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

<!-- 引入bootstrap-treeView -->
<script src="${pageContext.request.contextPath}/lib/bootstrap-treeview/bootstrap-treeview.js"></script>

<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>


<script>
    $(document).ready(function() {
        $.ajax({
            url: '/sys/resource/tree',
            type: 'post',
            dataType: 'json',
            success: function (response) {
                if (response.code == 0) {
                    var objTree =
                        $('#data-tree').treeview({
                            data: new Array(response.data),
                            levels: 2, // 默认打开的层级
                            // 当节点被选中的时候触发的事件
                            onNodeSelected: function (event, node) {
                                console.log(node);
                                $('#data-resource-list').attr('src', '${pageContext.request.contextPath}/sys/resource/list?parentId=' + node.id);
                            },
                            // showCheckbox: true,//是否显示选择框
                            // hierarchicalCheck: true, //级联勾选
                            // propagateCheckEvent: true //
                       });

                    // 获取所有没有被选择的节点(获取到所有节点)
                    // var arr = objTree.treeview('getUnselected');
                    // 获取所有节点
                    var arr = objTree.treeview('getNodes');
                    // 遍历每个节点
                    for (var i = 0; i < arr.length; i++) {
                        var node = arr[i];
                        if (node.id == ${parentId}) {
                            // 展开该节点
                            objTree.treeview('expandNode', [node]);
                        }
                    }
                } else {
                    layer.alert(response.msg, {icon: 5, offset: 't'});
                }
            }
        });
    });


    function getTree() {
        var tree = [
            {
                text: "Parent 1",
                nodes: [
                    {
                        text: "Child 1",
                        nodes: [
                            {
                                text: "Grandchild 1"
                            },
                            {
                                text: "Grandchild 2"
                            }
                        ]
                    },
                    {
                        text: "Child 2"
                    }
                ]
            },
            {
                text: "Parent 2"
            },
            {
                text: "Parent 3"
            },
            {
                text: "Parent 4"
            },
            {
                text: "Parent 5"
            }
        ];
        return tree;
    }



    // $('#data-tree').treeview({
    //     data: [
    //         {
    //             text: "父节点-1",
    //             nodes: [
    //                 {
    //                     text: "子节点 1-1"
    //                 },
    //                 {
    //                     text: "子节点 1-2",
    //                     nodes: [
    //                         {
    //                             text: "子节点 1-2-1"
    //                         },
    //                         {
    //                             text: "子节点 1-2-2"
    //                         }
    //                     ]
    //                 }
    //             ]
    //         },
    //         {
    //             text: "父节点-2",
    //             nodes: [
    //                 {
    //                     text: "子节点 2-1"
    //                 },
    //                 {
    //                     text: "子节点 2-2"
    //                 }
    //             ]
    //         }
    //     ]
    // });
    // var data = [{
    //     text: "Parent 1",
    //     nodes: [{
    //         text: "Child 1",
    //         nodes: [{
    //             text: "Grandchild 1"
    //         }, {
    //             text: "Grandchild 2"
    //         }]
    //     },
    //         {
    //             text: "Child 2"
    //         }
    //     ]
    // },
    //     {
    //         text: "Parent 2"
    //     },
    //     {
    //         text: "Parent 3"
    //     },
    //     {
    //         text: "Parent 4"
    //     },
    //     {
    //         text: "Parent 5"
    //     }
    // ];

    // $('#tree').treeview({
    //     data: data,
    //     onNodeSelected: function (event, node) {
    //         alert(node.text)
    //     }
    // });





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
