/**
*
* -> El evento (diparador periodico) del procedure reservas-prereservas no fuciona
*
*/

DROP DATABASE IF EXISTS VigoCoffeeLoversDB;
CREATE DATABASE VigoCoffeeLoversDB;
#GRANT ALL PRIVILEGES ON Proyecto.* TO 'cliente'@'localhost';
USE VigoCoffeeLoversDB;

/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE TABLE Espectaculos (
  id_espectaculo INT NOT NULL AUTO_INCREMENT,
  nombre_espectaculo VARCHAR (50) NOT NULL,
  descripcion VARCHAR(50) NOT NULL,
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
  FOREIGN KEY (id_recinto, id_espectaculo, fecha)
  REFERENCES Eventos(id_espectaculo, id_recinto, fecha)
  ON DELETE CASCADE

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
  FOREIGN KEY (id_grada, id_recinto, id_espectaculo, fecha)
  REFERENCES Gradas(id_grada, id_recinto, id_espectaculo, fecha)
  ON DELETE CASCADE
);

CREATE TABLE Reservas_Prereservas (
  id_localidad INT NOT NULL,
  id_grada INT NOT NULL,
  id_recinto INT NOT NULL,
  id_espectaculo INT NOT NULL,
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
INSERT INTO Espectaculos VALUES (1, 'Celta-Deportivo', 'Partido Celta vs Deportivo', 'Futbol');
INSERT INTO Espectaculos VALUES (2, 'Civil War', 'Proyeccion de la pelicula Civil War', 'Pelicula');
INSERT INTO Espectaculos VALUES (3, 'Concierto Sabina', 'Concierto de Joaquin Sabina', 'Concierto');
INSERT INTO Espectaculos VALUES (4, 'Concierto Alex Ubago', 'Concierto de Alex Ubago', 'Concierto');
INSERT INTO Espectaculos VALUES (5, 'Deportivo-Barcelona', 'Partido Deportivo vs Barcelona', 'Futbol');
INSERT INTO Espectaculos VALUES (6, 'El Rey Leon', 'Representacion de la obra El Rey Leon', 'Teatro');
INSERT INTO Espectaculos VALUES (7, 'Deadpool', 'Proyeccion de la pelicula Deadpool', 'Pelicula');


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


INSERT INTO Gradas VALUES (1, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 0, 0, 0);
INSERT INTO Gradas VALUES (1, 2, 2, '17-05-10 18:00:00', 'Grada', 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 3, 3, '18-05-12 16:00:00', 'Grada', 70, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 4, 4, '19-05-12 16:00:00', 'Grada', 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 5, 5, '20-05-12 16:00:00', 'Grada', 50, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 6, 6, '21-05-12 16:00:00', 'Grada', 80, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (1, 7, 7, '22-05-12 16:00:00', 'Grada', 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

INSERT INTO Gradas VALUES (2, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 0, 0, 0);
INSERT INTO Gradas VALUES (2, 2, 2, '17-05-10 18:00:00', 'Grada', 5, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 3, 3, '18-05-12 16:00:00', 'Grada', 70, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 4, 4, '19-05-12 16:00:00', 'Grada', 12, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 5, 5, '20-05-12 16:00:00', 'Grada', 50, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 6, 6, '21-05-12 16:00:00', 'Grada', 80, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
INSERT INTO Gradas VALUES (2, 7, 7, '22-05-12 16:00:00', 'Grada', 1, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

INSERT INTO Gradas VALUES (3, 1, 1, '16-05-12 16:00:00', 'Grada', 10, 10, 10, 10, 10, 10, 10, 10, 0, 0, 0);
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

INSERT INTO Reservas_Prereservas VALUES (1, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'adulto');
INSERT INTO Reservas_Prereservas VALUES (3, 1, 1, 1, '16-05-12 16:00:00', '32654125D', NULL, 'infantil');
INSERT INTO Reservas_Prereservas VALUES (1, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "infantil");
INSERT INTO Reservas_Prereservas VALUES (3, 2, 2, 2, '17-05-10 18:00:00', '45213658R', NULL, "infantil");
INSERT INTO Reservas_Prereservas VALUES (1, 3, 3, 3, '18-05-12 16:00:00', '78941235E', NULL, "parado");
INSERT INTO Reservas_Prereservas VALUES (3, 3, 3, 3, '18-05-12 16:00:00', '48210368I', NULL, "jubilado");
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
	if dni is null or (select * from clientes where dni = dni) is null then
		set @resultado = -1;
	else
		if nombre is not null then
			update clientes set clientes.nombre = nombre where clientes.dni = dni;
		end if;
		if iban is not null then
			update clientes set clientes.iban = iban where clientes.dni = dni;
		end if;
		if fecha is not null then
			update clientes set clientes.fecha = fecha where clientes.dni = dni;
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
    if exists (select dni from clientes where clientes.dni = dni) then
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
	IN filtro_espectaculo varchar(15),
    IN filtro_recinto varchar(25),
    IN filtro_fecha_min varchar(19),
    IN filtro_fecha_max varchar(19),
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
		CREATE TEMPORARY TABLE resultado select eventos.* from eventos where estado_evento = 'abierto';
	else
		CREATE TEMPORARY TABLE resultado select eventos.* from eventos, gradas 
		where eventos.id_espectaculo = gradas.id_espectaculo and eventos.id_recinto = gradas.id_recinto and eventos.fecha = gradas.fecha and estado_evento = 'abierto'
        and 0 < if(jubilado = true	, gradas.maximo_jubilado	, 1)
        and 0 < if(adulto 	= true	, gradas.maximo_adulto		, 1)
        and 0 < if(parado 	= true	, gradas.maximo_parado		, 1)
        and 0 < if(infantil = true	, gradas.maximo_infantil	, 1)
        and 0 < if(bebe 	= true	, gradas.maximo_bebe		, 1)
        group by eventos.id_espectaculo, eventos.id_recinto, eventos.fecha;
	end if;
	/**********************************************************************************************************************************************************/
    
    CREATE TEMPORARY TABLE aux select * from eventos where 1=0;
    
	if filtro_espectaculo is not null then
		insert into aux select resultado.* from resultado, espectaculos where resultado.id_espectaculo = espectaculos.id_espectaculo and espectaculos.nombre_espectaculo = filtro_espectaculo;
        truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_recinto is not null then
		insert into aux select resultado.* from resultado, recintos where resultado.id_recinto = recintos.id_recinto and recintos.nombre_recinto = filtro_recinto;
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
		insert into aux select resultado.* from resultado, espectaculos, participantes 
			where resultado.id_espectaculo = espectaculos.id_espectaculo 
				AND espectaculos.id_espectaculo = participantes.id_espectaculo AND participantes.participante = filtro_participante;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;

	if filtro_precio_max is not null then
		insert into aux select resultado.* from resultado, gradas 
			where resultado.id_espectaculo = gradas.id_espectaculo AND resultado.id_recinto = gradas.id_recinto AND resultado.fecha = gradas.fecha 
				and filtro_precio_max <= if(jubilado = true	, gradas.precio_jubilado	, filtro_precio_max)
				and filtro_precio_max <= if(adulto 	 = true	, gradas.precio_adulto		, filtro_precio_max)
				and filtro_precio_max <= if(parado 	 = true	, gradas.precio_parado		, filtro_precio_max)
				and filtro_precio_max <= if(infantil = true	, gradas.precio_infantil	, filtro_precio_max)
				and filtro_precio_max <= if(bebe 	 = true	, gradas.precio_bebe		, filtro_precio_max)
				group by resultado.id_espectaculo, resultado.id_recinto, resultado.fecha;
		truncate resultado; insert into resultado select * from aux; DROP TABLE aux;
    end if;

	select resultado.id_espectaculo, espectaculos.nombre_espectaculo, resultado.id_recinto, recintos.nombre_recinto, resultado.fecha
		from resultado, espectaculos, recintos where resultado.id_espectaculo = espectaculos.id_espectaculo and resultado.id_recinto = recintos.id_recinto;
	
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

	select count(*) into localidades_disponibles from gradas, localidades 
		where gradas.id_grada = localidades.id_grada 
			and gradas.id_recinto = localidades.id_recinto 
			and gradas.id_espectaculo = localidades.id_espectaculo 
			and gradas.fecha = localidades.fecha 
			and gradas.id_espectaculo = espectaculo
			and gradas.id_recinto = recinto
			and gradas.fecha = fecha
			and gradas.id_grada = grada
			and localidades.estado_localidad = 'libre'
		GROUP BY gradas.id_grada;
	if localidades_disponibles is null then set localidades_disponibles = 0; end if;
		
	select count(*) into localidades_ocupadas_por_usuario_jubilado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'jubilado'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_jubilado is null then set localidades_ocupadas_por_usuario_jubilado = 0; end if;
		
	select count(*) into localidades_ocupadas_por_usuario_adulto from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_adulto is null then set localidades_ocupadas_por_usuario_adulto = 0;  end if;
		
	select count(*) into localidades_ocupadas_por_usuario_parado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_parado is null then set localidades_ocupadas_por_usuario_parado = 0; end if;
		
	select count(*) into localidades_ocupadas_por_usuario_parado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'parado'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_bebe is null then set localidades_ocupadas_por_usuario_bebe = 0; end if;
		
	select count(*) into localidades_ocupadas_por_usuario_infantil from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'infantil'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_infantil is null then set localidades_ocupadas_por_usuario_infantil = 0; end if;
		
        
	select count(*) into localidades_ocupadas_por_usuario_bebe from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'bebe'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_bebe is null then set localidades_ocupadas_por_usuario_bebe = 0; end if;
    
		select gradas.id_grada, 
			if(localidades_disponibles < localidades_ocupadas_por_usuario_jubilado, localidades_disponibles, localidades_ocupadas_por_usuario_jubilado) as localidades_jubilado,
			gradas.precio_jubilado,
			if(localidades_disponibles < localidades_ocupadas_por_usuario_adulto, localidades_disponibles, localidades_ocupadas_por_usuario_adulto) 	as localidades_adulto,
			gradas.precio_adulto,
			if(localidades_disponibles < localidades_ocupadas_por_usuario_parado, localidades_disponibles, localidades_ocupadas_por_usuario_parado) 	as localidades_parado,
			gradas.precio_parado,
			if(localidades_disponibles < localidades_ocupadas_por_usuario_infantil, localidades_disponibles, localidades_ocupadas_por_usuario_infantil) as localidades_infantil,
			gradas.precio_infantil,
			if(localidades_disponibles < localidades_ocupadas_por_usuario_bebe, localidades_disponibles, localidades_ocupadas_por_usuario_bebe) 		as localidades_bebe,
			gradas.precio_bebe
		from gradas, eventos
        where gradas.id_grada = grada
			and gradas.id_espectaculo = eventos.id_espectaculo
			and gradas.id_recinto = eventos.id_recinto
			and gradas.fecha = eventos.fecha
			and gradas.id_espectaculo = espectaculo
			and gradas.id_recinto = recinto
			and gradas.fecha = fecha;

END //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure obtenerEntradasCompradasCliente(IN dni varchar(9))
begin
	select espectaculos.nombre_espectaculo, recintos.nombre_recinto, fecha, gradas.nombre_grada, reservas_prereservas.id_localidad, reservas_prereservas.tipo_usuario, 
		case 
			when reservas_prereservas.tipo_usuario = 'jubilado' then gradas.precio_jubilado
            when reservas_prereservas.tipo_usuario = 'adulto' then gradas.precio_adulto
            when reservas_prereservas.tipo_usuario = 'parado' then gradas.precio_parado
            when reservas_prereservas.tipo_usuario = 'infantil' then gradas.precio_infantil
            when reservas_prereservas.tipo_usuario = 'bebe' then gradas.precio_bebe
		end as precio
	from reservas_prereservas, gradas, espectaculos recintos where reservas_prereservas.dni = dni 
		and espectaculos.id_espectaculo = gradas.id_espectaculo = reservas_prereservas.id_espectaculo 
        and recintos.id_recinto = gradas.id_recinto = reservas_prereservas.id_recinto
        and reservas_prereservas.fecha = gradas.fecha 
        and reservas_prereservas.id_grada = gradas.id_grada;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
create procedure obtenerDatosCliente(IN dni varchar(9))
begin
	select nombre_cliente, iban, nacimiento from clientes where clientes.dni = dni;
end //
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE reservar_pre_reservar(IN tipo_transaccion VARCHAR (15),IN dni VARCHAR (9), IN tipo_usuario VARCHAR (15), IN id_localidad INT, IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT, IN fecha DATETIME, OUT id_transaccion VARCHAR (5))
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
    IF tipo_usuario = 'jubilado'
      THEN SELECT maximo_jubilado INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'adulto'
      THEN SELECT maximo_adulto INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'infaltil'
      THEN SELECT maximo_infantil INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'parado'
      THEN SELECT maximo_parado INTO max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'bebe'
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
    INSERT INTO Reservas_Prereservas VALUES (id_localidad,id_grada,id_recinto,id_espectaculo,fecha,dni, NULL,tipo_usuario);
	
    /*Añadimos el disparador periodico (evento) para eliminar la prereserva pasados los T1 minutos de tiempo de validez*/
	CALL eventoPrereserva(id_espectaculo, id_recinto, fecha, id_grada, id_localidad, dni);
	/**********************************************************************************************************/
    
    SET id_transaccion=1;
    LEAVE reservar;


ELSEIF estado='pre-reservado' AND comprobacion = dni AND tipo_transaccion = 'reservado'
  THEN
    /*Actualizamos el estado de la localidad de pre-reservado a reservado*/
    UPDATE Localidades SET estado_localidad = 'reservado' WHERE Localidades.id_localidad= id_localidad AND Localidades.id_grada= id_grada AND Localidades.id_recinto= id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;

	/*Añadimos el disparador periodico (evento) para eliminar la prereserva pasados los T1 minutos de tiempo de validez*/
	CALL eventoPrereserva(id_espectaculo, id_recinto, fecha, id_grada, id_localidad, dni);
	/**********************************************************************************************************/
    
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
	select participante from participantes;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE mostrarRecintos()
BEGIN
	select nombre_recinto from recintos;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE mostrarEspectaculos()
BEGIN
	select nombre_espectaculo from espectaculos;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/





/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE PROCEDURE eventoPrereserva(IN espectaculo int, IN recinto int, IN fecha datetime, IN grada int, IN localidad int, IN dni varchar(9))
BEGIN
	CREATE EVENT evento_preserva ON SCHEDULE at now() + interval (SELECT T1 from eventos where id_espectaculo = espectaculo and id_recinto = recinto and reservas_prereservas.fecha = fecha) minute
	DO
		delete from reservas_prereservas 
			where id_localidad = filtro_localidad and reservas_prereservas.id_grada = grada and reservas_prereservas.dni = dni and id_recinto = recinto 
				and id_espectaculo = espectaculo and reservas_prereservas.fecha = fecha;
END//
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
	




/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
/******************************************************************************************************************************************************************/
CREATE TRIGGER disparador_insertar_evento BEFORE INSERT ON eventos FOR EACH ROW
BEGIN
	if exists (select * from eventos where eventos.id_recinto = new.id_recinto and eventos.fecha = new.fecha) then
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
delimiter ;
