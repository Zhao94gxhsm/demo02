package com.rabbiter.service.Impl;

import com.rabbiter.entity.InventoryWarning;
import com.rabbiter.mapper.InventoryWarningMapper;
import com.rabbiter.service.InventoryWarningService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

@Service
public class InventoryWarningServiceImpl extends ServiceImpl<InventoryWarningMapper, InventoryWarning> implements InventoryWarningService {
}