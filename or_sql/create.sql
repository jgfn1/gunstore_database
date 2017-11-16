
CREATE OR REPLACE TYPE tp_adress AS OBJECT(
	zipcode integer
	street varchar2(100)
)FINAL;
/
CREATE OR REPLACE TYPE tp_phones AS TABLE OF VARCHAR2 (9);
/
CREATE OR REPLACE TYPE tp_persons AS OBJECT(
	cpf INTEGER,
	name VARCHAR2(100),
	birthdate DATE,
	sex VARCHAR2(1),
	adress tp_adress,
	phones tp_phones
)NOT FINAL  NOT INSTANCIABLE; -- THERE WILL BE SUBCLASSES OF tp_persons BUT THERE WILL NOT EXISTS A INSTANCE tp_persons, someone is either a employeer or a client
