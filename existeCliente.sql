drop procedure if exists existeCliente;
delimiter //
create procedure existeCliente(IN dni varchar(9), OUT resultado BOOLEAN)
begin
    if exists (select dni from clientes where clientes.dni = dni) then
		set resultado = true;
	else
		set resultado = false;
	end if;
end //
delimiter ;

#call existeCliente('32655125D', @resultado);
#select @resultado;