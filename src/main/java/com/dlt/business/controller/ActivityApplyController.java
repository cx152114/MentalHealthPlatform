package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.ActivityApply;
import com.dlt.business.entity.Message;
import com.dlt.business.service.IActivityApplyService;
import com.dlt.business.service.IMessageService;
import com.dlt.common.model.R;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
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
@RequestMapping("/business/activityApply")
public class ActivityApplyController {

    @Autowired
    private IActivityApplyService  activityApplyService;

    @GetMapping
    @RequiresPermissions("business:activityApply:search")
    public String activityApplyManagement(){
        return "/business/activityApplyManagement";
    }

    @RequestMapping(value = "/findAllActivityApply")
    @RequiresPermissions("business:activityApply:search")
    @ResponseBody
    public R findAllActivityApply(ActivityApply activityApply){
        QueryWrapper<ActivityApply> queryWrapper=new QueryWrapper<ActivityApply>();
        if (null!=activityApply.getApplyStatus()){
            queryWrapper.like("apply_status", activityApply.getApplyStatus());
        }

        List<ActivityApply> list = activityApplyService.list(queryWrapper);
        return R.ok().put("rows",list);
    }


    @RequestMapping(value = "/addActivityApply",method = RequestMethod.POST)
    @RequiresPermissions("business:activityApply:add")
    @ResponseBody
    public R addActivityApply(ActivityApply activityApply){
        activityApplyService.save(activityApply);
        return R.ok();
    }

    @RequestMapping(value = "/editActivityApply",method = RequestMethod.POST)
    @RequiresPermissions("business:activityApply:edit")
    @ResponseBody
    public R editActivityApply(ActivityApply activityApply){
        activityApplyService.updateById(activityApply);
        return R.ok();
    }

    @RequestMapping(value = "deleteTargetActivityApply")
    @RequiresPermissions("business:activityApply:remove")
    @ResponseBody
    public R deleteTargetActivityApply(Integer applyId){
        activityApplyService.removeById(applyId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "batchDeleteActivityApply")
    @RequiresPermissions("business:activityApply:batchRemove")
    @ResponseBody
    public R batchDeleteActivityApply(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        activityApplyService.removeByIds(list);
        return R.ok("删除成功");
    }

}
