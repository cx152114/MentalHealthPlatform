package com.dlt.sys.entity;

import lombok.Data;

/**
 * 菜单对象
 * @author 陈翔
 */
@Data
public class Menu {

    private Integer resourceId;
    private Integer parentId;
    private String resourceName;
    private String url;
    private String icon;

}
