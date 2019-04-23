#funcion:
drop PROCEDURE if exists anularReserva;

delimiter //

CREATE PROCEDURE anularReserva(IN id_localidad INT,IN id_grada INT, IN id_recinto INT, IN id_espectaculo INT,IN fecha DATETIME)
BEGIN
  #como hacemos lo de las transiciones, por que aquí debería haber una, por si no se puede eliminar una reserva, que no se marque la localidad como libre
  DELETE FROM Reservas_Prereservas
    WHERE id_localidad = id_localidad
      AND id_grada = id_grada
      AND id_recinto = id_recinto
      AND id_espectaculo = id_espectaculo
      AND fecha = fecha;

  UPDATE Localidades SET estado_localidad = 'libre'
    WHERE id_localidad = id_localidad
      AND id_grada = id_grada
      AND id_recinto = id_recinto
      AND id_espectaculo = id_espectaculo
      AND fecha = fecha;

  #Aquí cerrariamos el commit y además estaría bien devolver algo si todo fue ok o no, pero no sé como así que...
END//

delimiter ;
