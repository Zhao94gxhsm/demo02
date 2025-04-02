package com.rabbiter.service;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.rabbiter.entity.Goods;
import com.baomidou.mybatisplus.extension.service.IService;
import java.util.Map;

public interface GoodsService extends IService<Goods> {
    IPage pageCC(IPage<Goods> page, Wrapper wrapper);
    Map<Integer, String> getGoodsNameMap();
    boolean updateStock(Integer goodsId, Integer newStock);
    boolean checkStock(Integer goodsId, Integer quantity, Integer actionType);
}