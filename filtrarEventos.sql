drop PROCEDURE if exists filtrarEventos;
delimiter //
create procedure filtrarEventos(
    IN filtro_espectaculo int,
    IN filtro_recinto int,
    IN filtro_fecha_min varchar(19),
    IN filtro_fecha_max varchar(19),
    IN filtro_participante varchar(25),
    IN filtro_usuario varchar(10), #Filtrar por mas de 1 tipo de usuario?
    IN filtro_precio_max int
)
BEGIN
    
    drop table if exists resultado;
    drop table if exists aux;
	
	CREATE TEMPORARY TABLE resultado select * from eventos;
    CREATE TEMPORARY TABLE aux select * from eventos where 1=0;
	
    
	if filtro_espectaculo is not null then
		insert into aux select * from resultado where resultado.id_espectaculo = filtro_espectaculo;
        truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_recinto is not null then
		insert into aux select * from resultado where resultado.id_recinto = filtro_recinto;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_fecha_min is not null then
		insert into aux select * from resultado where resultado.fecha >= filtro_fecha_min;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_fecha_max is not null then
		insert into aux select * from resultado where resultado.fecha <= filtro_fecha_max;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_participante is not null then
		insert into aux select resultado.id_espectaculo, resultado.id_recinto, resultado.fecha, resultado.aforo_evento, resultado.estado_evento, 
			resultado.max_prereservas, resultado.fecha_finalizacion, resultado.T1, resultado.T2, resultado.T3, resultado.penalizacion_anulacion 
				from resultado, espectaculos, participantes where resultado.id_espectaculo = espectaculos.id_espectaculo 
					AND espectaculos.id_espectaculo = participantes.id_espectaculo AND participantes.participante = filtro_participante;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_usuario is not null then
		insert into aux select resultado.id_espectaculo, resultado.id_recinto, resultado.fecha, resultado.aforo_evento, resultado.estado_evento, 
			resultado.max_prereservas, resultado.fecha_finalizacion, resultado.T1, resultado.T2, resultado.T3, resultado.penalizacion_anulacion 
				from resultado, gradas where resultado.id_espectaculo = gradas.id_espectaculo AND resultado.id_recinto = gradas.id_recinto AND resultado.fecha = gradas.fecha AND 0 != 
					CASE 
						WHEN filtro_usuario = 'jubilado'	THEN maximo_jubilado
						WHEN filtro_usuario = 'adulto' 		THEN maximo_adulto
						WHEN filtro_usuario = 'infantil'	THEN maximo_infantil
						WHEN filtro_usuario = 'parado' 		THEN maximo_parado
						WHEN filtro_usuario = 'bebe' 		THEN maximo_bebe
						ELSE 0
					END
				group by resultado.id_espectaculo;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_precio_max is not null then
		insert into aux select resultado.id_espectaculo, resultado.id_recinto, resultado.fecha, resultado.aforo_evento, resultado.estado_evento, 
			resultado.max_prereservas, resultado.fecha_finalizacion, resultado.T1, resultado.T2, resultado.T3, resultado.penalizacion_anulacion 
				from resultado, gradas where resultado.id_espectaculo = gradas.id_espectaculo AND resultado.id_recinto = gradas.id_recinto 
					AND resultado.fecha = gradas.fecha AND filtro_precio_max > 
                    CASE
						WHEN filtro_usuario = 'jubilado'	THEN precio_jubilado
						WHEN filtro_usuario = 'infantil'	THEN precio_infantil
						WHEN filtro_usuario = 'parado' 		THEN precio_parado
						WHEN filtro_usuario = 'bebe' 		THEN precio_bebe
						ELSE precio_adulto
					END
				group by resultado.id_espectaculo;
		truncate resultado; insert into resultado select * from aux; DROP TABLE aux;
    end if;
    
    
	select * from resultado;
	
    DROP TABLE resultado;

END//
delimiter ;

call filtrarEventos(1,1,'2016-05-12 15:00:00', '2016-05-12 18:00:00', "Celta", "parado", 255);
