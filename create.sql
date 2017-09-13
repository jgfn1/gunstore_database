CREATE TABLE addresses
(
  cep INTEGER, --CEP is the Brazilian equivalent to the American ZIP Code.
  street VARCHAR2(20)
);

CREATE TABLE departments
(
  department_code INTEGER,
  name VARCHAR2(20),
  phone_extension INTEGER, --In Portuguese it is called "Ramal".
  manager_cpf INTEGER
);

CREATE TABLE persons
(
  cpf INTEGER, --CPF is the Brazilian equivalent to the American Social Security Number.
  name VARCHAR2(20),
  birthdate DATE,
  sex VARCHAR2(1),
  department_code INTEGER
);

CREATE TABLE phones
(
  cpf INTEGER,
  phone_number INTEGER
);

CREATE TABLE employees
(
  employee_cpf INTEGER,
  wage INTEGER,
  worked_years INTEGER,
  job_title VARCHAR2(20),
  supervisor_cpf INTEGER
);

CREATE TABLE clients
(
  client_cpf INTEGER,
  purchases_number INTEGER,
  heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  training_end_register BINARY_DOUBLE -- 1 - Finished the training | 0 - Don't.
);

CREATE TABLE artifacts
(
  artifact_code INTEGER,
  name VARCHAR2(20),
  manufacturer_name VARCHAR2(20),
  manufacture_date DATE,
  sale_date DATE
);

CREATE TABLE overtimes --Brazilian "hora extra"
(
  overtime_date DATE,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  employee_cpf INTEGER
);

CREATE TABLE employee_vacancies
(
  employee_cpf INTEGER,
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER
);

CREATE TABLE sales
(
  employee_cpf INTEGER,
  client_cpf INTEGER,
  artifact_code INTEGER,
  sale_number INTEGER,
  date_hour TIMESTAMP
);

CREATE TABLE instruct
(
  client_cpf INTEGER,
  employee_cpf INTEGER
)

