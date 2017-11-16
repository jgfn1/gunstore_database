DROP TYPE tp_adress force;
DROP TYPE tp_phones force;
DROP TYPE tp_persons force;
DROP TYPE tp_employees force;
DROP TYPE tp_clients force;
DROP TYPE tp_department force;
DROP TYPE tp_artifact force;
DROP TYPE tp_overtimes force;
DROP TYPE tp_vacancies force;

CREATE OR REPLACE TYPE tp_adress AS OBJECT(
	zipcode integer,
	street varchar2(100)
)FINAL;
/
CREATE OR REPLACE TYPE tp_phones AS TABLE OF VARCHAR2 (9);
/

--2. CriaÃ§Ã£o de um tipo que contenha um atributo que seja de um outro tipo
--4. CriaÃ§Ã£o de um tipo que contenha um atributo que seja de um tipo NESTED TABLE
CREATE OR REPLACE TYPE tp_persons AS OBJECT(
	cpf INTEGER,
	name VARCHAR2(100),
	birthdate DATE,
	sex VARCHAR2(1),
	adress tp_adress,
	phones tp_phones
)NOT FINAL  NOT INSTANTIABLE; -- THERE WILL BE SUBCLASSES OF tp_persons BUT THERE WILL NOT EXISTS A INSTANCE tp_persons, someone is either a employeer or a client
/

CREATE OR REPLACE TYPE tp_department AS OBJECT(
	department_code INTEGER,
 	name VARCHAR2 (100),
 	phone_extension INTEGER, --In Portuguese it is called "Ramal".
 	manager_cpf REF tp_persons
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
    --1. CriaÃ§Ã£o de tipo e subtipo
CREATE OR REPLACE TYPE tp_employees UNDER tp_persons(
	wage INTEGER,
  	worked_years INTEGER,
  	job_title VARCHAR2(100),	
  	ref_supervisor REF tp_employees,
  	ref_department_code REF tp_department
)FINAL ;
/

CREATE OR REPLACE TYPE tp_clients UNDER tp_persons(
	purchases_number INTEGER,
	heavy_guns_license BINARY_DOUBLE, -- 1 - Have the License | 0 - Don't.
  	training_end_register BINARY_DOUBLE -- 1 - Finished the training | 0 - Don't.
)FINAL;
/

CREATE OR REPLACE TYPE tp_artifact AS OBJECT(
	artifact_code INTEGER,
	artifact_name VARCHAR2 (100),
	manufacturer_name VARCHAR2(100),
	manufacture_date DATE,
	sale_date DATE
)FINAL;
/

CREATE OR REPLACE TYPE tp_overtimes AS OBJECT(
	overtime_date DATE,
	start_time TIMESTAMP,
	end_time TIMESTAMP,
    ref_employee REF tp_employees
)FINAL;
/

CREATE OR REPLACE TYPE tp_vacancies AS OBJECT(
  vacancy_number INTEGER,
  load_unload BINARY_DOUBLE, -- 1 - Load | 0 - Unload
  floor INTEGER,
  ref_employee REF tp_employees
)FINAL;
/

-->>monitoria apenas<< estarei limitando uma venda a 2 objetos aqui para exemplificar o uso de varray
CREATE OR REPLACE TYPE tp_artifacts_sale AS varray (2) of tp_artifact;
/
--3. CriaÃ§Ã£o de um tipo que contenha um atributo que seja de um tipo VARRAY
CREATE OR REPLACE TYPE tp_sale AS OBJECT(
	sale_number INTEGER,
	date_hour TIMESTAMP,
    ref_artifact tp_artifact_sale,
	ref_client REF tp_clients,
	ref_employee REF tp_employees
)FINAL;
/

CREATE OR REPLACE TYPE tp_instruct AS OBJECT(
	ref_client REF tp_clients,
	ref_employee REF tp_employees
)FINAL;
/
