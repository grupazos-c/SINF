drop PROCEDURE if exists filtrarEventos;
delimiter //
create procedure filtrarEventos (
	IN filtro_espectaculo varchar(15),
    IN filtro_recinto varchar(25),
    IN filtro_fecha_min varchar(19),
    IN filtro_fecha_max varchar(19),
    IN filtro_participante varchar(25),
    IN filtro_precio_max int,
    IN Jubilado BOOLEAN,
    IN Adulto BOOLEAN,
    IN Parado BOOLEAN,
    IN Infantil BOOLEAN,
    IN Bebe BOOLEAN
)
BEGIN
    
    drop table if exists resultado;
    drop table if exists aux;
	
/**********************************************************************************************************************************************************/
/**********TABLA TEMPORAL QUE FILTRE TODOS LOS EVENTOS PARA QUE SOLO MUESTRE LOS QUE PERMITEN TODOS LOS TIPOS DE USUARIOS PASADOS COMO TRUE****************/
/**********************************************************************************************************************************************************/
	/*if jubilado=false and adulto=false and parado=false and infantil=false and bebe=false then
		CREATE TEMPORARY TABLE resultado select eventos.* from eventos where estado_evento = 'abierto';
	else
		CREATE TEMPORARY TABLE resultado select eventos.* from eventos, gradas 
		where eventos.id_espectaculo = gradas.id_espectaculo and eventos.id_recinto = gradas.id_recinto and eventos.fecha = gradas.fecha and eventos.estado_evento = 'abierto'
        and 0 < if(jubilado=true, gradas.precio_jubilado	, 0)
        and 0 < if(adulto=true, gradas.precio_adulto		, 0)
        and 0 < if(parado=true, gradas.precio_parado		, 0)
        and 0 < if(infantil=true, gradas.precio_infantil	, 0)
        and 0 < if(bebe=true, gradas.precio_bebe			, 0)
        group by eventos.id_espectaculo, eventos.id_recinto, eventos.fecha;
	end if;
    select * from resultado;*/
    if jubilado=false and adulto=false and parado=false and infantil=false and bebe=false then
		CREATE TEMPORARY TABLE resultado select eventos.* from eventos where estado_evento = 'abierto';
	else
		CREATE TEMPORARY TABLE resultado select * from Eventos where 1=0;

		IF (Jubilado) THEN
			INSERT INTO resultado SELECT eventos.* from eventos, Gradas
				WHERE eventos.id_recinto=Gradas.id_recinto and eventos.fecha=Gradas.fecha and eventos.id_espectaculo=Gradas.id_espectaculo and Gradas.maximo_jubilado != 0 and eventos.estado_evento = 'abierto'
				GROUP BY eventos.id_espectaculo, eventos.id_recinto, eventos.fecha, eventos.aforo_evento, eventos.id_espectaculo, eventos.estado_evento, eventos.max_prereservas, eventos.fecha_finalizacion, eventos.T1, eventos.T2, eventos.T3, eventos.penalizacion_anulacion;
		END IF;

		IF (Adulto) THEN
		INSERT INTO resultado SELECT eventos.* from eventos, Gradas
			WHERE eventos.id_recinto=Gradas.id_recinto and eventos.fecha=Gradas.fecha and eventos.id_espectaculo=Gradas.id_espectaculo and Gradas.maximo_adulto != 0 and eventos.estado_evento = 'abierto'
			GROUP BY eventos.id_espectaculo, eventos.id_recinto, eventos.fecha, eventos.aforo_evento, eventos.estado_evento, eventos.max_prereservas, eventos.fecha_finalizacion, eventos.T1, eventos.T2, eventos.T3, eventos.penalizacion_anulacion;
		END IF;
		
		IF (Parado) THEN
		INSERT INTO resultado SELECT eventos.* from eventos, Gradas
			WHERE eventos.id_recinto=Gradas.id_recinto and eventos.fecha=Gradas.fecha and eventos.id_espectaculo=Gradas.id_espectaculo and Gradas.maximo_parado != 0 and eventos.estado_evento = 'abierto'
			GROUP BY eventos.id_espectaculo, eventos.id_recinto, eventos.fecha, eventos.aforo_evento, eventos.estado_evento, eventos.max_prereservas, eventos.fecha_finalizacion, eventos.T1, eventos.T2, eventos.T3, eventos.penalizacion_anulacion;
		END IF;

		IF (Infantil) THEN
		INSERT INTO resultado SELECT eventos.* from eventos, Gradas
			WHERE eventos.id_recinto=Gradas.id_recinto and eventos.fecha=Gradas.fecha and eventos.id_espectaculo=Gradas.id_espectaculo and Gradas.maximo_infantil != 0 and eventos.estado_evento = 'abierto'
			GROUP BY eventos.id_espectaculo, eventos.id_recinto, eventos.fecha, eventos.aforo_evento, eventos.estado_evento, eventos.max_prereservas, eventos.fecha_finalizacion, eventos.T1, eventos.T2, eventos.T3, eventos.penalizacion_anulacion;
		END IF;

		IF (Bebe) THEN
		INSERT INTO resultado SELECT eventos.* from eventos, Gradas
			WHERE eventos.id_recinto=Gradas.id_recinto and eventos.fecha=Gradas.fecha and eventos.id_espectaculo=Gradas.id_espectaculo and Gradas.maximo_bebe != 0 and eventos.estado_evento = 'abierto'
			GROUP BY eventos.id_espectaculo, eventos.id_recinto, eventos.fecha, eventos.aforo_evento, eventos.estado_evento, eventos.max_prereservas, eventos.fecha_finalizacion, eventos.T1, eventos.T2, eventos.T3, eventos.penalizacion_anulacion;
		END IF;
	end if;
/**********************************************************************************************************************************************************/
/**********************************************************************************************************************************************************/
    
    CREATE TEMPORARY TABLE aux select * from eventos where 1=0;
    
	if filtro_espectaculo is not null then
		insert into aux select * from resultado where resultado.nombre_espectaculo = filtro_espectaculo;
        truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_recinto is not null then
		insert into aux select * from resultado where resultado.nombre_recinto = filtro_recinto;
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
		insert into aux select resultado.* from resultado, espectaculos, participantes 
			where resultado.id_espectaculo = espectaculos.id_espectaculo 
				AND espectaculos.id_espectaculo = participantes.id_espectaculo AND participantes.participante = filtro_participante;
		truncate resultado; insert into resultado select * from aux; truncate aux;
    end if;
    
	if filtro_precio_max is not null then
		insert into aux select resultado.* from resultado, gradas 
			where resultado.id_espectaculo = gradas.id_espectaculo AND resultado.id_recinto = gradas.id_recinto AND resultado.fecha = gradas.fecha 
            AND filtro_precio_max > 
						CASE
							WHEN filtro_usuario = 'jubilado'	THEN precio_jubilado
							WHEN filtro_usuario = 'infantil'	THEN precio_infantil
							WHEN filtro_usuario = 'parado' 		THEN precio_parado
							WHEN filtro_usuario = 'bebe' 		THEN precio_bebe
							ELSE precio_adulto
						END
				group by resultado.id_espectaculo, resultado.id_recinto, resultado.fecha;
		truncate resultado; insert into resultado select * from aux; DROP TABLE aux;
    end if;
    
	select resultado.id_espectaculo,  resultado.id_recinto, recintos.nombre_recinto, resultado.fecha
		from resultado, espectaculos, recintos where resultado.id_espectaculo = espectaculos.id_espectaculo and resultado.id_recinto = recintos.id_recinto;
	
    DROP TABLE resultado;

END//
delimiter ;

#call filtrarEventos(1,1,'2016-05-12 15:00:00', '2016-05-12 18:00:00', "Celta", 255);
call filtrarEventos(null, null, null, null, null, null, false, false, false, true, false);


