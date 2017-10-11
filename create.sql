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


CREATE TABLE addresses(
  cep INTEGER,      --cep is the brazilian to 'zipcode'
  street VARCHAR2 (100),
  CONSTRAINT addresses_pkey PRIMARY KEY (cep)
);

--15. Usar ALTER TABLE para Adicionar Colunas
--16. Usar ALTER TABLE para Remover de Coluna
alter table addresses add (reference_point varchar2(30))
alter table addresses drop (reference_point)	

CREATE TABLE departments(
  department_code INTEGER,
  name VARCHAR2 (100),
  phone_extension INTEGER, --In Portuguese it is called "Ramal".
  manager_cpf INTEGER NOT NULL,
  CONSTRAINT departments_pkey PRIMARY KEY (department_code)
);

CREATE TABLE persons
(
  cpf INTEGER, --CPF is the Brazilian equivalent to the American Social Security Number.
  name VARCHAR2 (100),
  birthdate DATE,
  sex VARCHAR2(1)  check (sex= 'M' or sex = 'F'),
  P_cep INTEGER,
  CONSTRAINT persons_pkey PRIMARY KEY (cpf),
  CONSTRAINT persons_fkey FOREIGN KEY (P_cep) REFERENCES addresses(cep)
);

CREATE TABLE phones
(
  cpf INTEGER,
  phone_number INTEGER,
  CONSTRAINT phones_pkey PRIMARY KEY (cpf, phone_number),
  CONSTRAINT phones_fkey FOREIGN KEY (cpf) REFERENCES persons (cpf)
);

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

CREATE TABLE clients
(
  client_cpf INTEGER,
  purchases_number INTEGER,
  heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  training_end_register BINARY_DOUBLE, -- 1 - Finished the training | 0 - Don't.
  CONSTRAINT clients_pkey PRIMARY KEY (client_cpf),
  CONSTRAINT clients_fkey FOREIGN KEY (client_cpf) REFERENCES persons (cpf)
);

CREATE TABLE artifacts
(
  artifact_code INTEGER,
  name VARCHAR2 (100),
  manufacturer_name VARCHAR2(100),
  manufacture_date DATE,
  sale_date DATE,
  CONSTRAINT artifacts_pkey PRIMARY KEY (artifact_code)
);

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

CREATE TABLE employee_vacancies
(
  employee_cpf INTEGER,
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER,
  CONSTRAINT employee_vacancies_pkey PRIMARY KEY (employee_cpf, vacancy_number),
  CONSTRAINT employee_vacancies_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);

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

CREATE TABLE instruct
(
  client_cpf INTEGER,
  employee_cpf INTEGER,
  CONSTRAINT instruct_pkey PRIMARY KEY (client_cpf, employee_cpf),
  CONSTRAINT instruct_fkey FOREIGN KEY (client_cpf) REFERENCES clients (client_cpf),
  CONSTRAINT instruct_fkey1 FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);

ALTER TABLE departments ADD CONSTRAINT departments_fkey FOREIGN KEY (manager_cpf) REFERENCES employees (employee_cpf);