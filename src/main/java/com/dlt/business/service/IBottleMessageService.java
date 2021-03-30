package com.dlt.business.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.BottleMessage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.dlt.business.entity.Comment;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
public interface IBottleMessageService extends IService<BottleMessage> {

    public List<BottleMessage> selectTargetBottleMessages(Wrapper<BottleMessage> queryWrapper);
}
