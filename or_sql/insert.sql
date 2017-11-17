INSERT INTO tb_artifact VALUES (000, 'Desert Eagle .50C', 'Israel Military Industries', to_date('12/07/1997', 'dd/mm/yyyy'), to_date('01/01/2000', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (001, 'Katana', 'Hattori Hanzo', to_date('04/11/1580', 'dd/mm/yyyy'), to_date('10/08/2004', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (010, 'Kalashnikova 1947 (AK-47)', 'Mikhail Kalashnikov', to_date('01/01/1947', 'dd/mm/yyyy'), to_date('29/09/2017', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (011, 'Uzi Micro SMG ', 'Israel Military Industries', to_date('13/05/1948', 'dd/mm/yyyy'), to_date('21/09/1951', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (100, 'Winchester Model 1912 (Shotgun 12)', 'Winchester Repeating Arms Company', to_date('12/12/1912', 'dd/mm/yyyy'), to_date('30/10/2006', 'dd/mm/yyyy'));
INSERT INTO tb_artifact VALUES (101, 'C-4', 'Phillips Petroleum Company', to_date('31/03/1958', 'dd/mm/yyyy'), to_date('01/07/1987', 'dd/mm/yyyy'));

INSERT INTO tb_clients VALUES (000, 'Barão de Mauá', to_date('28/12/1813', 'dd/mm/yyyy'), tp_adress(010, 'Rua da Vida'), 
                                tp_phones(40028922,34219595,800777700), 'M', 000, 1, 1);
INSERT INTO tb_clients VALUES (001, 'Duque de Caxias', to_date('25/08/1803', 'dd/mm/yyyy'), tp_adress(009, 'Rua do Armamento Civil'),
                               tp_phones(40038922,34219595,190), 'M', 001,1,1);

--inserindo gerente do setor de espingardas 
INSERT INTO tb_employees VALUES (010,
    'Tomás de Aquino',
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
    'Gestor de Pistolas/Revólveres | Gestor de Armas Brancas | Instrutor de Tiro',
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
    tp_department(000, 'Pistolas/Revólveres', 000, 009));
    
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