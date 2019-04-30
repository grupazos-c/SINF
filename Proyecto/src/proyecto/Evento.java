package proyecto;

public class Evento {

	private int id_espectaculo;
	private String espectaculo;
	private int id_recinto;
	private String recinto;
	private String fecha;
	
	/**
	 * @param id_espectaculo
	 * @param espectaculo
	 * @param id_recinto
	 * @param recinto
	 * @param fecha
	 */
	public Evento(int id_espectaculo, String espectaculo, int id_recinto, String recinto, String fecha) {
		this.id_espectaculo = id_espectaculo;
		this.espectaculo = espectaculo;
		this.id_recinto = id_recinto;
		this.recinto = recinto;
		this.fecha = fecha.substring(0, 19);
	}
	
	public Evento getEvento() {
		return this;
	}

	/**
	 * @return the id_espectaculo
	 */
	public int getId_espectaculo() {
		return id_espectaculo;
	}

	/**
	 * @return the espectaculo
	 */
	public String getEspectaculo() {
		return espectaculo;
	}

	/**
	 * @return the id_recinto
	 */
	public int getId_recinto() {
		return id_recinto;
	}

	/**
	 * @return the recinto
	 */
	public String getRecinto() {
		return recinto;
	}

	/**
	 * @return the fecha
	 */
	public String getFecha() {
		return fecha;
	}
	
	@Override
	public String toString() {
		return (espectaculo + ", en: " + recinto + ", el: " + fecha);
	}
	
}
