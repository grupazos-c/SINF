package proyecto;

import java.sql.*;

public class Cliente {

	static final String JDBC_DRIVER = "com.mysql.jdb.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/Proyecto?useSSL=false"; // TODO como huevá se llame la BD

	static final String USER = "cliente";
	static final String PASSWORD = "1234";

	private static Connection conn = null;
	private static Statement stmt = null;

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
	 * @return 	 0: 	Query OK
	 * 			-1:	DNI existente
	 * 			-2: Formato de DNI incorrecto
	 * 			-3: Formato de IBAN incorrecto
	 * 			-87: SQLEXception //TODO, y si capturásemos esta excepción en la ventana?
	 */
	public static int registrarCliente(String dni, String nombre, String iban, String nacimiento) {
		if (dni.length() != 9) {
			return -2;
		} else if (iban.length() != 26) {
			return -3;
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
	 * Reserva-Prereserva de entradas
	 * 
	 * @return 	 0: 	Query OK
	 * 			-1:	Localidad no libre, o está pre-reservada por otro usuario
	 * 			-2: tipo_usuario desconocido
	 * 			-3: No se ofrecen entradas para este tipo_usuario
	 * 			-4: No quedan entradas disponibles para este tipo_usuario
	 * 			-5: No quedan más entradas disponibles para este evento
	 * 			-6: tipoTransaccion 
	 * 			-7: formato de dni incorrecto
	 * 			-8: formato de fecha incorrecto
	 * 			-87: SQLEXception //TODO, y si capturásemos esta excepción en la ventana?
	 */
	public static int reservarPreReservar(String tipoTransaccion, String dni, String tipo_usuario, int id_localidad, int id_grada,
			int id_recinto, int id_espectaculo, String fecha) {
		if (dni.length() != 9) {
			return -7;
		} else if (fecha.length() != 26) {
			return -8;
		} 

		try {
			init();

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
			System.out.println("Resultado del registro: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return -87;
		}
	}


	/**
	 * Anulación de reservaResgitro de Cliente en la BD
	 * 
	 * @return 	 0: 	Query OK
	 * 			-1:	La localidad no está reservada ni pre-reservada
	 * 			-2: Este cliente no es quien ha reservado la localidad
	 * 			-3: Formato de DNI incorrecto
	 * 			-4: Formato de fecha incorrecto
	 * 			-87: SQLEXception //TODO, y si capturásemos esta excepción en la ventana?
	 */
	public static int anularReserva(int id_localidad, int id_grada, int id_recinto, int id_espectaculo, String fecha, String dni) {
		if (dni.length() != 9) {
			return -3;
		} else if (fecha.length() != 26) {
			return -4;
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
			System.out.println("Resultado del registro: " + resultado);

			close();
			return resultado;
		} catch (SQLException e) {
			e.printStackTrace();
			return -87;
		}
	}

	public static boolean existeDni() {
		// TODO Auto-generated method stub
		return true;
	}
	
}
