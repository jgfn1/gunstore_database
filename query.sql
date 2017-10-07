--2. Uso de BETWEEN com datas
SELECT cep FROM addresses
WHERE cep BETWEEN 000 AND 006;

--4. Uso de IN com subconsulta
SELECT client_cpf FROM clients
WHERE client_cpf IN (
  SELECT client_cpf FROM instruct
);