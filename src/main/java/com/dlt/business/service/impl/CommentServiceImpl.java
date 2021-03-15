package com.dlt.business.service.impl;

import com.dlt.business.entity.Comment;
import com.dlt.business.mapper.CommentMapper;
import com.dlt.business.service.ICommentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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

}
