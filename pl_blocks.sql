--48 Bloco anônimo com declaração de variável e instrução
DECLARE
   sale_num sale.sale_number%TYPE;
BEGIN
   sale_num := 2;
   UPDATE sale SET sale_number = 20 WHERE sale_number = sale_num;
END;
/
/*
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
*/
--50. Uso de IF-THEN-ELSE
DECLARE
  salary INTEGER := 1000;
  minimum INTEGER := 700;
BEGIN
  IF salary < minimum THEN salary := salary + minimum;
  ELSE 
    DBMS_OUTPUT.put_line('Minimum wage creates unemployment');
  END IF;
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
  WHEN 1 THEN
    DBMS_OUTPUT.put_line('That''s equal, man!');
  ELSE
    DBMS_OUTPUT.put_line('That''s different, man!');
  END CASE;
END;
/

--53. LOOP com instrução de saída
DECLARE
  acum INTEGER := 0;
BEGIN
  LOOP
    acum := acum + 1;
    EXIT WHEN acum > 100;
  END LOOP;
END;
/

--54. WHILE LOOP
DECLARE
  var INTEGER := 1;
BEGIN
  WHILE var < 100 LOOP
    var := var + 1;
  END LOOP;
END;
/

--55. FOR LOOP
--Feito junto com 62.

--56. Recuperação de dados para variável
DECLARE
  bomb_number INTEGER := 0;
BEGIN
    SELECT artifact_code INTO bomb_number FROM artifacts
    WHERE name = 'C-4';
END;
/

--57 Recuperação de dados para registro
SELECT * FROM sale AS OF TIMESTAMP systimestamp - INTERVAL '5' MINUTE;

--58 Output de string com variável
SET SERVEROUTPUT ON FORMAT WRAPPED;
DECLARE
  numero NUMBER := 10;
BEGIN
  DBMS_OUTPUT.put_line('Vendemos ' || numero || ' armas.');
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
  salee artifacts.sale_date%TYPE;
BEGIN
  OPEN weapons;
  LOOP
    FETCH weapons INTO all_weapons;
  EXIT WHEN weapons%NOTFOUND;
  END LOOP;
  CLOSE weapons;
END;
/

--60. Uso de cursor explícito com registro
-- Declaração do Cursor
DECLARE
CURSOR c_artifacts IS
SELECT artifact_code, name FROM artifacts
WHERE manufacturer_name = 'Israel Military Industries';

v_artifacts c_artifacts%ROWTYPE;

BEGIN
OPEN c_artifacts;
LOOP
FETCH c_artifacts INTO v_artifacts;
EXIT WHEN c_artifacts%NOTFOUND;
DBMS_OUTPUT.PUTLINE('CODE: '||v_artifacts.artifact_code||' '||'Name: '|| v_artifacts.name);
END LOOP;

CLOSE c_artifacts;
END;

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
  salee artifacts.sale_date%TYPE;
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

--63. Procedimento sem parâmetro
CREATE OR REPLACE PROCEDURE the_procedure IS
  a INTEGER;
  BEGIN
    a := 1;
  END the_procedure;

EXECUTE the_procedure

--64. Procedimento com parâmetro IN
--Feito junto com o 67.

--65. Procedimento com parâmetro OUT
CREATE OR REPLACE PROCEDURE returnc4c(c4_number OUT INTEGER)
is
BEGIN
  SELECT artifact_code INTO c4_number FROM artifacts
  WHERE name = 'C-4';
END returnc4c ;

EXECUTE returnc4c(c4_number);

--66. Procedimento com parâmetro INOUT
CREATE OR REPLACE PROCEDURE return_super( super IN OUT INTEGER) IS
BEGIN
  SELECT supervisor_cpf INTO super FROM employees
  WHERE super = employee_cpf;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
  super := 0;
END return_super;

EXECUTE return_super(4323);

--67 Uso de procedimento dentro de outro bloco PL (pode-se usar um dos
-- procedimentos criados anteriormente)
--64. Procedimento com parâmetro IN
CREATE OR REPLACE PROCEDURE change_emp (sale_number IN NUMBER) AS
  tot_emps NUMBER;
  BEGIN
    UPDATE sale
    SET employee_cpf = 003
    WHERE sale_number = change_emp(sale_number);
    tot_emps := tot_emps - 1;
  END change_emp;
/

EXECUTE change_emp(1);

--68 Função sem parâmetro
CREATE OR REPLACE FUNCTION get_cpf
  RETURN NUMBER
IS acc_bal NUMBER;
  BEGIN
    SELECT employee_cpf INTO acc_bal FROM sale
    WHERE sale_number = 20;
    RETURN(acc_bal);
  END get_cpf;
/

EXECUTE get_cpf

--69. Função com parâmetro IN
CREATE OR REPLACE FUNCTION cpf_of_phone(phone IN phones.cpf%TYPE)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    RETURN desired_cpf;
  END cpf_of_phone;

EXECUTE cpf_of_phone(0002)

--70. Função com parâmetro OUT
--71. Função com parâmetro INOUT
CREATE OR REPLACE FUNCTION cpf_of_phone_value_incremented(phone IN phones.cpf%TYPE, value IN OUT INTEGER, value1 OUT INTEGER)
  RETURN INTEGER IS
  desired_cpf phones.cpf%TYPE;
  BEGIN
    value1 := 100;
    SELECT cpf INTO desired_cpf FROM phones
    WHERE phone_number = phone;
    value := value + 1;
    RETURN desired_cpf;
  END cpf_of_phone_value_incremented;

BEGIN
   change_emp(20);
END; 
/
DECLARE 
  value INTEGER;
  ret INTEGER;
BEGIN 
   ret := totalCustomers(011,value,0); 
   dbms_output.put_line('CPF of phone: ' || ret); 
END; 
/

--72. Criação de pacote (declaração e corpo) com pelo menos dois componentes
--90. Pacote com funções ou procedimentos que usem outros componentes do mesmo pacote
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
     value := cpf_of_phone(value) + 1;
     RETURN desired_cpf;
   END cpf_of_phone_value_incremented;

 END two_functions;
/
DECLARE 
  ret INTEGER; 
  code phones.cpf%type := &c_phone; 
BEGIN 
   ret = two_functions.cpf_of_phone(code,ret); 
END; 
/
DECLARE 
  ret INTEGER; 
  code phones.cpf%type := &c_phone; 
BEGIN 
   ret = two_functions.cpf_of_phone_value_incremented(code,ret); 
END; 
/
--73. BEFORE TRIGGER
--Feito com o 77.

--74. AFTER TRIGGER
--75. TRIGGER de linha sem condição
--84. Uso de TRIGGER para inserir valores em outra tabela
--85. Uso de TRIGGER para atualizar valores em outra tabela
CREATE OR REPLACE TRIGGER vaca
AFTER INSERT ON employee_vacancies
FOR EACH ROW
DECLARE
BEGIN
  UPDATE employees SET worked_years = 10
  WHERE worked_years > 11;
  INSERT INTO employees VALUES (123, 1230, 3, 'Clown.', 100, 000, 009);
END vaca;

INSERT INTO employees VALUES (150, 60, 0, 'Chief of BrazilBall', 002, 003, 004);

--76. TRIGGER de linha com condição
--86. Uso de TRIGGER para apagar valores em outra tabela
CREATE OR REPLACE TRIGGER overtrigger
AFTER INSERT ON overtimes
FOR EACH ROW
WHEN(end_time IS NULL)
DECLARE
BEGIN
  DELETE FROM employee_vacancies
  WHERE load_unload = 1;
END overtrigger;

INSERT INTO overtimes VALUES (to_date('09/11/2001', 'dd/mm/yyyy'), (CURRENT_TIMESTAMP), NULL, 008);

--77 TRIGGER de comando
--73. BEFORE TRIGGER
--78 Uso de NEW em TRIGGER de inserção
CREATE OR REPLACE TRIGGER addedSale
BEFORE INSERT ON sale FOR EACH ROW
BEGIN
  DBMS_OUTPUT.put_line('New sale number= ' || :NEW.sale_number );
END addedSale;
/
--Demonstration
INSERT INTO sale VALUES (100, 002, 010, 5000, SYSTIMESTAMP);

--79. Uso de OLD em TRIGGER de deleção
--83. Uso de TRIGGER para impedir deleção em tabela
CREATE OR REPLACE TRIGGER delete_check BEFORE DELETE ON employees
  REFERENCING OLD AS employee_cpf
BEGIN
  IF (OLD = 003) THEN
    raise_application_error(-20000, 'You can''t fire Ronald Reagan!');
  END IF;
END delete_check;
--Demonstration:
DELETE FROM employees WHERE employee_cpf = 003;

--80. Uso de NEW e OLD em TRIGGER de atualização
CREATE OR REPLACE TRIGGER stop_insert BEFORE UPDATE ON departments
  BEGIN
    IF NEW.department_code <> OLD.department_code THEN
    raise_application_error(-20001, 'You''re not allowed to update our departments.');
    END IF;
  END;

 UPDATE departments SET department_code = 000 WHERE manager_cpf = 003;

--81. Uso de TRIGGER para impedir inserção em tabela
CREATE OR REPLACE TRIGGER stop_insert BEFORE INSERT ON employees
  BEGIN
    raise_application_error(-20000, 'C''mon, how many employees do you think we can have?');
  END;
--Demonstration
INSERT INTO employees VALUES (100, 50, 0, 'President of United States', 001, 001, 001);

--82. Uso de TRIGGER para impedir atualização em tabela
CREATE OR REPLACE TRIGGER stop_insert BEFORE UPDATE ON departments
  BEGIN
    raise_application_error(-20001, 'You''re not allowed to update our departments.');
  END;
--Demonstration
UPDATE departments SET department_code = 0
WHERE department_code <> 0;

--83. Uso de TRIGGER para impedir deleção em tabela
--Feito coom a 79.

--84. Uso de TRIGGER para inserir valores em outra tabela
--Feito com a 74.

--85. Uso de TRIGGER para atualizar valores em outra tabela
--Feito com a 74.

--86. Uso de TRIGGER para apagar valores em outra tabela
--Feito com a 76.

--87 Uso de função dentro de uma consulta SQL (pode-se usar uma das funções criadas
--anteriormente). Já serve como demonstração da função get_cpf.
SELECT * FROM sale
WHERE sale_number = get_cpf();
;

--88 Registro como parâmetro de função ou procedimento
CREATE OR REPLACE PROCEDURE show_sale_number (sale_in IN sale%ROWTYPE) IS
BEGIN
   DBMS_OUTPUT.put_line (sale_in.sale_number);
END;
/
--Demonstration
DECLARE
  l_sale sale%ROWTYPE;
BEGIN
  SELECT * INTO l_sale FROM sale
  WHERE sale_number = 1;
  show_sale_number(l_sale);
END;
/

/*
DECLARE
  TYPE employee_record IS RECORD (
  name persons.name%TYPE,
  cpf  employees.employee_cpf%TYPE);
*/

--89. Função com registro como retorno
CREATE TYPE employee_record IS OBJECT (
  name persons.name%TYPE,
  cpf  employees.employee_cpf%TYPE
);

CREATE OR REPLACE FUNCTION initialize_employee_record(name persons.name%TYPE,
cpf  employees.employee_cpf%TYPE)
RETURN employee_record IS

  initialized_record employee_record;

BEGIN
  initialized_record.name := name;
  initialized_record.cpf := cpf;
  RETURN initialized_record;
END initialize_employee_record;

--Demonstration
DECLARE
BEGIN
initialize_employee_record('Dom Pedro I', 003);
END;

--90. Pacote com funções ou procedimentos que usem outros componentes do mesmo pacote
--Feito com a 72.

--91. INSTEAD OF TRIGGER
CREATE OR REPLACE TRIGGER delete_if_update_attempt INSTEAD OF UPDATE ON occupied_vacancies
BEGIN
    DELETE occupied_vacancies;
END delete_if_update_attempt;
/
--Demonstration
UPDATE occupied_vacancies SET vacancy_number = 0;

--Running functions/procedures and triggers
--63. Procedimento sem parâmetro
EXECUTE the_procedure

--64. Procedimento com parâmetro IN
--Feito junto com o 67.

--65. Procedimento com parâmetro OUT
DECLARE 
   c INTEGER; 
BEGIN 
   returnc4c(c)
   dbms_output.put_line(' Return: ' || c); 
END; 
/

--66. Procedimento com parâmetro INOUT
DECLARE 
   a INTEGER; 
BEGIN 
   a:= 23; 
   squareNum(a); 
   dbms_output.put_line(' Square of (23): ' || a); 
END; 
/