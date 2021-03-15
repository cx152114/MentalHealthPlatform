package com.dlt.business.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author cx
 * @since 2021-02-14
 */
@TableName("business_article")
@Data
public class Article implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "article_id", type = IdType.AUTO)
    private Integer articleId;

    private Integer typeId;

    private String articleTitle;

    private String articleContent;

    @TableField("article_date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date articleDate;

    private Integer articleCount;

    private String author;


    @TableField(exist = false)
    private ArticleType articleType;


}
