USE my_shop;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE products;
TRUNCATE TABLE customers;
TRUNCATE TABLE orders;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO customers (name, email, password, address, join_date)
VALUES
  ('이순신', 'yisunsin@example.com', 'password123', '서울특별시 중구 세종대로', '2023-05-01'),
  ('세종대왕', 'sejong@example.com', 'password456', '서울특별시 종로구 사직로', '2024-05-01'),
  ('장영실', 'youngsil@example.com', 'password789', '부산광역시 동래구 복천동', '2025-05-01');

INSERT INTO products (name, description, price, stock_quantity)
VALUES
  ('갤럭시', '최신 AI 기능이 탑재된 고성능 스마트폰', 10000, 55),
  ('LG 그램', '초경량 디자인과 강력한 성능을 자랑하는 노트북', 20000, 35),
  ('아이폰', '직관적인 사용자 경험을 제공하는 스마트폰', 5000, 55),
  ('에어팟', '편리한 사용성의 무선 이어폰', 3000, 110),
  ('보급형 스마트폰', NULL, 5000, 100);

INSERT INTO orders (customer_id, product_id, quantity)
VALUES
  (1, 1, 1), -- 이순신 고객이 갤럭시 1개 주문
  (2, 2, 1), -- 세종대왕 고객이 LG 그램 1개 주문
  (3, 3, 1), -- 장영실 고객이 아이폰 1개 주문
  (1, 4, 2), -- 이순신 고객이 에어팟 2개 추가 주문
  (2, 2, 1); -- 세종대왕 고객이 LG 그램 1개 주문(추가 주문)

SELECT * FROM orders;

-- SELECT
SELECT name AS `고객명`, email AS `이메일` FROM customers;

-- WHERE
SELECT * FROM products
WHERE price >= 10000;

SELECT * FROM products
WHERE price >= 5000 AND stock_quantity >= 50;

SELECT * FROM products
WHERE price = 20000 OR stock_quantity >= 100;

SELECT * FROM products
WHERE price != 20000; -- NOT

SELECT * FROM products
WHERE price >= 5000 AND price <= 15000; -- 5000원 이상 15000원 이하

SELECT * FROM products
WHERE price BETWEEN 5000 AND 15000; -- BETWEEN으로 간소화 (끝값 포함)

SELECT * FROM products
WHERE price NOT BETWEEN 5000 AND 15000; -- 해당 구간을 제외한 모든 값 검색 (끝값 미포함)

SELECT * FROM products
WHERE name = '갤럭시' OR name = '아이폰' OR name = '에어팟'; -- 다수 요소를 동시 검색

SELECT * FROM products
WHERE name IN ('갤럭시', '아이폰', '에어팟'); -- IN으로 간소화

SELECT * FROM products
WHERE name NOT IN ('갤럭시', '아이폰', '에어팟'); -- 목록을 제외한 모든 상품 검색

SELECT * FROM customers
WHERE email LIKE 'sejong%'; -- LIKE로 문자열의 일부로 검색하기 | %: 아무거나 여러개 | _: 아무거나 한개

SELECT * FROM customers
WHERE address NOT LIKE '서울특별시%'; -- 검색 결과를 제외한 모든 고객 검색

-- ORDER BY: 결과 정렬
SELECT * FROM customers
ORDER BY join_date DESC; -- 생략하면 ASC

SELECT * FROM products
ORDER BY price DESC;

SELECT * FROM products
ORDER BY stock_quantity DESC, price;

-- LIMIT: 결과 중 일부만
SELECT * FROM products
ORDER BY price DESC
LIMIT 2;

SELECT * FROM products
ORDER BY product_id
LIMIT 2, 2; -- 페이징

-- DISTINCT: 중복 제거
SELECT DISTINCT customer_id FROM orders;

SELECT customer_id, product_id FROM orders
ORDER BY customer_id, product_id;

SELECT DISTINCT customer_id, product_id FROM orders
ORDER BY customer_id, product_id;

-- NULL: 알 수 없는 값
SELECT * FROM products
WHERE description IS NULL; -- = 으로 비교할 수 없음

SELECT * FROM products
WHERE description IS NOT NULL;

SELECT * FROM products
ORDER BY description DESC; -- null은 가장 작은 값으로 취급함 (MySQL 기준 / Oracle은 가장 큰 값으로 취급함)

SELECT product_id, name, description FROM products
ORDER BY description IS NULL DESC, description DESC; -- null인 값만 먼저 보고싶을 때 사용하는 방법

-- Quiz
SELECT name AS `상품명`, price AS `판매가` FROM products;

SELECT * FROM customers
WHERE name = '장영실';

SELECT * FROM products
WHERE price >= 10000 AND stock_quantity < 50;

SELECT name, price FROM products
WHERE product_id IN (2, 3, 4);

SELECT name, address FROM customers
WHERE address LIKE '서울특별시%';

SELECT * FROM products
WHERE description IS NULL;

SELECT * FROM products
ORDER BY price DESC;

SELECT * FROM products
ORDER BY price, stock_quantity DESC;

SELECT * FROM customers
ORDER BY join_date DESC
LIMIT 2;

SELECT DISTINCT customer_id, product_id FROM orders;

SELECT
  name AS `상품 이름`
 ,stock_quantity AS `남은 수량`
FROM products
WHERE price > 3000 AND stock_quantity <= 100
ORDER BY stock_quantity DESC
LIMIT 3;