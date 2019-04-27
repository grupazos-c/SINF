#funcion:
drop PROCEDURE if exists registrarCliente;
delimiter //
CREATE PROCEDURE registrarCliente(IN dni VARCHAR(9),IN nombre VARCHAR(30), IN iban VARCHAR(26), IN nacimiento DATE,OUT error INT)
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
delimiter ;

#CALL registrarCliente ('39468547U', 'Marcos Cordeiro Sobrino','ES407050654851239650402325', '1998-05-12', @error);