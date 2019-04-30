package proyecto;

import java.io.ObjectInputStream.GetField;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

public class Aplicacion {

	static final String JDBC_DRIVER = "com.mysql.jdb.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/VigoCoffeeLoversDB?useSSL=false&noAccessToProcedureBodies=true"; //

	static final String USER = "cliente";
	static final String PASSWORD = "1234";

	private static Connection conn = null;
	private static Statement stmt = null;

	public static void main(String[] args) {
		Integer[] a = { 1, 2, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20 };
		List<Integer> aa = Arrays.asList(a);
		ArrayList<Integer> aaa = new ArrayList<Integer>(aa);
		maxConsecutivos(aaa);
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
			System.err.println("El driver se queja");
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
	 * @return -9: No se pueden conseguir entradas consecutivas
	 * 
	 */
	public static int reservarPreReservar(String tipoTransaccion, String dni, HashMap<Entrada, Integer> entradas) {
		System.out.println(entradas.toString());
		try {
			init();
			conn.setAutoCommit(false);
			conn.commit();

			Set<Entrada> set = entradas.keySet();
			int siguientelocalidad = 0;

			for (Entrada entrada : set) {
				int cantidad = entradas.get(entrada);
				if (cantidad == 0) {
					continue;
				}
				ArrayList<Integer> localidades = localidadesLibres(entrada.getId_espectaculo(), entrada.getId_recinto(),
						entrada.getFecha(), entrada.getId_grada());
				int maximoSec[] = maxConsecutivos(localidades);
				System.out.println("Cantidad de entradas deseada: " + cantidad + "\n Localidades disponibles: "
						+ localidades + "\n maximos consecutivos" + maximoSec[0] + ", " + maximoSec[1]);
				if (maximoSec[0] < cantidad) {
					conn.rollback();
					close();
					return -9;
				}
				for (int i = 0; i < cantidad; i++) {
					if(siguientelocalidad == 0) {
						siguientelocalidad = localidades.get(maximoSec[1] + i);
					}else {
						siguientelocalidad++;
					}
					System.out.println("reservando: (" + tipoTransaccion + "," + dni + "," + entrada.getTipoUsuario()
							+ "," + siguientelocalidad + "," + entrada.getId_grada() + ","
							+ entrada.getId_recinto() + "," + entrada.getId_espectaculo() + "," + entrada.getFecha()
							+ ")");
					int resultado = reservarPreReservar(tipoTransaccion, dni, entrada.getTipoUsuario(),
							siguientelocalidad, entrada.getId_grada(), entrada.getId_recinto(),
							entrada.getId_espectaculo(), entrada.getFecha());
					if (resultado != 1) {
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
				e.printStackTrace();
				conn.rollback();
				conn.setAutoCommit(true);
				close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return 0;
	}

	public static int reservarPreReservar(String tipoTransaccion, String dni, Entrada entrada) {
		System.out.println(entrada.toString());
		try {
			init();
			conn.setAutoCommit(false);
			conn.commit();

			System.out.println("reservando: (" + tipoTransaccion + "," + dni + "," + entrada.getTipoUsuario() + ","
					+ entrada.getId_localidad() + "," + entrada.getId_grada() + "," + entrada.getId_recinto()
					+ "," + entrada.getId_espectaculo() + "," + entrada.getFecha() + ")");
			int resultado = reservarPreReservar(tipoTransaccion, dni, entrada.getTipoUsuario(), entrada.getId_localidad(),
					entrada.getId_grada(), entrada.getId_recinto(), entrada.getId_espectaculo(), entrada.getFecha());
			if (resultado != 1) {
				conn.rollback();
				close();
				return resultado;
			}

			conn.commit();
			close();
		} catch (SQLException e) {
			try {
				e.printStackTrace();
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
		}
		String SQLProcedure = "{call reservar_pre_reservar(?,?,?,?,?,?,?,?,?)}";
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
	 * 
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
		String SQLProcedure = "{call infoLocalidades(?,?,?,?)}";
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
	 * 
	 * @param numeros
	 * @return
	 */
	public static int[] maxConsecutivos(ArrayList<Integer> numeros) {
		int maximo = 1;
		int count = 1;
		int empieza = 0;
		numeros.sort(null);
//		numeros.add(0);
		System.out.println("Foc" + numeros + "fococo" + numeros.size());

		for (int i = 0; i < numeros.size() - 1; i++) {
			if (numeros.get(i) == (numeros.get(i + 1) - 1)) {
				count++;
			} else {
				if (count > maximo) {
					maximo = count;
					empieza = i - (maximo - 1);
				}
				count = 1;
			}
		}
		if (count > maximo) {
			maximo = count;
			empieza = (numeros.size() - 1) - (maximo - 1);
		}
		int[] resultado = { maximo, empieza };
		System.out.println("Maximo: " + maximo + " en: " + empieza);
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

			String SQLProcedure = "{call existeCliente(?,?)}";
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
			return false;
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

			System.out.println("Linea: (" + espectaculo + "," + recinto + "," + fechamin + "," + fechamax + ","
					+ participante + "," + precio_max + "," + jubilado + "," + adulto + "," + parado + "," + infantil
					+ "," + bebe + ")");

			String SQLProcedure = "{call filtrarEventos(?,?,?,?,?,?,?,?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			if (espectaculo.equals(" - Espectáculos - ")) {
				cstmt.setString(1, null);
				System.out.println("Espect a null");
			} else {
				cstmt.setString(1, espectaculo);
			}

			if (recinto.equals(" - Recintos - ")) {
				cstmt.setString(2, null);
				System.out.println("recintos a null");
			} else {
				cstmt.setString(2, recinto);
			}

			if (participante.equals(" - Participantes - ")) {
				cstmt.setString(5, null);
				System.out.println("part a null");
			} else {
				cstmt.setString(5, participante);
			}
			cstmt.setString(3, fechamin);
			cstmt.setString(4, fechamax);
			cstmt.setInt(6, 0);
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
		} catch (Exception e) {
			e.printStackTrace();
			return eventos;
		}
	}

	public static ArrayList<Grada> buscarGradas(Evento evento) {
		ArrayList<Grada> gradas = new ArrayList<Grada>();
		ArrayList<Integer> id_gradas = new ArrayList<Integer>();
		try {
			init();

			System.out.println("Llamada (" + evento.getId_espectaculo() + "," + evento.getId_recinto() + ","
					+ evento.getFecha() + ")");
			String SQLProcedure = "{call mostrarGradas(?,?,?)}"; // Primero bucamos cuantas gradas iteraremos
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
				System.out.println("Llamada: (" + evento.getId_espectaculo() + "," + evento.getId_recinto() + ","
						+ evento.getFecha() + "," + integer + ")");
				SQLProcedure = "{call infoGrada(?,?,?,?)}"; // Ahora llamaos al info una vez por grada GG
				CallableStatement cstmt2 = conn.prepareCall(SQLProcedure);
				cstmt2.setInt(1, evento.getId_espectaculo());
				cstmt2.setInt(2, evento.getId_recinto());
				cstmt2.setString(3, evento.getFecha());
				cstmt2.setInt(4, integer);

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
			System.out.println(gradas);
			return gradas;
		} catch (Exception e) {
			e.printStackTrace();
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

			Cliente cliente = new Cliente(dni, rs.getString("nombre_cliente"), rs.getString("nacimiento"),
					rs.getString("iban"));

			close();
			return cliente;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
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

			String SQLProcedure = "{call cambiarDatosCliente(?,?,?,?,?)}";
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
						rs.getString("tipo_usuario"), rs.getInt("precio"), rs.getString("nombre_grada"),
						rs.getString("estado_localidad").equals("pre-reservado"));
				entradas.add(entrada);
			}
			close();
			return entradas;
		} catch (SQLException e) {
			e.printStackTrace();
			return entradas;
		}
	}

	public static int obtenerMaximoPreReservas(Evento evento) {
		try {
			init();
			String SQLProcedure = "{call obtenerMaximoPrereservas(?,?,?,?)}";
			CallableStatement cstmt = conn.prepareCall(SQLProcedure);
			cstmt.setInt(1, evento.getId_espectaculo());
			cstmt.setInt(2, evento.getId_recinto());
			cstmt.setString(3, evento.getFecha());
			cstmt.registerOutParameter(4, Types.INTEGER);
			cstmt.executeUpdate();

			int resultado = cstmt.getInt(4);
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
