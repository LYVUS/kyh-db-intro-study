USE my_shop;

SELECT name, price, stock_quantity FROM products;

-- 산술 연산
SELECT name, price, stock_quantity, price * stock_quantity AS `total_stock_value` FROM products;

SELECT name, price, price + 3000 AS `expected_price` FROM products;

SELECT name, price, price - 1000 AS `discount_price` FROM products;

SELECT name, price, price / 10 AS `monthly_payment` FROM products;

-- CONCAT: 문자열 합치기
SELECT CONCAT(name, email) FROM customers;

SELECT CONCAT(name, ' (', email, ')') AS `name_and_email` FROM customers;

SELECT CONCAT_WS(' - ', name, email, address) AS `customer_detail` FROM customers; -- MySQL 전용 함수

-- UPPER, LOWER: 대소문자 변환
SELECT email, UPPER(email) FROM customers;

-- LENGTH: 문자열 바이트 길이 반환 | CHAR_LENGTH: 문자열 글자수 반환
SELECT name, CHAR_LENGTH(name) AS `char_length`, LENGTH(name) AS `byte_length` from customers;

-- NULL
SELECT name, description
FROM products;

SELECT
  name
 ,IFNULL(description, '상품 설명이 없습니다.') AS `description` -- NULL인 경우 다음 문자로 대체
FROM products;

-- COALESCE(short_description, long_description, '상품 설명이 없습니다.') AS `description` -- 앞이 NULL인 경우 뒤가 NULL인지 확인
-- 전부 NULL이면 다음 문자로 대체

-- Quiz
SELECT name, price, price * 0.85 AS `sale_price` FROM products;

SELECT CONCAT_WS(' - ', name, address) AS `customer_info` FROM customers;

SELECT
  name
 ,COALESCE(description, name) AS `product_display_info`
FROM products;

SELECT
  name
 ,description
 ,COALESCE(description, name, '정보 없음') AS `display_text`
FROM products;

SELECT
  email
 ,SUBSTRING_INDEX(email, '@', 1) AS `user_id`
 ,CHAR_LENGTH(SUBSTRING_INDEX(email, '@', 1)) AS `id_length`
FROM customers;