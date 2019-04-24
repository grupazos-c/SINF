delimiter //

DROP PROCEDURE IF EXISTS reservar//

CREATE PROCEDURE reservar(IN dni VARCHAR (9), IN tipo_usuario VARCHAR (15), IN id_localidad INT, IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT, IN fecha DATETIME, OUT id_transaccion VARCHAR (5))
BEGIN
/*Este procedimiento reservará una localidad dados unos parámetros de entrada y retornará el id de la trnasacción.
  En caso de error retorna "ERROR"*/


/*PRIMERO COMPROBAMOS EL ESTADO DE LA LOCALIDAD*/
SET @estado = null;
SET @max_tipo = 0;

SET @comando_estado = concat("SELECT estado_localidad INTO @estado FROM Localidades WHERE id_localidad = ",id_localidad," AND id_grada = ",id_grada," AND id_recinto = ",id_recinto," AND id_espectaculo= ",id_espectaculo," AND fecha= '",fecha,"';");

PREPARE stmtestado FROM @comando_estado;
EXECUTE stmtestado;

select id_localidad; SELECT id_grada; SELECT id_recinto;
select @estado;

IF @estado = 'libre' /*la localidad está libre*/
THEN

    /*UNA VEZ COMPROBAMOS QUE LA LOCALIDAD ESTÁ LIBRE COMPROBAMOS SI SE ADMITEN USUARIOS DEL tipo_usuario*/
    IF tipo_usuario = 'jubilado'
      THEN SET @comando_tipo = concat("SELECT maximo_jubilado INTO @max_tipo FROM Gradas WHERE id_grada = ", id_grada, " AND id_recinto= ", id_recinto, " AND id_espectaculo= ", id_espectaculo, " AND fecha= '",fecha,"';");
    ELSEIF tipo_usuario = 'adulto'
      THEN SET @comando_tipo = concat("SELECT maximo_adulto INTO @max_tipo FROM Gradas WHERE id_grada = ", id_grada, " AND id_recinto= ", id_recinto, " AND id_espectaculo= ", id_espectaculo, " AND fecha= '",fecha,"';");
    ELSEIF tipo_usuario = 'infaltil'
      THEN SET @comando_tipo = concat("SELECT maximo_infantil INTO @max_tipo FROM Gradas WHERE id_grada = ", id_grada, " AND id_recinto= ", id_recinto, " AND id_espectaculo= ", id_espectaculo, " AND fecha= '",fecha,"';");
    ELSEIF tipo_usuario = 'parado'
      THEN SET @comando_tipo = concat("SELECT maximo_parado INTO @max_tipo FROM Gradas WHERE id_grada = ", id_grada, " AND id_recinto= ", id_recinto, " AND id_espectaculo= ", id_espectaculo, " AND fecha= '",fecha,"';");
    ELSEIF tipo_usuario = 'bebe'
      THEN SET @comando_tipo = concat("SELECT maximo_bebe INTO @max_tipo FROM Gradas WHERE id_grada = ",id_grada," AND id_recinto= ",id_recinto," AND id_espectaculo= ",id_espectaculo," AND fecha= '",fecha,"';");
    ELSE /*si no introduce los usuario que existen*/
      BEGIN
      END;
    END IF;

    PREPARE stmtcomando_tipo FROM @comando_tipo;
    EXECUTE stmtcomando_tipo;

    select @max_tipo;
    IF @max_tipo = 0
      THEN
        SET id_transaccion = -2; /*el id_reserva -2 significa que no hay más entradas para ese tipo de usuario*/
    ELSE /*Podemos proceder con la reserva*/

        SET @comando_actualizar_localidad = concat("UPDATE Localidades SET estado_localidad = 'reservado' WHERE id_localidad= ", id_localidad, " AND id_grada= ", id_grada, " AND id_recinto= ", id_recinto, " AND id_espectaculo= ", id_espectaculo, " AND fecha= '", fecha, "' ;");
        PREPARE stmtcomando_actualizar_localidad FROM @comando_actualizar_localidad;
        EXECUTE stmtcomando_actualizar_localidad;


        SET @comando_insertar = concat("INSERT INTO Reservas_Prereservas VALUES (",id_localidad,",",id_grada,",",id_recinto,",",id_espectaculo,",'",fecha,"','",dni,"', NULL,'",tipo_usuario,"');");
        PREPARE stmtcomando_insertar FROM @comando_insertar;
        EXECUTE stmtcomando_insertar;

        SET id_transaccion=1;

    END IF;

ELSE /*El id_reserva=-1 significa localidad no está libre*/
    SET id_transaccion = -1;
END IF;

END//

delimiter ;

DELETE FROM Reservas_Prereservas;
CALL reservar('32654125D', 'jubilado', 2, 1, 1, 1, '2016-05-12 16:00:00', @id_transaccion);
