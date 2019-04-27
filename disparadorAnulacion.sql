delimiter //

DROP TRIGGER IF EXISTS disparador_anulacion//

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

END
//
