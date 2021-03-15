<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-04-11
  Time: 19:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>统计商品销售量</title>
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

    <style type="text/css">
        .content-panel{
            padding-left: 15px;
            padding-right: 15px;
        }



    </style>
</head>
<body>

<div class="row">

    <!-- /col-md-12 -->
    <div class="col-md-12 mt">
        <div style="margin-top: -15px;">
            <h3>商品每月销售情况<small>（2020年）</small></h3>
        </div>

        <div class="content-panel" style="height: 650px;overflow: auto;" >
            <div id="main" style="width: 1200px;height:400px;" class="col-lg-12"></div>
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


<%--layui插件--%>
<script src="${pageContext.request.contextPath}/lib/layer/layer.js"></script>
<script src="${pageContext.request.contextPath}/lib/echarts/js/echarts.js"></script>

<script>
    function resetForm(data) {
        $(data)[0].reset();
    }

    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));

    var data1=[10, 52, 200, 334, 1800, 330, 220];
    // data1.push(900);
    // data1.push(1000);

    //var data1=new Array(12);

    $(document).ready(function(){
        $.ajax({
            url:'/business/static/staticSalesForMonth',
            dataType:'json',
            type:'post',
            success:function(data){
                if(data.code==0){
                    var static=data.static;
                    //alert(static);
                    $.each(static,function(i,item){
                        //data1.push(static[i]);
                        data1[i]=static[i];
                        i++;
                    });

                    // 指定图表的配置项和数据
                    var option = {
                        color: ['#3398DB'],
                        tooltip: {
                            trigger: 'axis',
                            axisPointer: {            // 坐标轴指示器，坐标轴触发有效
                                type: 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
                            }
                        },
                        grid: {
                            left: '3%',
                            right: '4%',
                            bottom: '3%',
                            containLabel: true
                        },
                        xAxis: [
                            {
                                type: 'category',
                                data: ['一月', '二月', '三月', '四月', '五月', '六月', '七月','八月', '九月', '十月', '十一月', '十二月'],
                                axisTick: {
                                    alignWithLabel: true
                                }
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value',
                                minInterval:1
                            }
                        ],
                        series: [
                            {
                                name: '总销售量',
                                type: 'bar',
                                barWidth: '60%',
                                //data: [10, 52, 200, 334, 1800, 330, 220]
                                //data: [0, 0, 0, 0, 3, 0, 0,0,0,0,0,0]
                                data:data1
                            }
                        ]
                    };

                    // 使用刚指定的配置项和数据显示图表。
                    myChart.setOption(option);


                }else{
                    layer.alert(data.msg, {icon: 5, offset: '0px'});
                }

            }
        });
    });






</script>
</body>
</html>
