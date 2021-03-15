package com.dlt.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.common.model.TreeNode;
import com.dlt.common.util.TreeUtil;
import com.dlt.sys.entity.RoleResource;
import com.dlt.sys.mapper.RoleResourceMapper;
import com.dlt.sys.service.IRoleResourceService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 角色与菜单对应关系 服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Service
public class RoleResourceServiceImpl extends ServiceImpl<RoleResourceMapper, RoleResource> implements IRoleResourceService {

    @Autowired
    private RoleResourceMapper roleResourceMapper;

    @Override
    public TreeNode getTreeByRoleId(Integer roleId) {

        //1.获取角色拥有的资源列表
        List<RoleResource> list = roleResourceMapper.selectByRoleId(roleId);
        //2.对象数据转换
        List<TreeNode> treeNodeList = new ArrayList<TreeNode>();
        for (RoleResource rr : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(rr.getResourceId());
            treeNode.setParentId(rr.getParentId());
            treeNode.setName(rr.getResourceName());
            // 设置节点的选中状态
            Map<String, Boolean> state = new HashMap<>();
            if (rr.getRoleId() == null) {
                state.put("checked", false);
            } else {
                state.put("checked", true);
            }
            treeNode.setState(state);
            treeNodeList.add(treeNode);
        }
        // 3.生成菜单树
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        TreeNode treeNode = treeUtil.generateTree(0);
        return treeNode;
    }

    @Override
    @Transactional
    public boolean save(Integer roleId, List<RoleResource> roleResourceList) {
        //1.删除该角色已经分配的资源
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("role_id",roleId);
        this.remove(queryWrapper);

        //2.保存新分配的资源到sys_role_resource
        this.saveBatch(roleResourceList);
        return true;
    }
}
