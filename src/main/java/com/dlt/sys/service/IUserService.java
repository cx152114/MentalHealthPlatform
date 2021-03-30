package com.dlt.sys.service;

import com.dlt.common.model.TreeNode;
import com.dlt.sys.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 员工 服务类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
public interface IUserService extends IService<User> {
    /**
     * 根据id查询用户角色名称的集合
     * @param id
     * @return
     */
    Set<String> selectUserRoleNameSet(Integer id);

    /**
     * 根据id查询用户权限名称的集合
     * @param id
     * @return
     */
    Set<String> selectUserPermissionNameSet(Integer id);


    /**
     * 根据用户id获取用户的菜单树
     * @param id
     * @return
     */
    List<TreeNode> getMenuTreeByUserId(Integer id);

    void updateByIdForPassword(String password);
}
