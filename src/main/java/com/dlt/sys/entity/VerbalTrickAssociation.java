package com.dlt.sys.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 话术关联表
 * </p>
 *
 * @author cx
 * @since 2021-03-30
 */
@TableName("VERBAL_TRICK_ASSOCIATION")
public class VerbalTrickAssociation implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 编号
     */
    @TableId("ASSOCIATION_ID")
    private String associationId;

    /**
     * 话术编号
     */
    @TableField("VERBAL_ID")
    private String verbalId;

    /**
     * 替换字段
     */
    @TableField("REPLACE_VALUE")
    private String replaceValue;

    /**
     * 字典字段
     */
    @TableField("DIC_VALUE")
    private String dicValue;

    public String getAssociationId() {
        return associationId;
    }

    public void setAssociationId(String associationId) {
        this.associationId = associationId;
    }
    public String getVerbalId() {
        return verbalId;
    }

    public void setVerbalId(String verbalId) {
        this.verbalId = verbalId;
    }
    public String getReplaceValue() {
        return replaceValue;
    }

    public void setReplaceValue(String replaceValue) {
        this.replaceValue = replaceValue;
    }
    public String getDicValue() {
        return dicValue;
    }

    public void setDicValue(String dicValue) {
        this.dicValue = dicValue;
    }

    @Override
    public String toString() {
        return "VerbalTrickAssociation{" +
            "associationId=" + associationId +
            ", verbalId=" + verbalId +
            ", replaceValue=" + replaceValue +
            ", dicValue=" + dicValue +
        "}";
    }
}
