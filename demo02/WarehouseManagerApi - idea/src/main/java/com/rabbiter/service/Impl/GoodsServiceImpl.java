package com.rabbiter.service.Impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.rabbiter.entity.Goods;
import com.rabbiter.mapper.GoodsMapper;
import com.rabbiter.service.GoodsService;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class GoodsServiceImpl extends ServiceImpl<GoodsMapper, Goods> implements GoodsService {

    @Override
    public IPage pageCC(IPage<Goods> page, Wrapper wrapper) {
        return baseMapper.selectPage(page, wrapper);
    }

    @Override
    public Map<Integer, String> getGoodsNameMap() {
        List<Goods> goodsList = list();
        Map<Integer, String> goodsNameMap = new HashMap<>();
        for (Goods goods : goodsList) {
            goodsNameMap.put(goods.getId(), goods.getName());
        }
        return goodsNameMap;
    }

    @Override
    public boolean updateStock(Integer goodsId, Integer newStock) {
        Goods goods = getById(goodsId);
        if (goods != null) {
            goods.setCount(goods.getCount() + newStock);
            return updateById(goods);
        }
        return false;
    }

    @Override
    public boolean checkStock(Integer goodsId, Integer quantity, Integer actionType) {
        Goods goods = getById(goodsId);
        if (actionType == 1 && goods.getCount() < quantity) {
            return false;
        }
        return true;
    }
}