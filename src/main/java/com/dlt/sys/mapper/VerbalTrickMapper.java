package com.dlt.sys.mapper;

import com.dlt.sys.entity.VerbalTrick;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import javax.jnlp.IntegrationService;

/**
 * <p>
 * 话术表 Mapper 接口
 * </p>
 *
 * @author cx
 * @since 2021-03-30
 */
public interface VerbalTrickMapper extends BaseMapper<VerbalTrick> {


    VerbalTrick queryTargetVerbalTrick(String verbalId);

}
