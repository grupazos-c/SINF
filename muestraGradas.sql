DROP PROCEDURE IF EXISTS muestraGradas;

delimiter //
CREATE PROCEDURE muestraGradas(IN espectaculo int, IN recinto int, IN fecha datetime, IN grada int)
BEGIN

	DECLARE localidades_disponibles int;
	DECLARE localidades_ocupadas_por_usuario_jubilado int;
	DECLARE localidades_ocupadas_por_usuario_adulto int;
	DECLARE localidades_ocupadas_por_usuario_parado int;
	DECLARE localidades_ocupadas_por_usuario_infantil int;
	DECLARE localidades_ocupadas_por_usuario_bebe int;

	select count(*) into localidades_disponibles from gradas, localidades 
		where gradas.id_grada = localidades.id_grada 
			and gradas.id_recinto = localidades.id_recinto 
			and gradas.id_espectaculo = localidades.id_espectaculo 
			and gradas.fecha = localidades.fecha 
			and gradas.id_espectaculo = espectaculo
			and gradas.id_recinto = recinto
			and gradas.fecha = fecha
			and gradas.id_grada = grada
			and localidades.estado_localidad = 'libre'
		GROUP BY gradas.id_grada;
	if localidades_disponibles is null then set localidades_disponibles = 0; end if;
        
	select count(*) into localidades_ocupadas_por_usuario_jubilado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'jubilado'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_jubilado is null then set localidades_ocupadas_por_usuario_jubilado = 0; end if;
        
	select count(*) into localidades_ocupadas_por_usuario_adulto from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_adulto is null then set localidades_ocupadas_por_usuario_adulto = 0; end if;
        
	select count(*) into localidades_ocupadas_por_usuario_parado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_parado is null then set localidades_ocupadas_por_usuario_parado = 0; end if;
        
	select count(*) into localidades_ocupadas_por_usuario_infantil from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'infantil'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_infantil is null then set localidades_ocupadas_por_usuario_infantil = 0; end if;
        
	select count(*) into localidades_ocupadas_por_usuario_bebe from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'bebe'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario;
	if localidades_ocupadas_por_usuario_bebe is null then set localidades_ocupadas_por_usuario_bebe = 0; end if;
    
	select gradas.id_grada, 
		if(localidades_disponibles < (gradas.maximo_jubilado-localidades_ocupadas_por_usuario_jubilado), localidades_disponibles, (gradas.maximo_jubilado - localidades_ocupadas_por_usuario_jubilado)) as localidades_jubilado,
		gradas.precio_jubilado,
		if(localidades_disponibles < (gradas.maximo_adulto-localidades_ocupadas_por_usuario_adulto), localidades_disponibles, (gradas.maximo_adulto-localidades_ocupadas_por_usuario_adulto)) 	as localidades_adulto,
		gradas.precio_adulto,
		if(localidades_disponibles < (gradas.maximo_parado-localidades_ocupadas_por_usuario_parado), localidades_disponibles, (gradas.maximo_parado-localidades_ocupadas_por_usuario_parado)) 	as localidades_parado,
		gradas.precio_parado,
		if(localidades_disponibles < (gradas.maximo_infantil-localidades_ocupadas_por_usuario_infantil), localidades_disponibles, (gradas.maximo_infantil-localidades_ocupadas_por_usuario_infantil)) as localidades_infantil,
		gradas.precio_infantil,
		if(localidades_disponibles < (gradas.maximo_bebe-localidades_ocupadas_por_usuario_bebe), localidades_disponibles, (gradas.maximo_bebe-localidades_ocupadas_por_usuario_bebe)) 		as localidades_bebe,
		gradas.precio_bebe
	from gradas, eventos
	where gradas.id_grada = grada
		and gradas.id_espectaculo = eventos.id_espectaculo
		and gradas.id_recinto = eventos.id_recinto
		and gradas.fecha = eventos.fecha
		and gradas.id_espectaculo = espectaculo
		and gradas.id_recinto = recinto
		and gradas.fecha = fecha;

END //
delimiter ;

CALL muestraGradas(1,1,'16-05-12 16:00:00',1);
