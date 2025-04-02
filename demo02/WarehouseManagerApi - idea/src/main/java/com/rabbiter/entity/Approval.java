package com.rabbiter.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("approval")
public class Approval {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer goodsId;
    private Integer purchase_id;
    private Integer userId;
    private Integer adminId;
    private Integer actionType;
    private Integer requestCount;
    private Integer status;
    private LocalDateTime applyTime;
    private LocalDateTime approveTime;
    private String remark;
}