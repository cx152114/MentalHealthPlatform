package com.dlt.sys.realm;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.common.util.MD5Util;
import com.dlt.sys.entity.User;

import com.dlt.sys.service.IUserService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.HashSet;
import java.util.Set;


public class ShiroRealm extends AuthorizingRealm {

    @Autowired
    private IUserService userService;

    /**
     * 登录认证
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {

        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;

        // 1.获取用户输入的用户名
        String username = token.getUsername();
        // 2.获取用户输入的密码
        String password = new String(token.getPassword());

        // 3.根据用户名去DB查询对应的用户信息
        QueryWrapper<User> param = new QueryWrapper<>();
        param.eq("username",username);
        User user = userService.getOne(param);

        if(user == null) {
            throw new UnknownAccountException("用户名不存在");
        }
        password = MD5Util.md5_private_salt(password,user.getSalt());

        // 两个密码的密文进行比对
        if (!user.getPassword().equals(password)) {
            throw new CredentialsException("密码错误");
        }
        if (user.getUserStatus() == 1) {
            throw new DisabledAccountException("账号被禁用");
        }
        if (user.getUserStatus() == 2) {
            throw new LockedAccountException("账号被锁定");
        }
        System.out.println("认证成功...");
        // 创建简单认证信息对象
        return new SimpleAuthenticationInfo(user, token.getCredentials(), getName());
    }


    /**
     * 授权
     * 将认证通过的用户的角色和权限信息设置到对应用户主体上
     *
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        User user = (User) principals.getPrimaryPrincipal();
        // 简单授权信息对象，对象中包含用户的角色和权限信息
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();

        //从数据库获取当前用户的角色 通过用户名查询该用户拥有的角色名称
        Set<String> roleNameSet = userService.selectUserRoleNameSet(user.getUserId());
        info.addRoles(roleNameSet);

        //假如用户拥有系统管理员角色，给予所有权限
        if (roleNameSet.contains("系统管理员")){
            info.addStringPermission("*:*");
            return  info;
        }

        //从数据库获取当前用户的权限 通过用户名查询该用户拥有的权限名称
        Set<String> permissionNameSet = userService.selectUserPermissionNameSet(user.getUserId());

        Set<String> permissions = new HashSet<>();
        for(String name : permissionNameSet) {
            for(String permission : name.split(",")){
                    if (!StringUtils.isEmpty(permission)) {
                        permissions.add(permission);
                    }
            }
        }
        if(permissions.size() > 0) {
            info.addStringPermissions(permissions);
        }
        System.out.println("授权完成....");
        return info;
    }
}
