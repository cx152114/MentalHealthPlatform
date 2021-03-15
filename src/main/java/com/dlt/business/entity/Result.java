package com.dlt.business.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
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

    public Integer getResultId() {
        return resultId;
    }

    public void setResultId(Integer resultId) {
        this.resultId = resultId;
    }
    public Integer getuId() {
        return uId;
    }

    public void setuId(Integer uId) {
        this.uId = uId;
    }
    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getSuggest() {
        return suggest;
    }

    public void setSuggest(String suggest) {
        this.suggest = suggest;
    }
    public String getResultLevel() {
        return resultLevel;
    }

    public void setResultLevel(String resultLevel) {
        this.resultLevel = resultLevel;
    }
    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
    }

    @Override
    public String toString() {
        return "Result{" +
            "resultId=" + resultId +
            ", uId=" + uId +
            ", score=" + score +
            ", description=" + description +
            ", suggest=" + suggest +
            ", resultLevel=" + resultLevel +
            ", examType=" + examType +
        "}";
    }
}
