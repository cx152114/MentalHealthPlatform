package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.dlt.business.entity.Message;
import com.dlt.business.mapper.MessageMapper;
import com.dlt.business.service.IMessageService;
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
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements IMessageService {

    @Autowired
    private MessageMapper messageMapper;

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<Message> list(Wrapper<Message> queryWrapper) {
        List<Message> messageList = new ArrayList<>();
        messageList = messageMapper.selectList(queryWrapper);
        for (Message message : messageList) {
            User user = userMapper.selectById(message.getUId());
            message.setUser(user);
            User receiveUser = userMapper.selectById(message.getReceiveId());
            message.setReceiveUser(receiveUser);
        }
        return messageList;
    }
}
