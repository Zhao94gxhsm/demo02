package com.rabbiter.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("inventory_warning")
public class InventoryWarning {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer goodsId;
    private Integer warningType;
    private Integer threshold;
    private Integer currentCount;
    private LocalDateTime occurTime;
    private Integer isHandled;
}