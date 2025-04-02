package com.rabbiter.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("purchase")
public class Purchase {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer goodsId;
    private Integer planCount;
    private Integer actualCount;
    private String supplier;
    private Integer status;
    private Integer approved;
    private LocalDateTime createTime;
    private LocalDateTime expectedTime;
    private String remark;
}