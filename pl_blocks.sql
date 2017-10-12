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

--51. Uso de ELSIF
DECLARE
  a INTEGER := 1;
BEGIN
  IF a <> 1 THEN
    DBMS_OUTPUT.put_line('That''s different, man!');
  ELSIF a = 1 THEN
    DBMS_OUTPUT.put_line('That''s equal, man!');
  END IF;
END;
/

--52. Uso de CASE
DECLARE
  a INTEGER := 1;
BEGIN CASE a
  WHEN NOT 1 THEN
    DBMS_OUTPUT.put_line('That''s different, man!');
  WHEN 1 THEN
    DBMS_OUTPUT.put_line('That''s equal, man!');
  END CASE;
END;
/

--59. Uso de cursor explícito com variável
DECLARE
  CURSOR all_weapons IS
    SELECT * FROM artifacts;

  weapons all_weapons%TYPE;

  code artifacts.artifact_code%TYPE;
  name artifacts.name%TYPE;
  manufacturer artifacts.manufacturer_name%TYPE;
  "date" artifacts.manufacture_date%TYPE;
  sale artifacts.sale_date%TYPE;
BEGIN
  OPEN weapons;
  LOOP
    FETCH weapons INTO all_weapons;
  EXIT WHEN weapons%NOTFOUND;
  END LOOP;
  CLOSE weapons;
END;
