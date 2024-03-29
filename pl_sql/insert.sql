INSERT INTO addresses VALUES (000, 'Avenida Presidente Jair Messias Bolsonaro');
INSERT INTO addresses VALUES (001, 'Avenida Presidente Dr. Enéas Carneiro');
INSERT INTO addresses VALUES (002, 'Avenida Imperador Dom Pedro II');
INSERT INTO addresses VALUES (003, 'Avenida Presidente Donald J. Trump');
INSERT INTO addresses VALUES (004, 'Avenida Princesa Isabel');
INSERT INTO addresses VALUES (005, 'Avenida José Bonifácio');
INSERT INTO addresses VALUES (006, 'Avenida Olavo de Carvalho');
INSERT INTO addresses VALUES (007, 'Rua do Livre Mercado');
INSERT INTO addresses VALUES (008, 'Rua da Monarquia');
INSERT INTO addresses VALUES (009, 'Rua do Armamento Civil');
INSERT INTO addresses VALUES (010, 'Rua da Vida');

INSERT INTO departments VALUES (000, 'Pistolas/Revólveres', 000, 002);
INSERT INTO departments VALUES (001, 'Armas Brancas', 001, 002);
INSERT INTO departments VALUES (010, 'Fuzis/Rifles', 010, 010);
INSERT INTO departments VALUES (011, 'Metralhadoras', 011, 003);
INSERT INTO departments VALUES (100, 'Espingardas', 100, 010);
INSERT INTO departments VALUES (101, 'Bombas', 101, 009);

INSERT INTO persons VALUES (000, 'Barão de Mauá', to_date('28/12/1813', 'dd/mm/yyyy'), 'M', 000);
INSERT INTO persons VALUES (001, 'Duque de Caxias', to_date('25/08/1803', 'dd/mm/yyyy'), 'M', 001);
INSERT INTO persons VALUES (002, 'Winston Churchill', to_date('30/11/1874', 'dd/mm/yyyy'), 'M', 002);
INSERT INTO persons VALUES (003, 'Ronald Reagan', to_date('06/02/1911', 'dd/mm/yyyy'), 'M', 003);
INSERT INTO persons VALUES (004, 'Machado de Assis', to_date('21/06/1839', 'dd/mm/yyyy'), 'M', 004);
INSERT INTO persons VALUES (005, 'Dom Pedro I', to_date('12/10/1798', 'dd/mm/yyyy'), 'M', 005);
INSERT INTO persons VALUES (006, 'Ariano Suassuna', to_date('16/06/1927', 'dd/mm/yyyy'), 'M', 006);
INSERT INTO persons VALUES (007, 'Plínio Salgado', to_date('22/01/1895', 'dd/mm/yyyy'), 'M', 007);
INSERT INTO persons VALUES (008, 'Coronel Brilhante Ustra', to_date('28/07/1932', 'dd/mm/yyyy'), 'M', 008);
INSERT INTO persons VALUES (009, 'Harry S. Truman', to_date('26/12/1972', 'dd/mm/yyyy'), 'M', 009);
INSERT INTO persons VALUES (010, 'Tomás de Aquino', to_date('07/03/1274', 'dd/mm/yyyy'), 'M', 010);

INSERT INTO phones VALUES (009, 0000);
INSERT INTO phones VALUES (000, 0001);
INSERT INTO phones VALUES (001, 0002);
INSERT INTO phones VALUES (002, 0003);
INSERT INTO phones VALUES (003, 0004);
INSERT INTO phones VALUES (004, 0005);
INSERT INTO phones VALUES (005, 0006);
INSERT INTO phones VALUES (006, 0007);
INSERT INTO phones VALUES (007, 0008);
INSERT INTO phones VALUES (008, 0009);
INSERT INTO phones VALUES (010, 0010);

INSERT INTO employees VALUES (002, 1000, 10, 'Gestor de Pistolas/Revólveres | Gestor de Armas Brancas', 012, 000);
INSERT INTO employees VALUES (003, 1200, 7, 'Gestor de Metralhadoras | Vendedor | Instrutor de Tiro', 013, 000);
INSERT INTO employees VALUES (009, 1100, 20, 'Gestor de Bombas | Vendedor | Instrutor de Tiro', 010, 000);
INSERT INTO employees VALUES (010, 300, 5, 'Gestor de Rifles/Fuzis | Gestor de Espingardas', 010, 000);

INSERT INTO clients VALUES (000, 3, 0, 0);
INSERT INTO clients VALUES (001, 300, 1, 1);
INSERT INTO clients VALUES (004, 5, 0, 0);
INSERT INTO clients VALUES (005, 1, 1, 1);
INSERT INTO clients VALUES (006, 20, 0, 1);
INSERT INTO clients VALUES (007, 7, 1, 1);
INSERT INTO clients VALUES (008, 5000, 1, 1);

INSERT INTO artifacts VALUES (000, 'Desert Eagle .50C', 'Israel Military Industries', to_date('12/07/1997', 'dd/mm/yyyy'), to_date('01/01/2000', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (001, 'Katana', 'Hattori Hanzo', to_date('04/11/1580', 'dd/mm/yyyy'), to_date('10/08/2004', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (010, 'Kalashnikova 1947 (AK-47)', 'Mikhail Kalashnikov', to_date('01/01/1947', 'dd/mm/yyyy'), to_date('29/09/2017', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (011, 'Uzi Micro SMG ', 'Israel Military Industries', to_date('13/05/1948', 'dd/mm/yyyy'), to_date('21/09/1951', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (100, 'Winchester Model 1912 (Shotgun 12)', 'Winchester Repeating Arms Company', to_date('12/12/1912', 'dd/mm/yyyy'), to_date('30/10/2006', 'dd/mm/yyyy'));
INSERT INTO artifacts VALUES (101, 'C-4', 'Phillips Petroleum Company', to_date('31/03/1958', 'dd/mm/yyyy'), to_date('01/07/1987', 'dd/mm/yyyy'));

--INSERT INTO overtimes VALUES (NULL , NULL, NULL, 002);
--INSERT INTO overtimes VALUES (NULL , NULL, NULL, 003);
INSERT INTO overtimes VALUES (to_date('21/07/2016', 'dd/mm/yyyy'), (CURRENT_TIMESTAMP), NULL, 009);
INSERT INTO overtimes VALUES (to_date('01/07/1998', 'dd/mm/yyyy'), (CURRENT_TIMESTAMP), NULL, 010);

INSERT INTO employee_vacancies VALUES (002, 00, 0, 00);
INSERT INTO employee_vacancies VALUES (003, 01, 1, 01);
INSERT INTO employee_vacancies VALUES (009, 10, 0, 00);
INSERT INTO employee_vacancies VALUES (010, 11, 1, 01);


INSERT INTO sale VALUES (009, 001, 101, 1, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 004, 100, 2, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 001, 010, 3, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (009, 008, 010, 4, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (003, 007, 011, 5, (CURRENT_TIMESTAMP));
INSERT INTO sale VALUES (009, 000, 001, 6, (CURRENT_TIMESTAMP));

INSERT INTO instruct VALUES (001, 009);
INSERT INTO instruct VALUES (005, 009);
INSERT INTO instruct VALUES (008, 003);