CREATE DATABASE my_shop;

USE my_shop;

CREATE TABLE sample(
  product_id INT PRIMARY KEY,
  name VARCHAR(100),
  price INT,
  stock_quantity INT,
  release_date DATE
);

DESC sample; -- 또는 DESCRIBE sample;

SHOW DATABASES;

SHOW TABLES;

DROP TABLE sample;

DROP DATABASE my_shop;

INSERT INTO sample (product_id, name, price, stock_quantity, release_date)
VALUES
  (1, '쿠모린 티셔츠', 59900, 100, '2025-06-11');

SELECT *
FROM sample;

UPDATE sample
SET price = 40000
WHERE product_id = 1;

DELETE FROM sample
WHERE product_id = 1;