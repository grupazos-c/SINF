package proyecto;

public class Grada extends Evento{
	
	private String nombre;
	private int id_grada;
	private int maxAdulto;
	private int maxInfantil;
	private int maxParado;
	private int maxJubilado;
	private int maxBebe;
	private int precioAdulto;
	private int precioInfantil;
	private int precioParado;
	private int precioJubilado;
	private int precioBebe;
	
	/**
	 * @param id_espectaculo
	 * @param espectaculo
	 * @param id_recinto
	 * @param recinto
	 * @param fecha
	 * @param nombre
	 * @param id_grada
	 * @param maxAdulto
	 * @param maxInfantil
	 * @param maxParado
	 * @param maxJubilado
	 * @param maxBebe
	 * @param precioAdulto
	 * @param precioInfantil
	 * @param precioParado
	 * @param precioJubilado
	 * @param precioBebe
	 */	
	public Grada(Evento evento, String nombre, int id_grada, int maxAdulto, int maxInfantil, int maxParado,
			int maxJubilado, int maxBebe, int precioAdulto, int precioInfantil, int precioParado, int precioJubilado,
			int precioBebe) {
		super(evento.getId_espectaculo(),evento.getEspectaculo(),evento.getId_recinto(), evento.getRecinto(), evento.getFecha());
		this.nombre = nombre;
		this.id_grada = id_grada;
		this.maxAdulto = maxAdulto;
		this.maxInfantil = maxInfantil;
		this.maxParado = maxParado;
		this.maxJubilado = maxJubilado;
		this.maxBebe = maxBebe;
		this.precioAdulto = precioAdulto;
		this.precioInfantil = precioInfantil;
		this.precioParado = precioParado;
		this.precioJubilado = precioJubilado;
		this.precioBebe = precioBebe;
	}
	/**
	 * @return the nombre
	 */
	public String getNombre() {
		return nombre;
	}
	/**
	 * @return the id_grada
	 */
	public int getId_grada() {
		return id_grada;
	}
	/**
	 * @return the maxAdulto
	 */
	public int getMaxAdulto() {
		return maxAdulto;
	}
	/**
	 * @return the maxInfantil
	 */
	public int getMaxInfantil() {
		return maxInfantil;
	}
	/**
	 * @return the maxParado
	 */
	public int getMaxParado() {
		return maxParado;
	}
	/**
	 * @return the maxJubilado
	 */
	public int getMaxJubilado() {
		return maxJubilado;
	}
	/**
	 * @return the maxBebe
	 */
	public int getMaxBebe() {
		return maxBebe;
	}
	/**
	 * @return the precioAdulto
	 */
	public int getPrecioAdulto() {
		return precioAdulto;
	}
	/**
	 * @return the precioInfantil
	 */
	public int getPrecioInfantil() {
		return precioInfantil;
	}
	/**
	 * @return the precioParado
	 */
	public int getPrecioParado() {
		return precioParado;
	}
	/**
	 * @return the precioJubilado
	 */
	public int getPrecioJubilado() {
		return precioJubilado;
	}
	/**
	 * @return the precioBebe
	 */
	public int getPrecioBebe() {
		return precioBebe;
	}
	
	
	
	
}
