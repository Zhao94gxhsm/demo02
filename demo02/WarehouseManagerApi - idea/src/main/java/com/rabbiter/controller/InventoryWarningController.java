package com.rabbiter.controller;

import com.rabbiter.entity.InventoryWarning;
import com.rabbiter.service.InventoryWarningService;
import com.rabbiter.service.GoodsService;
import com.rabbiter.common.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.rabbiter.common.QueryPageParam;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/inventoryWarning")
public class InventoryWarningController {

    @Autowired
    private InventoryWarningService inventoryWarningService;

    @Autowired
    private GoodsService goodsService;

    // 获取所有库存预警记录
    @GetMapping
    public Result<List<Map<String, Object>>> getAllWarnings() {
        List<InventoryWarning> warnings = inventoryWarningService.list();
        Map<Integer, String> goodsNameMap = goodsService.getGoodsNameMap();
        List<Map<String, Object>> resultList = new java.util.ArrayList<>();
        for (InventoryWarning warning : warnings) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", warning.getId());
            map.put("goodsName", goodsNameMap.get(warning.getGoodsId()));
            map.put("warningType", warning.getWarningType());
            map.put("threshold", warning.getThreshold());
            map.put("currentCount", warning.getCurrentCount());
            map.put("occurTime", warning.getOccurTime());
            map.put("isHandled", warning.getIsHandled());
            if (warning.getIsHandled() == 0) {
                map.put("suggestion", getSuggestion(warning));
            }
            resultList.add(map);
        }
        return Result.success(resultList);
    }

    // 新增库存预警记录
    @PostMapping
    public Result<InventoryWarning> saveWarning(@RequestBody InventoryWarning inventoryWarning) {
        inventoryWarning.setOccurTime(LocalDateTime.now());
        inventoryWarning.setIsHandled(0); // 新增预警记录默认未处理
        inventoryWarningService.save(inventoryWarning);

        // 智能提醒：发送预警通知
        sendWarningNotification(inventoryWarning);

        return Result.success(inventoryWarning);
    }

    // 更新库存预警记录
    @PutMapping
    public Result<InventoryWarning> updateWarning(@RequestBody InventoryWarning inventoryWarning) {
        inventoryWarningService.updateById(inventoryWarning);
        return Result.success(inventoryWarning);
    }

    // 删除库存预警记录
    @DeleteMapping("/{id}")
    public Result<String> deleteWarning(@PathVariable Integer id) {
        inventoryWarningService.removeById(id);
        return Result.success("删除成功");
    }

    // 分页获取未处理的库存预警记录
    @PostMapping("/unhandled/listPage")
    public Result listUnhandledPage(@RequestBody QueryPageParam query) {
        Page<InventoryWarning> page = new Page<>();
        page.setCurrent(query.getPageNum());
        page.setSize(query.getPageSize());

        IPage result = inventoryWarningService.lambdaQuery()
                .eq(InventoryWarning::getIsHandled, 0)
                .page(page);
        return Result.success(result.getRecords(), result.getTotal());
    }

    private String getSuggestion(InventoryWarning warning) {
        if (warning.getWarningType() == 1) {
            return "建议采购数量：" + (warning.getThreshold() - warning.getCurrentCount());
        } else {
            return "建议出库数量：" + (warning.getCurrentCount() - warning.getThreshold());
        }
    }

    private void sendWarningNotification(InventoryWarning warning) {
        // 这里可以实现发送预警通知的逻辑，例如短信、邮件等
        System.out.println("库存预警：商品ID " + warning.getGoodsId() + " 触发了 " + (warning.getWarningType() == 1 ? "低库存" : "高库存") + " 预警！");
    }
}