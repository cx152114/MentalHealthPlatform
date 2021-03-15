package com.dlt.business.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDateTime;
import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 笑话表
 * </p>
 *
 * @author cx
 * @since 2021-02-24
 */
@TableName("business_joy")
@Data
public class Joy implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "joy_id", type = IdType.AUTO)
    private Integer joyId;

    private String joyType;

    private String joyTitle;

    private String joyContent;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date joyDate;

    private String joyUrl;

    private String answer;


}
