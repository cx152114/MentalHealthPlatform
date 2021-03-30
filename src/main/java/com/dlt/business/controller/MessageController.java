package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dlt.business.entity.Activity;
import com.dlt.business.entity.Bottle;
import com.dlt.business.entity.Message;
import com.dlt.business.entity.Secret;
import com.dlt.business.service.IBottleService;
import com.dlt.business.service.IMessageService;
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
@RequestMapping("/business/message")
public class MessageController {

    @Autowired
    private IMessageService messageService;

    @Autowired
    private IUserService userService;

    @GetMapping
    @RequiresPermissions("business:message:search")
    public String messageManagement(){
        return "/business/messageManagement";
    }

    @RequestMapping(value = "/findAllMessage")
    @RequiresPermissions("business:message:search")
    @ResponseBody
    public R findAllMessage(Message message, String startTime, String endTime){
        QueryWrapper<Message> queryWrapper=new QueryWrapper<Message>();
        if (null!=message.getMessageStatus()){
            queryWrapper.like("message_status", message.getMessageStatus());
        }
        if (null != message.getUId()){
            queryWrapper.like("u_id", message.getUId());
        }
        if (!StringUtils.isEmpty(message.getMessageContent())){
            queryWrapper.like("message_content",message.getMessageContent());
        }
        if (!StringUtils.isEmpty(startTime)){
            queryWrapper.ge("create_time",startTime);
        }
        if (!StringUtils.isEmpty(endTime)){
            queryWrapper.le("create_time",endTime);
        }
        queryWrapper.orderByDesc("create_time");
        List<Message> messageList = messageService.list(queryWrapper);
        return R.ok().put("rows",messageList);
    }


    @RequestMapping(value = "/addMessage",method = RequestMethod.POST)
    @RequiresPermissions("business:message:add")
    @ResponseBody
    public R addMessage(Message message){
        message.setCreateTime(new Date());
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        message.setUId(user.getUserId());
        messageService.save(message);
        return R.ok();
    }

    @RequestMapping(value = "/editMessage",method = RequestMethod.POST)
    @RequiresPermissions("business:message:edit")
    @ResponseBody
    public R editMessage(Message message){
        //activity.setCreatetime(new Date());
        //User user=(User) SecurityUtils.getSubject().getPrincipal();
        //notice.setOpername(user.getUsername());
        messageService.updateById(message);
        return R.ok();
    }

    @RequestMapping(value = "/deleteTargetMessage")
    @RequiresPermissions("business:message:remove")
    @ResponseBody
    public R deleteTargetMessage(Integer messageId){
        messageService.removeById(messageId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteMessage")
    @RequiresPermissions("business:message:batchRemove")
    @ResponseBody
    public R batchDeleteMessage(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        messageService.removeByIds(list);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "/findTargetMessage",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetMessage(Integer messageId){
        Message message=messageService.getById(messageId);

        return R.ok().put("message",message);
    }

    @GetMapping(value = "/messageInteraction")
    @RequiresPermissions("business:message:search")
    public String messageInteraction(){
        return "/business/messageInteraction";
    }

    @RequestMapping(value = "/findMessages")
    @ResponseBody
    public R findMessages(){
        // 查询自己发的留言
        QueryWrapper<Message> queryWrapper = new QueryWrapper<>();
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        queryWrapper.eq("u_id", user.getUserId());
        List<Message> selfMessage = messageService.list(queryWrapper);

        QueryWrapper<Message> queryWrapper1 = new QueryWrapper<>();
        queryWrapper1.eq("receive_id", user.getUserId());
        List<Message> receiveMessage = messageService.list(queryWrapper1);
        for (Message message:receiveMessage) {
            selfMessage.add(message);
        }
        return R.ok().put("rows",selfMessage);
    }






}
