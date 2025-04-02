package com.rabbiter.service.Impl;

import com.rabbiter.entity.Purchase;
import com.rabbiter.mapper.PurchaseMapper;
import com.rabbiter.service.PurchaseService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class PurchaseServiceImpl extends ServiceImpl<PurchaseMapper, Purchase> implements PurchaseService {

    @Override
    public void updateApprovedStatus(Integer purchaseId, Integer approved) {
        Purchase purchase = getById(purchaseId);
        if (purchase != null) {
            purchase.setApproved(approved);
            updateById(purchase);
        }
    }

    @Override
    public void startPurchase(Integer purchaseId) {
        Purchase purchase = getById(purchaseId);
        if (purchase != null) {
            purchase.setStatus(1); // 采购中
            updateById(purchase);
        }
    }

    @Override
    public void cancelPurchase(Integer purchaseId) {
        Purchase purchase = getById(purchaseId);
        if (purchase != null) {
            purchase.setStatus(3); // 已取消
            purchase.setApproved(0);
            updateById(purchase);
        }
    }
}