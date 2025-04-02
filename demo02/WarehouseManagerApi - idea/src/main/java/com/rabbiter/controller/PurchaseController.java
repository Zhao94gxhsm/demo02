package com.rabbiter.controller;

import com.rabbiter.entity.Purchase;
import com.rabbiter.entity.Approval;
import com.rabbiter.entity.Goods;
import com.rabbiter.entity.Record;
import com.rabbiter.service.GoodsService;
import com.rabbiter.service.PurchaseService;
import com.rabbiter.service.ApprovalService;
import com.rabbiter.service.RecordService;
import com.rabbiter.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private ApprovalService approvalService;

    @Autowired
    private RecordService recordService;

    // 获取所有采购记录
    @GetMapping
    public Result<List<Purchase>> getAllPurchases() {
        List<Purchase> purchases = purchaseService.list();
        return Result.success(purchases);
    }

    // 新增采购记录
    @PostMapping
    public Result<Purchase> savePurchase(@RequestBody Purchase purchase) {
        purchase.setCreateTime(LocalDateTime.now());
        purchase.setStatus(0); // 新增采购记录默认状态为待采购
        purchase.setApproved(0); // 新增采购记录默认未审批
        purchaseService.save(purchase);

        // 智能推荐供应商：根据历史采购记录推荐供应商
        String recommendedSupplier = getRecommendedSupplier(purchase.getGoodsId());
        if (recommendedSupplier != null) {
            purchase.setSupplier(recommendedSupplier);
            purchaseService.updateById(purchase);
        }

        // 创建采购审批记录
        Approval approval = new Approval();
        approval.setGoodsId(purchase.getGoodsId());
        approval.setPurchase_id(purchase.getId());
        approval.setActionType(3);
        approval.setRequestCount(purchase.getPlanCount());
        approval.setStatus(0);
        approval.setApplyTime(LocalDateTime.now());
        approvalService.save(approval);

        return Result.success(purchase);
    }

    // 更新采购记录
    @PutMapping
    public Result<Purchase> updatePurchase(@RequestBody Purchase purchase) {
        purchaseService.updateById(purchase);
        if (purchase.getStatus() == 2) {
            // 采购完成后更新库存
            goodsService.updateStock(purchase.getGoodsId(), purchase.getActualCount());

            // 自动创建入库审批
            Approval approval = new Approval();
            approval.setGoodsId(purchase.getGoodsId());
            approval.setActionType(2);
            approval.setRequestCount(purchase.getActualCount());
            approval.setStatus(1);
            approval.setApplyTime(LocalDateTime.now());
            approval.setApproveTime(LocalDateTime.now());
            approvalService.save(approval);

            // 创建记录
            createRecord(purchase);
        }
        return Result.success(purchase);
    }

    // 删除采购记录
    @DeleteMapping("/{id}")
    public Result<String> deletePurchase(@PathVariable Integer id) {
        purchaseService.removeById(id);
        return Result.success("删除成功");
    }

    private void createRecord(Purchase purchase) {
        Goods goods = goodsService.getById(purchase.getGoodsId());
        Record record = new Record();
        record.setGoods(goods.getId());
        record.setCount(purchase.getActualCount());
        record.setCreatetime(LocalDateTime.now());
        record.setRemark("采购入库：" + goods.getName() + "，采购单号：" + purchase.getId());
        recordService.save(record);
    }

    private String getRecommendedSupplier(Integer goodsId) {
        // 这里可以实现根据历史采购记录推荐供应商的逻辑
        // 例如从数据库中查询该商品的历史采购记录，选择最常用的供应商
        return null;
    }
}