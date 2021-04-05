package com.dlt.business.mapper;

import com.dlt.business.entity.ActivityApply;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.io.Serializable;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
public interface ActivityApplyMapper extends BaseMapper<ActivityApply> {

    @Override
    ActivityApply selectById(Serializable id);
}
