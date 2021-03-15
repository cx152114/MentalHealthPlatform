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
 * 
 * </p>
 *
 * @author cx
 * @since 2021-03-01
 */
@TableName("business_activity")
@Data
public class Activity implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "activity_id", type = IdType.AUTO)
    private Integer activityId;

    private String title;

    private String descr;

    private String time;

    private Integer maxCount;

    private String address;

    private String sendName;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date activityDate;


}
