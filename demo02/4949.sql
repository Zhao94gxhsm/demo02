/*
 Navicat Premium Dump SQL

 Source Server         : zhouhao
 Source Server Type    : MySQL
 Source Server Version : 80041 (8.0.41)
 Source Host           : localhost:3306
 Source Schema         : dddd

 Target Server Type    : MySQL
 Target Server Version : 80041 (8.0.41)
 File Encoding         : 65001

 Date: 22/02/2025 20:13:18
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '货名',
  `storage` int NOT NULL COMMENT '仓库',
  `goodsType` int NOT NULL COMMENT '分类',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (13, '雷赛伺服电机', 9, 1, 35, '');
INSERT INTO `goods` VALUES (14, '禾川伺服电机', 9, 4, 78, '');
INSERT INTO `goods` VALUES (15, '汇川/inovance伺服电机', 9, 6, 49, '');
INSERT INTO `goods` VALUES (16, '雷赛步进电机', 10, 1, 404, '');
INSERT INTO `goods` VALUES (17, '禾川步进电机', 10, 4, 700, '');
INSERT INTO `goods` VALUES (18, '汇川/inovance步进电机', 10, 6, 102, '');
INSERT INTO `goods` VALUES (19, '雷赛伺服驱动', 1, 13, 222, '');
INSERT INTO `goods` VALUES (20, '禾川伺服驱动', 1, 15, 100, '');
INSERT INTO `goods` VALUES (21, ' 汇川/inovance伺服驱动', 1, 17, 200, '');
INSERT INTO `goods` VALUES (22, '雷赛步进驱动', 8, 13, 3000, '');
INSERT INTO `goods` VALUES (23, '禾川步进驱动', 8, 15, 2001, '');
INSERT INTO `goods` VALUES (24, '汇川/inovance步进驱动', 8, 17, 1002, '');
INSERT INTO `goods` VALUES (25, '雷子科技模组（0.7*1.4）', 11, 18, 200, '');
INSERT INTO `goods` VALUES (26, '雷子科技模组（0.9*1.7）', 11, 18, 300, '');
INSERT INTO `goods` VALUES (27, '雷子科技模组（1.4*2.3）', 11, 18, 100, '');
INSERT INTO `goods` VALUES (28, '雷子科技模组（2.2*3.6）', 11, 18, 65, '');
INSERT INTO `goods` VALUES (29, '雷赛科技三轴步进控制卡', 13, 22, 1000, '');
INSERT INTO `goods` VALUES (30, '雷赛科技三轴伺服控制卡', 12, 24, 600, '');
INSERT INTO `goods` VALUES (31, '雷赛科技四轴步进控制卡', 13, 22, 200, '');
INSERT INTO `goods` VALUES (32, '雷赛科技四轴伺服控制卡', 12, 24, 103, '');
INSERT INTO `goods` VALUES (33, '雷赛科技五轴伺服控制卡', 12, 24, 65, '');
INSERT INTO `goods` VALUES (34, '雷赛科技六轴伺服控制卡', 12, 24, 34, '');
INSERT INTO `goods` VALUES (35, '雷赛科技七轴伺服控制卡', 12, 24, 65, '');
INSERT INTO `goods` VALUES (36, '创鑫*3000焊接光纤激光器', 14, 29, 76, '');
INSERT INTO `goods` VALUES (37, '创鑫*手持焊三合一MFSC 1500HW', 14, 30, 55, '');
INSERT INTO `goods` VALUES (38, '创鑫*手持焊三合一MFSC 2000HW', 14, 30, 34, '');
INSERT INTO `goods` VALUES (39, '嘉强*BF330-C振镜激光器', 14, 32, 23, '');
INSERT INTO `goods` VALUES (40, '嘉强*BF450-B振镜激光器', 14, 32, 55, '');
INSERT INTO `goods` VALUES (41, '内六角螺丝（M4*0.7）', 15, 41, 76, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (42, '内六角螺丝（M4*0.9）', 15, 41, 55, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (43, '内六角螺丝（M4*1.2）', 15, 41, 56, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (44, '内六角螺丝（M4*1.6）', 15, 41, 76, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (45, '内六角螺丝（M6*0.7）', 15, 41, 434, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (46, '内六角螺丝（M6*1.2）', 15, 41, 66, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (47, '内六角螺丝（M6*1.6）', 15, 41, 8, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (48, '内六角螺丝（M6*2.2）', 15, 41, 2, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (49, '内六角螺丝（M8*3.6）', 15, 41, 32, '单位：盒\n请按需出库');
INSERT INTO `goods` VALUES (50, '缠胶带（1.0）/20m', 15, 43, 23, '单位：捆\n请按需出库');
INSERT INTO `goods` VALUES (51, '缠胶带（3.0）/20m', 15, 43, 22, '单位：捆\n请按需出库');

-- ----------------------------
-- Table structure for goodstype
-- ----------------------------
DROP TABLE IF EXISTS `goodstype`;
CREATE TABLE `goodstype`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '分类名',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 44 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of goodstype
-- ----------------------------
INSERT INTO `goodstype` VALUES (1, '雷赛电机', '');
INSERT INTO `goodstype` VALUES (4, '禾川电机', '');
INSERT INTO `goodstype` VALUES (6, '汇川/inovance电机', '');
INSERT INTO `goodstype` VALUES (13, '雷赛驱动', '');
INSERT INTO `goodstype` VALUES (15, '禾川驱动', '');
INSERT INTO `goodstype` VALUES (17, '汇川/inovance驱动', '');
INSERT INTO `goodstype` VALUES (18, '雷子科技模组（行程尺寸）', '');
INSERT INTO `goodstype` VALUES (22, '雷赛科技步进控制卡', '');
INSERT INTO `goodstype` VALUES (24, '雷赛科技伺服控制卡', '');
INSERT INTO `goodstype` VALUES (29, '创鑫*光纤激光器', '');
INSERT INTO `goodstype` VALUES (30, '创鑫*手持焊三合一', '');
INSERT INTO `goodstype` VALUES (32, '嘉强*振镜激光器', '');
INSERT INTO `goodstype` VALUES (41, '内六角螺丝（规格）', '');
INSERT INTO `goodstype` VALUES (43, '缠胶带（规格）', '');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu`  (
  `id` int NOT NULL COMMENT '主键',
  `menuCode` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单编码',
  `menuName` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单名字',
  `menuLevel` varchar(2) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单级别',
  `menuParentCode` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单的父code',
  `menuClick` varchar(16) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '点击触发的函数',
  `menuRight` varchar(8) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '权限 0超级管理员，1表示管理员，2表示普通用户，可以用逗号组合使用',
  `menuComponent` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '对应Vue菜单组件',
  `menuIcon` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES (1, '001', '管理员信息管理', '1', NULL, 'Admin', '0', 'admin/AdminManage.vue', 'iconfont icon-r-setting');
INSERT INTO `menu` VALUES (2, '002', '用户信息管理', '1', NULL, 'User', '0,1', 'user/UserManage.vue', 'iconfont icon-r-user1');
INSERT INTO `menu` VALUES (3, '003', '仓库信息管理', '1', NULL, 'Storage', '0,1', 'storage/StorageManage', 'iconfont icon-r-shield');
INSERT INTO `menu` VALUES (4, '004', '物品分类管理', '1', NULL, 'Goodstype', '0,1', 'goodstype/GoodstypeManage', 'iconfont icon-r-list');
INSERT INTO `menu` VALUES (5, '005', '物品信息管理 ', '1', NULL, 'Goods', '0,1,2', 'goods/GoodsManage', 'iconfont icon-r-mark1');
INSERT INTO `menu` VALUES (6, '006', '操作日志', '1', NULL, 'Record', '0,1,2', 'record/RecordManage', 'iconfont icon-r-paper');

-- ----------------------------
-- Table structure for record
-- ----------------------------
DROP TABLE IF EXISTS `record`;
CREATE TABLE `record`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods` int NOT NULL COMMENT '货品id',
  `userId` int NULL DEFAULT NULL COMMENT '取货人/补货人',
  `admin_id` int NULL DEFAULT NULL COMMENT '操作人id',
  `count` int NULL DEFAULT NULL COMMENT '数量',
  `createtime` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of record
-- ----------------------------
INSERT INTO `record` VALUES (1, 1, 3, 2, 100, '2023-01-06 20:46:48', '取货');
INSERT INTO `record` VALUES (12, 1, 3, 1, -5, '2023-01-19 15:32:27', '');
INSERT INTO `record` VALUES (15, 4, 3, 1, 100, '2023-06-11 21:08:13', '');
INSERT INTO `record` VALUES (16, 4, 3, 1, -50, '2023-06-11 21:08:25', '');
INSERT INTO `record` VALUES (17, 4, 3, 1, 100, '2023-06-11 21:17:24', '');
INSERT INTO `record` VALUES (18, 4, 3, 1, -200, '2023-06-11 21:17:33', '');
INSERT INTO `record` VALUES (19, 4, 3, 1, 100, '2023-08-06 11:15:11', '');
INSERT INTO `record` VALUES (20, 13, 3, 1, -10, '2025-02-22 19:06:39', 'a');

-- ----------------------------
-- Table structure for storage
-- ----------------------------
DROP TABLE IF EXISTS `storage`;
CREATE TABLE `storage`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '仓库名',
  `remark` varchar(1000) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of storage
-- ----------------------------
INSERT INTO `storage` VALUES (1, '伺服驱动仓库', '伺服和步进驱动和电机需要配套使用！');
INSERT INTO `storage` VALUES (8, '步进驱动仓库', '伺服和步进驱动和电机需要配套使用！');
INSERT INTO `storage` VALUES (9, '伺服电机仓库', '伺服和步进驱动和电机需要配套使用！');
INSERT INTO `storage` VALUES (10, '步进电机仓库', '伺服和步进驱动和电机需要配套使用！');
INSERT INTO `storage` VALUES (11, '模组仓库', '需要选定合适尺寸的模组！');
INSERT INTO `storage` VALUES (12, '伺服控制卡仓库', '伺服配套大功率激光器！');
INSERT INTO `storage` VALUES (13, '步进控制卡仓库', '步进配套手持焊以及小功率激光器使用！');
INSERT INTO `storage` VALUES (14, '激光器仓库', '需要明确配套功率大小！');
INSERT INTO `storage` VALUES (15, '配件仓库', '明确规格！');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `no` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '账号',
  `name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '名字',
  `password` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `age` int NULL DEFAULT NULL COMMENT '年龄',
  `sex` int NULL DEFAULT NULL COMMENT '性别',
  `phone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '电话',
  `role_id` int NULL DEFAULT NULL COMMENT '角色 0超级管理员，1管理员，2普通账号',
  `isValid` varchar(4) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT 'Y' COMMENT '是否有效，Y有效，其他无效',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'superadmin', '周总', '123456', 18, 1, '18855079621', 0, 'Y');
INSERT INTO `user` VALUES (2, 'admin', '小安', '123456', 19, 0, '18855079621', 1, 'Y');
INSERT INTO `user` VALUES (3, 'user11', '小周', '123456', 23, 1, '13392720289', 2, 'Y');
INSERT INTO `user` VALUES (18, 'user12', '小王', '123456', 22, 1, '19960228098', 2, 'Y');

-- 智能采购管理表
CREATE TABLE `purchase` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int NOT NULL COMMENT '物品ID',
  `plan_count` int NOT NULL COMMENT '计划采购数量',
  `actual_count` int DEFAULT NULL COMMENT '实际入库数量',
  `supplier` varchar(100) DEFAULT NULL COMMENT '供应商',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0:待采购 1:采购中 2:已完成 3:已取消',
  `approved` tinyint NOT NULL DEFAULT '0' COMMENT '是否审批通过 0:未审批 1:已审批',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `expected_time` datetime DEFAULT NULL COMMENT '预计到货时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `user_name` varchar(100) NULL COMMENT '申请人姓名',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`goods_id`) REFERENCES `goods`(`id`)
) ENGINE=InnoDB COMMENT='智能采购计划表';

-- 智能审批管理表
CREATE TABLE `approval` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int NOT NULL COMMENT '物品ID',
  `purchase_id` int DEFAULT NULL COMMENT '关联的采购计划 ID',
  `user_name` varchar(100) NULL COMMENT '申请人姓名',
  `admin_name` varchar(100) NULL COMMENT '审批人姓名',
  `action_type` tinyint NOT NULL COMMENT '操作类型 1:出库 2:入库 3:采购',
  `request_count` int NOT NULL COMMENT '申请数量',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '状态 0:待审批 1:已批准 2:已拒绝 3:已完成',
  `apply_time` datetime NOT NULL COMMENT '申请时间',
  `approve_time` datetime DEFAULT NULL COMMENT '审批时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`goods_id`) REFERENCES `goods`(`id`),
  FOREIGN KEY (`purchase_id`) REFERENCES `purchase`(`id`)
) ENGINE=InnoDB COMMENT='智能审批记录表';

-- 智能库存预警表
CREATE TABLE `inventory_warning` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `goods_id` int NOT NULL COMMENT '物品ID',
  `warning_type` tinyint NOT NULL COMMENT '预警类型 1:低库存 2:高库存',
  `threshold` int NOT NULL COMMENT '阈值',
  `current_count` int NOT NULL COMMENT '当前库存',
  `occur_time` datetime NOT NULL COMMENT '触发时间',
  `is_handled` tinyint NOT NULL DEFAULT '0' COMMENT '是否处理 0:未处理 1:已处理',
  `user_name` varchar(100) NULL COMMENT '申请人姓名',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`goods_id`) REFERENCES `goods`(`id`)
) ENGINE=InnoDB COMMENT='智能库存预警表';

-- 菜单权限配置
INSERT INTO `menu` VALUES 
(7, '007', '智能审批管理', '1', NULL, 'Approval', '0,1', 'approval/ApprovalManage', 'iconfont icon-r-lock'),
(8, '008', '智能采购管理', '1', NULL, 'Purchase', '0,1', 'purchase/PurchaseManage', 'iconfont icon-r-shield'),
(9, '009', '库存预警管理', '1', NULL, 'inventoryWarning', '0,1,2', 'inventorywarning/InventoryWarningmanage', 'iconfont icon-r-paper');

-- 备份原始表
CREATE TABLE approval_backup LIKE approval;
INSERT INTO approval_backup SELECT * FROM approval;

CREATE TABLE purchase_backup LIKE purchase;
INSERT INTO purchase_backup SELECT * FROM purchase;

CREATE TABLE inventory_warning_backup LIKE inventory_warning;
INSERT INTO inventory_warning_backup SELECT * FROM inventory_warning;

-- 修改表结构，删除 user_id 和 admin_id 字段，添加 user_name 和 admin_name 字段

ALTER TABLE purchase
DROP COLUMN user_id,
ADD COLUMN user_name VARCHAR(100) NULL COMMENT '申请人姓名';

ALTER TABLE inventory_warning
DROP COLUMN user_id,
ADD COLUMN user_name VARCHAR(100) NULL COMMENT '申请人姓名';

-- 更新数据，将 user_id 和 admin_id 替换为对应的 user_name 和 admin_name
UPDATE approval a
JOIN user u1 ON a.user_id = u1.id
LEFT JOIN user u2 ON a.admin_id = u2.id
SET a.user_name = u1.name,
    a.admin_name = u2.name;

UPDATE purchase p
JOIN user u ON p.user_id = u.id
SET p.user_name = u.name;

UPDATE inventory_warning iw
JOIN user u ON iw.user_id = u.id
SET iw.user_name = u.name;

-- 修改插入语句，使用 user_name 和 admin_name
-- 插入待审批的出库申请
INSERT INTO `approval` (`goods_id`, `purchase_id`, `user_name`, `admin_name`, `action_type`, `request_count`, `status`, `apply_time`, `remark`)
VALUES 
(13, NULL, (SELECT name FROM user WHERE id = 3), NULL, 1, 10, 0, NOW(), '生产领料申请'),
(14, NULL, (SELECT name FROM user WHERE id = 3), NULL, 1, 20, 0, NOW(), '设备维护领料'),
(16, NULL, (SELECT name FROM user WHERE id = 3), NULL, 1, 50, 0, NOW(), '客户订单发货');

-- 插入已批准的入库申请
INSERT INTO `approval` (`goods_id`, `purchase_id`, `user_name`, `admin_name`, `action_type`, `request_count`, `status`, `apply_time`, `approve_time`, `remark`)
VALUES 
(41, NULL, (SELECT name FROM user WHERE id = 2), (SELECT name FROM user WHERE id = 1), 2, 100, 1, NOW(), NOW(), '采购入库');

-- 插入已拒绝的采购申请
INSERT INTO `approval` (`goods_id`, `purchase_id`, `user_name`, `admin_name`, `action_type`, `request_count`, `status`, `apply_time`, `approve_time`, `remark`)
VALUES 
(46, NULL, (SELECT name FROM user WHERE id = 2), (SELECT name FROM user WHERE id = 1), 3, 200, 2, NOW(), NOW(), '供应商价格过高');

-- 插入待审批的采购计划
INSERT INTO `purchase` (`goods_id`, `plan_count`, `supplier`, `status`, `approved`, `create_time`, `expected_time`, `remark`, `user_name`)
VALUES 
(13, 50, '雷赛科技', 0, 0, NOW(), DATE_ADD(NOW(), INTERVAL 7 DAY), '伺服电机补充库存', (SELECT name FROM user WHERE id = 3)),
(16, 100, '禾川电机', 0, 0, NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY), '步进电机批量采购', (SELECT name FROM user WHERE id = 3));

-- 插入已审批的采购中记录
INSERT INTO `purchase` (`goods_id`, `plan_count`, `supplier`, `status`, `approved`, `create_time`, `expected_time`, `remark`, `user_name`)
VALUES 
(41, 200, '五金配件供应商', 1, 1, NOW(), DATE_ADD(NOW(), INTERVAL 3 DAY), '内六角螺丝采购', (SELECT name FROM user WHERE id = 2));

-- 插入已完成的采购记录
INSERT INTO `purchase` (`goods_id`, `plan_count`, `actual_count`, `supplier`, `status`, `approved`, `create_time`, `expected_time`, `remark`, `user_name`)
VALUES 
(46, 150, 150, '标准件公司', 2, 1, NOW(), NOW(), '内六角螺丝到货', (SELECT name FROM user WHERE id = 2));

-- 插入低库存预警（current_count < threshold）
INSERT INTO `inventory_warning` (`goods_id`, `warning_type`, `threshold`, `current_count`, `occur_time`, `is_handled`, `user_name`)
VALUES 
(13, 1, 50, 35, NOW(), 0, (SELECT name FROM user WHERE id = 3)),  -- 雷赛伺服电机库存不足
(47, 1, 20, 8, NOW(), 0, (SELECT name FROM user WHERE id = 3));   -- 内六角螺丝（M6*1.6）库存不足

-- 插入高库存预警（current_count > threshold）
INSERT INTO `inventory_warning` (`goods_id`, `warning_type`, `threshold`, `current_count`, `occur_time`, `is_handled`, `user_name`)
VALUES 
(22, 2, 1000, 3000, NOW(), 0, (SELECT name FROM user WHERE id = 3)),  -- 雷赛步进驱动库存过高
(23, 2, 1500, 2001, NOW(), 0, (SELECT name FROM user WHERE id = 3));  -- 禾川步进驱动库存过高

-- 修改触发器
DELIMITER //
CREATE TRIGGER create_purchase_on_warning
AFTER INSERT ON inventory_warning
FOR EACH ROW
BEGIN
    IF NEW.warning_type = 1 THEN
        -- 创建采购计划
        INSERT INTO purchase (goods_id, plan_count, create_time, approved, user_name)
        VALUES (NEW.goods_id, NEW.threshold - NEW.current_count, NOW(), 0, NEW.user_name);

        -- 获取新创建的采购计划 ID
        SET @purchase_id = LAST_INSERT_ID();

        -- 创建审批记录
        INSERT INTO approval (goods_id, user_name, admin_name, action_type, request_count, status, apply_time, purchase_id)
        VALUES (NEW.goods_id, NEW.user_name, NULL, 3, NEW.threshold - NEW.current_count, 0, NOW(), @purchase_id);
    END IF;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER update_inventory_on_approval
AFTER UPDATE ON approval
FOR EACH ROW
BEGIN
    IF NEW.status = 1 THEN
        IF NEW.action_type = 1 THEN -- 出库
            UPDATE goods SET count = count - NEW.request_count WHERE id = NEW.goods_id;
        ELSEIF NEW.action_type = 2 THEN -- 入库
            UPDATE goods SET count = count + NEW.request_count WHERE id = NEW.goods_id;
        ELSEIF NEW.action_type = 3 THEN -- 采购
            UPDATE purchase SET approved = 1, status = 1 WHERE id = NEW.purchase_id;
        END IF;
    ELSEIF NEW.status = 2 THEN -- 拒绝采购
        UPDATE purchase SET approved = 0, status = 3 WHERE id = NEW.purchase_id;
    END IF;
END //
DELIMITER ;

SET FOREIGN_KEY_CHECKS = 1;    