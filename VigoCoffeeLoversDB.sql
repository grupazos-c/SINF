DROP DATABASE IF EXISTS VigoCoffeeLoversDB;
CREATE DATABASE VigoCoffeeLoversDB;
DROP USER IF EXISTS 'cliente'@'localhost';
SET GLOBAL validate_password_length = 4;
SET GLOBAL validate_password_policy = LOW;
CREATE USER 'cliente'@'localhost' IDENTIFIED BY '1234';
GRANT EXECUTE ON VigoCoffeeLoversDB.* TO 'cliente'@'localhost';
USE VigoCoffeeLoversDB;

/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE TABLE Espectaculos (
  id_espectaculo INT NOT NULL AUTO_INCREMENT,
  nombre_espectaculo VARCHAR (50) NOT NULL,
  descripcion VARCHAR(100) NOT NULL,
  tipo VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_espectaculo)
);

CREATE TABLE Participantes (
  participante VARCHAR(25) NOT NULL,
  id_espectaculo INT NOT NULL,
  FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo)
  ON DELETE CASCADE,
  PRIMARY KEY (participante, id_espectaculo)
);

CREATE TABLE Recintos (
  id_recinto INT NOT NULL AUTO_INCREMENT,
  nombre_recinto VARCHAR (25) NOT NULL,
  aforo_recinto INT NOT NULL,
  PRIMARY KEY (id_recinto)
);

CREATE TABLE Eventos (
  id_espectaculo INT NOT NULL,
  id_recinto INT NOT NULL,
  fecha DATETIME NOT NULL,
  aforo_evento INT NOT NULL,
  estado_evento VARCHAR(15) NOT NULL,
  max_prereservas INT NOT NULL,
  fecha_finalizacion DATETIME NOT NULL,
  T1 INT NOT NULL,
  T2 INT NOT NULL,
  T3 INT NOT NULL,
  penalizacion_anulacion INT NOT NULL,
  PRIMARY KEY (id_espectaculo, id_recinto, fecha),
  FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo) ON DELETE CASCADE,
  FOREIGN KEY (id_recinto) REFERENCES Recintos(id_recinto) ON DELETE CASCADE
);

CREATE TABLE Clientes (
  dni VARCHAR(9) NOT NULL,
  nombre_cliente VARCHAR(30) NOT NULL,
  iban VARCHAR(26) NOT NULL,
  nacimiento DATE NOT NULL,
  PRIMARY KEY (dni)
);

CREATE TABLE Gradas (
  id_grada INT NOT NULL AUTO_INCREMENT,
  id_espectaculo INT NOT NULL,
  id_recinto INT NOT NULL,
  fecha DATETIME NOT NULL,
  nombre_grada VARCHAR(10) NOT NULL,
  aforo_grada INT NOT NULL,
  precio_jubilado INT NOT NULL,
  precio_adulto INT NOT NULL,
  precio_infantil INT NOT NULL,
  precio_parado INT NOT NULL,
  precio_bebe INT NOT NULL,
  maximo_jubilado INT NOT NULL,
  maximo_adulto INT NOT NULL,
  maximo_infantil INT NOT NULL,
  maximo_parado INT NOT NULL,
  maximo_bebe INT NOT NULL,
  PRIMARY KEY (id_grada, id_recinto, id_espectaculo, fecha),
  FOREIGN KEY (id_espectaculo, id_recinto, fecha)
  REFERENCES Eventos(id_espectaculo, id_recinto, fecha)
  ON DELETE CASCADE

);

CREATE TABLE Localidades
(
  id_localidad INT NOT NULL AUTO_INCREMENT,
  id_grada INT NOT NULL,
  id_espectaculo INT NOT NULL,
  id_recinto INT NOT NULL,
  fecha DATETIME NOT NULL,
  estado_localidad VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha),
  FOREIGN KEY (id_grada, id_recinto, id_espectaculo, fecha)
  REFERENCES Gradas(id_grada, id_recinto, id_espectaculo, fecha)
  ON DELETE CASCADE
);

CREATE TABLE Reservas_Prereservas (
  id_localidad INT NOT NULL,
  id_grada INT NOT NULL,
  id_espectaculo INT NOT NULL,
  id_recinto INT NOT NULL,
  fecha DATETIME NOT NULL,
  dni VARCHAR(9) NOT NULL,
  sello_temporal TIMESTAMP DEFAULT NOW(),
  tipo_usuario VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha),
  FOREIGN KEY (dni) REFERENCES Clientes(dni) ON DELETE CASCADE,
  FOREIGN KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha)
  REFERENCES Localidades(id_localidad, id_grada, id_recinto, id_espectaculo, fecha)
  ON DELETE CASCADE
);
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
DELETE FROM Reservas_Prereservas;
DELETE FROM Localidades;
DELETE FROM Gradas;
DELETE FROM Eventos;
DELETE FROM Participantes;
DELETE FROM Espectaculos;
DELETE FROM Recintos;
DELETE FROM Clientes;


INSERT INTO Espectaculos VALUES (1, 'Celta-Deportivo', 'Partido Celta de Vigo vs Deportivo de la Coru neno', 'Futbol');
INSERT INTO Espectaculos VALUES (2, 'Civil War', 'Proyeccion de la pelicula Civil War', 'Pelicula');
INSERT INTO Espectaculos VALUES (3, 'Joaquin Sabina', 'Concierto del señor Joaquin Sabina', 'Concierto');
INSERT INTO Espectaculos VALUES (4, 'Alex Ubago', 'Concierto de gran Alex Ubago', 'Concierto');
INSERT INTO Espectaculos VALUES (5, 'Deportivo-Barcelona', 'Partidazo entre el Deportivo de la Coruña y el Barcelona de Barcelona', 'Futbol');
INSERT INTO Espectaculos VALUES (6, 'El Rey Leon', 'Representacion de la obra El Rey Leon', 'Teatro');
INSERT INTO Espectaculos VALUES (7, 'Deadpool', 'Proyeccion de la pelicula Deadpool', 'Pelicula');
INSERT INTO Espectaculos VALUES (8, 'Dumbo', 'Proyeccion de la pelicula Dumbo', 'Pelicula');
INSERT INTO Espectaculos VALUES (9, 'Pokemon: Detective Pikachu', 'Proyeccion de la pelicula Detective Pikachu', 'Pelicula');
INSERT INTO Espectaculos VALUES (10, 'Capitana Marvel', 'Proyeccion de la pelicula Capitana Marvel', 'Pelicula');
INSERT INTO Espectaculos VALUES (11, 'Como entrenar a tu dragón', 'Proyeccion de la pelicula Como entrenar a tu dragón', 'Pelicula');
INSERT INTO Espectaculos VALUES (12, 'PortAmerica', 'Ven a disfrutar de grandes artistas como Madness, Amaia, Andres Calamaro, La casa azul, Sidecars', 'Festival');
INSERT INTO Espectaculos VALUES (13, 'O son do Camiño', 'Celebracion del festival O son do Camiño', 'Festival');
INSERT INTO Espectaculos VALUES (14, 'Iván Ferreiro: Cena recalentada', 'Conciertazo del gran artista contemporaneo Iván Ferreiro con su Cena recalentada', 'Concierto');
INSERT INTO Espectaculos VALUES (15, 'La Casa Azul: La gran Esfera', 'Gran concierto del inigualable grupo La Casa Azul en una gran esfera tambien azul', 'Concierto');
INSERT INTO Espectaculos VALUES (16, 'Caperucita Roja', 'Representacion del caperuzo dramatico y rojo', 'Teatro');
INSERT INTO Espectaculos VALUES (17, 'Shrek', '', 'Teatro');
INSERT INTO Espectaculos VALUES (18, 'Peter Pan', '', 'Teatro');
INSERT INTO Espectaculos VALUES (19, 'Nicolás Pastoriza', '', 'Concierto');
INSERT INTO Espectaculos VALUES (20, 'Xabarín Club, 25 aniversario', '', 'Concierto');
INSERT INTO Espectaculos VALUES (21, 'Celta B - Castilla', '', 'Futbol');
INSERT INTO Espectaculos VALUES (22, 'Euroliga 3', '', 'Baloncesto');
INSERT INTO Espectaculos VALUES (23, 'Celta Indepo - Barcelona', '', 'Baloncesto');


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


INSERT INTO Recintos VALUES (1, 'Santiago Bernabeu', 100);
INSERT INTO Recintos VALUES (2, 'Balaidos', 100);
INSERT INTO Recintos VALUES (3, 'Madrid Rio', 85);
INSERT INTO Recintos VALUES (4, 'Auditorio Mar de Vigo', 80);
INSERT INTO Recintos VALUES (5, 'Parque de Castrelos', 70);
INSERT INTO Recintos VALUES (6, 'As Gándaras', 50);
INSERT INTO Recintos VALUES (7, 'Sala Máster', 100);
INSERT INTO Recintos VALUES (8, 'Teatro Universitario', 50);
INSERT INTO Recintos VALUES (9, 'Pabellón Navia', 10);
INSERT INTO Recintos VALUES (11, 'Yelmo', 20);
INSERT INTO Recintos VALUES (12, 'Gran Vía', 30);
INSERT INTO Recintos VALUES (13, 'Plaza Elíptica', 25);
INSERT INTO Recintos VALUES (14, 'Barreiro', 50);
INSERT INTO Recintos VALUES (15, 'Camp Nou', 100);



INSERT INTO Eventos VALUES (1, 1, '16-05-12 16:00:00', 98,'abierto', 50, '16-05-12 18:00:00', 5, 20, 50, 10); #celta 1

INSERT INTO Eventos VALUES (2, 11, '17-05-10 18:00:00', 20,'abierto', 2, '17-05-10 21:00:00', 3, 6, 10, 3); #civil war en Yelmo
INSERT INTO Eventos VALUES (2, 11, '17-05-10 21:10:00', 20,'abierto', 2, '17-05-11 00:10:00', 3, 6, 10, 3); #civil war en Yelmo
INSERT INTO Eventos VALUES (2, 11, '17-05-11 00:00:00', 20,'abierto', 2, '17-05-11 03:00:00', 3, 6, 10, 3); #civil war en Yelmo
INSERT INTO Eventos VALUES (2, 12, '17-05-10 18:00:00', 30,'abierto', 3, '17-05-10 21:00:00', 8, 10, 10, 2); #civil war en Gran vía
INSERT INTO Eventos VALUES (2, 12, '17-05-10 21:10:00', 30,'abierto', 3, '17-05-11 00:10:00', 8, 10, 10, 2); #civil war en Gran vía
INSERT INTO Eventos VALUES (2, 12, '17-05-11 00:00:00', 30,'abierto', 3, '17-05-11 03:00:00', 8, 10, 10, 2); #civil war en Gran vía
INSERT INTO Eventos VALUES (2, 13, '17-05-10 18:00:00', 25,'abierto', 4, '17-05-10 21:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-10 21:10:00', 25,'abierto', 4, '17-05-11 00:10:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-11 00:00:00', 25,'abierto', 4, '17-05-11 03:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-11 13:00:00', 25,'abierto', 4, '17-05-11 16:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-11 18:00:00', 25,'abierto', 4, '17-05-11 21:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-11 21:10:00', 25,'abierto', 4, '17-05-12 00:10:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-12 19:00:00', 25,'abierto', 4, '17-05-12 22:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica
INSERT INTO Eventos VALUES (2, 13, '17-05-12 22:10:00', 25,'abierto', 4, '17-05-13 01:00:00', 10, 60, 0, 2); #civil war en Plaza elíptica

INSERT INTO Eventos VALUES (3, 1, '18-05-12 16:00:00', 100,'abierto', 10, '18-05-12 20:00:00', 5, 20, 130, 30); #Joaquin
INSERT INTO Eventos VALUES (3, 2, '18-05-15 18:00:00', 100,'abierto', 5, '18-05-15 22:00:00', 5, 20, 130, 30); #Joaquin
INSERT INTO Eventos VALUES (3, 5, '18-05-18 16:00:00', 70,'abierto', 5, '18-05-18 20:00:00', 5, 20, 130, 30); #Joaquin
INSERT INTO Eventos VALUES (3, 8, '18-05-21 22:00:00', 50,'abierto', 15, '18-05-21 02:00:00', 5, 20, 130, 30); #Joaquin

INSERT INTO Eventos VALUES (4, 4, '20-05-12 16:00:00', 80,'abierto', 50, '20-05-10 18:00:00', 3, 240, 60, 30); #Alex ubago
INSERT INTO Eventos VALUES (5, 5, '20-06-12 16:00:00', 70,'abierto', 50, '20-06-10 18:00:00', 3, 240, 60, 30); #Alex Ubago
INSERT INTO Eventos VALUES (4, 4, '20-07-12 16:00:00', 80,'abierto', 50, '20-07-10 18:00:00', 3, 240, 60, 30); #Alex ubago
INSERT INTO Eventos VALUES (5, 5, '20-08-12 16:00:00', 70,'abierto', 50, '20-08-10 18:00:00', 3, 240, 60, 30); #Alex Ubago
INSERT INTO Eventos VALUES (4, 4, '20-09-12 16:00:00', 80,'abierto', 50, '20-09-10 18:00:00', 3, 240, 60, 30); #Alex Ubago
INSERT INTO Eventos VALUES (5, 5, '20-10-12 16:00:00', 70,'abierto', 50, '20-10-10 18:00:00', 3, 240, 60, 30); #Alex Ubago

INSERT INTO Eventos VALUES (6, 15, '21-05-12 16:00:00', 95,'cerrado', 50, '21-05-12 19:00:00', 5, 60, 50, 10); #Depor-Barça
INSERT INTO Eventos VALUES (6, 15, '21-11-20 18:00:00', 95,'abierto', 50, '21-11-20 21:00:00', 5, 60, 50, 10); #Depor-Barça

INSERT INTO Eventos VALUES (7, 7, '22-05-12 16:00:00', 100,'abierto', 20, '22-05-12 20:00:00', 5, 120, 50, 30); #El rey Leon
INSERT INTO Eventos VALUES (7, 7, '22-05-13 16:00:00', 100,'abierto', 20, '22-05-13 20:00:00', 5, 120, 50, 30); #El rey Leon
INSERT INTO Eventos VALUES (7, 7, '22-05-15 16:00:00', 100,'abierto', 20, '22-05-15 20:00:00', 5, 120, 50, 30); #El rey Leon
INSERT INTO Eventos VALUES (7, 7, '22-06-01 16:00:00', 100,'abierto', 20, '22-06-01 20:00:00', 5, 120, 50, 30); #El rey Leon
INSERT INTO Eventos VALUES (7, 7, '22-06-03 16:00:00', 100,'abierto', 20, '22-06-03 20:00:00', 5, 120, 50, 30); #El rey Leon
INSERT INTO Eventos VALUES (7, 7, '22-06-06 16:00:00', 100,'abierto', 20, '22-06-06 20:00:00', 5, 120, 50, 30); #El rey Leon

/*
INSERT INTO Eventos VALUES (8, 11, '22-05-12 16:00:00', 100,'abierto', 50, '22-05-12 18:00:00', 5, 20, 50, 10); #Dumbo 1
INSERT INTO Eventos VALUES (8, 11, '22-05-12 16:00:00', 100,'abierto', 50, '23-05-12 16:00:00', 5, 20, 50, 10); #Dumbo 1
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

*/


INSERT INTO Gradas VALUES (1, 2, 11, '17-05-10 18:00:00', 'Grada', 20, 4, 10, 6, 7, 0, 2, 20, 5, 7, 0); #Gradas civil war en Yelmo
INSERT INTO Gradas VALUES (1, 2, 11, '17-05-10 21:10:00', 'Grada', 20, 4, 10, 6, 7, 0, 2, 20, 5, 7, 0);
INSERT INTO Gradas VALUES (1, 2, 11, '17-05-11 00:00:00', 'Grada', 20, 4, 10, 6, 7, 0, 2, 20, 5, 7, 0);

INSERT INTO Gradas VALUES (1, 2, 12, '17-05-10 18:00:00', 'Grada', 30, 3, 9, 7, 6, 0, 2, 30, 4, 10, 0); #Gradas civil war en Gran vía
INSERT INTO Gradas VALUES (1, 2, 12, '17-05-10 21:10:00', 'Grada', 30, 3, 9, 7, 6, 0, 2, 30, 4, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 12, '17-05-11 00:00:00', 'Grada', 30, 3, 9, 7, 6, 0, 2, 30, 4, 10, 0);

INSERT INTO Gradas VALUES (1, 2, 13, '17-05-10 18:00:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0); #Gradas civil war en Plaza elíptica no puse Localidades asociadas
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-10 21:10:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-11 00:00:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-11 13:00:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-11 18:00:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-11 21:10:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-12 19:00:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);
INSERT INTO Gradas VALUES (1, 2, 13, '17-05-12 22:10:00', 'Grada', 25, 5, 10, 5, 4, 0, 2, 25, 10, 10, 0);

INSERT INTO Gradas VALUES (1, 3, 1, '18-05-12 16:00:00', 'Grada', 25, 70, 100, 60, 75, 10, 5, 25, 5, 7, 10); #Gradas Joaquin Santiago Bernabeu
INSERT INTO Gradas VALUES (2, 3, 1, '18-05-12 16:00:00', 'Grada', 25, 70, 100, 60, 75, 10, 5, 25, 5, 7, 10);
INSERT INTO Gradas VALUES (3, 3, 1, '18-05-12 16:00:00', 'Grada', 25, 70, 100, 60, 75, 10, 5, 25, 5, 7, 10);
INSERT INTO Gradas VALUES (4, 3, 1, '18-05-12 16:00:00', 'Grada', 25, 70, 100, 60, 75, 10, 5, 25, 5, 7, 10);

INSERT INTO Gradas VALUES (1, 3, 2, '18-05-15 18:00:00', 'Grada', 50, 20, 30, 15, 10, 5, 50, 50, 50, 50, 7); #Gradas Joaquin Balaidos
INSERT INTO Gradas VALUES (2, 3, 2, '18-05-15 18:00:00', 'Grada', 20, 40, 40, 25, 20, 10, 10, 20, 10, 10, 4);
INSERT INTO Gradas VALUES (3, 3, 2, '18-05-15 18:00:00', 'Grada', 20, 60, 50, 35, 30, 15, 5, 20, 5, 5, 3);
INSERT INTO Gradas VALUES (4, 3, 2, '18-05-15 18:00:00', 'Grada', 10, 80, 60, 45, 40, 20, 2, 10, 2, 1, 1);

INSERT INTO Gradas VALUES (1, 3, 5, '18-05-18 16:00:00', 'Grada', 700, 10, 10, 10, 10, 0, 700, 700, 700, 700, 10); #Gradas Joaquin Parque de Castrelos

INSERT INTO Gradas VALUES (1, 3, 8, '18-05-21 22:00:00', 'Grada', 250, 0, 20, 0, 0, 10, 0, 250, 0, 0, 0); #Gradas Joaquin Teatro Universitario
INSERT INTO Gradas VALUES (2, 3, 8, '18-05-21 22:00:00', 'Grada', 250, 0, 20, 0, 0, 10, 0, 250, 0, 0, 0);
INSERT INTO Gradas VALUES (3, 3, 8, '18-05-21 22:00:00', 'Grada', 250, 0, 20, 0, 0, 10, 0, 250, 0, 0, 0);
INSERT INTO Gradas VALUES (4, 3, 8, '18-05-21 22:00:00', 'Grada', 250, 0, 20, 0, 0, 10, 0, 250, 0, 0, 0);
INSERT INTO Gradas VALUES (5, 3, 8, '18-05-21 22:00:00', 'Grada', 250, 0, 20, 0, 0, 10, 0, 250, 0, 0, 0);


INSERT INTO Gradas VALUES (1, 6, 15, '21-05-12 16:00:00', 'Grada', 50, 20, 100, 30, 10, 5, 20, 100, 30, 10, 5); #Depor-Barça
INSERT INTO Gradas VALUES (2, 6, 15, '21-05-12 16:00:00', 'Grada', 30, 20, 100, 30, 10, 5, 20, 100, 30, 10, 5);
INSERT INTO Gradas VALUES (3, 6, 15, '21-05-12 16:00:00', 'Grada', 20, 20, 100, 30, 10, 5, 20, 100, 30, 10, 5);


INSERT INTO Localidades VALUES (1, 1, 2, 11, '17-05-10 18:00:00','libre'); #Localidades para grada 1 civil war en Yelmo
INSERT INTO Localidades VALUES (2, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 2, 11, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (4, 1, 2, 11, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (5, 1, 2, 11, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (6, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 11, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 11, '17-05-10 18:00:00','libre');


INSERT INTO Localidades VALUES (1, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (2, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (3, 1, 2, 11, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (4, 1, 2, 11, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (5, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (6, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (16, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 11, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 11, '17-05-10 21:10:00','libre');


INSERT INTO Localidades VALUES (1, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (2, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (4, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (5, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (6, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 11, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 11, '17-05-11 00:00:00','libre');


INSERT INTO Localidades VALUES (1, 1, 2, 12, '17-05-10 18:00:00','reservado'); #Localidades para grada 1 civil war en Gran vía
INSERT INTO Localidades VALUES (2, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (3, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (4, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (5, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (6, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (21, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (22, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (23, 1, 2, 12, '17-05-10 18:00:00','reservado');
INSERT INTO Localidades VALUES (24, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (25, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (26, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (27, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (28, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (29, 1, 2, 12, '17-05-10 18:00:00','libre');
INSERT INTO Localidades VALUES (30, 1, 2, 12, '17-05-10 18:00:00','reservado');


INSERT INTO Localidades VALUES (1, 1, 2, 12, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (2, 1, 2, 12, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (3, 1, 2, 12, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (4, 1, 2, 12, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (5, 1, 2, 12, '17-05-10 21:10:00','reservado');
INSERT INTO Localidades VALUES (6, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 12, '17-05-10 21:10:00','deteriorado');
INSERT INTO Localidades VALUES (16, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (21, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (22, 1, 2, 12, '17-05-10 21:10:00','deteriorado');
INSERT INTO Localidades VALUES (23, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (24, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (25, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (26, 1, 2, 12, '17-05-10 21:10:00','deteriorado');
INSERT INTO Localidades VALUES (27, 1, 2, 12, '17-05-10 21:10:00','deteriorado');
INSERT INTO Localidades VALUES (28, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (29, 1, 2, 12, '17-05-10 21:10:00','libre');
INSERT INTO Localidades VALUES (30, 1, 2, 12, '17-05-10 21:10:00','libre');


INSERT INTO Localidades VALUES (1, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (2, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (4, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (5, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (6, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (21, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (22, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (23, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (24, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (25, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (26, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (27, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (28, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (29, 1, 2, 12, '17-05-11 00:00:00','libre');
INSERT INTO Localidades VALUES (30, 1, 2, 12, '17-05-11 00:00:00','libre');


INSERT INTO Localidades VALUES (1, 1, 3, 1, '18-05-12 16:00:00','libre'); #Localidades para Gradas Joaquin Santiago Bernabeu
INSERT INTO Localidades VALUES (2, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 3, 1, '18-05-12 16:00:00','reservado');
INSERT INTO Localidades VALUES (13, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 1, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 1, 3, 1, '18-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (2, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 2, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 2, 3, 1, '18-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (2, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 3, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 3, 3, 1, '18-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (2, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 4, 3, 1, '18-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 4, 3, 1, '18-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (2, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (4, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (5, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (6, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (21, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (22, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (23, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (24, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (25, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (26, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (27, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (28, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (29, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (30, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (31, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (32, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (33, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (34, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (35, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (36, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (37, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (38, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (39, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (40, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (41, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (42, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (43, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (44, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (45, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (46, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (47, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (48, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (49, 1, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (50, 1, 3, 2, '18-05-15 18:00:00','libre');


INSERT INTO Localidades VALUES (1, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (2, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (4, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (5, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (6, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (11, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (12, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (13, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (14, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (15, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (16, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (17, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (18, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (19, 2, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (20, 2, 3, 2, '18-05-15 18:00:00','libre');


INSERT INTO Localidades VALUES (1, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (2, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (4, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (5, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (6, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (11, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (12, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (13, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (14, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (15, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (16, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (17, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (18, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (19, 3, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (20, 3, 3, 2, '18-05-15 18:00:00','libre');


INSERT INTO Localidades VALUES (1, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (2, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (3, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (4, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (5, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (6, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (7, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (8, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (9, 4, 3, 2, '18-05-15 18:00:00','libre');
INSERT INTO Localidades VALUES (10, 4, 3, 2, '18-05-15 18:00:00','libre');


INSERT INTO Localidades VALUES (1, 1, 6, 15, '21-05-12 16:00:00','libre'); #Depor-Barça
INSERT INTO Localidades VALUES (2, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (26, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (27, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (28, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (29, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (30, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (31, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (32, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (33, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (34, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (35, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (36, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (37, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (38, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (39, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (40, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (41, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (42, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (43, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (44, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (45, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (46, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (47, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (48, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (49, 1, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (50, 1, 6, 15, '21-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (2, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (21, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (22, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (23, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (24, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (25, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (26, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (27, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (28, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (29, 2, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (30, 2, 6, 15, '21-05-12 16:00:00','libre');


INSERT INTO Localidades VALUES (1, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (2, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (3, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (4, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (5, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (6, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (7, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (8, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (9, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (10, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (11, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (12, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (13, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (14, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (15, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (16, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (17, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (18, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (19, 3, 6, 15, '21-05-12 16:00:00','libre');
INSERT INTO Localidades VALUES (20, 3, 6, 15, '21-05-12 16:00:00','libre');


insert into Clientes VALUES ('32654125D', 'Manolo Lopez Lopez', 'ES407050654851239650402325','1998-05-12');
insert into Clientes VALUES ('45213658R', 'Nelson Bighetti', 'ES45665485123965040232523','1997-02-05');
insert into Clientes VALUES ('78925136Y', 'David Perez Juin', 'ES782165304698521463055469','1991-01-01');
insert into Clientes VALUES ('78941235E', 'Alba Pires Filgueira', 'ES535695786256942065000569','1966-12-06');
insert into Clientes VALUES ('48210368I', 'Sara Smith Portela', 'ES786328645132153468748554','2012-05-12');
insert into Clientes VALUES ('34875964W', 'Pablo Cachafeiro Díaz', 'ES235416874235987132546987','1998-05-21');
insert into Clientes VALUES ('35582309K', 'Roi Martínez Portela', 'ES123456789012345678901234','1998-03-07');
insert into Clientes VALUES ('77712358Y', 'Sergio Arcay Mallo', 'ES456123365478965231569852','1999-05-02');


INSERT INTO Reservas_Prereservas VALUES (3, 1, 2, 11, '17-05-10 18:00:00', '32654125D', NULL, 'Adulto');
INSERT INTO Reservas_Prereservas VALUES (4, 1, 2, 11, '17-05-10 18:00:00', '32654125D', NULL, 'Adulto');
INSERT INTO Reservas_Prereservas VALUES (5, 1, 2, 11, '17-05-10 18:00:00', '32654125D', NULL, 'Infantil');

INSERT INTO Reservas_Prereservas VALUES (1, 1, 2, 12, '17-05-10 21:10:00', '45213658R', NULL, "Jubilado");
INSERT INTO Reservas_Prereservas VALUES (2, 1, 2, 12, '17-05-10 21:10:00', '45213658R', NULL, "Adulto");
INSERT INTO Reservas_Prereservas VALUES (3, 1, 2, 12, '17-05-10 21:10:00', '45213658R', NULL, "Adulto");
INSERT INTO Reservas_Prereservas VALUES (4, 1, 2, 12, '17-05-10 21:10:00', '45213658R', NULL, "Infantil");
INSERT INTO Reservas_Prereservas VALUES (5, 1, 2, 12, '17-05-10 21:10:00', '45213658R', NULL, "Bebe");

INSERT INTO Reservas_Prereservas VALUES (30, 1, 2, 12, '17-05-10 18:00:00', '45213658R', NULL, "Parado");

#INSERT INTO Reservas_Prereservas VALUES (1, 20, 1, 2, 12, '78941235E', NULL, "Jubilado");
#INSERT INTO Reservas_Prereservas VALUES (1, 21, 1, 2, 12, '78941235E', NULL, "Parado");
#INSERT INTO Reservas_Prereservas VALUES (1, 22, 1, 2, 12, '78941235E', NULL, "Infantil");
#INSERT INTO Reservas_Prereservas VALUES (1, 23, 1, 2, 12, '78941235E', NULL, "Infantil");

INSERT INTO Reservas_Prereservas VALUES (3, 1, 2, 11, '17-05-10 21:10:00', '48210368I', NULL, "Adulto");
INSERT INTO Reservas_Prereservas VALUES (4, 1, 2, 11, '17-05-10 21:10:00', '48210368I', NULL, "Adulto");

#INSERT INTO Reservas_Prereservas VALUES (4, 1, 3, 1, '18-05-12 16:00:00', '64648568I', NULL, "Jubilado");
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/



























/*INNECESARIO: si se borra la base de datos tambien se borran sus Procedures*/
drop PROCEDURE if exists registrarCliente;
drop PROCEDURE if exists anularReserva;
drop PROCEDURE if exists cambiarDatosCliente;
drop PROCEDURE if exists existeCliente;
drop PROCEDURE if exists filtrarEventos;
drop PROCEDURE if exists infoGrada;
drop PROCEDURE if exists obtenerEntradasCompradasCliente;
drop PROCEDURE if exists obtenerDatosCliente;
drop PROCEDURE if exists reservar_pre_reservar;
drop TRIGGER   if exists disparador_anulacion;
drop PROCEDURE if exists mostrarParticipantes;
drop PROCEDURE if exists mostrarRecintos;
drop PROCEDURE if exists eventoPrereserva;
drop PROCEDURE if exists mostrarEspectaculos;
drop PROCEDURE if exists infoLocalidades;

delimiter //


/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE registrarCliente(IN dni VARCHAR(9),IN nombre VARCHAR(30), IN iban VARCHAR(26), IN nacimiento DATE, OUT error INT)
  BEGIN
    DECLARE compDNI VARCHAR(9);
    set @compDNI = null;
    SELECT dni INTO @compDNI FROM Clientes where Clientes.dni=dni;
    IF (nacimiento > '2001-01-01') THEN
      SET error = -2; #menos de 18 años
    elseIF (@compDNI is NULL) THEN
      INSERT INTO Clientes VALUES (dni, nombre, iban, nacimiento);
      set error = 0; # Sin errores
    ELSE
      set error = -1; #Este error es que ya existe ese dni
    END IF;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
#
#   Return:
#       -1 : La localidad no está reservada ni pre-reservada
#       -2 : Este cliente no es quien ha reservado la localidad
#
CREATE PROCEDURE anularReserva(IN id_localidad INT,IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT,IN fecha DATETIME, IN dni VARCHAR(9), OUT resultado INT)
BEGIN
  #comprobación de que la reserva existe
  DECLARE estado VARCHAR(15);
  DECLARE bd_dni VARCHAR(9);
  SET @resultado = 0;
  SET @estado = (SELECT estado_localidad FROM Localidades
    WHERE Localidades.id_localidad = id_localidad
      AND Localidades.id_grada = id_grada
      AND Localidades.id_recinto = id_recinto
      AND Localidades.id_espectaculo = id_espectaculo
      AND Localidades.fecha = fecha);
  IF((@estado = 'libre') OR (@estado = 'deteriorado')) THEN
    SET @resultado = -1;
  END IF;
  #comprobación de que la resevra esta a nombre del usuario
  SET @bd_dni = (SELECT dni FROM Reservas_Prereservas
    WHERE Reservas_Prereservas.id_localidad = @id_localidad
      AND Reservas_Prereservas.id_grada = @id_grada
      AND Reservas_Prereservas.id_recinto = @id_recinto
      AND Reservas_Prereservas.id_espectaculo = @id_espectaculo
      AND Reservas_Prereservas.fecha = @fecha);
      SELECT @bd_dni;
    IF(@bd_dni != dni) THEN
      SET @resultado = -2;
    END IF;
  #como hacemos lo de las transiciones, por que aquí debería haber una, por si no se puede eliminar una reserva, que no se marque la localidad como libre
  IF(@resultado = 0) THEN
  DELETE FROM Reservas_Prereservas
    WHERE Reservas_Prereservas.id_localidad = id_localidad
      AND Reservas_Prereservas.id_grada = id_grada
      AND Reservas_Prereservas.id_recinto = id_recinto
      AND Reservas_Prereservas.id_espectaculo = id_espectaculo
      AND Reservas_Prereservas.fecha = fecha;
  END IF;
  #Aquí cerrariamos el commit y además estaría bien devolver algo si todo fue ok o no, pero no sé como así que...
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure cambiarDatosCliente (
	IN dni varchar(9),
    IN nombre varchar(25),
    IN iban varchar(26),
    IN fechaNacimiento datetime,
    OUT resultado int
)
begin
	if (select nombre_cliente from Clientes where Clientes.dni = dni) is null then
		set @resultado = -1;
	else
		if nombre is not null then
			update Clientes set Clientes.nombre_cliente = nombre where Clientes.dni = dni;
		end if;
		if iban is not null then
			update Clientes set Clientes.iban = iban where Clientes.dni = dni;
		end if;
		if fechaNacimiento is not null then
			update Clientes set Clientes.nacimiento = fechaNacimiento where Clientes.dni = dni;
		end if;
	end if;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure existeCliente(IN dni varchar(9), OUT resultado BOOLEAN)
begin
    if exists (select dni from Clientes where Clientes.dni = dni) then
		set resultado = true;
	else
		set resultado = false;
	end if;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure filtrarEventos (
	IN filtro_espectaculo varchar(50),
    IN filtro_recinto varchar(25),
    IN filtro_fecha_min datetime,
    IN filtro_fecha_max datetime,
    IN filtro_participante varchar(25),
    IN filtro_precio_max int,
    IN Jubilado BOOLEAN,
    IN Adulto BOOLEAN,
    IN Parado BOOLEAN,
    IN Infantil BOOLEAN,
    IN Bebe BOOLEAN
)
BEGIN

    drop table if exists resultado;
    drop table if exists aux;

	/*Primero filtramos por los tipos de usuarios que nos han mandado como TRUE*/
	if jubilado=false and adulto=false and parado=false and infantil=false and bebe=false then
		CREATE TEMPORARY TABLE resultado select Eventos.* from Eventos where estado_evento = 'abierto';
	else
		CREATE TEMPORARY TABLE resultado select Eventos.* from Eventos, Gradas
		where Eventos.id_espectaculo = Gradas.id_espectaculo and Eventos.id_recinto = Gradas.id_recinto and Eventos.fecha = Gradas.fecha and estado_evento = 'abierto'
        and 0 < if(jubilado = true	, Gradas.maximo_jubilado	, 1)
        and 0 < if(adulto 	= true	, Gradas.maximo_adulto		, 1)
        and 0 < if(parado 	= true	, Gradas.maximo_parado		, 1)
        and 0 < if(infantil = true	, Gradas.maximo_infantil	, 1)
        and 0 < if(bebe 	= true	, Gradas.maximo_bebe		, 1)
        group by Eventos.id_espectaculo, Eventos.id_recinto, Eventos.fecha;
	end if;
	/**********************************************************************************************************************************************************/

    CREATE TEMPORARY TABLE aux select * from Eventos where 1=0;

	if filtro_espectaculo is not null then
		insert into aux select resultado.* from resultado, Espectaculos where resultado.id_espectaculo = Espectaculos.id_espectaculo and Espectaculos.nombre_espectaculo = filtro_espectaculo;
        truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_recinto is not null then
		insert into aux select resultado.* from resultado, Recintos where resultado.id_recinto = Recintos.id_recinto and Recintos.nombre_recinto = filtro_recinto;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_fecha_min is not null then
		insert into aux select resultado.* from resultado where resultado.fecha >= filtro_fecha_min;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_fecha_max is not null then
		insert into aux select resultado.* from resultado where resultado.fecha <= filtro_fecha_max;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_participante is not null then
		insert into aux select resultado.* from resultado, Espectaculos, Participantes
			where resultado.id_espectaculo = Espectaculos.id_espectaculo
				AND Espectaculos.id_espectaculo = Participantes.id_espectaculo AND Participantes.participante = filtro_participante;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_precio_max != 0 then
		insert into aux select resultado.id_espectaculo, resultado.id_recinto, resultado.fecha from resultado, Gradas
			where resultado.id_espectaculo = Gradas.id_espectaculo AND resultado.id_recinto = Gradas.id_recinto AND resultado.fecha = Gradas.fecha
				and filtro_precio_max <= if(jubilado = true	, Gradas.precio_jubilado	, filtro_precio_max)
				and filtro_precio_max <= if(adulto 	 = true	, Gradas.precio_adulto		, filtro_precio_max)
				and filtro_precio_max <= if(parado 	 = true	, Gradas.precio_parado		, filtro_precio_max)
				and filtro_precio_max <= if(infantil = true	, Gradas.precio_infantil	, filtro_precio_max)
				and filtro_precio_max <= if(bebe 	 = true	, Gradas.precio_bebe		, filtro_precio_max)
				group by resultado.id_espectaculo, resultado.id_recinto, resultado.fecha;
		truncate resultado; insert into resultado select * from aux; DROP TABLE aux;
    end if;

	select resultado.id_espectaculo, Espectaculos.nombre_espectaculo, resultado.id_recinto, Recintos.nombre_recinto, resultado.fecha
		from resultado, Espectaculos, Recintos where resultado.id_espectaculo = Espectaculos.id_espectaculo and resultado.id_recinto = Recintos.id_recinto;

    DROP TABLE resultado;

END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE infoGrada(IN espectaculo int, IN recinto int, IN fecha datetime, IN grada int)
BEGIN

	DECLARE localidades_disponibles int;
	DECLARE localidades_ocupadas_por_usuario_jubilado int;
	DECLARE localidades_ocupadas_por_usuario_adulto int;
	DECLARE localidades_ocupadas_por_usuario_parado int;
	DECLARE localidades_ocupadas_por_usuario_infantil int;
	DECLARE localidades_ocupadas_por_usuario_bebe int;

	select count(*) into localidades_disponibles from Gradas, Localidades
		where Gradas.id_grada = Localidades.id_grada
			and Gradas.id_recinto = Localidades.id_recinto
			and Gradas.id_espectaculo = Localidades.id_espectaculo
			and Gradas.fecha = Localidades.fecha
			and Gradas.id_espectaculo = espectaculo
			and Gradas.id_recinto = recinto
			and Gradas.fecha = fecha
			and Gradas.id_grada = grada
			and Localidades.estado_localidad = 'libre'
		GROUP BY Gradas.id_grada;
	if localidades_disponibles is null then set localidades_disponibles = 0; end if;

	select count(*) into localidades_ocupadas_por_usuario_jubilado from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'jubilado'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_jubilado is null then set localidades_ocupadas_por_usuario_jubilado = 0; end if;

	select count(*) into localidades_ocupadas_por_usuario_adulto from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'adulto'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_adulto is null then set localidades_ocupadas_por_usuario_adulto = 0;  end if;

	select count(*) into localidades_ocupadas_por_usuario_parado from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'adulto'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_parado is null then set localidades_ocupadas_por_usuario_parado = 0; end if;

	select count(*) into localidades_ocupadas_por_usuario_parado from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'parado'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_bebe is null then set localidades_ocupadas_por_usuario_bebe = 0; end if;

	select count(*) into localidades_ocupadas_por_usuario_infantil from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'infantil'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_infantil is null then set localidades_ocupadas_por_usuario_infantil = 0; end if;


	select count(*) into localidades_ocupadas_por_usuario_bebe from Reservas_Prereservas, Gradas
		where Reservas_Prereservas.id_espectaculo = Gradas.id_espectaculo
			and Reservas_Prereservas.id_espectaculo = espectaculo
			and Reservas_Prereservas.id_recinto = Gradas.id_recinto
			and Reservas_Prereservas.id_recinto = recinto
			and Reservas_Prereservas.fecha = Gradas.fecha
			and Reservas_Prereservas.fecha = fecha
			and Reservas_Prereservas.id_grada = Gradas.id_grada
			and Gradas.id_grada = grada
			and Reservas_Prereservas.tipo_usuario = 'bebe'
		GROUP BY Gradas.id_grada, Reservas_Prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_bebe is null then set localidades_ocupadas_por_usuario_bebe = 0; end if;

		select Gradas.id_grada, Gradas.nombre_grada,
			if(localidades_disponibles < (maximo_jubilado - localidades_ocupadas_por_usuario_jubilado), localidades_disponibles, maximo_jubilado - localidades_ocupadas_por_usuario_jubilado) as localidades_jubilado,
			Gradas.precio_jubilado,
			if(localidades_disponibles < (maximo_adulto - localidades_ocupadas_por_usuario_adulto), localidades_disponibles, maximo_adulto - localidades_ocupadas_por_usuario_adulto) 	as localidades_adulto,
			Gradas.precio_adulto,
			if(localidades_disponibles < (maximo_parado - localidades_ocupadas_por_usuario_parado), localidades_disponibles, maximo_parado - localidades_ocupadas_por_usuario_parado) 	as localidades_parado,
			Gradas.precio_parado,
			if(localidades_disponibles < (maximo_infantil - localidades_ocupadas_por_usuario_infantil), localidades_disponibles, maximo_infantil - localidades_ocupadas_por_usuario_infantil) as localidades_infantil,
			Gradas.precio_infantil,
			if(localidades_disponibles < (maximo_bebe - localidades_ocupadas_por_usuario_bebe), localidades_disponibles, maximo_bebe - localidades_ocupadas_por_usuario_bebe) 		as localidades_bebe,
			Gradas.precio_bebe
		from Gradas, Eventos
        where Gradas.id_grada = grada
			and Gradas.id_espectaculo = Eventos.id_espectaculo
			and Gradas.id_recinto = Eventos.id_recinto
			and Gradas.fecha = Eventos.fecha
			and Gradas.id_espectaculo = espectaculo
			and Gradas.id_recinto = recinto
			and Gradas.fecha = fecha;

END //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure obtenerEntradasCompradasCliente(IN dni varchar(9))
begin
	select Espectaculos.nombre_espectaculo, Gradas.id_grada, Espectaculos.id_espectaculo, Recintos.id_recinto, Recintos.nombre_recinto, Gradas.fecha, Gradas.nombre_grada, Reservas_Prereservas.id_localidad, Reservas_Prereservas.tipo_usuario, Localidades.estado_localidad,
		case
			when Reservas_Prereservas.tipo_usuario = 'jubilado' then Gradas.precio_jubilado
            when Reservas_Prereservas.tipo_usuario = 'adulto' then Gradas.precio_adulto
            when Reservas_Prereservas.tipo_usuario = 'parado' then Gradas.precio_parado
            when Reservas_Prereservas.tipo_usuario = 'infantil' then Gradas.precio_infantil
            when Reservas_Prereservas.tipo_usuario = 'bebe' then Gradas.precio_bebe
		end as precio
	from Reservas_Prereservas, Gradas, Espectaculos, Recintos, Localidades where Reservas_Prereservas.dni = dni
		and Localidades.id_espectaculo = Gradas.id_espectaculo 
		and Espectaculos.id_espectaculo = Gradas.id_espectaculo 
		and Espectaculos.id_espectaculo = Reservas_Prereservas.id_espectaculo
        and Localidades.id_recinto = Gradas.id_recinto 
        and Recintos.id_recinto = Gradas.id_recinto 
        and Recintos.id_recinto = Reservas_Prereservas.id_recinto
        and Localidades.fecha = Gradas.fecha
        and Reservas_Prereservas.fecha = Gradas.fecha
        and Localidades.fecha = Gradas.fecha
        and Reservas_Prereservas.id_grada = Gradas.id_grada
        and Localidades.id_grada = Reservas_Prereservas.id_grada
        and Localidades.id_localidad = Reservas_Prereservas.id_localidad;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure obtenerDatosCliente(IN dni varchar(9))
begin
	select nombre_cliente, iban, nacimiento from Clientes where Clientes.dni = dni;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE reservar_pre_reservar(IN tipo_transaccion VARCHAR (15),IN dni VARCHAR (9), IN tipo_usuario VARCHAR (15), IN id_localidad INT, IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT, IN fecha DATETIME, OUT id_transaccion int)
reservar:BEGIN
/*tipo_transaccion es una variable que indica si la operacion es RESERVAR O PRE-RESERVAR*/
/*Este procedimiento reservará una localidad dados unos parámetros de entrada y retornará valores negativos cuando hay un error*/

/*PRIMERO COMPROBAMOS EL ESTADO DE LA LOCALIDAD*/
DECLARE estado VARCHAR (15) DEFAULT NULL;
DECLARE max_tipo INT DEFAULT 0;
DECLARE actuales_tipo INT DEFAULT 0;
DECLARE actuales_evento INT DEFAULT 0;
DECLARE comprobacion VARCHAR (9) DEFAULT NULL;

IF tipo_transaccion = 'reservar'
  THEN
    SET tipo_transaccion = 'reservado';
ELSEIF tipo_transaccion = 'pre-reservar'
  THEN
    SET tipo_transaccion = 'pre-reservado';
ELSE
    SET id_transaccion = -6; /*Transacción no adminita, solo admitimos reservar y pre_reservar*/
    LEAVE reservar;
END IF;

SELECT estado_localidad INTO estado FROM Localidades WHERE Localidades.id_localidad = id_localidad AND Localidades.id_grada = id_grada AND Localidades.id_recinto = id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;
SELECT dni INTO comprobacion FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_localidad=id_localidad AND Reservas_Prereservas.id_grada=id_grada AND Reservas_Prereservas.id_recinto=id_recinto AND Reservas_Prereservas.id_espectaculo=id_espectaculo AND Reservas_Prereservas.fecha=fecha;

IF estado = 'libre' /*la localidad está libre*/
  THEN
    /*UNA VEZ COMPROBAMOS QUE LA LOCALIDAD ESTÁ LIBRE COMPROBAMOS SI SE ADMITEN USUARIOS DEL tipo_usuario*/
    IF tipo_usuario = 'Jubilado'
      THEN SELECT maximo_jubilado INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'Adulto'
      THEN SELECT maximo_adulto INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'Infantil'
      THEN SELECT maximo_infantil INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'Parado'
      THEN SELECT maximo_parado INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'Bebe'
      THEN SELECT maximo_bebe INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSE /*si no introduce los usuario que existen*/
      SET id_transaccion = -2;
      LEAVE reservar;
    END IF;

    IF max_tipo = 0
      THEN
        SET id_transaccion = -3; /*el id_transaccion -2 significa que no hay entradas para ese tipo de usuario*/
        LEAVE reservar;
    END IF;

    /*Vamos a comprobar que no se exceda el límite de reservas para ese tipo de usuario*/
    SELECT COUNT(*) INTO actuales_tipo FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_grada = id_grada AND Reservas_Prereservas.id_recinto = id_recinto AND Reservas_Prereservas.id_espectaculo = id_espectaculo AND Reservas_Prereservas.fecha = fecha AND Reservas_Prereservas.tipo_usuario = tipo_usuario GROUP BY Reservas_Prereservas.tipo_usuario;
    IF actuales_tipo = max_tipo
      THEN
        SET id_transaccion = -4; /*el id_transaccion -4 significa que no hay más entradas para ese tipo de usuario*/
        LEAVE reservar;
    END IF;

    /*Vamos a comprobar que no se exceda el límite de reservas de cualquier usuario para ese tipo de evento*/
    SELECT COUNT(*) INTO actuales_evento FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_recinto = id_recinto AND Reservas_Prereservas.id_espectaculo = id_espectaculo AND Reservas_Prereservas.fecha = fecha GROUP BY Reservas_Prereservas.id_recinto, Reservas_Prereservas.id_espectaculo, Reservas_Prereservas.fecha;
    IF (SELECT aforo_evento FROM Eventos WHERE Eventos.id_espectaculo=id_espectaculo AND Eventos.id_recinto=id_recinto AND Eventos.fecha=fecha) = actuales_evento
      THEN
        SET id_transaccion = -5; /*el id_transaccion -5 significa que no hay más entradas para ese evento*/
        LEAVE reservar;
    END IF;

    /*PROCEDEMOS A METER LOS DATOS EN Reservas_Prereservas y actualizar el estado de la localidad en Localidades*/
    UPDATE Localidades SET estado_localidad = tipo_transaccion WHERE Localidades.id_localidad= id_localidad AND Localidades.id_grada= id_grada AND Localidades.id_recinto= id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;
    INSERT INTO Reservas_Prereservas VALUES (id_localidad,id_grada,id_espectaculo,id_recinto,fecha,dni, NULL,tipo_usuario);

    SET id_transaccion=1;
    LEAVE reservar;


ELSEIF estado='pre-reservado' AND comprobacion = dni AND tipo_transaccion = 'reservado'
  THEN
    /*Actualizamos el estado de la localidad de pre-reservado a reservado*/
    UPDATE Localidades SET estado_localidad = 'reservado' WHERE Localidades.id_localidad= id_localidad AND Localidades.id_grada= id_grada AND Localidades.id_recinto= id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;

	/*Añadimos el disparador periodico (evento) para eliminar la prereserva pasados los T1 minutos de tiempo de validez*/

    SET id_transaccion=1;
    LEAVE reservar;


ELSE /*El id_reserva=-1 significa localidad no está libre*/
    SET id_transaccion = -1;
    LEAVE reservar;
END IF;

END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE TRIGGER disparador_anulacion BEFORE DELETE ON Reservas_Prereservas FOR EACH ROW
BEGIN
    DECLARE id_localidad_AUX INT DEFAULT 0;
    DECLARE id_grada_AUX INT DEFAULT 0;
    DECLARE id_recinto_AUX INT DEFAULT 0;
    DECLARE id_espectaculo_AUX INT DEFAULT 0;
    DECLARE fecha_AUX DATETIME DEFAULT '1999-09-09 00:00:00';

    SELECT id_localidad INTO id_localidad_AUX FROM Reservas_Prereservas WHERE id_localidad = old.id_localidad AND id_grada=old.id_grada AND id_recinto=old.id_recinto AND id_espectaculo=old.id_espectaculo AND fecha=old.fecha;
    SELECT id_grada INTO id_grada_AUX FROM Reservas_Prereservas WHERE id_localidad = old.id_localidad AND id_grada=old.id_grada AND id_recinto=old.id_recinto AND id_espectaculo=old.id_espectaculo AND fecha=old.fecha;
    SELECT id_recinto INTO id_recinto_AUX FROM Reservas_Prereservas WHERE id_localidad = old.id_localidad AND id_grada=old.id_grada AND id_recinto=old.id_recinto AND id_espectaculo=old.id_espectaculo AND fecha=old.fecha;
    SELECT id_espectaculo INTO id_espectaculo_AUX FROM Reservas_Prereservas WHERE id_localidad = old.id_localidad AND id_grada=old.id_grada AND id_recinto=old.id_recinto AND id_espectaculo=old.id_espectaculo AND fecha=old.fecha;
    SELECT fecha INTO fecha_AUX FROM Reservas_Prereservas WHERE id_localidad = old.id_localidad AND id_grada=old.id_grada AND id_recinto=old.id_recinto AND id_espectaculo=old.id_espectaculo AND fecha=old.fecha;

    UPDATE Localidades SET estado_localidad='libre' WHERE id_localidad=id_localidad_AUX AND id_grada=id_grada_AUX AND id_recinto=id_recinto_AUX AND id_espectaculo=id_espectaculo_AUX AND fecha=fecha_AUX;

END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE mostrarParticipantes()
BEGIN
	select participante from Participantes;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE mostrarRecintos()
BEGIN
	select nombre_recinto from Recintos;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE mostrarEspectaculos()
BEGIN
	select nombre_espectaculo from Espectaculos;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/



/*aqui hay que cambiar*/

/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE eventoPrereserva(IN espectaculo int, IN recinto int, IN fecha datetime, IN grada int, IN localidad int, IN dni varchar(9))
BEGIN
#	CREATE EVENT evento_preserva ON SCHEDULE at now() + interval (SELECT T1 from Eventos where id_espectaculo = espectaculo and id_recinto = recinto and Eventos.fecha = fecha) minute
#	DO
#		delete from Reservas_Prereservas
#			where id_localidad = localidad and id_grada = grada and Reservas_Prereservas.dni = dni and id_recinto = recinto
#				and id_espectaculo = espectaculo and Reservas_Prereservas.fecha = fecha;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE TRIGGER disparador_insertar_evento BEFORE INSERT ON Eventos FOR EACH ROW
BEGIN
	if exists (select * from Eventos where Eventos.id_recinto = new.id_recinto and Eventos.fecha = new.fecha) then
		signal SQLSTATE '45000';
	end if;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE infoLocalidades(IN id_espectaculo int, IN id_recinto int, IN fecha datetime, IN id_grada int)
BEGIN
        select id_localidad
        from Localidades
        where Localidades.id_grada = id_grada
            and Localidades.id_espectaculo = id_espectaculo
            and Localidades.id_recinto = id_recinto
            and Localidades.fecha = fecha
      and Localidades.estado_localidad = 'libre'
      order by id_localidad;
END //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE obtenerMaximoPrereservas(IN id_espectaculo int, IN id_recinto int, IN fecha datetime, OUT maximo_prereservas int)
BEGIN
        select Eventos.max_prereservas INTO maximo_prereservas from Eventos where Eventos.id_espectaculo = id_espectaculo and Eventos.id_recinto = id_recinto and Eventos.fecha = fecha;
END //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/

/**/
/**/
/**/
CREATE PROCEDURE mostrarGradas(IN id_espectaculo int, IN id_recinto int, IN fecha datetime)
BEGIN
        select id_grada from Gradas where Gradas.id_espectaculo = id_espectaculo and Gradas.id_recinto = id_recinto and Gradas.fecha = fecha;
END //
/**/
/**/
/**/
delimiter ;