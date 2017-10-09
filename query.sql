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

--42. Subconsulta dentro da cláusula FROM (VIEW implícita)
SELECT name FROM (
  SELECT name, department_code FROM departments
);

----44. Uso de BETWEEN com valores numéricos retornados por funções de agregação
SELECT wage FROM employees
WHERE employees.wage > (
  SELECT avg(wage) FROM employees
);
