package com.rabbiter.common;

/*
 * 返回前端统一数据的封装类
 * @author
 * @date 2023/1/2 20:36
 */
public class Result<T> {

    private int code;  //编码 200/400
    private String msg;  //成功/失败
    private Long total;  //总记录数
    private T data;  //数据

    public static <T> Result<T> fail() {
        return result(400, "失败", 0L, null);
    }

    // 添加接收 String 参数的 fail 方法
    public static <T> Result<T> fail(String msg) {
        return result(400, msg, 0L, null);
    }

    public static <T> Result<T> success() {
        return result(200, "成功", 0L, null);
    }

    public static <T> Result<T> success(T data) {
        return result(200, "成功", 0L, data);
    }

    public static <T> Result<T> success(T data, Long total) {
        return result(200, "成功", total, data);
    }

    private static <T> Result<T> result(int code, String msg, Long total, T data) {
        Result<T> res = new Result<>();
        res.setData(data);
        res.setMsg(msg);
        res.setCode(code);
        res.setTotal(total);
        return res;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Long getTotal() {
        return total;
    }

    public void setTotal(Long total) {
        this.total = total;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    @Override
    public String toString() {
        return "Result{" +
                "code=" + code +
                ", msg='" + msg + '\'' +
                ", total=" + total +
                ", data=" + data +
                '}';
    }
}