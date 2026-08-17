CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  address VARCHAR(255) NOT NULL,
  join_date DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  description TEXT,
  price INT NOT NULL,
  stock_quantity INT NOT NULL DEFAULT 0
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  quantity INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  status VARCHAR(20) NOT NULL DEFAULT '주문접수',

  CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  CONSTRAINT fk_orders_products FOREIGN KEY (product_id) REFERENCES products(product_id)
);

ALTER TABLE customers
ADD COLUMN point INT NOT NULL DEFAULT 0; -- 컬럼 추가

DESC customers;

SELECT * FROM customers;

ALTER TABLE customers
MODIFY COLUMN address VARCHAR(500) NOT NULL; -- 컬럼 수정

ALTER TABLE customers
DROP COLUMN point; -- 컬럼 삭제

DROP TABLE products;

TRUNCATE TABLE products;

SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO customers
VALUES
  (NULL, '아오쿠모 린', 'kumorin@example.com', 'password', '안산시', '2024-05-23 09:00:00'),
  (NULL, '아카네 리제', 'lize@example.com', 'password', '안산시', '2025-05-23 09:00:00');

INSERT INTO customers (name, email, password, address)
VALUES ('아라하시 타비', 'tabidayo@example.com', 'password', '안산시');

SELECT * FROM customers;

INSERT INTO products (name, price, stock_quantity)
VALUES
  ('아크릴 코롯토', 19900, 200);

SELECT * FROM products;

INSERT INTO products (name, price, stock_quantity)
VALUES
  ('아크릴 스탠드', 4990, 100),
  ('아크릴 키링', 4990, 100),
  ('안경닦이', 4990, 100);

SELECT * FROM products
WHERE product_id = 1;

UPDATE products
SET price = 9800, stock_quantity = 990
WHERE product_id = 1;

UPDATE products
SET price = 990; -- WHERE이 실수로 생략됨 -> 모든 행의 price가 일괄 변경 (주의!) 일반적으로 safe mode로 방지됨

SELECT @@SQL_SAFE_UPDATES;

SET @@SQL_SAFE_UPDATES = 1; -- 1: 활성화 0: 비활성화

UPDATE products
SET price = 990
WHERE name = '아크릴 코롯토';

DELETE FROM products
WHERE product_id = 1;

SELECT * FROM products;

SET FOREIGN_KEY_CHECKS = 1;

TRUNCATE TABLE products;

TRUNCATE TABLE customers;

TRUNCATE TABLE orders;

INSERT INTO customers (name, email, password, address)
VALUES
  ('kumorin','kumorin@example.com', 'password', '안산시');

SELECT * FROM customers;

INSERT INTO customers (name, email, password, address)
VALUES
  ('Aokumo','kumorin@example.com', 'password', '안산시'); -- 오류 발생

INSERT INTO products (name, price, stock_quantity)
VALUES
  ('아크릴 코롯토', 19900, 200);

SELECT * FROM products;

INSERT INTO orders (customer_id, product_id, quantity)
VALUES
  (1, 1, 1);

SELECT * FROM orders;

INSERT INTO orders (customer_id, product_id, quantity)
VALUES
  (999, 1, 1); -- 오류 발생

CREATE DATABASE my_test;

USE my_test;

CREATE TABLE members (
  id INT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  join_date DATE
);

DESC members;

INSERT INTO members (id, name, join_date)
VALUES
  (1, '션', '2025-01-10'),
  (2, '네이트', '2025-02-15');

SELECT * FROM members;

UPDATE members
SET name = '네이트2'
WHERE id = 2;

DELETE FROM members
WHERE id = 1;

SELECT * FROM members;

CREATE TABLE products (
  product_id INT AUTO_INCREMENT PRIMARY KEY,
  product_name VARCHAR(100) NOT NULL,
  product_code VARCHAR(20) UNIQUE,
  price INT NOT NULL,
  stock_count INT NOT NULL DEFAULT 0
);

DESC products;

CREATE TABLE customers (
  customer_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE orders (
  order_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,

  CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers
VALUES
  (NULL, '아오쿠모 린');

SELECT * FROM customers;

INSERT INTO orders (customer_id)
VALUES
  (1);

SELECT * FROM orders;

INSERT INTO orders (customer_id)
VALUES (999); -- customer_id가 999인 행이 존재하지 않음

INSERT INTO customers (customer_id)
VALUES (2); -- name이 not null이라 반드시 값을 넣어야 함

USE my_shop;