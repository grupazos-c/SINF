package proyecto;

public class Cliente {
	// Atributos de la clase cliente
	private String dni;
	private String nombre;
	private String fecha_nacimiento;
	private String iban;

	// Constructor de la clase Cliente
	public Cliente(String dni, String nombre, String fecha_nacimiento, String iban) {
		this.dni = dni;
		this.nombre = nombre;
		this.iban = iban;
		this.fecha_nacimiento = fecha_nacimiento;
	}

	public Cliente() {
		this.dni = "";
		this.nombre = "";
		this.iban = "";
		this.fecha_nacimiento = "";
	}

	// Métodos getters y setters para establecer y modificar las variables
	public void setDni(String dni) {
		this.dni = dni;
	}

	public String getDni() {
		return dni;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getNombre() {
		return nombre;
	}

	public void setIban(String iban) {
		this.iban = iban;
	}

	public String getIban() {
		return iban;
	}

	public void setFecha_nacimiento(String fecha_nacimiento) {
		this.fecha_nacimiento = fecha_nacimiento;
	}

	public String getFecha_nacimiento() {
		return fecha_nacimiento;
	}

}