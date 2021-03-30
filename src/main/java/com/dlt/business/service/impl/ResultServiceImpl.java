package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Result;
import com.dlt.business.mapper.ResultMapper;
import com.dlt.business.service.IResultService;
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
public class ResultServiceImpl extends ServiceImpl<ResultMapper, Result> implements IResultService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ResultMapper resultMapper;

    @Override
    public List<Result> list(Wrapper<Result> queryWrapper) {
        List<Result> results =new ArrayList<>();
        results = resultMapper.selectList(queryWrapper);
        for (Result result: results) {
            User user = userMapper.selectById(result.getUId());
            result.setUser(user);
        }
        return results;
    }
}
