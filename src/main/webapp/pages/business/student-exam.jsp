<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-02
  Time: 18:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<html>
<head>
    <title>心理测试</title>
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

    <link  href="${pageContext.request.contextPath}/lib/summernote/summernote.css" rel="stylesheet" />


    <style>
        body{
            background-color: gray;
        }
        .index{
            margin: auto;
            width:920px;
            background-color: white;
            box-shadow:10px 10px 15px black;
            margin-top:10px;
        }
        h1{
            color:orange;
            padding-top:30px;
            text-align:center;
        }
        form{
            padding-left: 100px;
            line-height:180%;
        }
        input{
            border-color: black;
            border-top-width:0px;
            border-right-width:0px;
            border-bottom-width:2px;
            border-left-width:0px;
        }
        #btn{
            background-color: #FFA500;
            color:white;
            padding:5px 10px;
            margin-left:320px;
            margin-top:16px;
            margin-bottom: 20px;
        }

        .div4 {
            display: flex;
            justify-content: center;
            align-items: center;
        }
    </style>


</head>
<body>
<section id="container">
    <div class="row" id="content-type">
        <!-- /col-md-12 -->
        <div class="col-md-12 mt">
            <div>
                <div class="col-md-4">
                    <div style="width: 250px;height: 150px;border: #00a6b2 solid 1px;background: #9FAFD1" class="div4">
                        <a href="#" onclick="getTargetExam('综合测试')"><strong style="font-size: 24px;">综合测试</strong></a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="width: 250px;height: 150px;border: #00a6b2 solid 1px;background: #a9d96c" class="div4">
                        <a href="#" onclick="getTargetExam('日常交往')"><strong style="font-size: 24px;">日常交往</strong></a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="width: 250px;height: 150px;border: #00a6b2 solid 1px;background: antiquewhite" class="div4">
                        <a href="#" onclick="getTargetExam('人格检测')"><strong style="font-size: 24px;">人格检测</strong></a>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-12 mt">
            <div>
                <div class="col-md-4">
                    <div style="width: 250px;height: 150px;border: #00a6b2 solid 1px;background: #8D8D8D" class="div4">
                        <a href="#" onclick="getTargetExam('情感测试')"><strong style="font-size: 24px;">情感测试</strong></a>
                    </div>
                </div>
                <div class="col-md-4">
                    <div style="width: 250px;height: 150px;border: #00a6b2 solid 1px;background: red" class="div4">
                        <a href="#"><strong style="font-size: 24px;">更多期待</strong></a>
                    </div>
                </div>
            </div>
        </div>
        <!-- /col-md-12 -->
    </div>

    <!--内容区域-->
    <div class="row mt" id="content-area" style="display: none;height:500px;overflow:auto">
        <div class="index">
            <h1>大学生心理健康调查问卷</h1>
            <hr color="orange" width="700px" />
            <form method="post" action="/business/exam/generateExamResult">
                <div style="display: none">
                    <input type="text" name="examType" id="examType" value="" required>
                </div>
                <ol id="ol1">

                </ol>
                <br />
                <button id="btn" type="submit">提交问卷</button>
            </form>
        </div>
    </div>
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


<!-- 数据导出 -->
<script src="${pageContext.request.contextPath}/lib/tableExport/FileSaver.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/xlsx.core.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/jspdf.plugin.autotable.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/es6-promise.auto.min.js"></script>
<script src="${pageContext.request.contextPath}/lib/tableExport/html2canvas.min.js"></script>

<script src="${pageContext.request.contextPath}/lib/bootstrap-table/js/bootstrap-table-zh-CN.js"></script>

<%--引入bootstrap用于表单验证的插件--%>
<script src="${pageContext.request.contextPath}/lib/bootstrapValidator/js/bootstrapValidator.js"></script>



<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>

<%--summernote插件--%>
<script src="${pageContext.request.contextPath}/lib/summernote/summernote.js"></script>

<script type="application/javascript">
    /**
     * 初始化表格数据
     */
    var dataTable = $('#joys').bootstrapTable({
        url: "/business/joy/findTargetStudentJoy",                      //  请求后台的URL
        method: "post",                      //  请求方式
        contentType:'application/x-www-form-urlencoded; charset=UTF-8',
        uniqueId: "joyId",                 //  每一行的唯一标识，一般为主键列
        cache: false,                       //  设置为 false 禁用 AJAX 数据缓存， 默认为true
        pagination: true,                   //  是否显示分页
        sidePagination: "client",           //  分页方式：client客户端分页，server服务端分页
        pageSize: 5,                       //  每页的记录行数
        pageList:"[5,10,25,50,100,all]",
        queryParamsType: '',
        queryParams: function (param) {
            return {
                current: param.pageNumber, // 当前页 1
                size: param.pageSize,      // 一页显示多少天 10
            }
        },
        columns: [
            {
                field: 'joyId'
            }, {
                field: 'joyType'
            }, {
                field: 'joyTitle',
                formatter: function(value, item, index) {
                    if (value == null){
                        value = ''
                    }
                }
            }, {
                field: 'joyContent',
                visible:false
            }, {
                field: 'joyDate'
            }, {
                field: 'answer',
                visible:false
            }]
    });

    function detailFormatter(index, row) {
        var html = [];
        $.each(row, function (key, value) {
            if(key=="joyContent"){
                html.push("<div style='height:200px;overflow:auto'><b>文章内容：</b> " + value + "</div>")
            }
            if(key=="answer"){
                if (value != null){
                    html.push("<div><b>--</b> " + value + "</div>")
                }
            }
        })
        return html.join('')
    }

    function refreshTable(date) {
        dataTable.bootstrapTable('refresh', {
            url: "/business/joy/findTargetStudentJoy/"+date,
            pageSize: 5,
            pageNumber: 1,
            typeId:date
        });
    }

    function getTargetExam(date){
        $("#examType").val(date)
        $.ajax({
            url: "/business/exam/findTargetStudentExam",
            dataType: 'json',
            type: 'post',
            data: {type: date},
            success: function (data) {
                if (data.code == 0) {
                    if (data.exams.length < 10){
                        layer.alert("未找到足够的测评试题，请联系管理员添加", {icon: 5, offset: '0px'});
                    }else{
                        generateExam(data)
                    }

                } else {
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }
            }
        });
    }


    function generateExam(date){
        for (let i = 0; i < date.exams.length; i++) {
            var para = document.createElement("li");
            var node = document.createTextNode(date.exams[i].title);
            para.appendChild(node);
            var element = document.getElementById("ol1");
            element.appendChild(para);
            for (var j = 0; j < 4; j++) {
                var lable = document.createElement("lable");
                var br = document.createElement("br");
                var input = document.createElement("input");
                input.setAttribute("type","radio");
                input.setAttribute("name","question"+i);
                input.setAttribute("required","true");
                //input.setAttribute("id","item"+j);
                var node = ""
                if (j + 1 === 1){
                    input.setAttribute("value","4");
                    node = document.createTextNode(date.exams[i].section1);
                }else if (j + 1 === 2){
                    input.setAttribute("value","3");
                    node = document.createTextNode(date.exams[i].section2);
                }else if (j + 1 === 3){
                    input.setAttribute("value","2");
                    node = document.createTextNode(date.exams[i].section3);
                }else{
                    input.setAttribute("value","1");
                    node = document.createTextNode(date.exams[i].section4);
                }
                //input.setAttribute("value",date.exams[i].);
                //var node = document.createTextNode(date.exams[i].test);
                //input.appendChild(node);
                lable.appendChild(input);
                lable.appendChild(node);

                //input.setAttribute("value","&nbsp;&nbsp;18岁以下&nbsp;&nbsp; ");
                //var lable = document.createElement("lable");
                //document.getElementById(i).appendChild(input);
                var div = document.getElementById("ol1");
                div.appendChild(lable);
                div.appendChild(br);

            }
        }
        $("#content-type").hide()
        $("#content-area").show()
    }



</script>


</body>
</html>

