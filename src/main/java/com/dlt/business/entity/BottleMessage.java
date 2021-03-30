package com.dlt.business.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.dlt.sys.entity.User;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author cx
 * @since 2021-03-03
 */
@TableName("business_bottle_message")
@Data
public class BottleMessage implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "bm_id", type = IdType.AUTO)
    private Integer bmId;

    private String content;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    private Integer sendId;

    private String receiveId;

    private Integer bottleId;

    @TableField(exist = false)
    private User sendUser;

    @TableField(exist = false)
    private User receiveUser;


}
