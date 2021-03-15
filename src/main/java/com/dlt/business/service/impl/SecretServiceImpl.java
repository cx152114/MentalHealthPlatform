package com.dlt.business.service.impl;

import com.dlt.business.entity.Secret;
import com.dlt.business.mapper.SecretMapper;
import com.dlt.business.service.ISecretService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

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

}
