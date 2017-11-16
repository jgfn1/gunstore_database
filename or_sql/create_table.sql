
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

--2. Criação de um tipo que contenha um atributo que seja de um outro tipo
--4. Criação de um tipo que contenha um atributo que seja de um tipo NESTED TABLE
CREATE OR REPLACE TYPE tp_persons AS OBJECT(
	cpf INTEGER,
	name VARCHAR2(100),
	birthdate DATE,
	adress tp_adress,
	phones tp_phones
)NOT FINAL  NOT INSTANTIABLE; -- THERE WILL BE SUBCLASSES OF tp_persons BUT THERE WILL NOT EXISTS A INSTANCE tp_persons, someone is either a employeer or a client
/
--14. Alteração de supertipo com propagação de mudança
ALTER TYPE tp_persons ADD ATRIBUTE(sex VARCHAR2(1)) CASCADE;

CREATE OR REPLACE TYPE tp_department AS OBJECT(
	department_code INTEGER,
 	name VARCHAR2 (100),
 	phone_extension INTEGER --In Portuguese it is called "Ramal".
)FINAL;
/

 --1. Criação de tipo e subtipo
CREATE OR REPLACE TYPE tp_employees UNDER tp_persons(
	wage INTEGER,
  	worked_years INTEGER,
  	job_title VARCHAR2(100),	
  	ref_supervisor REF tp_employees,
  	ref_department_code REF tp_department
)FINAL ;
/
--11. Alteração de tipo: adição de atributo
ALTER TYPE tp_department ADD(manager_cpf REF tp_persons);

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
--3. Criação de um tipo que contenha um atributo que seja de um tipo VARRAY
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

ALTER TYPE tp_department DROP ATRIBUTE (manager_cpf REF tp_persons) CASCADE; 

CREATE TABLE tb_department of tp_department(
	PRIMARY KEY (department_code),
	name NOT NULL,
	phone_extension NOT NULL
);

CREATE TABLE tb_employees of tp_employees(
	PRIMARY KEY (cpf),
	name NOT NULL,
	birthdate NOT NULL,
	sex NOT NULL,
	wage NOT NULL,
	worked_years NOT NULL,
	job_title NOT NULL,
	FOREIGN KEY (ref_department_code) REFERENCES tb_department
)NESTED TABLE phone AS tb_phone_tec;

ALTER TYPE tp_department MODIFY ATRIBUTE (manager_cpf REF tp_persons) CASCADE;

CREATE TABLE tb_clients of tp_clients(
	PRIMARY KEY (cpf),
	name NOT NULL,
	birthdate NOT NULL,
	sex NOT NULL,
	purchases_number NOT NULL,
	heavy_guns_license NOT NULL,
	training_end_register NOT NULL
)NESTED TABLE phone AS tb_phone_cli;

CREATE TABLE tb_artifact of tp_artifact(
	PRIMARY KEY (artifact_code),
	artifact_name NOT NULL,
	 manufacturer_name NOT NULL,
	 manufacture_date NOT NULL,
	 sale_date
);

CREATE TABLE tb_overtimes of tp_overtimes(
	PRIMARY KEY(overtime_date),
	start_time NOT NULL,
	end_time NOT NULL,
	FOREIGN KEY (ref_employee) REFERENCES tb_employees
);

CREATE TABLE tb_vacancies of tp_vacancies(
	PRIMARY KEY(vacancy_number, ref_employee),
	load_unload NOT NULL,
	floor NOT NULL,
	FOREIGN KEY (ref_employee) REFERENCES tb_employees
);
--0k
CREATE TABLE tb_sale of tp_sale(
	PRIMARY KEY(employee_cpf, client_cpf, artifact_code),
	FOREIGN KEY(employee_cpf) REFERENCES tb_employees,
	FOREIGN KEY(client_cpf) REFERENCES tb_clients,
	FOREIGN KEY(artifact_code) REFERENCES tb_artifact,
	sale_number NOT NULL,
	date_hour NOT NULL
);
--ok
CREATE TABLE tb_instruct of tp_instruct(
	PRIMARY KEY(client_cpf, employee_cpf),
	FOREIGN KEY(client_cpf) REFERENCES tb_clients ,
	FOREIGN KEY(employee_cpf) REFERENCES tb_employees
);