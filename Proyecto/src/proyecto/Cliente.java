package proyecto;

import java.sql.*;
import java.util.Scanner;

public class Cliente {

	static final String JDBC_DRIVER = "com.mysql.jdb.Driver";
	static final String DB_URL = "jdbc:mysql://localhost/TaquillaVirtual?useSSL=false";
	
	static final String USER = "cliente";
	static final String PASSWORD = "27632298";
	
	public static void main(String[] args) {

		Connection conn = null;
		Statement stmt = null;
		Scanner sc = new Scanner(System.in);
		
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection("jdbc:mysql://localhost/Proyecto?useSSL=false&autoReconnect=true",USER,PASSWORD);
			stmt = conn.createStatement();

		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/* INSERTAR INTERFAZ Y PRUEBAS A REALIZAR
		 * */
		System.out.println("BIENVENIDO AL ");
		
		
		
		
		
		
	}

}
