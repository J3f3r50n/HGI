SELECT funcao_teste(CURSOR (SELECT 'A' a 
FROM dual
UNION
SELECT 'B'
FROM dual
UNION
SELECT 'C'
FROM dual
UNION
SELECT 'D'
FROM dual)) retorno
FROM dual