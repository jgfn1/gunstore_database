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

CREATE TABLE tb_employees of tp_employees(
	PRIMARY KEY (cpf),
	p_name NOT NULL,
	birthdate NOT NULL,
    FOREIGN KEY (ref_supervisor) REFERENCES tb_employees,
    department NOT NULL
)
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
INSERT INTO tb_artifact VALUES (000, 'Desert Eagle .50C', 'Israel Military Industries', to_date('12/07/1997', 'dd/mm/yyyy'), to_date('01/01/2000', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (001, 'Katana', 'Hattori Hanzo', to_date('04/11/1580', 'dd/mm/yyyy'), to_date('10/08/2004', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (010, 'Kalashnikova 1947 (AK-47)', 'Mikhail Kalashnikov', to_date('01/01/1947', 'dd/mm/yyyy'), to_date('29/09/2017', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (011, 'Uzi Micro SMG ', 'Israel Military Industries', to_date('13/05/1948', 'dd/mm/yyyy'), to_date('21/09/1951', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (100, 'Winchester Model 1912 (Shotgun 12)', 'Winchester Repeating Arms Company', to_date('12/12/1912', 'dd/mm/yyyy'), to_date('30/10/2006', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (101, 'C-4', 'Phillips Petroleum Company', to_date('31/03/1958', 'dd/mm/yyyy'), to_date('01/07/1987', 'dd/mm/yyyy'));

INSERT INTO tb_clients VALUES (000, 'Bar�o de Mau�', to_date('28/12/1813', 'dd/mm/yyyy'), tp_adress(010, 'Rua da Vida'), 
                                tp_phones(40028922,34219595,800777700), 'M', 000, 1, 1);
INSERT INTO tb_clients VALUES (001, 'Duque de Caxias', to_date('25/08/1803', 'dd/mm/yyyy'), tp_adress(009, 'Rua do Armamento Civil'),
                               tp_phones(40038922,34219595,190), 'M', 001,1,1);

--inserindo gerente do setor de espingardas 
INSERT INTO tb_employees VALUES (010,
    'Tom�s de Aquino',
    to_date('07/03/1274', 'dd/mm/yyyy'),
    tp_adress(019, 'Rua que sobe e desce'),
    tp_phones(814001,81342295, 0211240),
    'M',
    1300,
    15,
    'Gestor de Rifles/Fuzis | Gestor de Espingardas | Instrutor de Tiro',
    NULL,
    tp_department(100, 'Espingardas', 100, 010));
INSERT INTO tb_employees VALUES (
    002,
    'Winston Churchill',
    to_date('30/11/1874', 'dd/mm/yyyy'), 
    tp_adress(009, 'Rua do Armamento Civil'), 
    tp_phones(4001,342295,1240), 
    'M', 
    1000,
    10,
    'Gestor de Pistolas/Rev�lveres | Gestor de Armas Brancas | Instrutor de Tiro',
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 010), 
    tp_department(100, 'Espingardas', 100, 010));
    
INSERT INTO tb_employees VALUES (
    009,
    'Harry S. Truman',
    to_date('26/12/1972', 'dd/mm/yyyy'),
    tp_adress(099, 'AVENIDA BRASIL'), 
    tp_phones(40021,3422951,12401), 
    'M',
    1100,
    2, 
    ' Vendedor | Instrutor de Tiro',
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 010),
    tp_department(000, 'Pistolas/Rev�lveres', 000, 009));
    
INSERT INTO tb_instruct VALUES((SELECT REF(H) FROM tb_clients H WHERE H.CPF = 000),
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 010) );
    
INSERT INTO tb_instruct VALUES((SELECT REF(H) FROM tb_clients H WHERE H.CPF = 001),
   (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 010) );

INSERT INTO tb_overtimes VALUES(
    to_date('01/01/2018', 'dd/mm/yyyy'),
    (CURRENT_TIMESTAMP),
    to_date('01/02/2018', 'dd/mm/yyyy'),
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 010)
    );
INSERT INTO tb_overtimes VALUES(
    to_date('01/02/2018', 'dd/mm/yyyy'),
    (CURRENT_TIMESTAMP),
    to_date('01/03/2018', 'dd/mm/yyyy'),
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 009)
    );


INSERT INTO tb_sale VALUES(
    1,
    (CURRENT_TIMESTAMP),
    (SELECT REF(l) FROM tb_artifact l WHERE l.ARTIFACT_CODE = 011),
    (SELECT REF(H) FROM tb_clients H WHERE H.CPF = 000),
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 009)
);    
INSERT INTO tb_sale VALUES(
    2,
    (CURRENT_TIMESTAMP),
    (SELECT REF(l) FROM tb_artifact l WHERE l.ARTIFACT_CODE = 011),
    (SELECT REF(H) FROM tb_clients H WHERE H.CPF = 001),
    (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 009)
); 

INSERT INTO tb_vacancies VALUES(
    002,
    00,
    10,
   (SELECT REF(E) FROM tb_employees E WHERE E.cpf = 009)
);