<%--
  Created by IntelliJ IDEA.
  User: 陈翔
  Date: 2020-02-21
  Time: 23:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--页面头部-->
<header class="header black-bg">
    <div class="sidebar-toggle-box">
        <div class="fa fa-bars tooltips" data-placement="right" data-original-title="Toggle Navigation"></div>
    </div>
    <!--logo start-->
    <a href="/login/main"  class="logo"><b>手机<span>进销存管理系统</span></b></a>
    <!--logo end-->

    <div class="top-menu">
        <!-- 登录按钮 -->
        <ul class="nav pull-right top-menu ">
            <button type="button" class="btn btn-theme  dropdown-toggle"  data-toggle="dropdown" style="margin-top: 14px;font-size: 12px;">
                个人中心 <span class="caret"></span>
            </button>
            <ul class="nav pull-right dropdown-menu" role="menu">
                <li><a href="#"><i class="fa fa-user"></i>&nbsp;&nbsp;&nbsp;&nbsp;个人中心</a></li>
                <li><a href="#"><i class="fa fa-key"></i></i>&nbsp;&nbsp;&nbsp;&nbsp;修改密码</a></li>
                <li><a href="/sys/lockScreen"><i class="fa fa-unlock-alt"></i>&nbsp;&nbsp;&nbsp;&nbsp;锁屏</a></li>
                <li class="divider"></li>
                <li><a href="/user/logout"><i class="fa fa-sign-out"></i>&nbsp;&nbsp;&nbsp;&nbsp;退出系统</a></li>
            </ul>
        </ul>
    </div>
</header>
<!--页面头部-->
