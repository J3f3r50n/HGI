CREATE OR REPLACE FUNCTION funcao_teste(cur SYS_REFCURSOR) RETURN VARCHAR2 IS
  row_value LONG;
  RESULT LONG;
BEGIN

  LOOP
    FETCH cur
      INTO row_value;
    EXIT WHEN cur%NOTFOUND;
    IF (RESULT IS NULL)
    THEN
      RESULT := row_value;
    ELSE
      RESULT := RESULT || ' ' || row_value;
    END IF;
  END LOOP;
  CLOSE cur;