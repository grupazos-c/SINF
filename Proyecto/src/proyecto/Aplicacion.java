package proyecto;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class Aplicacion {

	static final String JDBC_DRIVER = "com.mysql.jdb.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/Proyecto?useSSL=false"; //

	static final String USER = "cliente";
	static final String PASSWORD = "1234";

	private static Connection conn = null;
	private static Statement stmt = null;
	//TODO borrar plz
	public static void main(String[] args) {
		ArrayList<Integer> integer = new ArrayList<Integer>();
		integer.add(1);
		integer.add(1);
		integer.add(1);
		integer.add(1);
		integer.add(1);
		integer.add(2);
		integer.add(3);
		integer.add(4);
		integer.add(5);
		integer.add(6);
		integer.add(7);
		integer.add(25);
		System.out.println(integer.toString());
		System.out.println("Salida: " + maxConsecutivos(integer)[0] + " en: " + maxConsecutivos(integer)[1]);
	}

	/**
	 * Inicio de la conexión con la BD SQL
	 * 
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	static void init() throws SQLException {

		try {
			Class.forName(JDBC_DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.println("Error al inizializar el driver");
			e.printStackTrace();
		}

		System.out.println("Connecting to database...");
		conn = DriverManager.getConnection(DB_URL, USER, PASSWORD);

		System.out.println("Creating statement...");
		stmt = conn.createStatement();

		return;
	}

	/**
	 * Cierre de conexión con la BD SQL
	 * 
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	static void close() throws SQLException {
		stmt.close();
		conn.close();

		return;
	}

	/**
	 * Resgitro de Cliente en la BD
	 * 
	 * @return 0: Query OK -1: DNI existente -2: Usuario menor de edad -3: Formato
	 *         de DNI incorrecto -4: Formato de IBAN incorrecto -87: SQLEXception
	 */
	public static int registrarCliente(String dni, String nombre, String iban, String nacimiento) {
		if (dni.length() != 9) {
			return -3;
		} else if (iban.length() != 26) {
			return -4;
		}

		try {
			init();

			String SQLProcedure = "{call registrarCliente(?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, dni);
			cstmt.setString(2, nombre);
			cstmt.setString(3, iban);
			cstmt.setString(4, nacimiento);
			cstmt.registerOutParameter(5, Types.INTEGER);
			cstmt.executeUpdate();

			int resultado = cstmt.getInt(5);
			System.out.println("Resultado del registro: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return -87;
		}
	}
	
	/**
	 * 
	 * @param entradas
	 * @return
	 * -9: No se pueden conseguir entradas consecutivas
	 * 
	 */
	public static int reservarPreReservar(String tipoTransaccion, String dni,HashMap<Entrada, Integer> entradas) {
		
		try {
			init();
			conn.setAutoCommit(false);
			conn.commit();
			
			Set<Entrada> set = entradas.keySet();
			
			for (Entrada entrada : set) {
				int cantidad = entradas.get(entrada);
				ArrayList<Integer> localidades = localidadesLibres(entrada.getId_espectaculo(), entrada.getId_recinto(), entrada.getFecha(), entrada.getId_grada());
				int maximoSec[] = maxConsecutivos(localidades);
				if(maximoSec[0] < cantidad) {
					conn.rollback();
					close();
					return -9;
				}
				for (int i = 0; i < cantidad; i++) {
					int resultado = reservarPreReservar(tipoTransaccion, dni, entrada.getTipoUsuario(), (maximoSec[1] + i), entrada.getId_grada(), entrada.getId_recinto(), entrada.getId_espectaculo(), entrada.getFecha());
					if(resultado != 0) {
						conn.rollback();
						close();
						return resultado;
					}
				}
			}
			conn.commit();
			close();
		} catch (SQLException e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
				close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return 0;
	}

	/**
	 * Reserva-Prereserva de entradas
	 * 
	 * @return 0: Query OK -1: Localidad no libre, o está pre-reservada por otro
	 *         usuario -2: tipo_usuario desconocido -3: No se ofrecen entradas para
	 *         este tipo_usuario -4: No quedan entradas disponibles para este
	 *         tipo_usuario -5: No quedan más entradas disponibles para este evento
	 *         -6: tipoTransaccion -7: formato de dni incorrecto -8: formato de
	 *         fecha incorrecto -87: SQLEXception
	 * @throws SQLException
	 */
	public static int reservarPreReservar(String tipoTransaccion, String dni, String tipo_usuario, int id_localidad,
			int id_grada, int id_recinto, int id_espectaculo, String fecha) throws SQLException {
		if (dni.length() != 9) {
			return -7;
		} else if (fecha.length() != 26) {
			return -8;
		}
		String SQLProcedure = "{call estado_localidad(?,?,?,?,?,?,?,?,?)}";
		CallableStatement cstmt = conn.prepareCall(SQLProcedure);
		cstmt.setString(1, tipoTransaccion);
		cstmt.setString(2, dni);
		cstmt.setString(3, tipo_usuario);
		cstmt.setInt(4, id_localidad);
		cstmt.setInt(5, id_grada);
		cstmt.setInt(6, id_recinto);
		cstmt.setInt(7, id_espectaculo);
		cstmt.setString(8, fecha);
		cstmt.registerOutParameter(9, Types.INTEGER);
		cstmt.executeUpdate();

		int resultado = cstmt.getInt(9);
		System.out.println("Resultado de la reserva: " + resultado);

		return resultado;
	}

	/**
	 * Lista de id_localidad libres
	 * @param id_espectaculo
	 * @param id_recinto
	 * @param fecha
	 * @param id_grada
	 * @return
	 * @throws SQLException
	 */
	public static ArrayList<Integer> localidadesLibres(int id_espectaculo, int id_recinto, String fecha, int id_grada)
			throws SQLException {
		ArrayList<Integer> resultado = new ArrayList<>();
		String SQLProcedure = "{call info_localidades(?,?,?,?)}"; // TODO
		CallableStatement cstmt = conn.prepareCall(SQLProcedure);
		cstmt.setInt(1, id_espectaculo);
		cstmt.setInt(2, id_recinto);
		cstmt.setString(3, fecha);
		cstmt.setInt(4, id_grada);

		ResultSet rs = cstmt.executeQuery();

		while (rs.next()) {
			resultado.add(rs.getInt(1));
		}
		return resultado;
	}

	/**
	 * Devuelve el mayor numero de de numeros secuanciales del array
	 * @param numeros
	 * @return
	 */
	public static int[] maxConsecutivos(ArrayList<Integer> numeros) {
		int maximo = 1;
		int count = 1;
		int empieza = 0;
		numeros.sort(null);
		
		for (int i = 0; i < numeros.size()-1; i++) {
			if (numeros.get(i) == (numeros.get(i+1)-1)) {
				count++;
			} else {
				if(count>maximo) {
					maximo = count;
					empieza = i - (maximo - 1);
				}
				count = 1;
			}
		}
		int[] resultado = { maximo , empieza };
		return resultado;

	}

	/**
	 * Anulación de reservaResgitro de Cliente en la BD
	 * 
	 * @return 0: Query OK -1: La localidad no está reservada ni pre-reservada -2:
	 *         Este cliente no es quien ha reservado la localidad -3: Formato de DNI
	 *         incorrecto -87: SQLEXception
	 */
	public static int anularReserva(int id_localidad, int id_grada, int id_recinto, int id_espectaculo, String fecha,
			String dni) {
		if (dni.length() != 9) {
			return -3;
		}
		try {
			init();

			String SQLProcedure = "{call anularReserva(?,?,?,?,?, ?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setInt(1, id_localidad);
			cstmt.setInt(2, id_grada);
			cstmt.setInt(3, id_recinto);
			cstmt.setInt(4, id_espectaculo);
			cstmt.setString(5, fecha);
			cstmt.setString(6, dni);
			cstmt.registerOutParameter(7, Types.INTEGER);
			cstmt.executeUpdate();

			int resultado = cstmt.getInt(7);
			System.out.println("Resultado de la anulación: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return -87;
		}
	}

	/**
	 * Checkeo de dni
	 * 
	 * @return true: existe, false: no existe
	 */
	public static boolean existeDni(String dni) {
		if (dni.length() != 9) {
			return false;
		}
		try {
			init();

			String SQLProcedure = "{call existeCliente(?,?}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, dni);
			cstmt.registerOutParameter(2, Types.BOOLEAN);
			cstmt.executeUpdate();

			boolean resultado = cstmt.getBoolean(2);
			System.out.println("Existe el DNI: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
//			return false; TODO
			return true;
		}
	}

	/**
	 * Filtrado de eventos, devuelve un array con los eventos que seleciona
	 * 
	 * @param id_recinto
	 * @param fechamax
	 * @param fechamin
	 * @param participante
	 * @param precio_max
	 * @param jubilado
	 * @param adulto
	 * @param parado
	 * @param bebe
	 * @param infantil
	 */
	public static ArrayList<Evento> filtrarEventos(String espectaculo, String recinto, String fechamax, String fechamin,
			String participante, int precio_max, boolean jubilado, boolean adulto, boolean parado, boolean bebe,
			boolean infantil) {
		ArrayList<Evento> eventos = new ArrayList<Evento>();
		try {
			init();

			String SQLProcedure = "{call filtrarEventos(?,?,?,?,?,?,?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, espectaculo);
			cstmt.setString(2, recinto);
			cstmt.setString(3, fechamin);
			cstmt.setString(4, fechamax);
			cstmt.setString(5, participante);
			cstmt.setInt(6, precio_max);
			cstmt.setBoolean(7, jubilado);
			cstmt.setBoolean(8, adulto);
			cstmt.setBoolean(9, parado);
			cstmt.setBoolean(10, infantil);
			cstmt.setBoolean(11, bebe);

			ResultSet rs = cstmt.executeQuery();

			while (rs.next()) {
				Evento evento = new Evento(rs.getInt("id_espectaculo"), rs.getString("nombre_espectaculo"),
						rs.getInt("id_recinto"), rs.getString("nombre_recinto"), rs.getString("fecha"));
				eventos.add(evento);
			}

			close();
			return eventos;
		} catch (Exception e) { // TODO solo SQL exception
//			e.printStackTrace();
//			return null;
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo increible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo algo incereible", 1, "En un museo", "15-05-19 17:00:00"));
			eventos.add(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"));
			return eventos; // TODO borrar prueba
		}
	}

	public static ArrayList<Grada> buscarGradas(Evento evento) {
		ArrayList<Grada> gradas = new ArrayList<Grada>();
		ArrayList<Integer> id_gradas = new ArrayList<Integer>();
		try {
			init();

			String SQLProcedure = "{call muestraGradas(?,?,?)}"; // Primero bucamos cuantas gradas iteraremos
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setInt(1, evento.getId_espectaculo());
			cstmt.setInt(2, evento.getId_recinto());
			cstmt.setString(3, evento.getFecha());

			ResultSet rs = cstmt.executeQuery();

			while (rs.next()) {
				int id_grada = rs.getInt(1);
				id_gradas.add(id_grada);
			}

			for (Integer integer : id_gradas) {
				SQLProcedure = "{call infoGradas(?,?,?,?)}"; // Ahora llamaos al info una vez por grada GG
				CallableStatement cstmt2 = conn.prepareCall(SQLProcedure);
				cstmt.setInt(1, evento.getId_espectaculo());
				cstmt.setInt(2, evento.getId_recinto());
				cstmt.setString(3, evento.getFecha());
				cstmt.setInt(4, integer);

				ResultSet rs2 = cstmt2.executeQuery();

				while (rs2.next()) {
					Grada grada = new Grada(evento, rs2.getString("nombre_grada"), rs2.getInt("id_grada"),
							rs2.getInt("localidades_adulto"), rs2.getInt("localidades_infantil"),
							rs2.getInt("localidades_parado"), rs2.getInt("localidades_jubilado"),
							rs2.getInt("localidades_bebe"), rs2.getInt("precio_adulto"), rs2.getInt("precio_infantil"),
							rs2.getInt("precio_parado"), rs2.getInt("precio_jubilado"), rs2.getInt("precio_bebe"));
					gradas.add(grada);
				}
			}

			close();
			return gradas;
		} catch (Exception e) { // TODO solo SQL exception
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
//			gradas.add(new Grada(evento, "Grada guay", 1, 10, 10, 5, 5, 0, 20, 10, 15, 10, 0));
			return gradas;
		}
	}

	public static Cliente obtenerCliente(String dni) {
		try {
			init();

			String SQLProcedure = "{call obtenerDatosCliente(?)}"; // Primero bucamos cuantas gradas iteraremos
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, dni);

			ResultSet rs = cstmt.executeQuery();

			rs.next();

			Cliente cliente = new Cliente(dni, rs.getString("nombre"), rs.getString("nacimiento"),
					rs.getString("iban"));

			close();
			return cliente;
		} catch (Exception e) { // TODO solo SQL exception
			e.printStackTrace();
//				return null; TODO
			return new Cliente(dni, "joaquin", "1998-03-15", "12345678901234567890123456");
		}

	}

	/**
	 * Resgitro de Cliente en la BD
	 *
	 * @return 0: Query OK -1: DNI inexistente -2: Formato de DNI incorrecto -3:
	 *         Formato de IBAN incorrecto -87: SQLEXception
	 */
	public static int modificarCliente(String dni, String nombre, String iban, String nacimiento) {
		if (dni.length() != 9) {
			return -2;
		} else if (iban.length() != 26) {
			return -3;
		}

		try {
			init();

			String SQLProcedure = "{call modificarDatosCliente(?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, dni);
			cstmt.setString(2, nombre);
			cstmt.setString(3, iban);
			cstmt.setString(4, nacimiento);
			cstmt.registerOutParameter(5, Types.INTEGER);
			cstmt.executeUpdate();

			int resultado = cstmt.getInt(5);
			System.out.println("Resultado de la modificación: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return -87;
		}
	}

	public static ArrayList<Entrada> obtenerEntradasCliente(String dni) {
		ArrayList<Entrada> entradas = new ArrayList<Entrada>();
		try {
			init();

			String SQLProcedure = "{call obtenerEntradasCompradasCliente(?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setString(1, dni);

			ResultSet rs = cstmt.executeQuery();

			while (rs.next()) {
				Evento evento = new Evento(rs.getInt("id_espectaculo"), rs.getString("nombre_espectaculo"),
						rs.getInt("id_recinto"), rs.getString("nombre_recinto"), rs.getString("fecha"));
				Entrada entrada = new Entrada(evento, rs.getInt("id_localidad"), rs.getInt("id_grada"),
						rs.getString("tipo_usuario"), rs.getInt("precio"), rs.getString("nombre_grada"));
				entradas.add(entrada);
			}
			close();
			return entradas;
		} catch (SQLException e) {
			e.printStackTrace();
//				TODO
			entradas.add(new Entrada(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"), 12,
					1, "Adulto", 7, "Tribuna pobre"));
			entradas.add(new Entrada(new Evento(1, "Espectaculo bueno", 1, "En un museo", "15-05-19 17:00:00"), 12, 1,
					"Adulto", 100, "Tribuna"));
			entradas.add(new Entrada(new Evento(1, "Espectaculo normalillo", 1, "En un museo", "15-05-19 17:00:00"), 12,
					1, "Adulto", 25, "Tribuna normalilla"));
			entradas.add(new Entrada(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"), 12,
					1, "Adulto", 25, "Tribuna pobre"));
			entradas.add(new Entrada(new Evento(1, "Espectaculo malisimo", 1, "En un museo", "15-05-19 17:00:00"), 12,
					1, "Adulto", 25, "Tribuna pobre"));
			return entradas;
		}
	}

	public static int obtenerMaximoPreReservas(Evento evento) {
		try {
            init();
            String SQLProcedure = "{call modificarDatosCliente(?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setInt(1, evento.getId_espectaculo());
			cstmt.setInt(2, evento.getId_recinto());
			cstmt.setString(3, evento.getFecha());
			cstmt.registerOutParameter(5, Types.INTEGER);
			cstmt.executeUpdate();

			int resultado = cstmt.getInt(5);
			return resultado;
			
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
	}
	
	public static ArrayList<String> obtenerParticipantes() {
        ArrayList<String> participantes = new ArrayList<String>();
        try {
            init();
            String SQLProcedure = "{call mostrarParticipantes()}";
            CallableStatement cstmt = conn.prepareCall(SQLProcedure);
            ResultSet rs = cstmt.executeQuery();
            while (rs.next())
                participantes.add(rs.getString("participante"));
            return participantes;
        } catch (SQLException e) {
            e.printStackTrace();
            return participantes;
        }
    }

    public static ArrayList<String> obtenerRecintos() {
        ArrayList<String> participantes = new ArrayList<String>();
        try {
            init();
            String SQLProcedure = "{call mostrarRecintos()}";
            CallableStatement cstmt = conn.prepareCall(SQLProcedure);
            ResultSet rs = cstmt.executeQuery();
            while (rs.next())
                participantes.add(rs.getString("nombre_recinto"));
            return participantes;
        } catch (SQLException e) {
            e.printStackTrace();
            return participantes;
        }
    }

    public static ArrayList<String> obtenerEspectaculos() {
        ArrayList<String> participantes = new ArrayList<String>();
        try {
            init();
            String SQLProcedure = "{call mostrarEspectaculos()}";
            CallableStatement cstmt = conn.prepareCall(SQLProcedure);
            ResultSet rs = cstmt.executeQuery();
            while (rs.next())
                participantes.add(rs.getString("nombre_espectaculo"));
            return participantes;
        } catch (SQLException e) {
            e.printStackTrace();
            return participantes;
        }
    }

}
