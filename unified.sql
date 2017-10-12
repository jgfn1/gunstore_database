DROP TABLE overtimes;
DROP TABLE employee_vacancies;
DROP TABLE phones;
DROP TABLE sale;
DROP TABLE instruct;
DROP TABLE clients;
DROP TABLE employees CASCADE CONSTRAINTS;
DROP TABLE persons CASCADE CONSTRAINTS; --foi dito para ser usado FORCE CONSTRAINTS, mas essa sintaxe não existe
DROP TABLE addresses;
DROP TABLE departments;
DROP TABLE artifacts;

CREATE TABLE addresses
(
  cep INTEGER,      --cep is the brazilian to 'zipcode'
  street VARCHAR2 (100),
  CONSTRAINT addresses_pkey PRIMARY KEY (cep)
);

--15. Usar ALTER TABLE para Adicionar Coluna
--16. Usar ALTER TABLE para Remover de Coluna
alter table addresses add (reference_point varchar2 (30))
alter table addresses drop (reference_point)

INSERT INTO addresses VALUES (000, 'Avenida Presidente Jair Messias Bolsonaro');
INSERT INTO addresses VALUES (001, 'Avenida Presidente Dr. Enéas Carneiro');
INSERT INTO addresses VALUES (002, 'Avenida Imperador Dom Pedro II');
INSERT INTO addresses VALUES (003, 'Avenida Presidente Donald J. Trump');
INSERT INTO addresses VALUES (004, 'Avenida Princesa Isabel');
INSERT INTO addresses VALUES (005, 'Avenida José Bonifácio');
INSERT INTO addresses VALUES (006, 'Avenida Olavo de Carvalho');
INSERT INTO addresses VALUES (007, 'Rua do Livre Mercado');
INSERT INTO addresses VALUES (008, 'Rua da Monarquia');
INSERT INTO addresses VALUES (009, 'Rua do Armamento Civil');
INSERT INTO addresses VALUES (010, 'Rua da Vida');

CREATE TABLE departments
(
  department_code INTEGER,
  name VARCHAR2 (100),
  phone_extension INTEGER, --In Portuguese it is called "Ramal".
  manager_cpf INTEGER NOT NULL,
  CONSTRAINT departments_pkey PRIMARY KEY (department_code)
);

INSERT INTO departments VALUES (000, 'Pistolas/Revólveres', 000, 002);
INSERT INTO departments VALUES (001, 'Armas Brancas', 001, 002);
INSERT INTO departments VALUES (010, 'Fuzis/Rifles', 010, 010);
INSERT INTO departments VALUES (011, 'Metralhadoras', 011, 003);
INSERT INTO departments VALUES (100, 'Espingardas', 100, 010);
INSERT INTO departments VALUES (101, 'Bombas', 101, 009);

CREATE TABLE persons
(
  cpf INTEGER, --CPF is the Brazilian equivalent to the American Social Security Number.
  name VARCHAR2 (100),
  birthdate DATE,
  sex VARCHAR2(1) CHECK (sex = 'M' or sex = 'F'),
  person_cep INTEGER,
  CONSTRAINT persons_pkey PRIMARY KEY (cpf),
  CONSTRAINT persons_fkey FOREIGN KEY (person_cep) REFERENCES addresses(cep)
);

INSERT INTO persons VALUES (000, 'Barão de Mauá', to_date('28/12/1813', 'dd/mm/yyyy'), 'M', 000);
INSERT INTO persons VALUES (001, 'Duque de Caxias', to_date('25/08/1803', 'dd/mm/yyyy'), 'M', 001);
INSERT INTO persons VALUES (002, 'Winston Churchill', to_date('30/11/1874', 'dd/mm/yyyy'), 'M', 002);
INSERT INTO persons VALUES (003, 'Ronald Reagan', to_date('06/02/1911', 'dd/mm/yyyy'), 'M', 003);
INSERT INTO persons VALUES (004, 'Machado de Assis', to_date('21/06/1839', 'dd/mm/yyyy'), 'M', 004);
INSERT INTO persons VALUES (005, 'Dom Pedro I', to_date('12/10/1798', 'dd/mm/yyyy'), 'M', 005);
INSERT INTO persons VALUES (006, 'Ariano Suassuna', to_date('16/06/1927', 'dd/mm/yyyy'), 'M', 006);
INSERT INTO persons VALUES (007, 'Plínio Salgado', to_date('22/01/1895', 'dd/mm/yyyy'), 'M', 007);
INSERT INTO persons VALUES (008, 'Coronel Brilhante Ustra', to_date('28/07/1932', 'dd/mm/yyyy'), 'M', 008);
INSERT INTO persons VALUES (009, 'Harry S. Truman', to_date('26/12/1972', 'dd/mm/yyyy'), 'M', 009);
INSERT INTO persons VALUES (010, 'Tomás de Aquino', to_date('07/03/1274', 'dd/mm/yyyy'), 'M', 010);

CREATE TABLE phones
(
  cpf INTEGER,
  phone_number INTEGER,
  CONSTRAINT phones_pkey PRIMARY KEY (cpf, phone_number),
  CONSTRAINT phones_fkey FOREIGN KEY (cpf) REFERENCES persons (cpf)
);


INSERT INTO phones VALUES (009, 0000);
INSERT INTO phones VALUES (000, 0001);
INSERT INTO phones VALUES (001, 0002);
INSERT INTO phones VALUES (002, 0003);
INSERT INTO phones VALUES (003, 0004);
INSERT INTO phones VALUES (004, 0005);
INSERT INTO phones VALUES (005, 0006);
INSERT INTO phones VALUES (006, 0007);
INSERT INTO phones VALUES (007, 0008);
INSERT INTO phones VALUES (008, 0009);
INSERT INTO phones VALUES (010, 0010);

CREATE TABLE employees
(
  employee_cpf INTEGER,
  wage INTEGER,
  worked_years INTEGER,
  job_title VARCHAR2(100),
  supervisor_cpf INTEGER,
  department_code INTEGER,
  CONSTRAINT employees_pkey PRIMARY KEY (employee_cpf),
  CONSTRAINT employees_fkey FOREIGN KEY (employee_cpf) REFERENCES persons (cpf),
  CONSTRAINT employees_fkey1 FOREIGN KEY (supervisor_cpf) REFERENCES employees (employee_cpf),
  CONSTRAINT persons_fkey2 FOREIGN KEY (department_code) REFERENCES departments (department_code)
);

INSERT INTO employees VALUES (010, 300, 5, 'Gestor de Rifles/Fuzis | Gestor de Espingardas', 010, 000);    
INSERT INTO employees VALUES (002, 1000, 10, 'Gestor de Pistolas/Revólveres | Gestor de Armas Brancas', 010, 000);
INSERT INTO employees VALUES (003, 1200, 7, 'Gestor de Metralhadoras | Vendedor | Instrutor de Tiro', 010, 000);
INSERT INTO employees VALUES (009, 1100, 20, 'Gestor de Bombas | Vendedor | Instrutor de Tiro', 010, 000);

--14. Usar ALTER TABLE para Modificação de Coluna
ALTER TABLE departments ADD CONSTRAINT departments_fkey FOREIGN KEY (manager_cpf) REFERENCES employees (employee_cpf); --adding a foreing key at departments

CREATE TABLE clients
(
  client_cpf INTEGER,
  purchases_number INTEGER,
  heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  training_end_register BINARY_DOUBLE, -- 1 - Finished the training | 0 - Don't.
  CONSTRAINT clients_pkey PRIMARY KEY (client_cpf),
  CONSTRAINT clients_fkey FOREIGN KEY (client_cpf) REFERENCES persons (cpf)
);

INSERT INTO clients VALUES (000, 3, 0, 0);
INSERT INTO clients VALUES (001, 300, 1, 1);
INSERT INTO clients VALUES (004, 5, 0, 0);
INSERT INTO clients VALUES (005, 1, 1, 1);
INSERT INTO clients VALUES (006, 20, 0, 0);
INSERT INTO clients VALUES (007, 7, 1, 0);
INSERT INTO clients VALUES (008, 5000, 1, 1);

CREATE TABLE artifacts
(
  artifact_code INTEGER,
  name VARCHAR2 (100),
  manufacturer_name VARCHAR2(100),
  manufacture_date DATE,
  sale_date DATE,
  CONSTRAINT artifacts_pkey PRIMARY KEY (artifact_code)
);

INSERT INTO artifacts VALUES (000, 'Desert Eagle .50C', 'Israel Military Industries', to_date('12/07/1997', 'dd/mm/yyyy'), to_date('01/01/2000', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (001, 'Katana', 'Hattori Hanzo', to_date('04/11/1580', 'dd/mm/yyyy'), to_date('10/08/2004', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (010, 'Kalashnikova 1947 (AK-47)', 'Mikhail Kalashnikov', to_date('01/01/1947', 'dd/mm/yyyy'), to_date('29/09/2017', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (011, 'Uzi Micro SMG ', 'Israel Military Industries', to_date('13/05/1948', 'dd/mm/yyyy'), to_date('21/09/1951', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (100, 'Winchester Model 1912 (Shotgun 12)', 'Winchester Repeating Arms Company', to_date('12/12/1912', 'dd/mm/yyyy'), to_date('30/10/2006', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (101, 'C-4', 'Phillips Petroleum Company', to_date('31/03/1958', 'dd/mm/yyyy'), to_date('01/07/1987', 'dd/mm/yyyy'));

CREATE TABLE overtimes --Brazilian "hora extra"
(
  overtime_date DATE,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  employee_cpf INTEGER NOT NULL,
  CONSTRAINT overtimes_pkey PRIMARY KEY (overtime_date),
  CONSTRAINT overtimes_const UNIQUE (employee_cpf),
  CONSTRAINT overtimes_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);

--INSERT INTO overtimes VALUES (NULL , NULL, NULL, 002);
--INSERT INTO overtimes VALUES (NULL , NULL, NULL, 003);

--13. Usar Valor DEFAULT (Ex: Data do Sistema)
INSERT INTO overtimes VALUES (to_date('21/07/2016', 'dd/mm/yyyy'), (CURRENT_TIMESTAMP), NULL, 009);
INSERT INTO overtimes VALUES (to_date('01/07/1998', 'dd/mm/yyyy'), (CURRENT_TIMESTAMP), NULL, 010);

CREATE TABLE employee_vacancies
(
  employee_cpf INTEGER,
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER,
  CONSTRAINT employee_vacancies_pkey PRIMARY KEY (employee_cpf, vacancy_number),
  CONSTRAINT employee_vacancies_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);

INSERT INTO employee_vacancies VALUES (002, 00, 0, 00);
INSERT INTO employee_vacancies VALUES (003, 01, 1, 01);
INSERT INTO employee_vacancies VALUES (009, 10, 0, 00);
INSERT INTO employee_vacancies VALUES (010, 11, 1, 01);

CREATE TABLE sale
(
  employee_cpf INTEGER,
  client_cpf INTEGER,
  artifact_code INTEGER,
  sale_number INTEGER,
  date_hour TIMESTAMP,
  CONSTRAINT sale_pkey PRIMARY KEY (employee_cpf, client_cpf, artifact_code, sale_number),
  CONSTRAINT sale_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf),
  CONSTRAINT sale_fkey1 FOREIGN KEY (client_cpf) REFERENCES clients (client_cpf),
  CONSTRAINT sale_fkey2 FOREIGN KEY (artifact_code) REFERENCES artifacts (artifact_code)
);

INSERT INTO sale VALUES (009, 001, 101, 1, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 004, 100, 2, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 001, 010, 3, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (009, 008, 010, 4, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 007, 011, 5, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (009, 000, 001, 6, (CURRENT_TIMESTAMP));

CREATE TABLE instruct
(
  client_cpf INTEGER,
  employee_cpf INTEGER,
  --11. Criar PK Composta
  CONSTRAINT instruct_pkey PRIMARY KEY (client_cpf, employee_cpf),
  CONSTRAINT instruct_fkey FOREIGN KEY (client_cpf) REFERENCES clients (client_cpf),
  CONSTRAINT instruct_fkey1 FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);


INSERT INTO instruct VALUES (001, 009);
INSERT INTO instruct VALUES (005, 009);
INSERT INTO instruct VALUES (008, 003);

--1. Uso de BETWEEN com valores numéricos
SELECT client_cpf, training_end_register from clients
WHERE purchases_number BETWEEN 1 and 10;
    
--2. Uso de BETWEEN com datas
SELECT name FROM persons
WHERE birthdate BETWEEN to_date('01/01/1900', 'dd/mm/yyyy') AND to_date('01/01/2017', 'dd/mm/yyyy');

--3. Uso de LIKE/NOT LIKE com tokens (% ou _)
--seleciona todas as armas nao fabricadas pela israel military
SELECT name from artifacts
WHERE manufacturer_name NOT LIKE 'Israel Military %'; 

--4. Uso de IN com subconsulta
SELECT client_cpf FROM clients
WHERE client_cpf IN (
  SELECT client_cpf FROM instruct
);

 --5. Uso de IS NULL/IS NOT NULL
select employee_cpf from overtimes 
where end_time is NULL;

--6. Uso de ORDER BY
--46. ORDER BY com mais de dois campos
SELECT sale_number FROM sale
WHERE sale_number > 3
ORDER BY date_hour, client_cpf DESC;

--7. Criação de VIEW
CREATE VIEW occupied_vacancies AS
SELECT employee_cpf, vacancy_number FROM employee_vacancies;

--8. Consulta sobre VIEW
SELECT * FROM occupied_vacancies;

--9. Deleção de VIEW
DROP VIEW occupied_vacancies;

--10. Criar CHECKs
ALTER TABLE employees
ADD (CONSTRAINT employees_wage_check CHECK (wage > 200))/
ALTER TABLE persons
ADD (CONSTRAINT persons_name_check CHECK (name <> 'Adolf Hitler'));

--17 Operadores aritméticos no SELECT
SELECT sale_number + employee_cpf
FROM sale;

--18 Função de agregação sem GROUP BY
SELECT COUNT(*) FROM sale;

--19. Função de agregação com GROUP BY
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code;

--20. Uso de DISTINCT
SELECT DISTINCT department_code FROM employeey;

--21. Uso de HAVING
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code
HAVING sum(wage) > 200;

--22. Uso de HAVING com subconsulta
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code
HAVING sum(wage) > (
  SELECT sum(worked_years) FROM employees
);

--23. Uso de WHERE + HAVING
SELECT department_code, COUNT (*) FROM employees
WHERE wage > 1000 GOUP BY department_code
HAVING count(*)>1

--24. Junção entre duas tabelas
SELECT D.name 
FROM departments D, employeey E
WHERE E.employee_cpf = D.manager_cpf;

--34. Uso de UNION
select P.name, S.artifact_code
from persons P, sale S
where P.cpf = S.client_cpf 
union (select artifact_code from artifacts)
;

--26. Junção usando INNER JOIN
select name
from persons
INNER JOIN sale ON cpf = client_cpf ;

--27 Junção usando LEFT OUTER JOIN

SELECT employees.employee_cpf, sale.sale_number
FROM employees
LEFT OUTER JOIN sale
ON employees.employee_cpf = sale.employee_cpf;

--28 Junção usando RIGHT OUTER JOIN

SELECT sale.sale_number, employees.employee_cpf
FROM sale
RIGHT OUTER JOIN employees
ON employees.employee_cpf = sale.employee_cpf;

--29. Junção usando FULL OUTER JOIN
SELECT P.name, D.name FROM persons P FULL OUTER JOIN departments D
  ON P.cpf = D.manager_cpf;

--30. Uma subconsulta com uso de ANY ou SOME
SELECT employee_cpf, wage, job_title, worked_years
FROM employees
WHERE worked_years >
SOME ( SELECT worked_years FROM employees 
		WHERE worked_years < 7 );

--31. Uma subconsulta com uso de ALL
SELECT name FROM persons
WHERE birthdate < ALL (
  SELECT birthdate FROM persons
  WHERE birthdate > to_date('01/01/1850', 'dd/mm/yyyy')
);

--32. Uma subconsulta com uso de EXISTS/NOT EXISTS
SELECT A.name FROM artifacts A
WHERE exists(
  SELECT S.artifact_code FROM sale S
  WHERE A.artifact_code = S.artifact_code
);

--33. Uma subconsulta com uso de ALIAS com consultas aninhadas (ALIAS externo sendo referenciado na subconsulta)

--34. Uso de UNION
( SELECT employee_cpf FROM employees)
UNION
	(SELECT cpf FROM persons)

--35. Uso de INTERSECT
--funcionarios que tiraram ferias
(select cpf from persons)
intersect
	(select employee_cpf from employee_vacancies);

--36. Uso de MINUS
--funcionarios que nao tiraram ferias
(select cpf from persons)
minus
	(select employee_cpf from employee_vacancies);

--37. INSERT com subconsulta

INSERT INTO sale
(employee_cpf, client_cpf, artifact_code, sale_number)
SELECT 009, client_cpf, 100, 412
FROM clients
WHERE client_cpf = 001;

--38. UPDATE com subconsulta
UPDATE sale
SET employee_cpf = 003
WHERE sale_number = 412;

--40. Uso de GRANT
GRANT SELECT ON employees TO acs;

--42. Subconsulta dentro da cláusula FROM (VIEW implícita)
SELECT name FROM (
  SELECT name, department_code FROM departments
);

--43. Operação aritmética com função de agregação como operador
SELECT employee_cpf, (wage * 1.60) AS new_wage
FROM employees WHERE wage < AVG(wage) FROM employees;

--44. Uso de BETWEEN com valores numéricos retornados por funções de agregação
SELECT wage FROM employees
WHERE employees.wage > (
  SELECT avg(wage) FROM employees
);

--45. Junção entre três tabelas usando INNER JOIN ou OUTER JOIN
select p.name
from persons as p
INNER JOIN sale as s ON p.cpf = s.client_cpf 
INNER JOIN instruct as i ON p.cpf = i.cpf;

--47 EXISTS com mais de uma tabela, sem fazer junção
SELECT *
FROM sale
WHERE EXISTS (SELECT *
FROM employees
WHERE sale.employee_cpf = employees.employee_cpf);

--48 Bloco anônimo com declaração de variável e instrução
DECLARE
   sale_num sale.sale_number%TYPE;
BEGIN
   sale_num := 2;
   UPDATE sale SET sale_number = 20 WHERE sale_number = sale_num;
END;
/


--56. Recuperação de dados para variável
--55. FOR LOOP
DECLARE
  bomb_number INTEGER := 0;
BEGIN
    SELECT artifact_code INTO bomb_number FROM artifacts
    WHERE name = 'C-4';
    --LOOP

    --EXIT [WHEN ];
    --END LOOP;
END;

--57 Recuperação de dados para registro
select * from sale as of timestamp systimestamp - interval '5' minute;

--58 Output de string com variável
set serveroutput on format wrapped;
declare
numero NUMBER := 10;
begin
    DBMS_OUTPUT.put_line('Vendemos ' || numero || ' armas');
end;
/

--67 Uso de procedimento dentro de outro bloco PL (pode-se usar um dos procedimentos
criados anteriormente)

CREATE OR REPLACE PROCEDURE change_emp (sale_number NUMBER) AS
   tot_emps NUMBER;
   BEGIN
      UPDATE sale
      SET employee_cpf = 003
      WHERE sale_number = change_emp.sale_number;
   tot_emps := tot_emps - 1;
   END;
/

BEGIN
   change_emp(20);
END;
/

--68 Função sem parâmetro

CREATE OR REPLACE FUNCTION get_cpf 
   RETURN NUMBER 
   IS acc_bal NUMBER;
   BEGIN 
      SELECT employee_cpf 
      INTO acc_bal 
      FROM sale 
      WHERE sale_number = 20; 
      RETURN(acc_bal); 
    END;
/


--77 TRIGGER de comando
--78 Uso de NEW em TRIGGER de inserção

CREATE OR REPLACE TRIGGER addedSale
BEFORE INSERT
ON sale
FOR EACH ROW
BEGIN
	DBMS_OUTPUT.put_line('New sale number= ' || :NEW.sale_number );
END addedSale;
/

--87 Uso de função dentro de uma consulta SQL (pode-se usar uma das funções criadas
--anteriormente)
SELECT *
FROM sale
WHERE sale_number = get_cpf;


--88 Registro como parâmetro de função ou procedimento

CREATE OR REPLACE PROCEDURE show_sale_number (sale_in IN sale%ROWTYPE)
IS
BEGIN
   DBMS_OUTPUT.put_line (sale_in.sale_number);
END;
/

DECLARE
  l_sale sale%ROWTYPE;
BEGIN
  SELECT *
    INTO l_sale
    FROM sale
   WHERE sale_number = 1;
   show_sale_number(l_sale);
END;
/
