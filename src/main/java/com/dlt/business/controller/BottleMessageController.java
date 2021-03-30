package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.BottleMessage;
import com.dlt.business.entity.Comment;
import com.dlt.business.service.IBottleMessageService;
import com.dlt.business.service.IBottleService;
import com.dlt.business.service.ICommentService;
import com.dlt.common.model.R;
import com.dlt.sys.service.IUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ResponseBody;

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
@RequestMapping("/business/bottleMessage")
public class BottleMessageController {

    @Autowired
    private IBottleMessageService bottleMessageService;

    @Autowired
    private IUserService userService;

    @RequestMapping(value = "/findTargetBottleMessage/{bottleId}")
    @RequiresPermissions("business:bottleMessage:search")
    @ResponseBody
    public R findTargetBottleMessage(@PathVariable Integer bottleId){
        QueryWrapper<BottleMessage> queryWrapper=new QueryWrapper<BottleMessage>();
        if (null != bottleId){
            queryWrapper.eq("bottle_id", bottleId);
        }
        List<BottleMessage> bottleMessageList = bottleMessageService.selectTargetBottleMessages(queryWrapper);
        return R.ok().put("rows",bottleMessageList);
    }

    @RequestMapping(value = "/deleteTargetBottleMessage")
    @RequiresPermissions("business:bottleMessage:remove")
    @ResponseBody
    public R deleteTargetBottleMessage(Integer bmId){
        bottleMessageService.removeById(bmId);
        return R.ok("删除成功");
    }

}
