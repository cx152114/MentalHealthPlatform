package com.dlt.business.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.Comment;
import com.dlt.business.entity.Message;
import com.dlt.business.service.ICommentService;
import com.dlt.business.service.IMessageService;
import com.dlt.common.model.R;
import com.dlt.sys.entity.User;
import com.dlt.sys.service.IUserService;
import net.sf.json.JSONArray;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
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
@RequestMapping("/business/comment")
public class CommentController {

    @Autowired
    private ICommentService commentService;

    @Autowired
    private IUserService userService;

    @RequestMapping(value = "/findTargetComments/{messageId}")
    @RequiresPermissions("business:message:search")
    @ResponseBody
    public R findTargetComments(@PathVariable Integer messageId){
        QueryWrapper<Comment> queryWrapper=new QueryWrapper<Comment>();
        if (null != messageId){
            queryWrapper.eq("message_id", messageId);
        }
        List<Comment> commentList = commentService.selectTargetComments(queryWrapper);
        return R.ok().put("rows",commentList);
    }

    @RequestMapping(value = "/addComment",method = RequestMethod.POST)
    @RequiresPermissions("business:message:add")
    @ResponseBody
    public R addComment(Comment comment){
        comment.setCreateTime(new Date());
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        comment.setUId(user.getUserId());
        commentService.save(comment);
        return R.ok();
    }

    @RequestMapping(value = "/editComment",method = RequestMethod.POST)
    @RequiresPermissions("business:message:edit")
    @ResponseBody
    public R editComment(Comment comment){
        //activity.setCreatetime(new Date());
        //User user=(User) SecurityUtils.getSubject().getPrincipal();
        //notice.setOpername(user.getUsername());
        commentService.updateById(comment);
        return R.ok();
    }

    @RequestMapping(value = "/deleteTargetComment")
    @RequiresPermissions("business:message:remove")
    @ResponseBody
    public R deleteTargetComment(Integer commentId){
        System.out.println(commentId);
        commentService.removeById(commentId);
        return R.ok("删除成功");
    }


    @RequestMapping(value = "/batchDeleteComment")
    @RequiresPermissions("business:message:batchRemove")
    @ResponseBody
    public R batchDeleteComment(String ids){
        JSONArray arrIds= JSONArray.fromObject(ids);
        List<Integer> list=new ArrayList<>();
        for (int i = 0; i <arrIds.size() ; i++) {
            Integer id= (Integer) arrIds.get(i);
            list.add(id);
        }
        commentService.removeByIds(list);
        return R.ok("删除成功");
    }

    @RequestMapping(value = "/findTargetComment",method = RequestMethod.POST)
    @ResponseBody
    public R findTargetComment(Integer commentId){
        Comment comment=commentService.getById(commentId);
        User sendUser = userService.getById(comment.getUId());
        User receiveUser = userService.getById(comment.getReceiveId());
        comment.setSendUser(sendUser);
        comment.setReceiveUser(receiveUser);
        return R.ok().put("comment",comment);
    }

    @RequestMapping(value = "/receiveComment",method = RequestMethod.POST)
    @RequiresPermissions("business:message:add")
    @ResponseBody
    public R receiveComment(Comment comment){
        comment.setCreateTime(new Date());
        User user=(User) SecurityUtils.getSubject().getPrincipal();

        System.out.println(comment);
        Comment oldComment = commentService.getById(comment.getCommentId());

        System.out.println(oldComment);
        Comment newComment = new Comment();
        newComment.setContent(comment.getContent());
        newComment.setMessageId(comment.getMessageId());
        // 假如回复人就是收件人
        if (oldComment.getReceiveId().equals(user.getUserId())){
            newComment.setUId(oldComment.getUId());
            newComment.setReceiveId(user.getUserId());
        }else {
            // 假如回复人不是收件人
            newComment.setUId(user.getUserId());
            newComment.setReceiveId(user.getUserId());
        }
        commentService.save(newComment);
        return R.ok();
    }



}
