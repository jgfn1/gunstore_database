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

--6. Uso de ORDER BY
SELECT sale_number FROM sale
WHERE sale_number > 3
ORDER BY date_hour;

--7. Criação de VIEW
CREATE VIEW ocuppied_vacancies AS
SELECT employee_cpf, vacancy_number FROM employee_vacancies;

--8. Consulta sobre VIEW
SELECT * FROM ocuppied_vacancies;

--9. Deleção de VIEW
DROP VIEW occupied_vacancies;

--10. Criar CHECKs
ALTER TABLE employees
ADD (CONSTRAINT employees_wage_check CHECK (wage > 200))/
ALTER TABLE persons
ADD (CONSTRAINT persons_name_check CHECK (name <> 'Adolf Hitler'));

--19. Função de agregação com GROUP BY
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code;

--21. Uso de HAVING
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code
HAVING sum(wage) > 200;

--22. Uso de HAVING com subconsulta
SELECT department_code, sum(wage) FROM employees
GROUP BY department_code
HAVING sum(wage) > (
  SELECT sum(worked_years) FROM employees;
);

--29. Junção usando FULL OUTER JOIN
SELECT P.name, D.name FROM persons P FULL OUTER JOIN departments D
  ON P.cpf = D.manager_cpf;

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

--39. DELETE com subconsulta
DELETE FROM employees
WHERE wage > (
    SELECT avg(wage) FROM employees
);

-- 40. Uso de GRANT
GRANT SELECT ON employees TO human_resources_maganer;

-- 41. Uso de REVOKE
REVOKE SELECT ON employees FROM human_resources_maganer;

--42. Subconsulta dentro da cláusula FROM (VIEW implícita)
SELECT name FROM (
  SELECT name, department_code FROM departments
);

--43. Operação aritmética com função de agregação como operador
SELECT employee_cpf, (wage * 1.60) AS new_wage
FROM employees WHERE wage < (
  SELECT avg(wage) FROM employees
);

--44. Uso de BETWEEN com valores numéricos retornados por funções de agregação
SELECT wage FROM employees
WHERE employees.wage BETWEEN (SELECT avg(wage) FROM employees)
  AND (SELECT avg(wage) - 1 FROM employees);