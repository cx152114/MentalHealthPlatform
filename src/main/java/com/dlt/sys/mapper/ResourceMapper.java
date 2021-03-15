package com.dlt.sys.mapper;

import com.dlt.sys.entity.Menu;
import com.dlt.sys.entity.Resource;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
 * 菜单管理 Mapper 接口
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
public interface ResourceMapper extends BaseMapper<Resource> {
    /**
     * 功能描述: <br>
     * 〈〉查询全部资源信息
     * @Param: []
     * @Return: java.util.List<com.dlt.sys.entity.Menu>  --菜单信息
     * @Author: 陈翔
     * @Date: 2021-02-06 13:06
     */
    public List<Menu> selectAllMenuList();
}
