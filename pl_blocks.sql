--48. Bloco anônimo com declaração de variável e instrução
DECLARE
  bomb_number INTEGER := 0;
BEGIN
    SELECT artifact_code INTO bomb_number FROM artifacts
    WHERE name = 'C-4';
END;
/

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
/

--61. Uso de cursor explícito com parâmetro
DECLARE
  israel_military artifacts.manufacturer_name%TYPE := 'Israel Military Industries';

  CURSOR israel_weapons(israel_military artifacts.manufacturer_name%TYPE) IS
  SELECT * FROM artifacts
  WHERE name = israel_military;

  iweapons israel_weapons%TYPE;

  code artifacts.artifact_code%TYPE;
  name artifacts.name%TYPE;
  manufacturer artifacts.manufacturer_name%TYPE;
  "date" artifacts.manufacture_date%TYPE;
  sale artifacts.sale_date%TYPE;
BEGIN
  OPEN iweapons;
  LOOP
    FETCH iweapons INTO israel_weapons;
  EXIT WHEN iweapons%NOTFOUND;
  END LOOP;
  CLOSE iweapons;
END;
/

--62. Cursor dentro de FOR (sem DECLARE)
DECLARE

BEGIN
  FOR implicit IN (
    SELECT name, birthdate FROM persons
    WHERE sex = 'M'
  )
  LOOP
    DBMS_OUTPUT.put_line(implicit.name || 'birthday is' || to_char(implicit.birthdate));
  END LOOP;
END;
/

--65. Procedimento com parâmetro OUT
CREATE OR REPLACE PROCEDURE returnc4c(c4_number OUT INTEGER)
is
BEGIN
  SELECT artifact_code INTO c4_number FROM artifacts
  WHERE name = 'C-4';
END returnc4c ;

EXECUTE returnc4c(c4_number);

--66. Procedimento com parâmetro INOUT
CREATE OR REPLACE PROCEDURE return_super( super IN OUT INTEGER)
is
BEGIN
  SELECT supervisor_cpf INTO super FROM employees
  WHERE super = employee_cpf;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  super = 0;
END return_super;

EXECUTE return_super(4323);
--69. Função com parâmetro IN
CREATE OR REPLACE FUNCTION cpf_of_phone(phone IN)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    RETURN desired_cpf;
  END cpf_of_phone;

  --71. Função com parâmetro INOUT
CREATE OR REPLACE FUNCTION cpf_of_phone_value_incremented(phone IN phones.cpf%TYPE, value IN OUT INTEGER)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    value := value + 1;
    RETURN desired_cpf;
  END cpf_of_phone_value_incremented;

  --72. Criação de pacote (declaração e corpo) com pelo menos dois componentes
CREATE OR REPLACE PACKAGE two_functions AS
  FUNCTION cpf_of_phone(phone IN phones.cpf%TYPE) RETURN INTEGER;
  FUNCTION cpf_of_phone_value_incremented(phone IN phones.cpf%TYPE, value IN OUT INTEGER)
  RETURN INTEGER;
END two_functions;

CREATE OR REPLACE PACKAGE BODY two_functions AS
  FUNCTION cpf_of_phone(phone IN phones.cpf%TYPE)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    RETURN desired_cpf;
  END cpf_of_phone;

  FUNCTION cpf_of_phone_value_incremented(phone IN phones.cpf%TYPE, value IN OUT INTEGER)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    value := value + 1;
    RETURN desired_cpf;
  END cpf_of_phone_value_incremented;

END two_functions;

--79. Uso de OLD em TRIGGER de deleção
CREATE OR REPLACE TRIGGER delete_check BEFORE DELETE ON employees
  REFERENCING OLD AS name
BEGIN
  IF (OLD = 'Dom Pedro I') THEN
    DBMS_OUTPUT.put_line('You can''t fire the King who declared our independence, you idiot!');
  END IF;
END delete_check;

--81. Uso de TRIGGER para impedir inserção em tabela
CREATE OR REPLACE TRIGGER stop_insert BEFORE INSERT ON employees
  BEGIN
    raise_application_error(-20000, 'C''mon, how many employees do you think we can have?');
  END;

--82. Uso de TRIGGER para impedir atualização em tabela
CREATE OR REPLACE TRIGGER stop_insert BEFORE UPDATE ON departments
  BEGIN
    raise_application_error(-20000, 'You''re not allowed to update our departments.');
  END;

  --91. INSTEAD OF TRIGGER
CREATE OR REPLACE TRIGGER delete_if_update_attempt INSTEAD OF UPDATE ON occupied_vacancies
BEGIN
    DELETE occupied_vacancies;
END delete_if_update_attempt;