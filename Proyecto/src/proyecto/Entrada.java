package proyecto;

public class Entrada extends Evento {

	private int id_localidad;
	private int id_grada;
	private String tipoUsuario;
	private String nombre_grada;
	private int precio;
	private boolean preReserva; //true si si lo es

	/**
	 * @param id_espectaculo
	 * @param espectaculo
	 * @param id_recinto
	 * @param recinto
	 * @param fecha
	 * @param id_localidad
	 * @param tipoUsuario
	 * @param precio
	 */
	public Entrada(Evento evento, int id_localidad, int id_grada, String tipoUsuario, int precio, String nombre_grada) {
		super(evento.getId_espectaculo(), evento.getEspectaculo(), evento.getId_recinto(), evento.getRecinto(),
				evento.getFecha());
		this.id_localidad = id_localidad;
		this.id_grada = id_grada;
		this.tipoUsuario = tipoUsuario;
		this.precio = precio;
		this.nombre_grada = nombre_grada;
	}
	
	public Entrada(Evento evento, int id_localidad, int id_grada, String tipoUsuario, int precio, String nombre_grada, boolean preReserva) {
		super(evento.getId_espectaculo(), evento.getEspectaculo(), evento.getId_recinto(), evento.getRecinto(),
				evento.getFecha());
		this.id_localidad = id_localidad;
		this.id_grada = id_grada;
		this.tipoUsuario = tipoUsuario;
		this.precio = precio;
		this.nombre_grada = nombre_grada;
		this.preReserva = preReserva;
	}


	/**
	 * @return the preReserva
	 */
	public boolean isPreReserva() {
		return preReserva;
	}

	/**
	 * @return the nombre_grada
	 */
	public String getNombre_grada() {
		return nombre_grada;
	}

	/**
	 * @return the id_grada
	 */
	public int getId_grada() {
		return id_grada;
	}

	/**
	 * @return the id_localidad
	 */
	public int getId_localidad() {
		return id_localidad;
	}

	/**
	 * @return the tipoUsuario
	 */
	public String getTipoUsuario() {
		return tipoUsuario;
	}

	/**
	 * @return the precio
	 */
	public int getPrecio() {
		return precio;
	}

	@Override
	public String toString() {
		if(preReserva) {
			return (super.toString() + " ; " + nombre_grada + ", " + tipoUsuario + ", " + precio + "€ , Pre-Reserva");
		} else {
			return (super.toString() + " ; " + nombre_grada + ", " + tipoUsuario + ", " + precio + "€");
		}
	}

}
