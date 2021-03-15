package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Bottle;
import com.dlt.business.entity.Joy;
import com.dlt.business.service.IBottleService;
import com.dlt.business.service.IJoyService;
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
@RequestMapping("/business/bottle")
public class BottleController {

    @Autowired
    private IBottleService bottleService;

    @GetMapping
    @RequiresPermissions("business:bottle:search")
    public String bottleManagement(){
        return "/business/bottleManagement";
    }

    @RequestMapping(value = "/findAllBottle")
    @RequiresPermissions("business:bottle:search")
    @ResponseBody
    public R findAllBottle(Page<Bottle> page, Bottle bottle, String startTime, String endTime){
        QueryWrapper<Bottle> queryWrapper=new QueryWrapper<Bottle>();
        if (null != bottle.getUId()){
            queryWrapper.like("u_id", bottle.getUId());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("create_date",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("create_date",startTime);
        }
        queryWrapper.orderByDesc("create_date");
        bottleService.page(page, queryWrapper);
        return R.ok(page);
    }


    @RequestMapping(value = "/addBottle",method = RequestMethod.POST)
    @RequiresPermissions("business:bottle:add")
    @ResponseBody
    public R addBottle(Bottle bottle){
        bottle.setCreateDate(new Date());
        bottleService.save(bottle);
        return R.ok();
    }

    @RequestMapping(value = "/editBottle",method = RequestMethod.POST)
    @RequiresPermissions("business:bottle:edit")
    @ResponseBody
    public R editBottle(Bottle bottle){
        //activity.setCreatetime(new Date());
        //User user=(User) SecurityUtils.getSubject().getPrincipal();
        //notice.setOpername(user.getUsername());
        bottleService.updateById(bottle);
        return R.ok();
    }

    @RequestMapping(value = "deleteTargetBottle")
    @RequiresPermissions("business:bottle:remove")
    @ResponseBody
    public R deleteTargetBottle(Integer bottleId){
        bottleService.removeById(bottleId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "batchDeleteBottle")
    @RequiresPermissions("business:bottle:batchRemove")
    @ResponseBody
    public R batchDeleteBottle(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        bottleService.removeByIds(list);
        return R.ok("删除成功");
    }





}
