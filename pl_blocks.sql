--48. Bloco anônimo com declaração de variável e instrução
DECLARE
  bomb_number INTEGER := 0;
BEGIN
    SELECT artifact_code INTO bomb_number FROM artifacts
    WHERE name = 'C-4';
END;

--49. Bloco anônimo com exceção
DECLARE
  a TIMESTAMP;
BEGIN
  WHILE TRUE LOOP
    a := SYSTIMESTAMP;
  END LOOP;

EXCEPTION WHEN LOGIN_DENIED THEN
  DBMS_OUTPUT.put_line('ERROR! The aliens are attacking, try logging in later!');
END;
/