<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-03-15
  Time: 1:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib uri="http://shiro.apache.org/tags" prefix="shiro" %>
<aside>
    <div id="sidebar" class="nav-collapse ">
        <!-- sidebar menu start-->
        <div style="padding-top: 70px;">
            <p class="centered"><img src="${pageContext.request.contextPath}/img/ui-sam.jpg" class="img-circle" width="80"></p>
            <h5 class="centered"><shiro:principal property="username"></shiro:principal></h5>
        </div>

        <ul class="sidebar-menu" id="nav-accordion" style="margin-top: 0px;">

        </ul>
        <!-- sidebar menu end-->
    </div>
</aside>
<!-- js placed at the end of the document so the pages load faster -->
<script src="${pageContext.request.contextPath}/lib/jquery/jquery.min.js"></script>

<script src="${pageContext.request.contextPath}/lib/art-template/template-web.js"></script>


<script id="tpl-menu" type="text/html">
    {{each menuList menu}}
    <li class="sub-menu">
        <a><i class="{{menu.icon}}"></i>{{menu.text}}</a>
        <ul class="sub">
            {{each menu.nodes sub_menu}}
            <li>
                {{if sub_menu.nodes}}
                    <a href="javascript:;" url="${pageContext.request.contextPath}/{{sub_menu.url}}" >{{sub_menu.text}}</a>
                {{else}}
                    <a href="javascript:;">{{sub_menu.text}}</a>
                <ul class="sub">
                    {{each sub_menu.nodes sub_sub_menu}}
                    <li>
                        <a href="javascript:;"
                           url="${pageContext.request.contextPath}/{{sub_sub_menu.url}}">{{sub_sub_menu.text}}</a>
                    </li>
                    {{/each}}
                </ul>
                {{/if}}
            </li>
            {{/each}}
        </ul>
    </li>
    {{/each}}
</script>

<script>
    var datas = {
        resourceList: []
    };
    $(document).ready(function() {
            $.ajax({
                url: '/login/menu',
                async: false,
                type: 'get',
                dataType: 'json',
                success: function (response) {
                    if (response.code == 0) {
                        datas.resourceList=response.data;

                        var html = template('tpl-menu',{
                            menuList: datas.resourceList
                        });
                        $('#sidebar .sidebar-menu').html(html);
                        //点击左侧菜单
                        $('.sub-menu a').click(function () {
                            $('.sub li').removeClass('active');
                            var url = $(this).attr('url');
                            if (url!=null) {
                            //if (url) {
                                var name= $(this).attr("url");
                                location.hash = name;//设置锚点
                                $('#main-body').attr('src', url);
                             }
                        });
                    } else {
                        window.parent.parent.layer.alert(response.msg, {icon: 5, offset: 't'});
                    }
                }
            });
    });
</script>

<script type="text/javascript">
    window.onhashchange = function(){//监听锚点的变化
        var hash = location.hash;
        hash = hash.substring(1,hash.length);
        $("#main-body").attr("src",hash);
    }
    document.addEventListener('DOMContentLoaded', function () {//刷新
        var hash = location.hash;
        var url = hash.substring(1,hash.length);
        $("#main-body").attr("src", url);
    }, false)
</script>


