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
 * @since 2021-03-02
 */
@TableName("business_exam")
public class Exam implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "business_id", type = IdType.AUTO)
    private Integer businessId;

    private String title;

    private String section1;

    private String section2;

    private String section3;

    private String section4;

    private String type;

    public Integer getBusinessId() {
        return businessId;
    }

    public void setBusinessId(Integer businessId) {
        this.businessId = businessId;
    }
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
    public String getSection1() {
        return section1;
    }

    public void setSection1(String section1) {
        this.section1 = section1;
    }
    public String getSection2() {
        return section2;
    }

    public void setSection2(String section2) {
        this.section2 = section2;
    }
    public String getSection3() {
        return section3;
    }

    public void setSection3(String section3) {
        this.section3 = section3;
    }
    public String getSection4() {
        return section4;
    }

    public void setSection4(String section4) {
        this.section4 = section4;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    @Override
    public String toString() {
        return "Exam{" +
            "businessId=" + businessId +
            ", title=" + title +
            ", section1=" + section1 +
            ", section2=" + section2 +
            ", section3=" + section3 +
            ", section4=" + section4 +
            ", type=" + type +
        "}";
    }
}
