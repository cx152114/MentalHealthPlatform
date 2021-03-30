package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Activity;
import com.dlt.business.entity.ActivityApply;
import com.dlt.business.service.IActivityApplyService;
import com.dlt.business.service.IActivityService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.User;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-03-01
 */
@Controller
@RequestMapping("/business/activityApplyDetail")
public class ActivityApplyDetailController {

    @Autowired
    private IActivityService activityService;

    @Autowired
    private IActivityApplyService activityApplyService;

    @GetMapping
    @RequiresPermissions("business:activityApplyDetail:search")
    public String activityManagement(){
        return "/business/activityApplyDetail";
    }

    @RequestMapping(value = "/findActivityApplyDetail/{activityId}")
    @RequiresPermissions("business:activityApplyDetail:search")
    @ResponseBody
    public R findActivityApplyDetail(@PathVariable Integer activityId){
        QueryWrapper<ActivityApply> queryWrapper=new QueryWrapper<ActivityApply>();
        if (activityId != null){
            queryWrapper.le("activity_id",activityId);
        }
        List<ActivityApply> list = activityApplyService.list(queryWrapper);
        System.out.println(list);
        return R.ok().put("rows",list);
    }
}
