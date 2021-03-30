package com.dlt.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dlt.business.entity.Activity;
import com.dlt.business.entity.ActivityApply;
import com.dlt.business.mapper.ActivityApplyMapper;
import com.dlt.business.mapper.ActivityMapper;
import com.dlt.business.service.IActivityApplyService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dlt.business.service.IActivityService;
import com.dlt.sys.entity.User;
import com.dlt.sys.mapper.UserMapper;
import com.dlt.sys.service.IUserService;
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
public class ActivityApplyServiceImpl extends ServiceImpl<ActivityApplyMapper, ActivityApply> implements IActivityApplyService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ActivityApplyMapper activityApplyMapper;



    @Override
    public List<ActivityApply> list(Wrapper queryWrapper) {
        List<ActivityApply> arrayList = new ArrayList<ActivityApply>();
        arrayList = activityApplyMapper.selectList(queryWrapper);
        for (ActivityApply activityApply: arrayList) {
            User user = userMapper.selectById(activityApply.getUId());
            Activity activity = activityMapper.selectById(activityApply.getActivityId());
            activityApply.setUser(user);
            activityApply.setActivity(activity);
        }
        return arrayList;
    }

    @Override
    public boolean update(Wrapper<ActivityApply> updateWrapper, Integer applyId,Integer applyStatus) {
        ActivityApply activityApply = activityApplyMapper.selectById(applyId);
        activityApply.setApplyStatus(applyStatus);
        int update = activityApplyMapper.update(activityApply, updateWrapper);
        Activity activity = activityMapper.selectById(activityApply.getActivityId());
        if (update != 0) {
            if (activity.getRemainingCount() > 0) {
                int newRemainingCount = activity.getRemainingCount() - 1;
                activity.setRemainingCount(newRemainingCount);
                activityMapper.update(activity, new QueryWrapper<>());
            } else {
                return false;

            }
        }
        return true;
    }

    @Override
    public boolean remove(Integer applyId) {
        QueryWrapper queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("apply_id",applyId);
        int remove = activityApplyMapper.delete(queryWrapper);
        Activity activity = activityApplyMapper.selectById(applyId).getActivity();
        if (remove != 0) {
            if (activity.getRemainingCount() > 0) {
                int newRemainingCount = activity.getRemainingCount() + 1;
                activity.setRemainingCount(newRemainingCount);
                activityMapper.update(activity, new QueryWrapper<>());
            } else {
                return false;
            }
        }
        return true;
    }
}
