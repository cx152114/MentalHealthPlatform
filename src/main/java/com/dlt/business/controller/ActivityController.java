package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Activity;
import com.dlt.business.service.IActivityService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.Notice;
import com.dlt.sys.entity.User;
import com.dlt.sys.service.INoticeService;
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
 * @since 2021-03-01
 */
@Controller
@RequestMapping("/business/activity")
public class ActivityController {

    @Autowired
    private IActivityService activityService;

    @GetMapping
    @RequiresPermissions("business:activity:search")
    public String activityManagement(){
        return "/business/activityManagement";
    }

    @RequestMapping(value = "/findAllActivity")
    @RequiresPermissions("business:activity:search")
    @ResponseBody
    public R findAllActivity(Page<Activity> page, Activity activity, String startTime, String endTime){
        QueryWrapper<Activity> queryWrapper=new QueryWrapper<Activity>();
        if (!StringUtils.isEmpty(activity.getTitle())){
            queryWrapper.like("title",activity.getTitle());
        }
        if (!StringUtils.isEmpty(activity.getSendName())){
            queryWrapper.like("send_name",activity.getSendName());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("activity_date",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("activity_date",startTime);
        }
        queryWrapper.orderByDesc("activity_date");
        activityService.page(page, queryWrapper);
        return R.ok(page);
    }


    @RequestMapping(value = "/addActivity",method = RequestMethod.POST)
    @RequiresPermissions("business:activity:add")
    @ResponseBody
    public R addActivity(Activity activity){
        activity.setActivityDate(new Date());
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        activity.setSendName(user.getUsername());
        activityService.save(activity);
        return R.ok();
    }

    @RequestMapping(value = "/editActivity",method = RequestMethod.POST)
    @RequiresPermissions("business:activity:edit")
    @ResponseBody
    public R editActivity(Activity activity){
        //activity.setCreatetime(new Date());
        //User user=(User) SecurityUtils.getSubject().getPrincipal();
        //notice.setOpername(user.getUsername());
        activityService.updateById(activity);
        return R.ok();
    }

    @RequestMapping(value = "/deleteTargetActivity")
    @RequiresPermissions("business:activity:remove")
    @ResponseBody
    public R deleteTargetActivity(Integer activityId){
        activityService.removeById(activityId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteActivity")
    @RequiresPermissions("business:activity:batchRemove")
    @ResponseBody
    public R batchDeleteActivity(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        activityService.removeByIds(list);
        return R.ok("删除成功");
    }



    @RequestMapping(value = "/findTargetActivity",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetActivity(Integer activityId){
        Activity activity=activityService.getById(activityId);

        return R.ok().put("activity",activity);
    }


}
