package com.dlt.sys.service.impl;

import com.dlt.sys.entity.Role;
import com.dlt.sys.mapper.RoleMapper;
import com.dlt.sys.service.IRoleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

}
