package com.dlt.sys.service.impl;

import cn.hutool.core.util.IdUtil;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.common.exception.BizException;
import com.dlt.common.model.TreeNode;
import com.dlt.common.util.MD5Util;
import com.dlt.common.util.TreeUtil;
import com.dlt.sys.entity.Menu;
import com.dlt.sys.entity.Resource;
import com.dlt.sys.entity.User;
import com.dlt.sys.mapper.ResourceMapper;
import com.dlt.sys.mapper.UserMapper;
import com.dlt.sys.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 员工 服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ResourceMapper resourceMapper;


    @Override
    public List<User> list(Wrapper<User> queryWrapper) {
        List<User> list=userMapper.selectList(queryWrapper);
        return list;
    }

    @Override
    public Set<String> selectUserRoleNameSet(Integer id) {
        return userMapper.selectUserRoleNameSet(id);
    }

    @Override
    public Set<String> selectUserPermissionNameSet(Integer id) {
        return userMapper.selectUserPermissionNameSet(id);
    }

    /**
     * 获取用户的菜单树
     * @param id
     * @return
     */
    @Override
    public List<TreeNode> getMenuTreeByUserId(Integer id) {

        List<Menu> menuList;

        // 查询用户角色信息
        Set<String> roleList = userMapper.selectUserRoleNameSet(id);
        if (roleList.contains("系统管理员")) {
            menuList = userMapper.selectAllMenuList();
        } else {
            // 查询用户拥有的菜单资源
            menuList = userMapper.selectMenuList(id);
            if (menuList.isEmpty()) {
                return new ArrayList<>();
            }
        }

        // 存储父id是0的节点的id
        List<Integer> nodeIds = new ArrayList<>();
        List<TreeNode> treeNodeList = new ArrayList<>();
        for (Menu menu : menuList) {
            TreeNode treeNode = new TreeNode();
            treeNode.setId(menu.getResourceId());
            treeNode.setName(menu.getResourceName());
            treeNode.setParentId(menu.getParentId());
            treeNode.setUrl(menu.getUrl());
            treeNode.setIcon(menu.getIcon());
            treeNodeList.add(treeNode);
            if(treeNode.getParentId() == 0) {
                nodeIds.add(treeNode.getId());
            }
        }
        TreeUtil treeUtil = new TreeUtil(treeNodeList);
        List<TreeNode> treeNodeData = new ArrayList<>();
        for (Integer nodeId : nodeIds) {
            treeNodeData.add(treeUtil.generateTree(nodeId));
        }
        return treeNodeData;
    }

    @Override
    public void updateByIdForPassword(String password) {
        User user=(User) SecurityUtils.getSubject().getPrincipal();
        user.setPassword(password);
        userMapper.updateById(user);
    }

    @Override
    public boolean save(User user) {
        String username = user.getUsername();
        String password = user.getPassword();
        String email = user.getUserEmail();
        String mobile = user.getUserPhone();
        // 校验用户名不能为空
        if (StringUtils.isEmpty(username)) {
            throw new BizException("用户名不能为空");
        }
        // 校验密码不能为空
        if (StringUtils.isEmpty(password)) {
            throw new BizException("密码不能为空");
        }

        // 校验用户名是否被占用
        QueryWrapper queryUsername = new QueryWrapper();
        queryUsername.eq("username", username);
        if (this.count(queryUsername) > 0) {
            throw new BizException("用户名已存在");
        }

        if (!StringUtils.isEmpty(mobile)) {
            QueryWrapper queryMobile = new QueryWrapper();
            queryMobile.eq("user_phone", user.getUserPhone());
            if (this.count(queryMobile) > 0) {
                throw new BizException("手机号已经被使用");
            }
        }


        if (!StringUtils.isEmpty(email)) {
            QueryWrapper queryEmail = new QueryWrapper();
            queryEmail.eq("user_email", user.getUserEmail());
            if (this.count(queryEmail) > 0) {
                throw new BizException("邮箱已经被使用");
            }
        }
        String salt= IdUtil.simpleUUID().toUpperCase();
        password = MD5Util.md5_private_salt(password, salt);
        user.setPassword(password);
        user.setSalt(salt);
        return super.save(user);
    }


    @Override
    public boolean updateById(User user) {
        String userEmail = user.getUserEmail();
        String userPhone = user.getUserPhone();

        // 不是当前用户使用了该手机号，表示手机号被占用
        if (!StringUtils.isEmpty(userPhone)) {
            QueryWrapper queryMobile = new QueryWrapper();
            queryMobile.eq("user_phone", user.getUserPhone());
            queryMobile.ne("user_id",user.getUserId());
            if (this.count(queryMobile) > 0) {
                throw new BizException("手机号已经被使用");
            }
        }
        if (!StringUtils.isEmpty(userEmail)) {
            QueryWrapper queryEmail = new QueryWrapper();
            queryEmail.eq("user_email", user.getUserEmail());
            queryEmail.ne("user_id",user.getUserId());
            if (this.count(queryEmail) > 0) {
                throw new BizException("邮箱已经被使用");
            }
        }
        return super.updateById(user);
    }
}
