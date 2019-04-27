drop procedure if exists obtenerEntradasCompradasCliente;
delimiter //
create procedure obtenerEntradasCompradasCliente(IN dni varchar(9))
begin
	select reservas_prereservas.*, 
		case 
			when reservas_prereservas.tipo_usuario = 'jubilado' then gradas.precio_jubilado
            when reservas_prereservas.tipo_usuario = 'adulto' then gradas.precio_adulto
            when reservas_prereservas.tipo_usuario = 'parado' then gradas.precio_parado
            when reservas_prereservas.tipo_usuario = 'infantil' then gradas.precio_infantil
            when reservas_prereservas.tipo_usuario = 'bebe' then gradas.precio_bebe
		end as precio
	from reservas_prereservas, gradas where reservas_prereservas.dni = dni and reservas_prereservas.id_espectaculo = gradas.id_espectaculo
		and reservas_prereservas.id_recinto = gradas.id_recinto and reservas_prereservas.fecha = gradas.fecha and reservas_prereservas.id_grada = gradas.id_grada;
end //
delimiter ;