package com.dlt.business.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Comment;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
public interface ICommentService extends IService<Comment> {

    /**
     * 功能描述: <br>
     * 〈查询指定留言集〉
     * @Param: [queryWrapper] 查询参数集
     * @Return: java.util.List<com.dlt.business.entity.Comment>  查询结果
     * @Author: 陈翔
     * @Date: 2021-03-20 21:17
     */
    public List<Comment> selectTargetComments(Wrapper<Comment> queryWrapper);
}
