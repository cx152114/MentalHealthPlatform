package com.dlt.sys.controller;

import com.dlt.common.model.R;
import com.dlt.common.model.TreeNode;
import com.dlt.common.util.MD5Util;
import com.dlt.common.util.WebUtils;
import com.dlt.sys.entity.LogLogin;
import com.dlt.sys.entity.User;
import com.dlt.sys.service.ILogLoginService;
import com.dlt.sys.service.IUserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.HttpRequestHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;


/**
 * @author 陈翔
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {


    @Autowired
    private IUserService userService;


    @Autowired
    private ILogLoginService logLoginService;

    /**
     * 跳转到系统登录页面
     * @return
     */
    @GetMapping("/login")
    public String login(){
        return "sys/login";
    }


    /**
     * 登录
     * @param username
     * @param password
     * @return
     */
    @PostMapping("/login")
    @ResponseBody
    public R login(HttpServletRequest request, String username, String password) {
        UsernamePasswordToken token =
                new UsernamePasswordToken(username,password);
        Subject subject = SecurityUtils.getSubject();
        subject.login(token);
        User user= (User) subject.getPrincipal();

        LogLogin logLogin=new LogLogin();
        logLogin.setLoginName(user.getUsername());
        logLogin.setLoginIp(WebUtils.getRequest().getRemoteAddr());
        logLogin.setLoginTime(new Date());
        logLoginService.save(logLogin);
        return R.ok();
    }

    /**
     * 解锁
     * @param password
     * @return
     */
    @PostMapping("/unlock")
    @ResponseBody
    public R unlock(String password) {
        User user=(User)SecurityUtils.getSubject().getPrincipal();
        if (user.getPassword().equals(MD5Util.md5_private_salt(password.trim(),user.getSalt()))){
            return R.ok();
        }
        return R.error("密码错误");
    }


    /**
     * 跳转到系统初始化页面
     * @return
     */
    @GetMapping("/index")
    public String index(){
        //HttpRequestHandler handler=new H
        return "/sys/index";
    }

    /**
     * 跳转到系统主页
     * @return
     */
    @GetMapping("/main")
    public String main(){
        return "main";
    }

    /**
     * 获取资源菜单树
     * @return
     */
    @GetMapping("/menu")
    @ResponseBody
    public R menu(){
        Subject subject = SecurityUtils.getSubject();
        User user = (User) subject.getPrincipal();
        List<TreeNode> treeNodeList
                = userService.getMenuTreeByUserId(user.getUserId());
        return R.ok("请求成功",treeNodeList);
    }


    @GetMapping("/logout")
    public String logout(){
        // 销毁会话
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "/sys/login";
    }


}
