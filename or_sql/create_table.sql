/*
 serie de drops se nescessario:
 */
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