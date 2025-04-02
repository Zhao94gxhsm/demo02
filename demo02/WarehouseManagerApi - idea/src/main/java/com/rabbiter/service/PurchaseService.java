package com.rabbiter.service;

import com.rabbiter.entity.Purchase;
import com.baomidou.mybatisplus.extension.service.IService;

public interface PurchaseService extends IService<Purchase> {
    void updateApprovedStatus(Integer purchaseId, Integer approved);
    void startPurchase(Integer purchaseId);
    void cancelPurchase(Integer purchaseId);
}