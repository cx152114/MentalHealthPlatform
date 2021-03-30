package com.dlt.sys.entity;

import java.math.BigDecimal;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableId;
import java.time.LocalDateTime;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 话术表
 * </p>
 *
 * @author cx
 * @since 2021-03-30
 */
@TableName("VERBAL_TRICK")
public class VerbalTrick implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 话术编号
     */
    @TableId("VERBAL_ID")
    private String verbalId;

    /**
     * 父节点
     */
    @TableField("PARENT_ID")
    private String parentId;

    /**
     * 话术内容
     */
    @TableField("VERBAL_CONTENT")
    private String verbalContent;

    /**
     * 交易名称
     */
    @TableField("TRAN_NAME")
    private String tranName;

    /**
     * 答案标识（用于区分话术支路  0：客户确认回答时 1：客户否认回答时）
     */
    @TableField("ANSWER_FLAG")
    private BigDecimal answerFlag;

    /**
     * 创建人
     */
    @TableField("CREATE_USERID")
    private String createUserid;

    /**
     * 修改人
     */
    @TableField("UPDATE_USERID")
    private String updateUserid;

    /**
     * 创建时间
     */
    @TableField("CREATE_TIME")
    private LocalDateTime createTime;

    /**
     * 修改时间
     */
    @TableField("UPDATE_TIME")
    private LocalDateTime updateTime;

    /**
     * 删除标志 0：正常使用 1：已删除 默认为0
     */
    @TableField("DELETE_FLAG")
    private BigDecimal deleteFlag;

    public String getVerbalId() {
        return verbalId;
    }

    public void setVerbalId(String verbalId) {
        this.verbalId = verbalId;
    }
    public String getParentId() {
        return parentId;
    }

    public void setParentId(String parentId) {
        this.parentId = parentId;
    }
    public String getVerbalContent() {
        return verbalContent;
    }

    public void setVerbalContent(String verbalContent) {
        this.verbalContent = verbalContent;
    }
    public String getTranName() {
        return tranName;
    }

    public void setTranName(String tranName) {
        this.tranName = tranName;
    }
    public BigDecimal getAnswerFlag() {
        return answerFlag;
    }

    public void setAnswerFlag(BigDecimal answerFlag) {
        this.answerFlag = answerFlag;
    }
    public String getCreateUserid() {
        return createUserid;
    }

    public void setCreateUserid(String createUserid) {
        this.createUserid = createUserid;
    }
    public String getUpdateUserid() {
        return updateUserid;
    }

    public void setUpdateUserid(String updateUserid) {
        this.updateUserid = updateUserid;
    }
    public LocalDateTime getCreateTime() {
        return createTime;
    }

    public void setCreateTime(LocalDateTime createTime) {
        this.createTime = createTime;
    }
    public LocalDateTime getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(LocalDateTime updateTime) {
        this.updateTime = updateTime;
    }
    public BigDecimal getDeleteFlag() {
        return deleteFlag;
    }

    public void setDeleteFlag(BigDecimal deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    @Override
    public String toString() {
        return "VerbalTrick{" +
            "verbalId=" + verbalId +
            ", parentId=" + parentId +
            ", verbalContent=" + verbalContent +
            ", tranName=" + tranName +
            ", answerFlag=" + answerFlag +
            ", createUserid=" + createUserid +
            ", updateUserid=" + updateUserid +
            ", createTime=" + createTime +
            ", updateTime=" + updateTime +
            ", deleteFlag=" + deleteFlag +
        "}";
    }
}
