package com.dlt.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 用户与角色对应关系
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@TableName("sys_user_role")
@Data
public class UserRole implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Integer userId;

    /**
     * 角色ID
     */
    private Integer roleId;

    /**
     * 角色名称
     * 和数据库中的列没有对应关系
     */
    private String roleName;

}
