CREATE TABLE addresses
(
  cep INTEGER, --CEP is the Brazilian equivalent to the American ZIP Code.
  street VARCHAR2(20),
  CONSTRAINT addresses_pkey
    PRIMARY KEY (cep)
);

CREATE TABLE departments
(
  department_code INTEGER,
  name VARCHAR2(20),
  phone_extension INTEGER, --In Portuguese it is called "Ramal".
  manager_cpf INTEGER,
  CONSTRAINT departments_pkey
    PRIMARY KEY (department_code),
  CONSTRAINT departments_fkey
    FOREIGN KEY (manager_cpf) REFERENCES employees(employee_cpf)
);

CREATE TABLE persons
(
  cpf INTEGER, --CPF is the Brazilian equivalent to the American Social Security Number.
  name VARCHAR2(20),
  birthdate DATE,
  sex VARCHAR2(1),
  CONSTRAINT persons_pkey
    PRIMARY KEY (cpf),
);

CREATE TABLE phones
(
  cpf INTEGER,
  phone_number INTEGER,
  CONSTRAINT phones_pkey1
    PRIMARY KEY (cpf),
  CONSTRAINT phones_pkey2
    PRIMARY KEY (phone_number),
  CONSTRAINT phones_fkey
    FOREIGN KEY (cpf) REFERENCES persons(cpf)
);

CREATE TABLE employees
(
  employee_cpf INTEGER,
  wage INTEGER,
  worked_years INTEGER,
  job_title VARCHAR2(20),
  supervisor_cpf INTEGER,
  department_code INTEGER,
  CONSTRAINT employees_pkey
    PRIMARY KEY (employee_cpf),
  CONSTRAINT employees_fkey
    FOREIGN KEY (supervisor_cpf) REFERENCES employees(employee_cpf),
  CONSTRAINT persons_fkey1
    FOREIGN KEY (department_code) REFERENCES departments(department_code)
);

CREATE TABLE clients
(
  client_cpf INTEGER,
  purchases_number INTEGER,
  heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  training_end_register BINARY_DOUBLE, -- 1 - Finished the training | 0 - Don't.
  CONSTRAINT clients_pkey
    PRIMARY KEY (client_cpf),
  CONSTRAINT clients_fkey
    FOREIGN KEY (client_cpf) REFERENCES persons(cpf)
);

CREATE TABLE artifacts
(
  artifact_code INTEGER,
  name VARCHAR2(20),
  manufacturer_name VARCHAR2(20),
  manufacture_date DATE,
  sale_date DATE,
  CONSTRAINT artifacts_pkey
    PRIMARY KEY (artifact_code)
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