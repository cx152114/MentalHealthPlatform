package com.dlt.business.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.dlt.sys.entity.User;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@TableName("business_activity_apply")
@Data
public class ActivityApply implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "apply_id", type = IdType.AUTO)
    private Integer applyId;

    private Integer uId;


    private Integer activityId;


    private Integer applyStatus;

    @TableField(exist = false)
    private User user;

    @TableField(exist = false)
    private Activity activity;


}
