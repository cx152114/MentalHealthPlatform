package com.dlt.common.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

    /**
     * 功能描述: <br>
     * 〈〉
     * @Param: 日期转换成字符串
     * @Return:
     * @Author: dlt
     * @Date: 2021-02-02 23:41
     */
    public static String date2String(Date date, String patt) {
        SimpleDateFormat sdf = new SimpleDateFormat(patt);
        String format = sdf.format(date);
        return format;
    }

    /**
     * 功能描述: <br>字符串转换成日期
     * 〈〉
     * @Author: dlt
     * @Date: 2021-02-02 23:54
     */
    public static Date string2Date(String str, String patt) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat(patt);
        Date parse = sdf.parse(str);
        return parse;
    }
}
