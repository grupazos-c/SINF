delimiter //

DROP PROCEDURE IF EXISTS muestraGradas;

CREATE PROCEDURE muestraGradas(IN espectaculo int, IN recinto int, IN fecha varchar(10), IN grada)
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
		
	select count(*) into localidades_ocupadas_por_usuario_jubilado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'jubilado'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
		
	select count(*) into localidades_ocupadas_por_usuario_adulto from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
		
	select count(*) into localidades_ocupadas_por_usuario_adulto from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'adulto'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
		
	select count(*) into localidades_ocupadas_por_usuario_parado from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'parado'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
		
	select count(*) into localidades_ocupadas_por_usuario_infantil from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'infantil'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
		
		
	select count(*) into localidades_ocupadas_por_usuario_bebe from reservas_prereservas, gradas 
		where reservas_prereservas.id_espectaculo = gradas.id_espectaculo 
			and reservas_prereservas.id_recinto = gradas.id_recinto
			and reservas_prereservas.fecha = gradas.fecha
			and reservas_prereservas.id_grada = gradas.id_grada
			and gradas.id_grada = grada
			and reservas_prereservas.tipo_usuario = 'bebe'
		GROUP BY gradas.id_grada, reservas_prereservas.tipo_usuario
    
    select gradas.nombre, 
		min(localidades_disponibles, localidades_ocupadas_por_usuario_jubilado) as localidades_jubilado,
        gradas.precio_jubilado,
		min(localidades_disponibles, localidades_ocupadas_por_usuario_adulto) 	as localidades_adulto,
        gradas.precio_adulto,
		min(localidades_disponibles, localidades_ocupadas_por_usuario_parado) 	as localidades_parado,
        gradas.precio_parado,
		min(localidades_disponibles, localidades_ocupadas_por_usuario_infantil) as localidades_infantil,
        gradas.precio_infantil,
		min(localidades_disponibles, localidades_ocupadas_por_usuario_bebe) 	as localidades_bebe,
        gradas.precio_bebe
		from gradas
        where gradas.id_grada;

END//

CALL muestraGradas(1,1,'16-05-12 16:00:00',1)

delimiter ;
