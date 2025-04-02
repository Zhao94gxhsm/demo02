package com.rabbiter.controller;

import com.rabbiter.entity.Approval;
import com.rabbiter.entity.Goods;
import com.rabbiter.entity.Record;
import com.rabbiter.service.ApprovalService;
import com.rabbiter.service.GoodsService;
import com.rabbiter.service.PurchaseService;
import com.rabbiter.service.RecordService;
import com.rabbiter.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/approval")
public class ApprovalController {

    @Autowired
    private ApprovalService approvalService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private RecordService recordService;

    // 获取所有审批记录
    @GetMapping
    public Result<List<Approval>> getAllApprovals() {
        List<Approval> approvals = approvalService.list();
        return Result.success(approvals);
    }

    // 新增审批记录
    @PostMapping
    public Result<Approval> saveApproval(@RequestBody Approval approval) {
        approval.setApplyTime(LocalDateTime.now());
        approval.setStatus(0); // 新增审批记录默认状态为待审批
        approvalService.save(approval);

        // 智能提醒：如果是出库申请且库存接近下限，给出警告
        if (approval.getActionType() == 1) {
            Goods goods = goodsService.getById(approval.getGoodsId());
            if (goods != null && goods.getCount() - approval.getRequestCount() < goods.getLowStockThreshold()) {
                // 这里可以添加发送通知的逻辑，例如短信、邮件等
                System.out.println("警告：出库申请可能导致库存低于下限！商品：" + goods.getName());
            }
        }

        return Result.success(approval);
    }

    // 更新审批记录
    @PutMapping
    public Result<Approval> updateApproval(@RequestBody Approval approval) {
        approval.setApproveTime(LocalDateTime.now());
        approvalService.updateById(approval);
        if (approval.getStatus() == 1) {
            Goods goods = goodsService.getById(approval.getGoodsId());
            if (approval.getActionType() == 1) {
                if (goods != null && goods.getCount() >= approval.getRequestCount()) {
                    goods.setCount(goods.getCount() - approval.getRequestCount());
                    goodsService.updateById(goods);
                    createRecord(goods, approval.getRequestCount(), "出库审批通过：" + goods.getName());
                } else {
                    // 库存不足，更新审批状态为已拒绝
                    approval.setStatus(2);
                    approvalService.updateById(approval);
                    return Result.fail("库存不足，审批拒绝");
                }
            } else if (approval.getActionType() == 2) {
                if (goods != null) {
                    goods.setCount(goods.getCount() + approval.getRequestCount());
                    goodsService.updateById(goods);
                    createRecord(goods, approval.getRequestCount(), "入库审批通过：" + goods.getName());
                }
            } else if (approval.getActionType() == 3) {
                createRecord(goods, approval.getRequestCount(), "采购审批通过：" + goods.getName());
                if (approval.getPurchase_id() != null) {
                    purchaseService.updateApprovedStatus(approval.getPurchase_id(), 1);
                    // 启动采购流程
                    purchaseService.startPurchase(approval.getPurchase_id());
                }
            }
        } else if (approval.getStatus() == 2) {
            if (approval.getActionType() == 3 && approval.getPurchase_id() != null) {
                purchaseService.cancelPurchase(approval.getPurchase_id());
            }
        }
        return Result.success(approval);
    }

    // 删除审批记录
    @DeleteMapping("/{id}")
    public Result<String> deleteApproval(@PathVariable Integer id) {
        approvalService.removeById(id);
        return Result.success("删除成功");
    }

    private void createRecord(Goods goods, Integer count, String remark) {
        Record record = new Record();
        record.setGoods(goods.getId());
        record.setUserid(null);
        record.setAdminId(null);
        record.setCount(count);
        record.setCreatetime(LocalDateTime.now());
        record.setRemark(remark);
        recordService.save(record);
    }
}