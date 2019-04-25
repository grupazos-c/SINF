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


INSERT INTO Participantes VALUES ('Celta', 1);
INSERT INTO Participantes VALUES ('Deportivo', 1);
INSERT INTO Participantes VALUES ('Chris Evans', 2);
INSERT INTO Participantes VALUES ('Robert Downey Jr.', 2);
INSERT INTO Participantes VALUES ('Joaquin Sabina', 3);
INSERT INTO Participantes VALUES ('Alex Ubago', 4);
INSERT INTO Participantes VALUES ('Deportivo', 5);
INSERT INTO Participantes VALUES ('Barcelona', 5);
INSERT INTO Participantes VALUES ('David Comrie (Mufasa)', 6);
INSERT INTO Participantes VALUES ('Sergi Albert (Scar)', 6);
INSERT INTO Participantes VALUES ('Michael Jauregui (Simba)', 6);
INSERT INTO Participantes VALUES ('Antonio Curros (Timon)', 6);
INSERT INTO Participantes VALUES ('David Velardo (Pumbaa)', 6);
INSERT INTO Participantes VALUES ('Ryan Reynolds', 7);


INSERT INTO Recintos VALUES (1, 'Santiago Bernabeu', 90000);
INSERT INTO Recintos VALUES (2, 'Balaidos', 40000);
INSERT INTO Recintos VALUES (3, 'Madrid Rio', 15000);
INSERT INTO Recintos VALUES (4, 'Auditorio Mar de Vigo', 2000);
INSERT INTO Recintos VALUES (5, 'Parque de Castrelos', 800);
INSERT INTO Recintos VALUES (6, 'As Gándaras', 500);
INSERT INTO Recintos VALUES (7, 'Sala Máster', 10000);
INSERT INTO Recintos VALUES (8, 'Teatro Universitario', 1500);
INSERT INTO Recintos VALUES (9, 'Teatro A Fundación', 5000);


INSERT INTO Eventos VALUES (1, 1, '16-05-12 16:00:00', 80000,'abierto', 50, '16-05-12 18:00:00', 5, 20, 50, 10); #celta 1
INSERT INTO Eventos VALUES (2, 2, '17-05-10 18:00:00', 30000,'abierto', 50, '17-05-10 18:00:00', 5, 20, 50, 10); #civil war 2
INSERT INTO Eventos VALUES (3, 3, '18-05-12 16:00:00', 14000,'abierto', 50, '18-05-10 18:00:00', 5, 20, 50, 10); #Joaquin 3
INSERT INTO Eventos VALUES (4, 4, '19-05-12 16:00:00', 1000,'cerrado', 50, '19-05-10 18:00:00', 5, 20, 50, 10); #Alex ubago 4
INSERT INTO Eventos VALUES (5, 5, '20-05-12 16:00:00', 700,'abierto', 50, '20-05-10 18:00:00', 5, 20, 50, 10); #Alex Ubago 5
INSERT INTO Eventos VALUES (6, 6, '21-05-12 16:00:00', 300,'cerrado', 50, '21-05-10 18:00:00', 5, 20, 50, 10); #Depor-Barça 6
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

INSERT INTO Reservas_Prereservas VALUES (1, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'adulto'); #Deberíamos poner un tipo de usuario y un TIMESTAMP, pero ahora no me da la cabeza
INSERT INTO Reservas_Prereservas VALUES (3, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'infantil');
INSERT INTO Reservas_Prereservas VALUES (1, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "infantil");
INSERT INTO Reservas_Prereservas VALUES (3, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "infantil");
INSERT INTO Reservas_Prereservas VALUES (1, 3, 3, 3, '18-05-12 16:00:00', '78941235E', NULL, "parado");
INSERT INTO Reservas_Prereservas VALUES (3, 3, 3, 3, '18-05-12 16:00:00', '48210368I', NULL, "jubilado");
