-- WutheringWaves Store database schema
-- Target database: MySQL 8.0+

CREATE DATABASE IF NOT EXISTS wutheringwaves
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_0900_ai_ci;

USE wutheringwaves;

CREATE TABLE IF NOT EXISTS store_user
(
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    display_name  VARCHAR(50)  NOT NULL,
    role          VARCHAR(20)  NOT NULL DEFAULT 'CUSTOMER',
    status        VARCHAR(20)  NOT NULL DEFAULT 'ENABLED',
    email         VARCHAR(100),
    phone         VARCHAR(30),
    created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_store_user_username UNIQUE (username),
    CONSTRAINT uk_store_user_email UNIQUE (email),
    CONSTRAINT chk_store_user_role CHECK (role IN ('CUSTOMER', 'ADMIN')),
    CONSTRAINT chk_store_user_status CHECK (status IN ('ENABLED', 'DISABLED'))
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS category
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    code       VARCHAR(50)  NOT NULL,
    parent_id  BIGINT,
    parent_key BIGINT GENERATED ALWAYS AS (IFNULL(parent_id, 0)) STORED,
    name       VARCHAR(100) NOT NULL,
    sort_order INT          NOT NULL DEFAULT 0,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_category_code UNIQUE (code),
    CONSTRAINT uk_category_parent_name UNIQUE (parent_key, name),
    CONSTRAINT fk_category_parent FOREIGN KEY (parent_id) REFERENCES category (id) ON DELETE RESTRICT,
    CONSTRAINT chk_category_sort_order CHECK (sort_order >= 0),
    INDEX idx_category_parent_sort (parent_id, sort_order, id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS product
(
    id            BIGINT AUTO_INCREMENT PRIMARY KEY,
    sku           VARCHAR(64)    NOT NULL,
    category_id   BIGINT         NOT NULL,
    name          VARCHAR(120)   NOT NULL,
    summary       VARCHAR(255)   NOT NULL,
    description   TEXT           NOT NULL,
    cover_image   VARCHAR(255)   NOT NULL,
    price         DECIMAL(10, 2) NOT NULL,
    stock         INT            NOT NULL DEFAULT 0,
    status        VARCHAR(20)    NOT NULL DEFAULT 'DRAFT',
    sort_order    INT            NOT NULL DEFAULT 0,
    version       BIGINT         NOT NULL DEFAULT 0,
    created_at    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_product_sku UNIQUE (sku),
    CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES category (id) ON DELETE RESTRICT,
    CONSTRAINT chk_product_price CHECK (price > 0),
    CONSTRAINT chk_product_stock CHECK (stock >= 0),
    CONSTRAINT chk_product_status CHECK (status IN ('DRAFT', 'ON_SALE')),
    CONSTRAINT chk_product_sort_order CHECK (sort_order >= 0),
    CONSTRAINT chk_product_version CHECK (version >= 0),
    INDEX idx_product_category_status_sort (category_id, status, sort_order, id),
    INDEX idx_product_status_created (status, created_at, id),
    INDEX idx_product_name (name)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS product_image
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    product_id BIGINT       NOT NULL,
    image_path VARCHAR(255) NOT NULL,
    alt_text   VARCHAR(120) NOT NULL,
    sort_order INT          NOT NULL DEFAULT 0,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_product_image_sort UNIQUE (product_id, sort_order),
    CONSTRAINT fk_product_image_product FOREIGN KEY (product_id) REFERENCES product (id) ON DELETE CASCADE,
    CONSTRAINT chk_product_image_sort_order CHECK (sort_order >= 0),
    INDEX idx_product_image_product (product_id, sort_order, id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS cart_item
(
    id         BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id    BIGINT   NOT NULL,
    product_id BIGINT   NOT NULL,
    quantity   INT      NOT NULL,
    version    BIGINT   NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_cart_item_user_product UNIQUE (user_id, product_id),
    CONSTRAINT fk_cart_item_user FOREIGN KEY (user_id) REFERENCES store_user (id) ON DELETE RESTRICT,
    CONSTRAINT fk_cart_item_product FOREIGN KEY (product_id) REFERENCES product (id) ON DELETE RESTRICT,
    CONSTRAINT chk_cart_item_quantity CHECK (quantity BETWEEN 1 AND 99),
    CONSTRAINT chk_cart_item_version CHECK (version >= 0),
    INDEX idx_cart_item_user (user_id, id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS sales_order
(
    id               BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_no         VARCHAR(40)    NOT NULL,
    user_id          BIGINT         NOT NULL,
    status           VARCHAR(30)    NOT NULL DEFAULT 'PENDING_PAYMENT',
    total_amount     DECIMAL(12, 2) NOT NULL,
    receiver_name    VARCHAR(50)    NOT NULL,
    receiver_phone   VARCHAR(30)    NOT NULL,
    receiver_address VARCHAR(255)   NOT NULL,
    payment_method   VARCHAR(20),
    payment_no       VARCHAR(64),
    paid_at          DATETIME,
    shipped_at       DATETIME,
    completed_at     DATETIME,
    cancelled_at     DATETIME,
    created_at       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT uk_sales_order_order_no UNIQUE (order_no),
    CONSTRAINT uk_sales_order_payment_no UNIQUE (payment_no),
    CONSTRAINT fk_sales_order_user FOREIGN KEY (user_id) REFERENCES store_user (id) ON DELETE RESTRICT,
    CONSTRAINT chk_sales_order_status CHECK (
        status IN ('PENDING_PAYMENT', 'PAID', 'SHIPPED', 'COMPLETED', 'CANCELLED')
    ),
    CONSTRAINT chk_sales_order_total CHECK (total_amount > 0),
    CONSTRAINT chk_sales_order_payment CHECK (
        (payment_method IS NULL AND payment_no IS NULL AND paid_at IS NULL)
        OR
        (payment_method = 'MOCK' AND payment_no IS NOT NULL AND paid_at IS NOT NULL)
    ),
    CONSTRAINT chk_sales_order_lifecycle CHECK (
        (status = 'PENDING_PAYMENT' AND paid_at IS NULL AND shipped_at IS NULL
            AND completed_at IS NULL AND cancelled_at IS NULL)
        OR
        (status = 'PAID' AND paid_at IS NOT NULL AND shipped_at IS NULL
            AND completed_at IS NULL AND cancelled_at IS NULL)
        OR
        (status = 'SHIPPED' AND paid_at IS NOT NULL AND shipped_at IS NOT NULL
            AND completed_at IS NULL AND cancelled_at IS NULL)
        OR
        (status = 'COMPLETED' AND paid_at IS NOT NULL AND shipped_at IS NOT NULL
            AND completed_at IS NOT NULL AND cancelled_at IS NULL)
        OR
        (status = 'CANCELLED' AND paid_at IS NULL AND shipped_at IS NULL
            AND completed_at IS NULL AND cancelled_at IS NOT NULL)
    ),
    INDEX idx_sales_order_user_created (user_id, created_at, id),
    INDEX idx_sales_order_status_created (status, created_at, id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS sales_order_item
(
    id                     BIGINT AUTO_INCREMENT PRIMARY KEY,
    order_id               BIGINT         NOT NULL,
    product_id             BIGINT         NOT NULL,
    sku_snapshot           VARCHAR(64)    NOT NULL,
    product_name_snapshot  VARCHAR(120)   NOT NULL,
    cover_image_snapshot   VARCHAR(255)   NOT NULL,
    unit_price             DECIMAL(10, 2) NOT NULL,
    quantity               INT            NOT NULL,
    line_amount            DECIMAL(12, 2) NOT NULL,
    created_at             DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uk_sales_order_item_product UNIQUE (order_id, product_id),
    CONSTRAINT fk_sales_order_item_order FOREIGN KEY (order_id) REFERENCES sales_order (id) ON DELETE RESTRICT,
    CONSTRAINT fk_sales_order_item_product FOREIGN KEY (product_id) REFERENCES product (id) ON DELETE RESTRICT,
    CONSTRAINT chk_sales_order_item_unit_price CHECK (unit_price > 0),
    CONSTRAINT chk_sales_order_item_quantity CHECK (quantity BETWEEN 1 AND 99),
    CONSTRAINT chk_sales_order_item_amount CHECK (line_amount = unit_price * quantity),
    INDEX idx_sales_order_item_order (order_id, id),
    INDEX idx_sales_order_item_product (product_id)
) ENGINE = InnoDB;
