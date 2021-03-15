package com.dlt.common.exception;

/**
 * 自定义业务异常
 * @author dlt
 */
public class BizException extends RuntimeException {

    public BizException(String message) {
        super(message);
    }
}
