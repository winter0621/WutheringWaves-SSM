-- WutheringWaves Store teaching data
-- Run this file once after 01_schema.sql on an empty database.

USE wutheringwaves;

-- All teaching accounts use the password: password
INSERT INTO store_user
    (id, username, password_hash, display_name, role, status, email, phone)
VALUES
    (1, 'alice', '$2a$10$YG.W9uQrzg1sn0Mhpl9fnuGKR89F5QUtJeOuZVVEH7vxoF1LcqPsO', '漂泊者 Alice', 'CUSTOMER', 'ENABLED', 'alice@example.test', '13800000001'),
    (2, 'bob', '$2a$10$YG.W9uQrzg1sn0Mhpl9fnuGKR89F5QUtJeOuZVVEH7vxoF1LcqPsO', '漂泊者 Bob', 'CUSTOMER', 'ENABLED', 'bob@example.test', '13800000002'),
    (3, 'disabled', '$2a$10$YG.W9uQrzg1sn0Mhpl9fnuGKR89F5QUtJeOuZVVEH7vxoF1LcqPsO', '禁用教学账号', 'CUSTOMER', 'DISABLED', 'disabled@example.test', NULL),
    (4, 'admin', '$2a$10$YG.W9uQrzg1sn0Mhpl9fnuGKR89F5QUtJeOuZVVEH7vxoF1LcqPsO', '商城管理员', 'ADMIN', 'ENABLED', 'admin@example.test', NULL);

INSERT INTO category (id, code, parent_id, name, sort_order)
VALUES
    (1, 'CHARACTER_GOODS', NULL, '角色周边', 10),
    (2, 'FASHION', NULL, '服饰箱包', 20),
    (3, 'LIFESTYLE', NULL, '家居生活', 30),
    (4, 'DIGITAL', NULL, '数码配件', 40),
    (5, 'COLLECTION', NULL, '收藏模型', 50),
    (6, 'ACRYLIC', 1, '亚克力制品', 10),
    (7, 'BADGE', 1, '徽章与挂件', 20),
    (8, 'APPAREL', 2, '上衣与服饰', 10),
    (9, 'BAG', 2, '箱包与配饰', 20),
    (10, 'PLUSH', 3, '毛绒玩偶', 10),
    (11, 'HOME', 3, '杯具与摆件', 20),
    (12, 'PHONE', 4, '手机配件', 10),
    (13, 'DESK', 4, '桌面用品', 20),
    (14, 'FIGURE', 5, '手办模型', 10),
    (15, 'GIFT', 5, '典藏礼盒', 20);

INSERT INTO product
    (id, sku, category_id, name, summary, description, cover_image, price, stock, status, sort_order)
VALUES
    (1, 'WW-ACR-001', 6, '漂泊者主题亚克力立牌', '漂泊者主题双面亚克力立牌', '采用透明亚克力材质制作，适合桌面展示。', '/images/products/placeholder.png', 39.00, 19, 'ON_SALE', 10),
    (2, 'WW-ACR-002', 6, '秧秧主题亚克力立牌', '秧秧角色主题桌面摆件', '角色立绘与底座组合设计，附保护膜。', '/images/products/placeholder.png', 45.00, 19, 'ON_SALE', 20),
    (3, 'WW-ACR-003', 6, '忌炎主题亚克力立牌', '忌炎角色战斗姿态立牌', '适合收藏展示的角色主题亚克力制品。', '/images/products/placeholder.png', 42.00, 0, 'ON_SALE', 30),
    (4, 'WW-ACR-004', 6, '吟霖主题亚克力立牌', '吟霖角色主题立牌', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 49.00, 14, 'DRAFT', 40),
    (5, 'WW-ACR-005', 6, '今汐主题亚克力立牌', '今汐角色收藏立牌', '透明印刷与主题底座组合。', '/images/products/placeholder.png', 36.00, 1, 'ON_SALE', 50),
    (6, 'WW-ACR-006', 6, '长离主题亚克力立牌', '长离角色主题大尺寸立牌', '大尺寸桌面展示款，带独立底座。', '/images/products/placeholder.png', 55.00, 29, 'ON_SALE', 60),
    (7, 'WW-BDG-001', 7, '炽霞角色徽章', '炽霞主题圆形徽章', '金属背板搭配彩色印刷图案。', '/images/products/placeholder.png', 18.00, 18, 'ON_SALE', 10),
    (8, 'WW-BDG-002', 7, '白芷角色徽章', '白芷主题收藏徽章', '适合装饰背包或徽章展示板。', '/images/products/placeholder.png', 22.00, 19, 'ON_SALE', 20),
    (9, 'WW-BDG-003', 7, '相里要主题挂件', '相里要角色亚克力挂件', '双面印刷角色挂件，附金属扣。', '/images/products/placeholder.png', 20.00, 0, 'ON_SALE', 30),
    (10, 'WW-BDG-004', 7, '守岸人主题挂件', '守岸人角色主题挂件', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 25.00, 14, 'DRAFT', 40),
    (11, 'WW-BDG-005', 7, '椿角色徽章', '椿主题异形徽章', '角色主题异形金属徽章。', '/images/products/placeholder.png', 19.00, 0, 'ON_SALE', 50),
    (12, 'WW-BDG-006', 7, '珂莱塔主题挂件', '珂莱塔角色主题挂件', '带主题色挂绳的收藏挂件。', '/images/products/placeholder.png', 28.00, 29, 'ON_SALE', 60),
    (13, 'WW-APP-001', 8, '黑海岸主题短袖', '黑海岸主题纯棉短袖', '舒适棉质面料，正面采用主题印花。', '/images/products/placeholder.png', 129.00, 19, 'ON_SALE', 10),
    (14, 'WW-APP-002', 8, '今州主题卫衣', '今州主题连帽卫衣', '宽松版型，适合日常穿着。', '/images/products/placeholder.png', 159.00, 19, 'ON_SALE', 20),
    (15, 'WW-APP-003', 8, '漂泊者主题外套', '漂泊者配色轻便外套', '轻量面料与主题刺绣结合。', '/images/products/placeholder.png', 139.00, 0, 'ON_SALE', 30),
    (16, 'WW-APP-004', 8, '黎那汐塔主题卫衣', '黎那汐塔主题限定卫衣', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 179.00, 14, 'DRAFT', 40),
    (17, 'WW-APP-005', 8, '共鸣者主题帽子', '共鸣者标识刺绣帽', '可调节帽围，带主题刺绣。', '/images/products/placeholder.png', 119.00, 0, 'ON_SALE', 50),
    (18, 'WW-APP-006', 8, '黑海岸主题夹克', '黑海岸主题轻薄夹克', '主题配色拼接设计。', '/images/products/placeholder.png', 199.00, 30, 'ON_SALE', 60),
    (19, 'WW-BAG-001', 9, '鸣潮主题帆布包', '鸣潮标识大容量帆布包', '日常通勤容量，内置小口袋。', '/images/products/placeholder.png', 89.00, 19, 'ON_SALE', 10),
    (20, 'WW-BAG-002', 9, '今州主题斜挎包', '今州主题轻便斜挎包', '可调节肩带，适合日常出行。', '/images/products/placeholder.png', 109.00, 19, 'ON_SALE', 20),
    (21, 'WW-BAG-003', 9, '黑海岸主题收纳包', '黑海岸主题多功能收纳包', '可收纳数据线与小型随身物品。', '/images/products/placeholder.png', 79.00, 0, 'ON_SALE', 30),
    (22, 'WW-BAG-004', 9, '黎那汐塔主题双肩包', '黎那汐塔主题双肩背包', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 129.00, 15, 'DRAFT', 40),
    (23, 'WW-BAG-005', 9, '漂泊者主题卡包', '漂泊者主题便携卡包', '轻便卡位设计，带主题图案。', '/images/products/placeholder.png', 69.00, 1, 'ON_SALE', 50),
    (24, 'WW-BAG-006', 9, '共鸣者主题旅行包', '共鸣者主题大容量旅行包', '短途出行和运动场景均可使用。', '/images/products/placeholder.png', 149.00, 30, 'ON_SALE', 60),
    (25, 'WW-PLS-001', 10, '守岸人毛绒玩偶', '守岸人主题毛绒玩偶', '柔软短绒材质，适合收藏与摆放。', '/images/products/placeholder.png', 99.00, 20, 'ON_SALE', 10),
    (26, 'WW-PLS-002', 10, '椿毛绒玩偶', '椿角色主题毛绒玩偶', '角色元素刺绣与柔软填充。', '/images/products/placeholder.png', 129.00, 20, 'ON_SALE', 20),
    (27, 'WW-PLS-003', 10, '洛可可毛绒玩偶', '洛可可主题毛绒玩偶', '适合桌面与床头摆放。', '/images/products/placeholder.png', 119.00, 0, 'ON_SALE', 30),
    (28, 'WW-PLS-004', 10, '坎特蕾拉毛绒玩偶', '坎特蕾拉主题毛绒玩偶', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 149.00, 15, 'DRAFT', 40),
    (29, 'WW-PLS-005', 10, '呜呜物流毛绒挂件', '呜呜物流主题毛绒挂件', '小尺寸毛绒挂件，附金属扣。', '/images/products/placeholder.png', 89.00, 1, 'ON_SALE', 50),
    (30, 'WW-PLS-006', 10, '鸣式毛绒抱枕', '鸣式主题柔软抱枕', '大尺寸柔软填充抱枕。', '/images/products/placeholder.png', 169.00, 30, 'ON_SALE', 60),
    (31, 'WW-HOM-001', 11, '今州主题马克杯', '今州风景主题陶瓷马克杯', '陶瓷杯体，适合日常饮用。', '/images/products/placeholder.png', 59.00, 20, 'ON_SALE', 10),
    (32, 'WW-HOM-002', 11, '黑海岸主题保温杯', '黑海岸主题便携保温杯', '不锈钢杯体与密封杯盖。', '/images/products/placeholder.png', 69.00, 20, 'ON_SALE', 20),
    (33, 'WW-HOM-003', 11, '黎那汐塔主题杯垫', '黎那汐塔主题杯垫套装', '一套四枚，采用不同主题图案。', '/images/products/placeholder.png', 49.00, 0, 'ON_SALE', 30),
    (34, 'WW-HOM-004', 11, '共鸣者主题夜灯', '共鸣者标识桌面夜灯', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 79.00, 15, 'DRAFT', 40),
    (35, 'WW-HOM-005', 11, '漂泊者主题钥匙盘', '漂泊者主题桌面钥匙盘', '适合放置钥匙与小件物品。', '/images/products/placeholder.png', 39.00, 1, 'ON_SALE', 50),
    (36, 'WW-HOM-006', 11, '鸣潮主题桌面摆钟', '鸣潮主题静音桌面摆钟', '简洁主题设计与静音机芯。', '/images/products/placeholder.png', 89.00, 30, 'ON_SALE', 60),
    (37, 'WW-PHN-001', 12, '漂泊者主题手机壳', '漂泊者角色主题手机保护壳', '透明保护壳搭配角色主题印刷。', '/images/products/placeholder.png', 49.00, 20, 'ON_SALE', 10),
    (38, 'WW-PHN-002', 12, '今汐主题手机壳', '今汐角色主题手机保护壳', '防滑边框与彩色角色图案。', '/images/products/placeholder.png', 59.00, 20, 'ON_SALE', 20),
    (39, 'WW-PHN-003', 12, '长离主题气囊支架', '长离角色主题手机支架', '折叠气囊结构，便于握持。', '/images/products/placeholder.png', 39.00, 0, 'ON_SALE', 30),
    (40, 'WW-PHN-004', 12, '守岸人主题充电线', '守岸人主题数据线', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 69.00, 15, 'DRAFT', 40),
    (41, 'WW-PHN-005', 12, '椿主题手机挂绳', '椿角色主题手机挂绳', '可拆卸挂绳与主题吊牌。', '/images/products/placeholder.png', 45.00, 1, 'ON_SALE', 50),
    (42, 'WW-PHN-006', 12, '黑海岸主题无线充电板', '黑海岸主题桌面充电板', '简洁主题图案，适合桌面使用。', '/images/products/placeholder.png', 79.00, 30, 'ON_SALE', 60),
    (43, 'WW-DSK-001', 13, '今州主题鼠标垫', '今州风景主题桌垫', '细纹布面与防滑橡胶底。', '/images/products/placeholder.png', 29.00, 20, 'ON_SALE', 10),
    (44, 'WW-DSK-002', 13, '黑海岸主题桌垫', '黑海岸主题大尺寸桌垫', '适合键盘与鼠标共同使用。', '/images/products/placeholder.png', 39.00, 20, 'ON_SALE', 20),
    (45, 'WW-DSK-003', 13, '共鸣者主题便签本', '共鸣者主题便签套装', '多种主题图案便签组合。', '/images/products/placeholder.png', 35.00, 0, 'ON_SALE', 30),
    (46, 'WW-DSK-004', 13, '黎那汐塔主题文件夹', '黎那汐塔主题文件收纳夹', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 49.00, 15, 'DRAFT', 40),
    (47, 'WW-DSK-005', 13, '漂泊者主题笔记本', '漂泊者主题硬壳笔记本', '内页采用横线设计。', '/images/products/placeholder.png', 25.00, 1, 'ON_SALE', 50),
    (48, 'WW-DSK-006', 13, '鸣潮主题桌面收纳盒', '鸣潮标识桌面收纳盒', '可收纳文具和小型周边。', '/images/products/placeholder.png', 55.00, 30, 'ON_SALE', 60),
    (49, 'WW-FIG-001', 14, '漂泊者收藏手办', '漂泊者主题收藏模型', '角色主题静态收藏模型。', '/images/products/placeholder.png', 199.00, 20, 'ON_SALE', 10),
    (50, 'WW-FIG-002', 14, '忌炎收藏手办', '忌炎主题收藏模型', '战斗姿态造型与主题底座。', '/images/products/placeholder.png', 259.00, 20, 'ON_SALE', 20),
    (51, 'WW-FIG-003', 14, '今汐收藏手办', '今汐主题收藏模型', '角色主题静态收藏模型。', '/images/products/placeholder.png', 229.00, 0, 'ON_SALE', 30),
    (52, 'WW-FIG-004', 14, '长离收藏手办', '长离主题收藏模型', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 299.00, 15, 'DRAFT', 40),
    (53, 'WW-FIG-005', 14, '守岸人收藏手办', '守岸人主题收藏模型', '带场景底座的收藏模型。', '/images/products/placeholder.png', 189.00, 1, 'ON_SALE', 50),
    (54, 'WW-FIG-006', 14, '椿收藏手办', '椿主题收藏模型', '角色动态造型与主题底座。', '/images/products/placeholder.png', 329.00, 30, 'ON_SALE', 60),
    (55, 'WW-GFT-001', 15, '今州主题典藏礼盒', '今州主题周边组合礼盒', '包含徽章、挂件和纪念卡。', '/images/products/placeholder.png', 159.00, 20, 'ON_SALE', 10),
    (56, 'WW-GFT-002', 15, '黑海岸主题典藏礼盒', '黑海岸主题周边组合礼盒', '包含立牌、徽章和主题卡片。', '/images/products/placeholder.png', 199.00, 20, 'ON_SALE', 20),
    (57, 'WW-GFT-003', 15, '黎那汐塔主题典藏礼盒', '黎那汐塔主题周边礼盒', '主题纪念品组合包装。', '/images/products/placeholder.png', 179.00, 0, 'ON_SALE', 30),
    (58, 'WW-GFT-004', 15, '漂泊者周年纪念礼盒', '漂泊者主题周年纪念礼盒', '新品预备商品，当前暂未上架。', '/images/products/placeholder.png', 239.00, 15, 'DRAFT', 40),
    (59, 'WW-GFT-005', 15, '共鸣者主题入门礼盒', '共鸣者主题基础周边组合', '包含徽章、贴纸与主题明信片。', '/images/products/placeholder.png', 149.00, 1, 'ON_SALE', 50),
    (60, 'WW-GFT-006', 15, '鸣潮主题豪华典藏礼盒', '鸣潮主题豪华周边组合', '包含多种收藏周边的礼盒套装。', '/images/products/placeholder.png', 269.00, 30, 'ON_SALE', 60);

-- One gallery image for every product, plus a second teaching image for products 1-40.
INSERT INTO product_image (product_id, image_path, alt_text, sort_order)
SELECT id, cover_image, CONCAT(name, '主图'), 1
FROM product;

INSERT INTO product_image (product_id, image_path, alt_text, sort_order)
SELECT id, cover_image, CONCAT(name, '细节图'), 2
FROM product
WHERE id <= 40;

INSERT INTO cart_item (id, user_id, product_id, quantity, version)
VALUES
    (1, 1, 21, 1, 0),
    (2, 1, 23, 2, 0),
    (3, 1, 25, 1, 0),
    (4, 1, 27, 1, 0),
    (5, 1, 29, 3, 0),
    (6, 2, 31, 1, 0),
    (7, 2, 33, 2, 0),
    (8, 2, 35, 1, 0),
    (9, 2, 37, 1, 0),
    (10, 2, 39, 2, 0);

INSERT INTO sales_order
    (id, order_no, user_id, status, total_amount, receiver_name, receiver_phone,
     receiver_address, payment_method, payment_no, paid_at, shipped_at, completed_at,
     cancelled_at, created_at)
VALUES
    (1, 'DEMO-202611-0001', 1, 'PENDING_PAYMENT', 75.00, 'Alice', '13800000001', '今州教学路1号', NULL, NULL, NULL, NULL, NULL, NULL, '2026-11-01 10:00:00'),
    (2, 'DEMO-202611-0002', 1, 'PAID', 67.00, 'Alice', '13800000001', '今州教学路1号', 'MOCK', 'MOCK-202611-0002', '2026-11-02 10:05:00', NULL, NULL, NULL, '2026-11-02 10:00:00'),
    (3, 'DEMO-202611-0003', 1, 'SHIPPED', 213.00, 'Alice', '13800000001', '今州教学路1号', 'MOCK', 'MOCK-202611-0003', '2026-11-03 10:05:00', '2026-11-04 09:00:00', NULL, NULL, '2026-11-03 10:00:00'),
    (4, 'DEMO-202611-0004', 1, 'COMPLETED', 208.00, 'Alice', '13800000001', '今州教学路1号', 'MOCK', 'MOCK-202611-0004', '2026-11-04 10:05:00', '2026-11-05 09:00:00', '2026-11-07 18:00:00', NULL, '2026-11-04 10:00:00'),
    (5, 'DEMO-202611-0005', 1, 'CANCELLED', 56.00, 'Alice', '13800000001', '今州教学路1号', NULL, NULL, NULL, NULL, NULL, '2026-11-05 10:10:00', '2026-11-05 10:00:00'),
    (6, 'DEMO-202611-0006', 2, 'PENDING_PAYMENT', 80.00, 'Bob', '13800000002', '黑海岸教学路2号', NULL, NULL, NULL, NULL, NULL, NULL, '2026-11-06 10:00:00'),
    (7, 'DEMO-202611-0007', 2, 'PAID', 177.00, 'Bob', '13800000002', '黑海岸教学路2号', 'MOCK', 'MOCK-202611-0007', '2026-11-07 10:05:00', NULL, NULL, NULL, '2026-11-07 10:00:00'),
    (8, 'DEMO-202611-0008', 2, 'SHIPPED', 207.00, 'Bob', '13800000002', '黑海岸教学路2号', 'MOCK', 'MOCK-202611-0008', '2026-11-08 10:05:00', '2026-11-09 09:00:00', NULL, NULL, '2026-11-08 10:00:00'),
    (9, 'DEMO-202611-0009', 2, 'COMPLETED', 208.00, 'Bob', '13800000002', '黑海岸教学路2号', 'MOCK', 'MOCK-202611-0009', '2026-11-09 10:05:00', '2026-11-10 09:00:00', '2026-11-12 18:00:00', NULL, '2026-11-09 10:00:00'),
    (10, 'DEMO-202611-0010', 2, 'CANCELLED', 308.00, 'Bob', '13800000002', '黑海岸教学路2号', NULL, NULL, NULL, NULL, NULL, '2026-11-10 10:10:00', '2026-11-10 10:00:00');

INSERT INTO sales_order_item
    (order_id, product_id, sku_snapshot, product_name_snapshot, cover_image_snapshot,
     unit_price, quantity, line_amount)
VALUES
    (1, 1, 'WW-ACR-001', '漂泊者主题亚克力立牌', '/images/products/placeholder.png', 39.00, 1, 39.00),
    (1, 7, 'WW-BDG-001', '炽霞角色徽章', '/images/products/placeholder.png', 18.00, 2, 36.00),
    (2, 2, 'WW-ACR-002', '秧秧主题亚克力立牌', '/images/products/placeholder.png', 45.00, 1, 45.00),
    (2, 8, 'WW-BDG-002', '白芷角色徽章', '/images/products/placeholder.png', 22.00, 1, 22.00),
    (3, 3, 'WW-ACR-003', '忌炎主题亚克力立牌', '/images/products/placeholder.png', 42.00, 2, 84.00),
    (3, 13, 'WW-APP-001', '黑海岸主题短袖', '/images/products/placeholder.png', 129.00, 1, 129.00),
    (4, 4, 'WW-ACR-004', '吟霖主题亚克力立牌', '/images/products/placeholder.png', 49.00, 1, 49.00),
    (4, 14, 'WW-APP-002', '今州主题卫衣', '/images/products/placeholder.png', 159.00, 1, 159.00),
    (5, 5, 'WW-ACR-005', '今汐主题亚克力立牌', '/images/products/placeholder.png', 36.00, 1, 36.00),
    (5, 9, 'WW-BDG-003', '相里要主题挂件', '/images/products/placeholder.png', 20.00, 1, 20.00),
    (6, 6, 'WW-ACR-006', '长离主题亚克力立牌', '/images/products/placeholder.png', 55.00, 1, 55.00),
    (6, 10, 'WW-BDG-004', '守岸人主题挂件', '/images/products/placeholder.png', 25.00, 1, 25.00),
    (7, 11, 'WW-BDG-005', '椿角色徽章', '/images/products/placeholder.png', 19.00, 2, 38.00),
    (7, 15, 'WW-APP-003', '漂泊者主题外套', '/images/products/placeholder.png', 139.00, 1, 139.00),
    (8, 12, 'WW-BDG-006', '珂莱塔主题挂件', '/images/products/placeholder.png', 28.00, 1, 28.00),
    (8, 16, 'WW-APP-004', '黎那汐塔主题卫衣', '/images/products/placeholder.png', 179.00, 1, 179.00),
    (9, 17, 'WW-APP-005', '共鸣者主题帽子', '/images/products/placeholder.png', 119.00, 1, 119.00),
    (9, 19, 'WW-BAG-001', '鸣潮主题帆布包', '/images/products/placeholder.png', 89.00, 1, 89.00),
    (10, 18, 'WW-APP-006', '黑海岸主题夹克', '/images/products/placeholder.png', 199.00, 1, 199.00),
    (10, 20, 'WW-BAG-002', '今州主题斜挎包', '/images/products/placeholder.png', 109.00, 1, 109.00);

-- Ensure subsequent auto-increment values start after the teaching data IDs.
ALTER TABLE store_user AUTO_INCREMENT = 5;
ALTER TABLE category AUTO_INCREMENT = 16;
ALTER TABLE product AUTO_INCREMENT = 61;
ALTER TABLE sales_order AUTO_INCREMENT = 11;
