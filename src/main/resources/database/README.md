# WutheringWaves Store 数据库

本目录保存鸣潮周边商城的 MySQL 8.0 初始化脚本。数据库只需手动初始化一次，Spring Boot 正常启动时不得自动删除或重建业务数据。

## 数据库信息

- 数据库名：`wutheringwaves`
- 字符集：`utf8mb4`
- 业务表数量：7
- 订单状态：`PENDING_PAYMENT`、`PAID`、`SHIPPED`、`COMPLETED`、`CANCELLED`
- 商品状态：`DRAFT`、`ON_SALE`

## 初始化步骤

请在空数据库环境中按顺序执行：

1. `01_schema.sql`：创建数据库、数据表、索引、外键和检查约束。
2. `02_seed.sql`：插入教学账号、15 个分类、60 个鸣潮周边商品、100 条相册数据、10 条购物车数据、10 张订单和 20 条订单明细。

不要在已经产生业务数据的数据库上重复执行初始化脚本。如果需要重新初始化，请先确认当前数据不再需要，再手动删除数据库。

## 教学账号

| 用户名 | 密码 | 角色 | 状态 | 用途 |
| --- | --- | --- | --- | --- |
| `alice` | `password` | CUSTOMER | ENABLED | 普通用户与数据归属测试 |
| `bob` | `password` | CUSTOMER | ENABLED | 跨账号隔离测试 |
| `disabled` | `password` | CUSTOMER | DISABLED | 禁用账号测试 |
| `admin` | `password` | ADMIN | ENABLED | 管理端登录 |

账号密码采用 BCrypt 散列保存。这里的教学账号密码与本机 MySQL 用户密码没有关系。

## Spring Boot 连接参数

开发环境 JDBC URL：

```text
jdbc:mysql://localhost:3306/wutheringwaves?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Shanghai&useSSL=false&allowPublicKeyRetrieval=true
```

MySQL 用户名和密码应通过本机开发配置或环境变量提供，不要提交真实数据库密码。

## 图片说明

初始化数据暂时统一引用 `/images/products/placeholder.png`。商品模块开发时应在 `src/main/resources/static/images/products/` 中加入占位图及正式商品图片，并同步更新 `cover_image` 和 `product_image.image_path`。
