-- 부모의 형질을 모두 가지는 대장균 찾기
-- https://school.programmers.co.kr/learn/courses/30/lessons/301647

SELECT C.ID, C.GENOTYPE, C.PARENT_GENOTYPE
FROM (
    SELECT A.ID, A.PARENT_ID, A.GENOTYPE, B.GENOTYPE AS PARENT_GENOTYPE
    FROM ECOLI_DATA as A
    LEFT JOIN ECOLI_DATA as B
    ON A.PARENT_ID = B.ID
) AS C
where (C.GENOTYPE & C.PARENT_GENOTYPE) = C.PARENT_GENOTYPE
ORDER BY C.ID 