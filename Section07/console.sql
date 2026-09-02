USE my_shop;

CREATE TABLE order_stat (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(50),
    category VARCHAR(50),
    product_name VARCHAR(100),
    price INT,
    quantity INT,
    order_date DATE
);

INSERT INTO order_stat (customer_name, category, product_name, price, quantity, order_date) VALUES
('이순신', '전자기기', '프리미엄 기계식 키보드', 150000, 1, '2025-05-10'),
('세종대왕', '도서', 'SQL 마스터링', 35000, 2, '2025-05-10'),
('신사임당', '가구', '인체공학 사무용 의자', 250000, 1, '2025-05-11'),
('이순신', '전자기기', '고성능 게이밍 마우스', 80000, 1, '2025-05-12'),
('세종대왕', '전자기기', '4K 모니터', 450000, 1, '2025-05-12'),
('장영실', '도서', '파이썬 데이터 분석', 40000, 3, '2025-05-13'),
('이순신', '문구', '고급 만년필 세트', 200000, 1, '2025-05-14'),
('세종대왕', '가구', '높이조절 스탠딩 데스크', 320000, 1, '2025-05-15'),
('신사임당', '전자기기', '노이즈캔슬링 블루투스 이어폰', 180000, 1, '2025-05-15'),
('장영실', '전자기기', '보조배터리 20000mAh', 50000, 2, '2025-05-16'),
('홍길동', NULL, 'USB-C 허브', 65000, 1, '2025-05-17'); -- 카테고리가 NULL인 데이터 추가

SELECT * FROM order_stat;

-- COUNT: 행의 개수 계산
SELECT COUNT(*) FROM order_stat; -- 단순 행 전체 개수 계산

SELECT COUNT(category) FROM order_stat; -- 해당 열의 null을 제외하고 계산

-- SUM: 합 | AVG: 평균 (null값 자동 제외)
SELECT
  SUM(price * quantity) AS `총 매출액`
 ,AVG(price * quantity) AS `평균 주문 금액`
FROM order_stat;

SELECT SUM(quantity) FROM order_stat;

SELECT
  SUM(quantity) AS `총 판매 수량`
 ,AVG(quantity) AS `주문당 평균 수량`
FROM order_stat;

-- MAX, MIN: 최대, 최소
SELECT
  MAX(price) AS `최고가`
 ,MIN(price) AS `최저가`
FROM order_stat;

SELECT
  MIN(order_date) AS `최초 주문일`
 ,MAX(order_date) AS `최근 주문일`
FROM order_stat;

-- DISTINCT COUNT: 중복없는 집계
SELECT COUNT(DISTINCT customer_name) FROM order_stat;

-- GROUP BY: 그룹별 집계
SELECT
  category
 ,COUNT(*) AS `카테고리별 주문 건수`
FROM order_stat
GROUP BY category;

SELECT
  customer_name
 ,COUNT(*) AS `주문 횟수`
FROM order_stat
GROUP BY customer_name;

SELECT
  customer_name
 ,COUNT(*) AS `총 주문 횟수`
 ,SUM(quantity) AS `총 구매 수량`
 ,SUM(price * quantity) AS `총 구매 금액`
FROM order_stat
GROUP BY customer_name
ORDER BY `총 구매 금액` DESC;

SELECT
  customer_name
 ,category
 ,SUM(price * quantity) AS `카테고리별 구매 금액`
FROM order_stat
GROUP BY customer_name, category
ORDER BY customer_name, `카테고리별 구매 금액` DESC;

-- 주의사항
SELECT
  category
  -- ,product_name << 오류 발생
 ,COUNT(*)
FROM order_stat
GROUP BY category;

-- HAVING: 그룹화 후 필터링
SELECT
  category
 ,SUM(price * quantity) AS `total_sales`
FROM order_stat
-- WHERE SUM(price * quantity) >= 500000 << 오류! WHERE는 GROUP BY 전에 실행되므로 집계함수를 사용할 수 없음
GROUP BY category;

SELECT
  category
 ,SUM(price * quantity) AS `total_sales`
FROM order_stat
GROUP BY category
HAVING `total_sales` >= 500000; -- 별칭으로 사용하는 것은 MySQL에서만 가능

SELECT
  customer_name
 ,COUNT(*) AS `order_count`
FROM order_stat
GROUP BY customer_name
HAVING COUNT(*) >= 3;

-- WHERE과 HAVING의 적용 시기
SELECT
  category
 ,COUNT(*) AS `premium_order_count`
FROM order_stat
WHERE price >= 100000 -- 전체 행 필터링
GROUP BY category
HAVING COUNT(*) >= 2; -- 그룹화 후 필터링

-- SQL의 실행 순서
-- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY -> LIMIT
SELECT
  customer_name
 ,SUM(price * quantity) AS `total_purchase`
FROM order_stat
-- WHERE total_purchase >= 400000 << 오류 발생! 그룹화 전에 실행되는 WHERE에 그룹화 후 적용되는 별칭을 사용함
GROUP BY customer_name;

SELECT -- 5단계
  customer_name
 ,SUM(price * quantity) AS `total_purchase`
FROM order_stat -- 1단계
WHERE order_date < '2025-05-14' -- 2단계
GROUP BY customer_name -- 3단계
HAVING COUNT(*) >= 2 -- 4단계
ORDER BY `total_purchase` DESC -- 6단계
LIMIT 1; -- 7단계

-- Quiz
SELECT COUNT(*) AS `총 주문 건수`, COUNT(category) AS `카테고리 보유 건수` FROM order_stat;

SELECT
  SUM(price * quantity) AS `총 매출액`
 ,AVG(price * quantity) AS `평균 주문 금액`
 ,MAX(price) AS `최고 단가`
 ,MIN(price) AS `최저 단가`
FROM order_stat;

SELECT
  category
 ,SUM(quantity) AS `카테고리별 총 판매 수량`
 ,SUM(price * quantity) AS `카테고리별 총 매출액`
FROM order_stat
GROUP BY category
ORDER BY SUM(price * quantity) DESC;

SELECT
  customer_name
 ,COUNT(*) AS `총 주문 횟수`
 ,SUM(quantity) AS `총 구매 수량`
FROM order_stat
GROUP BY customer_name
ORDER BY `총 주문 횟수` DESC, `총 구매 수량` DESC;

SELECT
  customer_name
 ,SUM(price * quantity) AS `총 구매 금액`
FROM order_stat
GROUP BY customer_name
HAVING SUM(price * quantity) >= 400000
ORDER BY `총 구매 금액` DESC;

SELECT
  customer_name
 ,COUNT(*) AS `주문 횟수`
 ,SUM(price * quantity) AS `총 사용 금액`
FROM order_stat
WHERE category != '도서' OR category IS NULL -- null과의 비교는 알 수 없음으로 결과에서 빠지게 되므로 null을 포함하려면 반드시 명시해야 함
GROUP BY customer_name
HAVING COUNT(*) >= 2
ORDER BY SUM(price * quantity) DESC;