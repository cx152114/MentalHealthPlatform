package com.dlt.sys.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.common.model.R;
import com.dlt.sys.entity.LogLogin;
import com.dlt.sys.service.ILogLoginService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Controller
@RequestMapping("/sys/logLogin")
public class LogLoginController {

    @Autowired
    private ILogLoginService logLoginService;

    @GetMapping
    @RequiresPermissions("sys:log:list")
    public String loginLogInfo(){
        return "/sys/loginLog";
    }


    @RequestMapping(value = "/loadAllLoginInfo")
    @RequiresPermissions("sys:log:list")
    @ResponseBody
    public R loadAllLoginInfo(Page<LogLogin> page, LogLogin logLogin, String startTime, String endTime){
        QueryWrapper<LogLogin> queryWrapper=new QueryWrapper<LogLogin>();
        if (!StringUtils.isEmpty(logLogin.getLoginName())){
            queryWrapper.like("login_name",logLogin.getLoginName());
        }
        if (!StringUtils.isEmpty(logLogin.getLoginIp())){
            queryWrapper.like("login_ip",logLogin.getLoginIp());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("login_time",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("login_time",startTime);
        }
        queryWrapper.orderByDesc("login_time");
        logLoginService.page(page, queryWrapper);
        return R.ok(page);
    }

    @RequestMapping(value = "deleteTargetLoginInfo")
    @RequiresPermissions("sys:log:remove")
    @ResponseBody
    public R deleteTargetLoginInfo(Integer id){
        logLoginService.removeById(id);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "batchDeleteLoginLog")
    @RequiresPermissions("sys:log:batchRemove")
    @ResponseBody
    public R batchDeleteLoginLog(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        logLoginService.removeByIds(list);
        return R.ok("删除成功");
    }
}
