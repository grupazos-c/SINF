#funcion:


SELECT Eventos.* from Eventos, Gradas WHERE Gradas.maximo_jubilado != 0 GROUP BY Eventos.id_espectaculo, Eventos.id_recinto, Eventos.fecha;


drop PROCEDURE if exists filtrarTipoUsuario;
delimiter //
CREATE PROCEDURE filtrarTipoUsuario(IN Jubilado BOOLEAN,IN Adulto BOOLEAN, IN Parado BOOLEAN, IN Infantil BOOLEAN,IN Bebe BOOLEAN)
  BEGIN
    DROP TABLE if EXISTS filtroUsuario;
    DROP TABLE if EXISTS aux;

    CREATE TEMPORARY TABLE filtroUsuario select * from Eventos;
    CREATE TEMPORARY TABLE aux select * from Eventos where 1=0;

    IF (Jubilado) THEN
    INSERT INTO aux SELECT filtroUsuario.* from filtroUsuario, Gradas

     WHERE filtroUsuario.id_recinto=Gradas.id_recinto
        and filtroUsuario.fecha=Gradas.fecha
        and filtroUsuario.id_espectaculo=Gradas.id_espectaculo
        and Gradas.maximo_jubilado != 0

        GROUP BY filtroUsuario.id_espectaculo, filtroUsuario.id_recinto, filtroUsuario.fecha, filtroUsuario.aforo_evento, filtroUsuario.estado_evento, filtroUsuario.max_prereservas, filtroUsuario.fecha_finalizacion, filtroUsuario.T1, filtroUsuario.T2, filtroUsuario.T3, filtroUsuario.penalizacion_anulacion;

    truncate filtroUsuario; insert into filtroUsuario select * from aux; truncate aux;
    END IF;

    IF (Adulto) THEN
    INSERT INTO aux SELECT filtroUsuario.* from filtroUsuario, Gradas

     WHERE filtroUsuario.id_recinto=Gradas.id_recinto
        and filtroUsuario.fecha=Gradas.fecha
        and filtroUsuario.id_espectaculo=Gradas.id_espectaculo
        and Gradas.maximo_adulto != 0

        GROUP BY filtroUsuario.id_espectaculo, filtroUsuario.id_recinto, filtroUsuario.fecha, filtroUsuario.aforo_evento, filtroUsuario.estado_evento, filtroUsuario.max_prereservas, filtroUsuario.fecha_finalizacion, filtroUsuario.T1, filtroUsuario.T2, filtroUsuario.T3, filtroUsuario.penalizacion_anulacion;

    truncate filtroUsuario; insert into filtroUsuario select * from aux; truncate aux;
    END IF;
    IF (Parado) THEN
    INSERT INTO aux SELECT filtroUsuario.* from filtroUsuario, Gradas

     WHERE filtroUsuario.id_recinto=Gradas.id_recinto
        and filtroUsuario.fecha=Gradas.fecha
        and filtroUsuario.id_espectaculo=Gradas.id_espectaculo
        and Gradas.maximo_parado != 0

        GROUP BY filtroUsuario.id_espectaculo, filtroUsuario.id_recinto, filtroUsuario.fecha, filtroUsuario.aforo_evento, filtroUsuario.estado_evento, filtroUsuario.max_prereservas, filtroUsuario.fecha_finalizacion, filtroUsuario.T1, filtroUsuario.T2, filtroUsuario.T3, filtroUsuario.penalizacion_anulacion;

    truncate filtroUsuario; insert into filtroUsuario select * from aux; truncate aux;
    END IF;
    IF (Infantil) THEN
    INSERT INTO aux SELECT filtroUsuario.* from filtroUsuario, Gradas

     WHERE filtroUsuario.id_recinto=Gradas.id_recinto
        and filtroUsuario.fecha=Gradas.fecha
        and filtroUsuario.id_espectaculo=Gradas.id_espectaculo
        and Gradas.maximo_infantil != 0

        GROUP BY filtroUsuario.id_espectaculo, filtroUsuario.id_recinto, filtroUsuario.fecha, filtroUsuario.aforo_evento, filtroUsuario.estado_evento, filtroUsuario.max_prereservas, filtroUsuario.fecha_finalizacion, filtroUsuario.T1, filtroUsuario.T2, filtroUsuario.T3, filtroUsuario.penalizacion_anulacion;

    truncate filtroUsuario; insert into filtroUsuario select * from aux; truncate aux;
    END IF;
    IF (Bebe) THEN
    INSERT INTO aux SELECT filtroUsuario.* from filtroUsuario, Gradas

     WHERE filtroUsuario.id_recinto=Gradas.id_recinto
        and filtroUsuario.fecha=Gradas.fecha
        and filtroUsuario.id_espectaculo=Gradas.id_espectaculo
        and Gradas.maximo_bebe != 0

        GROUP BY filtroUsuario.id_espectaculo, filtroUsuario.id_recinto, filtroUsuario.fecha, filtroUsuario.aforo_evento, filtroUsuario.estado_evento, filtroUsuario.max_prereservas, filtroUsuario.fecha_finalizacion, filtroUsuario.T1, filtroUsuario.T2, filtroUsuario.T3, filtroUsuario.penalizacion_anulacion;

    truncate filtroUsuario; insert into filtroUsuario select * from aux; truncate aux;
    END IF;

    END//
delimiter ;


#CALL registrarCliente ('39468547U', 'Marcos Cordeiro Sobrino','ES407050654851239650402325', '1998-05-12', @error);
