package com.dlt.business.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.ActivityApply;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
public interface IActivityApplyService extends IService<ActivityApply> {

    /**
     * 功能描述: <br>
     * 〈〉
     * @Param: [updateWrapper, applyId]
     * @Return: boolean
     * @Author: 陈翔
     * @Date: 2021-03-18 22:58
     */
    public boolean update(Wrapper<ActivityApply> updateWrapper, Integer applyId,Integer applyStatus);

    /**
     * 功能描述: <br>
     * 〈〉
     * @Param: [applyId]
     * @Return: boolean
     * @Author: 陈翔
     * @Date: 2021-03-18 23:07
     */
    public boolean remove(Integer applyId);
}
