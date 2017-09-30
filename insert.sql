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

INSERT INTO persons VALUES (000, 'Barão de Mauá', 28/12/1813, 'M', 000);
INSERT INTO persons VALUES (001, 'Duque de Caxias', 25/08/1803, 'M', 001);
INSERT INTO persons VALUES (002, 'Winston Churchill', 30/11/1874, 'M', 002);
INSERT INTO persons VALUES (003, 'Ronald Reagan', 6/02/1911, 'M', 003);
INSERT INTO persons VALUES (004, 'Machado de Assis', 21/06/1839, 'M', 004);
INSERT INTO persons VALUES (005, 'Dom Pedro I', 12/10/1798, 'M', 005);
INSERT INTO persons VALUES (006, 'Ariano Suassuna', 16/06/1927, 'M', 006);
INSERT INTO persons VALUES (007, 'Plínio Salgado', 22/01/1895, 'M', 007);
INSERT INTO persons VALUES (008, 'Coronel Brilhante Ustra', 28/07/1932, 'M', 008);
INSERT INTO persons VALUES (009, 'Harry S. Truman', 26/12/1972, 'M', 009);
INSERT INTO persons VALUES (010, 'Tomás de Aquino', 07/03/1274, 'M', 010);

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

INSERT INTO employees VALUES (002, 1000, 10, 'Gestor de Pistolas/Revólveres | Gestor de Armas Brancas', 010, 000);
INSERT INTO employees VALUES (003, 1200, 7, 'Gestor de Metralhadoras | Vendedor | Instrutor de Tiro', 010, 000);
INSERT INTO employees VALUES (009, 1100, 20, 'Gestor de Bombas | Vendedor | Instrutor de Tiro', 010, 000);
INSERT INTO employees VALUES (010, 300, 5, 'Gestor de Rifles/Fuzis | Gestor de Espingardas', 010, 000);

