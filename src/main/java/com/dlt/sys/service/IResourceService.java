package com.dlt.sys.service;

import com.dlt.common.model.TreeNode;
import com.dlt.sys.entity.Resource;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 菜单管理 服务类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
public interface IResourceService extends IService<Resource> {

    TreeNode getTreeById(Integer id);
}
