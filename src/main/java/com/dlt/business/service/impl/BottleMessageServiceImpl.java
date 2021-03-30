package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.BottleMessage;
import com.dlt.business.entity.Comment;
import com.dlt.business.mapper.BottleMessageMapper;
import com.dlt.business.mapper.CommentMapper;
import com.dlt.business.service.IBottleMessageService;
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
public class BottleMessageServiceImpl extends ServiceImpl<BottleMessageMapper, BottleMessage> implements IBottleMessageService {

    @Autowired
    private BottleMessageMapper bottleMessageMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<BottleMessage> selectTargetBottleMessages(Wrapper<BottleMessage> queryWrapper) {
        List<BottleMessage> bottleMessageList = new ArrayList<>();
        bottleMessageList = bottleMessageMapper.selectList(queryWrapper);
        for (BottleMessage bottleMessage:bottleMessageList) {
            User sendUser = userMapper.selectById(bottleMessage.getSendId());
            User receiveUser = userMapper.selectById(bottleMessage.getReceiveId());
            bottleMessage.setSendUser(sendUser);
            bottleMessage.setReceiveUser(receiveUser);
        }
        return bottleMessageList;
    }
}
