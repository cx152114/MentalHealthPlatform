package com.dlt.sys.mapper;

import com.dlt.sys.entity.Menu;
import com.dlt.sys.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 员工 Mapper 接口
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
public interface UserMapper extends BaseMapper<User> {
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
     * 根据用户id查询用户菜单
     * @param id
     * @return
     */
    List<Menu> selectMenuList(Integer id);


    /**
     * 根据用户id查询用户菜单
     * @return
     */
    List<Menu> selectAllMenuList();
}
