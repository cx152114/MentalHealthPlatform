package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Activity;
import com.dlt.business.entity.Article;
import com.dlt.business.entity.Joy;
import com.dlt.business.service.IActivityService;
import com.dlt.business.service.IJoyService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.User;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-02-24
 */
@Controller
@RequestMapping("/business/joy")
public class JoyController {

    @Autowired
    private IJoyService joyService;

    @GetMapping
    @RequiresPermissions("business:joy:search")
    public String joyManagement(){
        return "/business/joyManagement";
    }

    @RequestMapping(value = "/findAllJoy")
    @RequiresPermissions("business:joy:search")
    @ResponseBody
    public R findAllJoy(Page<Joy> page, Joy joy, String startTime, String endTime){
        QueryWrapper<Joy> queryWrapper=new QueryWrapper<Joy>();
        if (!StringUtils.isEmpty(joy.getJoyTitle())){
            queryWrapper.like("joy_title",joy.getJoyTitle());
        }
        if (!StringUtils.isEmpty(joy.getJoyType())){
            queryWrapper.like("joy_type",joy.getJoyType());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("joy_date",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("joy_date",startTime);
        }
        queryWrapper.orderByDesc("joy_date");
        joyService.page(page, queryWrapper);
        return R.ok(page);
    }


    @RequestMapping(value = "/addJoy",method = RequestMethod.POST)
    @RequiresPermissions("business:joy:add")
    @ResponseBody
    public R addJoy(Joy joy){
        joy.setJoyDate(new Date());
        joyService.save(joy);
        return R.ok();
    }

    @RequestMapping(value = "/editJoy",method = RequestMethod.POST)
    @RequiresPermissions("business:joy:edit")
    @ResponseBody
    public R editJoy(Joy joy){
        //activity.setCreatetime(new Date());
        //User user=(User) SecurityUtils.getSubject().getPrincipal();
        //notice.setOpername(user.getUsername());
        joyService.updateById(joy);
        return R.ok();
    }

    @RequestMapping(value = "/deleteTargetJoy")
    @RequiresPermissions("business:joy:remove")
    @ResponseBody
    public R deleteTargetJoy(Integer joyId){
        joyService.removeById(joyId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteJoy")
    @RequiresPermissions("business:joy:batchRemove")
    @ResponseBody
    public R batchDeleteJoy(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        joyService.removeByIds(list);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "/findTargetJoy",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetJoy(Integer joyId){
        Joy joy=joyService.getById(joyId);
        return R.ok().put("joy",joy);
    }

    @GetMapping(value = "/studentJoy")
    @RequiresPermissions("business:joy:search")
    public String studentJoy(){
        return "/business/student-joy";
    }

    @RequestMapping(value = "/findTargetStudentJoy/{joyType}")
    @RequiresPermissions("business:exam:search")
    @ResponseBody
    public R findTargetStudentArticle(@PathVariable String joyType){
        QueryWrapper<Joy> queryWrapper = new QueryWrapper<>();
        if (! StringUtils.isEmpty(joyType)){
            queryWrapper.like("joy_type",joyType);
        }
        List<Joy> joyList=joyService.list(queryWrapper);
        return R.ok().put("rows",joyList);
    }
}
