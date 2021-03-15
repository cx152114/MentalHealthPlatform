package com.dlt.common.util;

import org.apache.shiro.crypto.hash.Md5Hash;

public class MD5Util {
    // 散列次数
    private static int hashIterations = 3;

    // 内置salt
    private static String public_salt = "958AEF84DB49419689159022A74D547E";

    /**
     * md5加密工具类
     * @param source 要用共盐加密的字符串
     * @return
     */
    private static String md5_public_salt(String source) {
        return new Md5Hash(source, public_salt, hashIterations).toString();
    }

    /**
     *
     * @param source 原始密码
     * @param salt 私盐
     * @return
     */
    public static String md5_private_salt(String source,String salt) {
        //1.先用共盐对原始密码加密
        //md5_public_salt(source);

        //2.再对加密的后密文用私盐加密一次
        return new Md5Hash(md5_public_salt(source), salt, hashIterations).toString();
    }
}