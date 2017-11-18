DROP TYPE tp_adress force;
DROP TYPE tp_phones force;
DROP TYPE tp_persons force;
DROP TYPE tp_employees force;
DROP TYPE tp_clients force;
DROP TYPE tp_department force;
DROP TYPE tp_artifact force;
DROP TYPE tp_overtimes force;
DROP TYPE tp_vacancies force;
DROP TYPE tp_sale force;
DROP TYPE tp_instruct force;

CREATE OR REPLACE TYPE tp_adress AS OBJECT(
	zipcode integer,
	street varchar2(100)
)FINAL;
/
CREATE OR REPLACE TYPE tp_phones AS TABLE OF VARCHAR2(9);
/

--2. Criação de um tipo que contenha um atributo que seja de um outro tipo
--4. Criação de um tipo que contenha um atributo que seja de um tipo NESTED TABLE
CREATE OR REPLACE TYPE tp_persons AS OBJECT(
	cpf INTEGER,
    p_name VARCHAR2(100),
	birthdate DATE,
	adress tp_adress,
	phones tp_phones
)NOT FINAL NOT INSTANTIABLE; -- THERE WILL BE SUBCLASSES OF tp_persons BUT THERE WILL NOT EXISTS A INSTANCE tp_persons, someone is either a employeer or a client
/
--14. Alteração de supertipo com propagação de mudança
ALTER TYPE tp_persons ADD ATTRIBUTE(sex VARCHAR2(1)) CASCADE;

CREATE OR REPLACE TYPE tp_department AS OBJECT(
	department_code INTEGER,
 	d_name VARCHAR2 (100),
 	phone_extension INTEGER, --In Portuguese it is called "Ramal".
    manager_cpf INTEGER
)FINAL;
/
 --1. Criação de tipo e subtipo
CREATE OR REPLACE TYPE tp_employees UNDER tp_persons(
    wage INTEGER,
  	worked_years INTEGER,
  	job_title VARCHAR2(100),
  	ref_supervisor REF tp_employees,
  	department tp_department
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
	manufacture_date DATE
)FINAL;
/
--11. Alteração de tipo: adição de atributo
ALTER TYPE tp_artifact ADD ATTRIBUTE (sale_date DATE) CASCADE;

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

CREATE OR REPLACE TYPE tp_sale AS OBJECT(
	sale_number INTEGER,
	date_hour TIMESTAMP,
    ref_artifact REF tp_artifact,
	ref_client REF tp_clients,
	ref_employee REF tp_employees
)FINAL;
/

CREATE OR REPLACE TYPE tp_instruct AS OBJECT(
	ref_client REF tp_clients,
	ref_employee REF tp_employees
)FINAL;
/

DROP TABLE tb_employees CASCADE CONSTRAINTS;
DROP TABLE tb_clients CASCADE CONSTRAINTS;
DROP TABLE tb_artifact CASCADE CONSTRAINTS;
DROP TABLE tb_overtimes;
DROP TABLE tb_vacancies;
DROP TABLE tb_sale;
DROP TABLE tb_instruct;

CREATE TABLE tb_employees OF tp_employees(
	cpf PRIMARY KEY,
	p_name NOT NULL,
	birthdate NOT NULL,
  FOREIGN KEY (ref_supervisor) REFERENCES tb_employees,
  department NOT NULL
) NOT FINAL;
/

NESTED TABLE phones STORE AS tb_phone;

CREATE TABLE tb_clients of tp_clients(
	PRIMARY KEY (cpf),
	birthdate NOT NULL,
	sex NOT NULL
) 
NESTED TABLE phones STORE AS tb_phone_cli;

CREATE TABLE tb_artifact of tp_artifact(
	PRIMARY KEY (artifact_code),
	artifact_name NOT NULL,
    manufacturer_name NOT NULL,
    manufacture_date NOT NULL,
	sale_date NOT NULL
);

CREATE TABLE tb_overtimes of tp_overtimes(
	PRIMARY KEY(overtime_date),
	start_time NOT NULL,
	end_time NOT NULL,
	FOREIGN KEY (ref_employee) REFERENCES tb_employees
);

CREATE TABLE tb_vacancies of tp_vacancies(
	PRIMARY KEY(vacancy_number),
	load_unload NOT NULL,
	floor NOT NULL,
	FOREIGN KEY (ref_employee) REFERENCES tb_employees
);
--0k
CREATE TABLE tb_sale of tp_sale(
	PRIMARY KEY(sale_number),
    FOREIGN KEY (ref_artifact) REFERENCES tb_artifact,
    FOREIGN KEY(ref_employee) REFERENCES tb_employees,
	FOREIGN KEY(ref_client) REFERENCES tb_clients,
	date_hour NOT NULL
);
--ok
--17. Restri��o de escopo de refer�ncia
--garantinhdo que apenas clientes possam receber  treinamento 
CREATE TABLE tb_instruct of tp_instruct(
    ref_client SCOPE IS tb_clients,
    ref_employee SCOPE IS tb_employees
    );
