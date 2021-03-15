package com.dlt.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.common.exception.BizException;
import com.dlt.common.model.TreeNode;
import com.dlt.common.util.TreeUtil;
import com.dlt.sys.entity.Resource;
import com.dlt.sys.mapper.ResourceMapper;
import com.dlt.sys.mapper.RoleResourceMapper;
import com.dlt.sys.service.IResourceService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 菜单管理 服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements IResourceService {
    @Autowired
    private IResourceService resourceService;

    @Autowired
    private RoleResourceMapper roleResourceMapper;



    /**
     * 通过id查询该节点的树形结构数据
     *
     * @param
     * @return
     */
    @Override
    public TreeNode getTreeById(Integer id) {
        Resource r = this.getById(id);
        //1.查询所有节点
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.likeRight("path", r.getPath());
        //queryWrapper.orderByAsc("order_num");
        List<Resource> list = this.list(queryWrapper);

        //2.对象数据转换
        List<TreeNode> treeNodeList = new ArrayList<>();
        for (Resource resource : list) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(resource.getResourceId());
            treeNode.setName(resource.getResourceName());
            treeNode.setParentId(resource.getParentId());
            treeNodeList.add(treeNode);
        }
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        TreeNode treeNode = treeUtil.generateTree(id);
        return treeNode;
    }

    @Override
    @Transactional
    public boolean save(Resource resource) {
        //保存以后会自动将生成的主键回写到resource对象上
        super.save(resource);
        //1.获取父资源的路径
        Resource parent = this.getById(resource.getParentId());
        String path = parent.getPath() + "/" + resource.getResourceId(); // path/id
        //2.将生成的path更新到资源表
        resource.setPath(path);
        this.updateById(resource);
        return true;
    }


    @Override
    public boolean removeById(Serializable id) {
        //检查该节点是否有子节点
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("parent_id", id); //select * from sys_resource where parent_id = 10
        if (this.count(queryWrapper) > 0) {
            throw new BizException("请先删除该资源下的子资源");
        }
        // 删除该资源分配的角色信息
        QueryWrapper queryRoleResource = new QueryWrapper();
        queryRoleResource.eq("resource_id", id);
        roleResourceMapper.delete(queryRoleResource);
        return super.removeById(id);
    }
}
