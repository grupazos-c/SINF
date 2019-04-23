DROP DATABASE IF EXISTS Proyecto;
CREATE DATABASE Proyecto;
GRANT ALL PRIVILEGES ON Proyecto.* TO 'cliente'@'localhost';
USE Proyecto;


CREATE TABLE Espectaculos
(
  id_espectaculo INT NOT NULL AUTO_INCREMENT,
  descripcion VARCHAR(50) NOT NULL,
  tipo VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_espectaculo)
);

CREATE TABLE Participantes
(
  participante VARCHAR(25) NOT NULL,
  id_espectaculo INT NOT NULL,
  FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo),
  PRIMARY KEY (participante, id_espectaculo)
);

CREATE TABLE Recintos
(
  id_recinto INT NOT NULL AUTO_INCREMENT,
  nombre_recinto VARCHAR (25) NOT NULL,
  aforo_recinto INT NOT NULL,
  PRIMARY KEY (id_recinto)
);

CREATE TABLE Eventos
(
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
  FOREIGN KEY (id_espectaculo) REFERENCES Espectaculos(id_espectaculo),
  FOREIGN KEY (id_recinto) REFERENCES Recintos(id_recinto)
);

CREATE TABLE Clientes
(
  dni VARCHAR(9) NOT NULL,
  nombre VARCHAR(30) NOT NULL,
  iban VARCHAR(26) NOT NULL,
  nacimiento DATE NOT NULL,
  PRIMARY KEY (dni)
);

CREATE TABLE Gradas
(
  id_grada INT NOT NULL AUTO_INCREMENT,
  id_espectaculo INT NOT NULL,
  id_recinto INT NOT NULL,
  fecha DATETIME NOT NULL,
  nombre VARCHAR(10) NOT NULL,
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
  FOREIGN KEY (id_recinto, id_espectaculo, fecha) REFERENCES Eventos(id_espectaculo, id_recinto, fecha)
);

CREATE TABLE Localidades
(
  id_localidad INT NOT NULL AUTO_INCREMENT,
  id_grada INT NOT NULL,
  id_recinto INT NOT NULL,
  id_espectaculo INT NOT NULL,
  fecha DATETIME NOT NULL,
  estado_localidad VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha),
  FOREIGN KEY (id_grada, id_recinto, id_espectaculo, fecha) REFERENCES Gradas(id_grada, id_recinto, id_espectaculo, fecha)
);

CREATE TABLE Reservas_Prereservas
(
  id_localidad INT NOT NULL,
  id_grada INT NOT NULL,
  id_recinto INT NOT NULL,
  id_espectaculo INT NOT NULL,
  fecha DATETIME NOT NULL,

  dni VARCHAR(8) NOT NULL,
  sello_temporal TIMESTAMP DEFAULT NOW(),
  tipo_usuario VARCHAR(15) NOT NULL,
  PRIMARY KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha, dni),
  FOREIGN KEY (dni) REFERENCES Clientes(dni),
  FOREIGN KEY (id_localidad, id_grada, id_recinto, id_espectaculo, fecha) REFERENCES Localidades(id_localidad, id_grada, id_recinto, id_espectaculo, fecha)
);
