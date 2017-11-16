
CREATE OR REPLACE TYPE tp_adress AS OBJECT(
	zipcode integer,
	street varchar2(100)
)FINAL;
/

CREATE OR REPLACE TYPE tp_phones AS TABLE OF VARCHAR2 (9);
/

--2. Criação de um tipo que contenha um atributo que seja de um outro tipo
--4. Criação de um tipo que contenha um atributo que seja de um tipo NESTED TABLE
CREATE OR REPLACE TYPE tp_persons AS OBJECT(
	cpf INTEGER,
	name VARCHAR2(100),
	birthdate DATE,
	sex VARCHAR2(1),
	adress tp_adress,
	phones tp_phones
)NOT FINAL  NOT INSTANCIABLE; -- THERE WILL BE SUBCLASSES OF tp_persons BUT THERE WILL NOT EXISTS A INSTANCE tp_persons, someone is either a employeer or a client

/*
CREATE TABLE departments(
  department_code INTEGER,
  name VARCHAR2 (100),
  phone_extension INTEGER, --In Portuguese it is called "Ramal".
  manager_cpf INTEGER NOT NULL,
  CONSTRAINT departments_pkey PRIMARY KEY (department_code)
);
*/


CREATE OR REPLACE TYPE tp_departments AS OBJECT(
	department_code INTEGER,
 	name VARCHAR2 (100),
 	phone_extension INTEGER, --In Portuguese it is called "Ramal".
 	manager_cpf REF tp_employees
)FINAL;
/
/*
CREATE TABLE employees
(
  employee_cpf INTEGER,
  wage INTEGER,
  worked_years INTEGER,
  job_title VARCHAR2(100),
  supervisor_cpf INTEGER,
  department_code INTEGER,
  CONSTRAINT employees_pkey PRIMARY KEY (employee_cpf),
	CONSTRAINT employees_fkey FOREIGN KEY (employee_cpf) REFERENCES persons (cpf),--precisa
  CONSTRAINT employees_fkey1 FOREIGN KEY (supervisor_cpf) REFERENCES employees (employee_cpf),
  CONSTRAINT persons_fkey2 FOREIGN KEY (department_code) REFERENCES departments (department_code)
);
*/
    --1. Criação de tipo e subtipo
CREATE OR REPLACE TYPE tp_employees UNDER tp_persons AS OBJECT(
	wage INTEGER,
  	worked_years INTEGER,
  	job_title VARCHAR2(100),	
  	ref_supervisor REF tp_empregado,
  	ref_department_code REF tp_department
)FINAL ;
/
/*
CREATE TABLE clients
(
  client_cpf INTEGER,
  purchases_number INTEGER,
  heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  training_end_register BINARY_DOUBLE, -- 1 - Finished the training | 0 - Don't.
  CONSTRAINT clients_pkey PRIMARY KEY (client_cpf),
  CONSTRAINT clients_fkey FOREIGN KEY (client_cpf) REFERENCES persons (cpf)
);

*/
CREATE OR REPLACE TYPE tp_clients UNDER tp_persons AS OBJECT(
	purchases_number INTEGER,
	heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  	training_end_register BINARY_DOUBLE -- 1 - Finished the training | 0 - Don't.
)FINAL;
/
/*
CREATE TABLE artifacts
(
  artifact_code INTEGER,
  name VARCHAR2 (100),
  manufacturer_name VARCHAR2(100),
  manufacture_date DATE,
  sale_date DATE,
  CONSTRAINT artifacts_pkey PRIMARY KEY (artifact_code)
);
*/
CREATE OR REPLACE TYPE tp_artifacts AS OBJECT(
	artifact_code INTEGER,
	name VARCHAR2 (100),
	manufacturer_name VARCHAR2(100),
	manufacture_date DATE,
	sale_date DATE
)FINAL;
/
/*
CREATE TABLE overtimes --Brazilian "hora extra"
(
  overtime_date DATE,
  start_time TIMESTAMP,
  end_time TIMESTAMP,
  employee_cpf INTEGER NOT NULL,
  CONSTRAINT overtimes_pkey PRIMARY KEY (overtime_date),
  CONSTRAINT overtimes_const UNIQUE (employee_cpf),
  CONSTRAINT overtimes_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
  
);*/
CREATE OR REPLACE TYPE tp_overtimes AS OBJECT(
	overtime_date DATE,
	start_time TIMESTAMP,
	end_time TIMESTAMP,
	employee_cpf INTEGER NOT NULL
)FINAL;
/
/*

CREATE TABLE employee_vacancies
(
  employee_cpf INTEGER,
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER,
  CONSTRAINT employee_vacancies_pkey PRIMARY KEY (employee_cpf, vacancy_number),
  CONSTRAINT employee_vacancies_fkey FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);
*/
CREATE OR REPLACE TYPE tp_vacancies AS OBJECT(
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER,
  ref_employee REF ep_employess
)FINAL;
/
/*CREATE TABLE sale
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
);*/

-->>monitoria apenas<< estarei limitando uma venda a 4 objetos aqui para exemplificar o uso de varray
CREATE OR REPLACE TYPE tp_artifacts_sale AS varray (4) of tp_artifacts;
/
--3. Criação de um tipo que contenha um atributo que seja de um tipo VARRAY
CREATE OR REPLACE TYPE tp_sale AS OBJECT(
	sale_number INTEGER,
	date_hour TIMESTAMP,
	ref_client REF tp_client,
	ref_employee REF tp_employee,
	ref_artifact REF tp_artifact_sale
)FINAL;
/

/*CREATE TABLE instruct
(
  --client_cpf INTEGER,
  --employee_cpf INTEGER,
  --CONSTRAINT instruct_pkey PRIMARY KEY (client_cpf, employee_cpf),
  CONSTRAINT instruct_fkey FOREIGN KEY (client_cpf) REFERENCES clients (client_cpf),
  CONSTRAINT instruct_fkey1 FOREIGN KEY (employee_cpf) REFERENCES employees (employee_cpf)
);*/
CREATE OR REPLACE TYPE tp_instruct AS OBJECT(
	ref_client REF tp_client,
	ref_employee REF tp_employee
)FINAL;
/
