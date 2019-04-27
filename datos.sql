DELETE FROM Reservas_Prereservas;
DELETE FROM Localidades;
DELETE FROM Gradas;
DELETE FROM Eventos;
DELETE FROM Participantes;
DELETE FROM Espectaculos;
DELETE FROM Recintos;
DELETE FROM Clientes;



INSERT INTO Espectaculos VALUES (1, 'Celta-Deportivo', 'Futbol');
INSERT INTO Espectaculos VALUES (2, 'Civil War', 'Pelicula');
INSERT INTO Espectaculos VALUES (3, 'Joaquin Sabina', 'Concierto');
INSERT INTO Espectaculos VALUES (4, 'Alex Ubago', 'Concierto');
INSERT INTO Espectaculos VALUES (5, 'Deportivo-Barcelona', 'Futbol');
INSERT INTO Espectaculos VALUES (6, 'El Rey Leon', 'Teatro');
INSERT INTO Espectaculos VALUES (7, 'Deadpool', 'Pelicula');

INSERT INTO Espectaculos VALUES (8, 'Dumbo', 'Pelicula');
INSERT INTO Espectaculos VALUES (9, 'Pokemon: Detective Pikachu', 'Pelicula');
INSERT INTO Espectaculos VALUES (10, 'Capitana Marvel', 'Pelicula');
INSERT INTO Espectaculos VALUES (11, 'Como entrenar a tu dragón', 'Pelicula');
INSERT INTO Espectaculos VALUES (12, 'PortAmerica', 'Concierto');
INSERT INTO Espectaculos VALUES (13, 'O son do Camiño', 'Concierto');
INSERT INTO Espectaculos VALUES (14, 'Iván Ferreiro: Cena recalentada', 'Concierto');
INSERT INTO Espectaculos VALUES (15, 'La Casa Azul: La gran Esfera', 'Concierto');
INSERT INTO Espectaculos VALUES (16, 'Caperuzita Roja', 'Teatro');
INSERT INTO Espectaculos VALUES (17, 'Shrek', 'Teatro');
INSERT INTO Espectaculos VALUES (18, 'Peter Pan', 'Teatro');
INSERT INTO Espectaculos VALUES (19, 'Nicolás Pastoriza', 'Concierto');
INSERT INTO Espectaculos VALUES (20, 'Xabarín Club, 25 aniversario', 'Concierto');
INSERT INTO Espectaculos VALUES (21, 'Celta B - Castilla', 'Futbol');
INSERT INTO Espectaculos VALUES (22, 'Euroliga 3', 'Baloncesto');
INSERT INTO Espectaculos VALUES (23, 'Celta Indepo - Barcelona', 'Baloncesto');



INSERT INTO Participantes VALUES ('Celta', 1);
INSERT INTO Participantes VALUES ('Deportivo', 1);
INSERT INTO Participantes VALUES ('Chris Evans', 2);
INSERT INTO Participantes VALUES ('Robert Downey Jr.', 2);
INSERT INTO Participantes VALUES ('Joaquin Sabina', 3);
INSERT INTO Participantes VALUES ('Alex Ubago', 4);
INSERT INTO Participantes VALUES ('Deportivo', 5);
INSERT INTO Participantes VALUES ('Barcelona', 5);
INSERT INTO Participantes VALUES ('David Comrie', 6);
INSERT INTO Participantes VALUES ('Sergi Albert', 6);
INSERT INTO Participantes VALUES ('Michael Jauregui', 6);
INSERT INTO Participantes VALUES ('Antonio Curros', 6);
INSERT INTO Participantes VALUES ('David Velardo', 6);
INSERT INTO Participantes VALUES ('Ryan Reynolds', 7);

INSERT INTO Participantes VALUES ('Eva Green', 8);
INSERT INTO Participantes VALUES ('Ryan Reynolds', 9);
INSERT INTO Participantes VALUES ('Justice Smith', 9);
INSERT INTO Participantes VALUES ('Brie Larson', 10);
INSERT INTO Participantes VALUES ('Samuel L. Jackson', 10);
INSERT INTO Participantes VALUES ('Kit Harington', 11);
INSERT INTO Participantes VALUES ('La casa Azul', 12);
INSERT INTO Participantes VALUES ('Iván Ferreiro', 12);
INSERT INTO Participantes VALUES ('Amaia', 12);
INSERT INTO Participantes VALUES ('Black eye peas', 13);
INSERT INTO Participantes VALUES ('Iván Ferreiro', 13);
INSERT INTO Participantes VALUES ('Rosalía', 13);
INSERT INTO Participantes VALUES ('Iván Ferreiro', 14);
INSERT INTO Participantes VALUES ('La casa Azul', 15);
INSERT INTO Participantes VALUES ('Michael Jauregui', 16);
INSERT INTO Participantes VALUES ('Sergi Albert', 17);
INSERT INTO Participantes VALUES ('David Velardo', 18);
INSERT INTO Participantes VALUES ('Nicolás Pastoriza', 19);
INSERT INTO Participantes VALUES ('Nicolás Pastoriza', 20);
INSERT INTO Participantes VALUES ('Siniestro Total', 20);
INSERT INTO Participantes VALUES ('Aerolineas Federales', 20);
INSERT INTO Participantes VALUES ('Celta', 21);
INSERT INTO Participantes VALUES ('Real Madrid', 21);
INSERT INTO Participantes VALUES ('Amfiv', 22);
INSERT INTO Participantes VALUES ('London Titans', 22);
INSERT INTO Participantes VALUES ('Celta', 23);
INSERT INTO Participantes VALUES ('Barcelona', 23);


INSERT INTO Recintos VALUES (1, 'Santiago Bernabeu', 90000);
INSERT INTO Recintos VALUES (2, 'Balaidos', 40000);
INSERT INTO Recintos VALUES (3, 'Madrid Rio', 15000);
INSERT INTO Recintos VALUES (4, 'Auditorio Mar de Vigo', 2000);
INSERT INTO Recintos VALUES (5, 'Parque de Castrelos', 800);
INSERT INTO Recintos VALUES (6, 'As Gándaras', 500);
INSERT INTO Recintos VALUES (7, 'Sala Máster', 10000);
INSERT INTO Recintos VALUES (8, 'Teatro Universitario', 1500);
INSERT INTO Recintos VALUES (9, 'Pabellón Navia', 5000);
INSERT INTO Recintos VALUES (11, 'Yelmo', 5000);
INSERT INTO Recintos VALUES (12, 'Gran Vía', 5000);
INSERT INTO Recintos VALUES (13, 'Plaza Elíptica', 5000);
INSERT INTO Recintos VALUES (14, 'Barreiro', 5000);


INSERT INTO Eventos VALUES (1, 1, '16-05-12 16:00:00', 80000,'abierto', 50, '16-05-12 18:00:00', 5, 20, 50, 10); #celta 1
INSERT INTO Eventos VALUES (2, 2, '17-05-10 18:00:00', 30000,'abierto', 50, '17-05-10 18:00:00', 5, 20, 50, 10); #civil war 2
INSERT INTO Eventos VALUES (3, 3, '18-05-12 16:00:00', 14000,'abierto', 50, '18-05-10 18:00:00', 5, 20, 50, 10); #Joaquin 3
INSERT INTO Eventos VALUES (4, 4, '19-05-12 16:00:00', 1000,'cerrado', 50, '19-05-10 18:00:00', 5, 20, 50, 10); #Alex ubago 4
INSERT INTO Eventos VALUES (5, 5, '20-05-12 16:00:00', 700,'abierto', 50, '20-05-10 18:00:00', 5, 20, 50, 10); #Alex Ubago 5
INSERT INTO Eventos VALUES (6, 6, '21-05-12 16:00:00', 300,'cerrado', 50, '21-05-10 18:00:00', 5, 20, 50, 10); #Depor-Barça 6
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7

INSERT INTO Eventos VALUES (8, 11, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-12 16:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 11, '23-05-12 16:00:00', 100,'abierto', 50, '23-05-12 16:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 12, '22-05-12 19:00:00', 100,'abierto', 50, '22-05-12 19:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 12, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 12, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 13, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 13, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Dumbo 1

INSERT INTO Eventos VALUES (9, 11, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Detective pikachu
INSERT INTO Eventos VALUES (9, 11, '23-05-12 16:00:00', 100,'abierto', 50, '23-05-12 16:00:00', 5, 20, 50, 10); #
INSERT INTO Eventos VALUES (9, 12, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #
INSERT INTO Eventos VALUES (9, 13, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #

INSERT INTO Eventos VALUES (10, 11, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Capitana Marvel
INSERT INTO Eventos VALUES (10, 12, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #
INSERT INTO Eventos VALUES (10, 13, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #

INSERT INTO Eventos VALUES (11, 11, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #Como entrenar a tu dragon
INSERT INTO Eventos VALUES (11, 12, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #
INSERT INTO Eventos VALUES (11, 13, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #
INSERT INTO Eventos VALUES (11, 13, '25-05-12 20:30:00', 100,'abierto', 50, '25-05-12 20:30:00', 5, 20, 50, 10); #

INSERT INTO Eventos VALUES (12, 5, '30-06-12 16:00:00', 100,'abierto', 50, '02-07-12 16:00:00', 5, 20, 50, 10); #PortAmerica
INSERT INTO Eventos VALUES (13, 5, '25-05-12 16:00:00', 100,'abierto', 50, '28-05-10 18:00:00', 5, 20, 50, 10); #O son do camiño
INSERT INTO Eventos VALUES (14, 4, '22-07-12 16:00:00', 100,'abierto', 50, '22-07-12 20:00:00', 5, 20, 50, 10); #concierto ivan
INSERT INTO Eventos VALUES (15, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-07-12 16:00:00', 5, 20, 50, 10); #concierto casa azul

INSERT INTO Eventos VALUES (16, 8, '15-04-12 16:00:00', 100,'abierto', 50, '15-04-12 16:00:00', 5, 20, 50, 10); #Caperucita Roja
INSERT INTO Eventos VALUES (16, 8, '18-04-12 16:00:00', 100,'abierto', 50, '18-04-12 16:00:00', 5, 20, 50, 10); #

INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7
INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-10 18:00:00', 5, 20, 50, 10); #El rey Leon 7



insert into Clientes VALUES ('32654125D', 'Manolo Lopez Lopez', 'ES407050654851239650402325','1998-05-12');
insert into Clientes VALUES ('45213658R', 'Nelson Bighetti', 'ES45665485123965040232523','1997-02-05');
insert into Clientes VALUES ('78925136Y', 'David Perez Juin', 'ES782165304698521463055469','1991-01-01');
insert into Clientes VALUES ('78941235E', 'Alba Pires Filgueira', 'ES535695786256942065000569','1966-12-06');
insert into Clientes VALUES ('48210368I', 'Sara Smith Portela', 'ES786328645132153468748554','2012-05-12');


INSERT INTO Gradas VALUES (1, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 2, 2, '17-05-10 18:00:00', 'Grada', 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 3, 3, '18-05-12 16:00:00', 'Grada', 70, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 4, 4, '19-05-12 16:00:00', 'Grada', 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 5, 5, '20-05-12 16:00:00', 'Grada', 50, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 6, 6, '21-05-12 16:00:00', 'Grada', 80, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 7, 7, '22-05-12 16:00:00', 'Grada', 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

INSERT INTO Gradas VALUES (2, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 2, 2, '17-05-10 18:00:00', 'Grada', 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 3, 3, '18-05-12 16:00:00', 'Grada', 70, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 4, 4, '19-05-12 16:00:00', 'Grada', 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 5, 5, '20-05-12 16:00:00', 'Grada', 50, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 6, 6, '21-05-12 16:00:00', 'Grada', 80, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 7, 7, '22-05-12 16:00:00', 'Grada', 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

INSERT INTO Gradas VALUES (3, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 2, 2, '17-05-10 18:00:00', 'Grada', 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 3, 3, '18-05-12 16:00:00', 'Grada', 70, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 4, 4, '19-05-12 16:00:00', 'Grada', 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 5, 5, '20-05-12 16:00:00', 'Grada', 50, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 6, 6, '21-05-12 16:00:00', 'Grada', 80, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (3, 7, 7, '22-05-12 16:00:00', 'Grada', 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);


INSERT INTO Localidades VALUES (1, 1, 1, 1, '16-05-12 16:00:00','reservado');
INSERT INTO Localidades VALUES (2, 1, 1, 1, '16-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 1, 1, '16-05-12 16:00:00','pre-reservado');
INSERT INTO Localidades VALUES (4, 1, 1, 1, '16-05-12 16:00:00','deteriorado');
INSERT INTO Localidades VALUES (5, 1, 1, 1, '16-05-12 16:00:00','libre');

INSERT INTO Localidades VALUES (1, 2, 2, 2, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (2, 2, 2, 2, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 2, 2, 2, '17-05-10 18:00:00','pre-reservado');
INSERT INTO Localidades VALUES (4, 2, 2, 2, '17-05-10 18:00:00','deteriorado');
INSERT INTO Localidades VALUES (5, 2, 2, 2, '17-05-10 18:00:00','libre');

INSERT INTO Localidades VALUES (1, 3, 3, 3, '18-05-12 16:00:00', 'reservado');
INSERT INTO Localidades VALUES (2, 3, 3, 3, '18-05-12 16:00:00', 'libre');
INSERT INTO Localidades VALUES (3, 3, 3, 3, '18-05-12 16:00:00', 'pre-reservado');
INSERT INTO Localidades VALUES (4, 3, 3, 3, '18-05-12 16:00:00', 'deteriorado');
INSERT INTO Localidades VALUES (5, 3, 3, 3, '18-05-12 16:00:00', 'libre');

INSERT INTO Reservas_Prereservas VALUES (1, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'Adulto'); #Deberíamos poner un tipo de usuario y un TIMESTAMP, pero ahora no me da la cabeza
INSERT INTO Reservas_Prereservas VALUES (3, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'Infantil');
INSERT INTO Reservas_Prereservas VALUES (1, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "Infantil");
INSERT INTO Reservas_Prereservas VALUES (3, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "Infantil");
INSERT INTO Reservas_Prereservas VALUES (1, 3, 3, 3, '18-05-12 16:00:00', '78941235E', NULL, "Parado");
INSERT INTO Reservas_Prereservas VALUES (3, 3, 3, 3, '18-05-12 16:00:00', '48210368I', NULL, "Jubilado");
