package com.dlt.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.common.model.R;
import com.dlt.common.util.MD5Util;
import com.dlt.sys.entity.User;
import com.dlt.sys.entity.UserRole;
import com.dlt.sys.service.IUserRoleService;
import com.dlt.sys.service.IUserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import javax.jws.soap.SOAPBinding;
import java.util.List;

/**
 * <p>
 * 员工 前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @Autowired
    private IUserRoleService userRoleService;


    @GetMapping(value = "/userManagement")
    @RequiresPermissions("sys:user:list")
    private String userManagement(){
        return "/sys/employee-list";
    }

    @RequestMapping(value = "/showAllUser")
    @RequiresPermissions("sys:user:list")
    @ResponseBody
    public R showAllUser(User user, String startTime, String endTime){
        QueryWrapper<User> param = new QueryWrapper<>();
        param.eq("deleted",0);
        if (null!=user.getUserId()){
            param.like("user_id",user.getUserId());
        }
        if (!StringUtils.isEmpty(user.getUsername())){
            param.like("username",user.getUsername());
        }
        if (null!=user.getUserStatus()){
            param.eq("user_status",user.getUserStatus());
        }
        if (!StringUtils.isEmpty(startTime)){
            param.ge("create_time",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            param.le("create_time",endTime);
        }
        List<User> userList=userService.list(param);
        return R.ok().put("rows",userList);
    }


    @RequestMapping(value = "/addUser",method = RequestMethod.POST)
    @RequiresPermissions("sys:user:add")
    public String addCustomer(User user){
        userService.save(user);
        return "redirect:/user/userManagement";
    }


    @RequestMapping(value = "/editUser",method = RequestMethod.POST)
    @RequiresPermissions("sys:user:update")
    public String editUser(User user){
        System.out.println(user);
        //String salt=IdUtil.simpleUUID().toUpperCase();
        QueryWrapper<String> pram=new QueryWrapper<>();
        User oldUser=userService.getById(user.getUserId());
        String salt=oldUser.getSalt();
        String password= MD5Util.md5_private_salt(user.getPassword(),salt);
        user.setSalt(salt);
        user.setPassword(password);
        userService.updateById(user);
        return "redirect:/user/userManagement";
    }

    @RequestMapping(value = "/removeUser",method = RequestMethod.POST)
    @RequiresPermissions("sys:user:delete")
    @ResponseBody
    public R removeUser(Integer userId){
        if (userId==null){
            return R.error("请先勾选要移除的用户");
        }
        try {
            User user=userService.getById(userId);
            user.setDeleted(1);
            userService.updateById(user);
            return R.ok();
        } catch (Exception e) {
            e.printStackTrace();
            return R.error("出现未知错误，请联系管理员");
        }

    }

    /**
     * 跳转到给用户分配角色的页面
     *
     * @param userId
     * @return
     */
    @PostMapping("/getRoleList")
    @RequiresPermissions("sys:user:assign:role")
    @ResponseBody
    public R getRoleList(Integer userId) {
        List<UserRole> userRoleList = userRoleService.getByUserId(userId);
        return R.ok().put("userRoleList",userRoleList).put("userId",userId);
    }

    /**
     * 给用户分配角色
     *
     * @param userId
     * @return
     */
    @PostMapping("/assignRole")
    @RequiresPermissions("sys:user:assign:role")
    @ResponseBody
    public R assignRole(Integer userId,
                        @RequestParam(name = "roleId",required = false) List<Integer> roleIdList) {
        userRoleService.save(userId,roleIdList);
        return R.ok();
    }


    @RequestMapping(value = "/getTargetUsers" )
    @ResponseBody
    public R getTargetUsers(){
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("user_status",0);
        queryWrapper.eq("deleted",0);
        List<User> userList=userService.list(queryWrapper);
        return R.ok().put("userList",userList);
    }

    @RequestMapping(value = "/getCurrentUsers" )
    @ResponseBody
    public R getCurrentUsers(){
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        return R.ok().put("user",user);
    }

    @RequestMapping(value = "/editTargetUser",method = RequestMethod.POST)
    @RequiresPermissions("sys:user:update")
    public String editTargetUser(User user){
        QueryWrapper<String> pram=new QueryWrapper<>();
        //User oldUser=userService.getById(user.getUserId());
        //String salt=oldUser.getSalt();
        //String password= MD5Util.md5_private_salt(oldUser.getPassword(),salt);
        //user.setSalt(salt);
        //user.setPassword(password);
        userService.updateById(user);
        // 销毁会话
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "/sys/login";
    }

    @RequestMapping(value = "/resetPassword",method = RequestMethod.POST)
    @RequiresPermissions("sys:user:update")
    @ResponseBody
    public R resetPassword(String password){
        QueryWrapper<String> pram=new QueryWrapper<>();
        //User oldUser=userService.getById(user.getUserId());
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        String salt=user.getSalt();
        password= MD5Util.md5_private_salt(password,salt);
        userService.updateByIdForPassword(password);
        return R.ok();
    }

}
