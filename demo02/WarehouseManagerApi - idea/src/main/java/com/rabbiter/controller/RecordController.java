package com.rabbiter.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.rabbiter.common.QueryPageParam;
import com.rabbiter.common.Result;
import com.rabbiter.entity.Goods;
import com.rabbiter.entity.Record;
import com.rabbiter.entity.Approval;
import com.rabbiter.service.GoodsService;
import com.rabbiter.service.RecordService;
import com.rabbiter.service.ApprovalService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;

@RestController
@RequestMapping("/record")
public class RecordController {
    @Autowired
    private RecordService recordService;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ApprovalService approvalService;

    @PostMapping("/listPage")
    public Result listPage(@RequestBody QueryPageParam query) {
        HashMap param = query.getParam();
        String name = (String) param.get("name");
        String goodstype = (String) param.get("goodstype");
        String storage = (String) param.get("storage");
        String roleId = (String) param.get("roleId");
        String userId = (String) param.get("userId");

        Page page = new Page();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());

        QueryWrapper<Record> queryWrapper = new QueryWrapper();
        queryWrapper.apply("a.goods=b.id and b.storage=c.id and b.goodsType=d.id ");

        if ("2".equals(roleId)) {
            queryWrapper.apply(" a.userId= " + userId);
        }

        if (StringUtils.isNotBlank(name) && !"null".equals(name)) {
            queryWrapper.like("b.name", name);
        }
        if (StringUtils.isNotBlank(goodstype) && !"null".equals(goodstype)) {
            queryWrapper.eq("d.id", goodstype);
        }
        if (StringUtils.isNotBlank(storage) && !"null".equals(storage)) {
            queryWrapper.eq("c.id", storage);
        }

        IPage result = recordService.pageCC(page, queryWrapper);
        return Result.success(result.getRecords(), result.getTotal());
    }

    @PostMapping("/save")
    public Result save(@RequestBody Record record) {
        Goods goods = goodsService.getById(record.getGoods());
        int n = record.getCount();
        if ("2".equals(record.getAction())) {
            n = -n;
            record.setCount(n);
        }

        int num = goods.getCount() + n;
        if (num < 0) {
            return Result.fail();
        }
        goods.setCount(num);
        goodsService.updateById(goods);
        record.setCreatetime(LocalDateTime.now());
        return recordService.save(record) ? Result.success() : Result.fail();
    }

    @PostMapping("/autoCreate")
    public Result autoCreateRecord(@RequestBody Record record) {
        if (record.getAction().equals("出库")) {
            if (goodsService.checkStock(record.getGoods(), record.getCount(), 1)) {
                Approval approval = new Approval();
                approval.setGoodsId(record.getGoods());
                approval.setUserId(record.getUserid());
                approval.setActionType(1);
                approval.setRequestCount(record.getCount());
                approval.setApplyTime(LocalDateTime.now());
                approvalService.save(approval);
                return Result.success("已提交出库审批，等待管理员处理");
            } else {
                return Result.fail("库存不足，无法出库");
            }
        }
        return Result.success();
    }
}