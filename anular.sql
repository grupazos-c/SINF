#funcion:
drop PROCEDURE if exists anularReserva;

delimiter //

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

delimiter ;

