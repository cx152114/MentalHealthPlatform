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
@TableName("business_result")
@Data
public class Result implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "result_id", type = IdType.AUTO)
    private Integer resultId;

    /**
     * 用户编号
     */
    private Integer uId;

    /**
     * 分数
     */
    private Integer score;

    /**
     * 描述
     */
    private String description;

    /**
     * 建议
     */
    private String suggest;

    /**
     * 级别
     */
    private String resultLevel;

    /**
     * 测试类型
     */
    private String examType;

    @TableField(exist = false)
    private User user;

}
