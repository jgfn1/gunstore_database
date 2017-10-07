--2. Uso de BETWEEN com datas
SELECT cep FROM addresses
WHERE cep BETWEEN 000 AND 006;

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

--10. Criar CHECKs
ALTER TABLE employees
ADD (CONSTRAINT employees_wage_check CHECK (wage > 200))
ADD (CONSTRAINT employees_name_check CHECK (name <> 'Adolf Hitler'));