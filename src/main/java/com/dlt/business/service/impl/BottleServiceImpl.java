package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Bottle;
import com.dlt.business.mapper.BottleMapper;
import com.dlt.business.service.IBottleService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dlt.sys.entity.User;
import com.dlt.sys.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@Service
public class BottleServiceImpl extends ServiceImpl<BottleMapper, Bottle> implements IBottleService {

    @Autowired
    private BottleMapper bottleMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Bottle> list(Wrapper<Bottle> queryWrapper) {
        List<Bottle> bottles =new ArrayList<>();
        bottles = bottleMapper.selectList(queryWrapper);
        for (Bottle bottle: bottles) {
            User user = userMapper.selectById(bottle.getUId());
            bottle.setUser(user);
        }
        return bottles;
    }
}
