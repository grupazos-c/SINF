delimiter //

DROP PROCEDURE IF EXISTS reservar_pre_reservar//

CREATE PROCEDURE reservar_pre_reservar(IN tipo_transaccion VARCHAR (15),IN dni VARCHAR (9), IN tipo_usuario VARCHAR (15), IN id_localidad INT, IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT, IN fecha DATETIME, OUT id_transaccion VARCHAR (5))
reservar:BEGIN
/*tipo_transaccion es una variable que indica si la operacion es RESERVAR O PRE-RESERVAR*/
/*Este procedimiento reservará una localidad dados unos parámetros de entrada y retornará valores negativos cuando hay un error*/


/*PRIMERO COMPROBAMOS EL ESTADO DE LA LOCALIDAD*/
SET @estado = null;
SET @max_tipo = 0;
SET @actuales_tipo = 0;
SET @actuales_evento = 0;
SET @comprobacion = null;
SET @transaccion = null;

IF tipo_transaccion = 'reservar'
  THEN
    SET @transaccion = 'reservado';
ELSEIF tipo_transaccion = 'pre-reservar'
  THEN
    SET @transaccion = 'pre-reservado';
ELSE
    SET id_transaccion = -6; /*Transacción no adminita, solo admitimos reservar y pre_reservar*/
    LEAVE reservar;
END IF;

SELECT estado_localidad INTO @estado FROM Localidades WHERE Localidades.id_localidad = id_localidad AND Localidades.id_grada = id_grada AND Localidades.id_recinto = id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;
SELECT dni INTO @comprobacion FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_localidad=id_localidad AND Reservas_Prereservas.id_grada=id_grada AND Reservas_Prereservas.id_recinto=id_recinto AND Reservas_Prereservas.id_espectaculo=id_espectaculo AND Reservas_Prereservas.fecha=fecha;

IF @estado = 'libre' /*la localidad está libre*/
  THEN
    /*UNA VEZ COMPROBAMOS QUE LA LOCALIDAD ESTÁ LIBRE COMPROBAMOS SI SE ADMITEN USUARIOS DEL tipo_usuario*/
    IF tipo_usuario = 'jubilado'
      THEN SELECT maximo_jubilado INTO @max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'adulto'
      THEN SELECT maximo_adulto INTO @max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'infaltil'
      THEN SELECT maximo_infantil INTO @max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'parado'
      THEN SELECT maximo_parado INTO @max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSEIF tipo_usuario = 'bebe'
      THEN SELECT maximo_bebe INTO @max_tipo FROM Gradas WHERE Gradas.id_grada = id_grada AND Gradas.id_recinto= id_recinto AND Gradas.id_espectaculo= id_espectaculo AND Gradas.fecha= fecha;
    ELSE /*si no introduce los usuario que existen*/
      SET id_transaccion = -2;
      LEAVE reservar;
    END IF;

    IF @max_tipo = 0
      THEN
        SET id_transaccion = -3; /*el id_transaccion -2 significa que no hay entradas para ese tipo de usuario*/
        LEAVE reservar;
    END IF;

    /*Vamos a comprobar que no se exceda el límite de reservas para ese tipo de usuario*/
    SELECT COUNT(*) INTO @actuales FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_grada = id_grada AND Reservas_Prereservas.id_recinto = id_recinto AND Reservas_Prereservas.id_espectaculo = id_espectaculo AND Reservas_Prereservas.fecha = fecha AND Reservas_Prereservas.tipo_usuario = tipo_usuario GROUP BY Reservas_Prereservas.tipo_usuario;
    IF @actuales = @max_tipo
      THEN
        SET id_transaccion = -4; /*el id_transaccion -4 significa que no hay más entradas para ese tipo de usuario*/
        LEAVE reservar;
    END IF;

    /*Vamos a comprobar que no se exceda el límite de reservas de cualquier usuario para ese tipo de evento*/
    SELECT COUNT(*) INTO @actuales_evento FROM Reservas_Prereservas WHERE Reservas_Prereservas.id_recinto = id_recinto AND Reservas_Prereservas.id_espectaculo = id_espectaculo AND Reservas_Prereservas.fecha = fecha GROUP BY Reservas_Prereservas.id_recinto, Reservas_Prereservas.id_espectaculo, Reservas_Prereservas.fecha;
    IF (SELECT aforo_evento FROM Eventos WHERE Eventos.id_espectaculo=id_espectaculo AND Eventos.id_recinto=id_recinto AND Eventos.fecha=fecha) = @actuales_evento
      THEN
        SET id_transaccion = -5; /*el id_transaccion -5 significa que no hay más entradas para ese evento*/
        LEAVE reservar;
    END IF;

    /*PROCEDEMOS A METER LOS DATOS EN Reservas_Prereservas y actualizar el estado de la localidad en Localidades*/
    UPDATE Localidades SET estado_localidad = @transaccion WHERE Localidades.id_localidad= id_localidad AND Localidades.id_grada= id_grada AND Localidades.id_recinto= id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;
    INSERT INTO Reservas_Prereservas VALUES (id_localidad,id_grada,id_recinto,id_espectaculo,fecha,dni, NULL,tipo_usuario);

    SET id_transaccion=1;
    LEAVE reservar;


ELSEIF @estado='pre-reservado' AND @comprobacion = dni AND tipo_transaccion = 'reservar'
  THEN
    /*Actualizamos el estado de la localidad de pre-reservado a reservado*/
    UPDATE Localidades SET estado_localidad = 'reservado' WHERE Localidades.id_localidad= id_localidad AND Localidades.id_grada= id_grada AND Localidades.id_recinto= id_recinto AND Localidades.id_espectaculo= id_espectaculo AND Localidades.fecha= fecha;


    SET id_transaccion=1;
    LEAVE reservar;


ELSE /*El id_reserva=-1 significa localidad no está libre*/
    SET id_transaccion = -1;
    LEAVE reservar;
END IF;

END//

delimiter ;

/*DELETE FROM Reservas_Prereservas;
CALL reservar_pre_reservar('pre-reservar','32654125D', 'jubilado', 2, 1, 1, 1, '2016-05-12 16:00:00', @id_transaccion);
*/
