package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Comment;
import com.dlt.business.mapper.CommentMapper;
import com.dlt.business.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dlt.sys.entity.User;
import com.dlt.sys.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@Service
public class CommentServiceImpl extends ServiceImpl<CommentMapper, Comment> implements ICommentService {

    @Autowired
    private CommentMapper commentMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Comment> selectTargetComments(Wrapper<Comment> queryWrapper) {
        List<Comment> commentList = new ArrayList<>();
        commentList = commentMapper.selectList(queryWrapper);
        for (Comment comment:commentList) {
            User sendUser = userMapper.selectById(comment.getUId());
            User receiveUser = userMapper.selectById(comment.getReceiveId());
            comment.setSendUser(sendUser);
            comment.setReceiveUser(receiveUser);
        }
        return commentList;
    }
}
