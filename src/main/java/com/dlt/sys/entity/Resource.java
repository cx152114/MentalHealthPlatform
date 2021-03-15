package com.dlt.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

import java.time.LocalDateTime;
import java.io.Serializable;

/**
 * <p>
 * 菜单管理
 * </p>
 *
 * @author cx
 * @since 2021-02-03
 */
@TableName("sys_resource")
@Data
public class Resource implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "resource_id", type = IdType.AUTO)
    private Integer resourceId;

    /**
     * 父资源ID，一级资源ID为0
     */
    private Integer parentId;

    /**
     * 资源名称
     */
    private String resourceName;

    private String path;

    /**
     * 菜单URL
     */
    private String url;

    /**
     * 授权(多个用逗号分隔，如：user:list,user:create)
     */
    private String permission;

    /**
     * 类型  -1：根目录  0：目录   1：菜单   2：按钮
     */
    private Integer type;

    /**
     * 资源图标
     */
    private String icon;

    /**
     * 排序
     */
    private Integer orderNum;

    private LocalDateTime createTime;

    private LocalDateTime updateTime;

}
