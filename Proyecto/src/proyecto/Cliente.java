package proyecto;

import java.sql.*;
import java.util.Scanner;

public class Cliente {

	static final String JDBC_DRIVER = "com.mysql.jdb.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/Proyecto?useSSL=false"; //TODO como huevá se llame la BD

	static final String USER = "cliente";
	static final String PASSWORD = "27632298";

	private static Connection conn = null;
	private static Statement stmt = null;

	/**
	 * Inicio de la conexión con la BD SQL
	 * 
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	void init() throws SQLException, ClassNotFoundException {
		Class.forName(JDBC_DRIVER);

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
	void close() throws SQLException {
		stmt.close();
		conn.close();

		return;
	}

}
