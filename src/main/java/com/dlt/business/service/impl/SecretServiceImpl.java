package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Secret;
import com.dlt.business.mapper.SecretMapper;
import com.dlt.business.service.ISecretService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dlt.sys.entity.User;
import com.dlt.sys.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@Service
public class SecretServiceImpl extends ServiceImpl<SecretMapper, Secret> implements ISecretService {

    @Autowired
    private SecretMapper secretMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Secret> list(Wrapper<Secret> queryWrapper) {
        List<Secret> secretList = new ArrayList<>();
        secretList = secretMapper.selectList(queryWrapper);
        for (Secret secret : secretList) {
            User user = userMapper.selectById(secret.getUId());
            secret.setUser(user);
        }
        return secretList;
    }
}
