package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Activity;
import com.dlt.business.entity.ActivityApply;
import com.dlt.business.entity.Joy;
import com.dlt.business.entity.Secret;
import com.dlt.business.service.IJoyService;
import com.dlt.business.service.ISecretService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.User;
import com.dlt.sys.service.IUserService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@Controller
@RequestMapping("/business/secret")
public class SecretController {

    @Autowired
    private ISecretService secretService;

    @Autowired
    private IUserService userService;

    @GetMapping
    @RequiresPermissions("business:secret:search")
    public String secretManagement(){
        return "/business/secretManagement";
    }

    @RequestMapping(value = "/findAllSecret")
    @RequiresPermissions("business:secret:search")
    @ResponseBody
    public R findAllSecret(Secret secret, String startTime, String endTime){
        QueryWrapper<Secret> queryWrapper=new QueryWrapper<Secret>();
        if (null != secret.getUId()) {
            queryWrapper.eq("u_id", secret.getUId());
        }
        if (!StringUtils.isEmpty(secret.getSecretMessage())) {
            queryWrapper.like("secret_message", secret.getSecretMessage());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("create_date",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("create_date",startTime);
        }
        queryWrapper.orderByDesc("create_date");
        List<Secret> list = secretService.list(queryWrapper);
        return R.ok().put("rows",list);
    }


    @RequestMapping(value = "/addSecret",method = RequestMethod.POST)
    @RequiresPermissions("business:secret:add")
    @ResponseBody
    public R addSecret(Secret secret){
        secret.setCreateDate(new Date());
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        secret.setUId(user.getUserId());
        secretService.save(secret);
        return R.ok();
    }

    @RequestMapping(value = "/editSecret",method = RequestMethod.POST)
    @RequiresPermissions("business:secret:edit")
    @ResponseBody
    public R editSecret(Secret secret){
        secretService.updateById(secret);
        return R.ok();
    }

    @RequestMapping(value = "/deleteTargetSecret")
    @RequiresPermissions("business:secret:remove")
    @ResponseBody
    public R deleteTargetSecret(Integer secretId){
        secretService.removeById(secretId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteSecret")
    @RequiresPermissions("business:secret:batchRemove")
    @ResponseBody
    public R batchDeleteSecret(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        secretService.removeByIds(list);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "/findTargetSecret",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetSecret(Integer secretId){
        Secret secret=secretService.getById(secretId);
        User user = userService.getById(secret.getUId());
        secret.setUser(user);
        return R.ok().put("secret",secret);
    }

    /**
     * 功能描述: <br>
     * 〈心情分享〉
     * @Param:
     * @Return:
     * @Author: dlt
     * @Date: 2021-03-28 0:21
     */
    @GetMapping(value = "/moodSharing")
    @RequiresPermissions("business:secret:search")
    public String moodSharing(){
        return "/business/student-moodSharing";
    }

    @GetMapping(value = "/secretPublicWall")
    @RequiresPermissions("business:secret:search")
    public String secretPublicWall(){
        return "/business/student-secretWall";
    }

    @RequestMapping(value = "/pointLikeTargetSecret",method = RequestMethod.POST)
    @RequiresPermissions("business:secret:search")
    @ResponseBody
    public R pointLikeTargetSecret(Integer secretId){
        Secret secret = secretService.getById(secretId);
        secret.setHitCount(secret.getHitCount()+1);
        secretService.updateById(secret);
        return R.ok();
    }





}
