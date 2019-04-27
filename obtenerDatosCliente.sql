drop procedure if exists obtenerDatosCliente;
delimiter //
create procedure obtenerDatosCliente(IN dni varchar(9))
begin
	select * from clientes where clientes.dni = dni;
end //
delimiter ;