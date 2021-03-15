package com.dlt.sys.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.sys.entity.UserRole;
import com.dlt.sys.mapper.UserRoleMapper;
import com.dlt.sys.service.IUserRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 用户与角色对应关系 服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements IUserRoleService {

    @Autowired
    private UserRoleMapper userRoleMapper;


    @Override
    public List<UserRole> getByUserId(Integer userId) {
        return userRoleMapper.selectByUserId(userId);
    }


    @Override
    @Transactional
    public boolean save(Integer userId, List<Integer> roleIdList) {
        //1.删除当前用户拥有的角色
        QueryWrapper queryWrapper = new QueryWrapper();
        queryWrapper.eq("user_id", userId);
        this.remove(queryWrapper);

        if (roleIdList != null && !roleIdList.isEmpty()) {
            //2.将新设置的角色分配给当前用户
            List<UserRole> userRoleList = new ArrayList<>();
            for (Integer roleId : roleIdList) {
                UserRole userRole = new UserRole();
                userRole.setUserId(userId);
                userRole.setRoleId(roleId);
                //System.out.println(userRole);
                userRoleList.add(userRole);
            }
            System.out.println(userRoleList);
            //3.批量插入数据
            //this.saveBatch(userRoleList);
            this.saveBatch(userRoleList);
        }
        return true;
    }
}
