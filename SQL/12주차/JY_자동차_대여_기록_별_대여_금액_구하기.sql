-- https://school.programmers.co.kr/learn/courses/30/lessons/151141
-- 자동차 대여 기록 별 대여 금액 구하기
WITH CTE AS (
    SELECT CAR_TYPE, HISTORY_ID, DAILY_FEE, DATEDIFF(END_DATE, START_DATE)+1 AS DURATION
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H
    JOIN CAR_RENTAL_COMPANY_CAR C
    ON H.CAR_ID = C.CAR_ID
    WHERE CAR_TYPE = '트럭'
)
SELECT HISTORY_ID, 
       ROUND((1-IF(DISCOUNT_RATE IS NULL,0,DISCOUNT_RATE)/100)*DAILY_FEE*DURATION ,0) AS FEE
FROM CTE C
LEFT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN P
ON C.CAR_TYPE = P.CAR_TYPE AND
    IF(DURATION BETWEEN 7 AND 30,'7일 이상',
        IF(DURATION BETWEEN 30 AND 90, '30일 이상',
        IF(DURATION >= 90, '90일 이상','-'))) = DURATION_TYPE
ORDER BY FEE DESC, HISTORY_ID DESC