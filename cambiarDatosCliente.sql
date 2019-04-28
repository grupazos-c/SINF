drop procedure if exists cambiarDatosCliente;
delimiter //
create procedure cambiarDatosCliente (
	IN dni varchar(9),
    IN nombre varchar(25),
    IN iban varchar(26),
    IN fechaNacimiento datetime,
    OUT resultado int
)
begin
	if dni is null or (select * from clientes where dni = dni) then
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
delimiter ;
		