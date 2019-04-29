package proyecto;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;
import java.util.Set;
import java.util.Stack;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.border.EmptyBorder;

public class VentanaSINF extends JFrame {

	public static void main(String[] args) {
		VentanaSINF ventana = new VentanaSINF();
		ventana.setVisible(true);
	}

	/**
	 * Auto-generated
	 */
	private static final long serialVersionUID = 1L;

	Color colorFondo = new Color(209, 125, 146);
	Color colorprincipal = Color.WHITE;
	Color colorDetalles = new Color(207, 60, 95);

	MouseListener ml;

	private String DNI = "0";
	/**
	 * Paneles del frame: - panelLogo: aquí solo sale el logo - panelLogin: en este
	 * panel habrá dos botones para logearse, una vez dentro podremos ver nuestras
	 * entradas y nuestros datos - panelBusqueda: todas las opciones de busqueda -
	 * panelPrincipal: aquí se mostrarán los eventos, nuestras entradas, o lo que
	 * toque
	 */
	JPanel panelLogo, panelLogin, panelBusqueda, panelPrincipal, panelEventos, panelGradas, panelEntradas;
	private JPanel contentPane;

	JComboBox<String> participantes;
	JComboBox<String> espectaculos;
	JComboBox<String> recintos;

	/**
	 * consturctor que inicializa nuestra ventana
	 */
	public VentanaSINF() {
		super();
		setTitle("Servicio de Taquilla Virtual");
		setBounds(250, 150, 1200, 800);
		setMinimumSize(new Dimension(650, 750));
		setDefaultCloseOperation(WindowConstants.EXIT_ON_CLOSE);

		/** Content Pane */
		contentPane = new JPanel();
		contentPane.setBackground(colorFondo);
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new GridBagLayout());
		setContentPane(contentPane);

		/**
		 * Panel del Logo
		 */
		panelLogo = new JPanel();
		panelLogo.setBackground(colorprincipal);

		BufferedImage logo = null;
		try {
			logo = ImageIO.read(new File("resources/VigoCoffeeLoversLogo.png"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		JLabel picLabel = new JLabel(new ImageIcon(logo));
		picLabel.setBackground(colorprincipal);
		panelLogo.add(picLabel);

		/**
		 * Panel de login
		 */
		panelLogin = new JPanel(new CardLayout());
		panelLogin.setBorder(new EmptyBorder(10, 10, 10, 10));
		panelLogin.setBackground(colorprincipal);

		/* Carta de Log in */
		JPanel LoginCard = new JPanel();
		LoginCard.setBorder(new EmptyBorder(25, 10, 0, 0));
		LoginCard.setBackground(colorprincipal);
		LoginCard.setLayout(new BoxLayout(LoginCard, BoxLayout.Y_AXIS));

		JButton LoginJB = new JButton("Iniciar Sesión");
		JButton RegistrarJB = new JButton("Nuevo Usuario");
		LoginJB.setAlignmentX(Component.CENTER_ALIGNMENT);
		RegistrarJB.setAlignmentX(Component.CENTER_ALIGNMENT);

		LoginCard.add(LoginJB);
		LoginCard.add(Box.createRigidArea(new Dimension(15, 25)));
		LoginCard.add(RegistrarJB);

		/* Carta de Sesion iniciada */
		JPanel LogedCard = new JPanel();
		LogedCard.setBorder(new EmptyBorder(10, 0, 0, 0));
		LogedCard.setBackground(colorprincipal);
		LogedCard.setLayout(new BoxLayout(LogedCard, BoxLayout.Y_AXIS));

		JLabel UsuarioJL = new JLabel("Usuario: " + DNI);
		JButton MisEntradasJB = new JButton("Mis Entradas");
		JButton MisDatosJB = new JButton("Mis Datos");
		JButton LogedJB = new JButton("Cerrar Sesión");

		UsuarioJL.setAlignmentX(Component.CENTER_ALIGNMENT);
		LogedJB.setAlignmentX(Component.CENTER_ALIGNMENT);
		MisEntradasJB.setAlignmentX(Component.CENTER_ALIGNMENT);
		MisDatosJB.setAlignmentX(Component.CENTER_ALIGNMENT);

		LogedCard.add(UsuarioJL);
		LogedCard.add(Box.createRigidArea(new Dimension(1, 10)));
		LogedCard.add(MisEntradasJB);
		LogedCard.add(Box.createRigidArea(new Dimension(1, 10)));
		LogedCard.add(MisDatosJB);
		LogedCard.add(Box.createRigidArea(new Dimension(1, 10)));
		LogedCard.add(LogedJB);

		panelLogin.add(LoginCard, "Login");
		panelLogin.add(LogedCard, "Loged");

		/**
		 * Panel de Busqueda
		 */
		panelBusqueda = new JPanel();
		panelBusqueda.setBorder(new EmptyBorder(10, 10, 5, 10));
		panelBusqueda.setBackground(colorprincipal);
		panelBusqueda.setLayout(new BoxLayout(panelBusqueda, BoxLayout.Y_AXIS));

		JButton BuscarJB = new JButton("Buscar");
		JLabel TipoUsuarioJL = new JLabel("Tipo de entrada:");
		JCheckBox AdultoJCB = new JCheckBox("Adulto", true);
		JCheckBox InfantilJCB = new JCheckBox("Infantil", true);
		JCheckBox ParadoJCB = new JCheckBox("Parado", true);
		JCheckBox JubiladoJCB = new JCheckBox("Jubilado", true);
		JCheckBox BebeJCB = new JCheckBox("Bebé", true);
		participantes = new JComboBox<String>();
		espectaculos = new JComboBox<String>();
		recintos = new JComboBox<String>();
		JLabel PrecioJL = new JLabel("Precio máximo:");
		JSlider PrecioJS = new JSlider(0, 50, 50);
		JLabel FminJL = new JLabel("Desde:");
		JLabel FmaxJL = new JLabel("Hasta:");
		Box fechamin = seleccionarFecha();
		Box horamin = seleccionarHora();
		Box fechamax = seleccionarFecha();
		Box horamax = seleccionarHora();

		BuscarJB.setAlignmentX(Component.LEFT_ALIGNMENT);
		TipoUsuarioJL.setAlignmentX(Component.LEFT_ALIGNMENT);
		participantes.setAlignmentX(Component.LEFT_ALIGNMENT);
		espectaculos.setAlignmentX(Component.LEFT_ALIGNMENT);
		recintos.setAlignmentX(Component.LEFT_ALIGNMENT);
		PrecioJL.setAlignmentX(Component.LEFT_ALIGNMENT);
		PrecioJS.setAlignmentX(Component.LEFT_ALIGNMENT);
		participantes.setMaximumSize(new Dimension(250, 25));
		espectaculos.setMaximumSize(new Dimension(250, 25));
		recintos.setMaximumSize(new Dimension(250, 25));
		AdultoJCB.setBackground(colorprincipal);
		InfantilJCB.setBackground(colorprincipal);
		ParadoJCB.setBackground(colorprincipal);
		JubiladoJCB.setBackground(colorprincipal);
		BebeJCB.setBackground(colorprincipal);
		PrecioJS.setBackground(colorprincipal);
		PrecioJS.setMajorTickSpacing(10);
		PrecioJS.setMinorTickSpacing(1);
		PrecioJS.setPaintTicks(true);
		PrecioJS.setPaintLabels(true);
		fechamin.setAlignmentX(Component.LEFT_ALIGNMENT);
		fechamin.setMaximumSize(new Dimension(250, 25));
		fechamax.setAlignmentX(Component.LEFT_ALIGNMENT);
		fechamax.setMaximumSize(new Dimension(250, 25));
		horamin.setAlignmentX(Component.LEFT_ALIGNMENT);
		horamin.setMaximumSize(new Dimension(250, 25));
		horamax.setAlignmentX(Component.LEFT_ALIGNMENT);
		horamax.setMaximumSize(new Dimension(250, 25));

		// TODO de prueba
		refresh();		

		panelBusqueda.add(BuscarJB);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(TipoUsuarioJL);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(AdultoJCB);
		panelBusqueda.add(InfantilJCB);
		panelBusqueda.add(ParadoJCB);
		panelBusqueda.add(JubiladoJCB);
		panelBusqueda.add(BebeJCB);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(participantes);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(espectaculos);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(recintos);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(PrecioJL);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(PrecioJS);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(FminJL);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(fechamin);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(horamin);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 10)));
		panelBusqueda.add(FmaxJL);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(fechamax);
		panelBusqueda.add(Box.createRigidArea(new Dimension(1, 5)));
		panelBusqueda.add(horamax);

		/**
		 * Panel Principal
		 */
		panelPrincipal = new JPanel();
		panelEventos = new JPanel();
		panelGradas = new JPanel();
		panelEntradas = new JPanel();

		panelPrincipal.setBorder(new EmptyBorder(2, 2, 2, 2));
		panelPrincipal.setBackground(colorprincipal);
		panelPrincipal.setLayout(new CardLayout());

		JScrollPane scrollEventos = new JScrollPane(panelEventos);
		scrollEventos.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scrollEventos.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);

		JScrollPane scrollEntradas = new JScrollPane(panelEntradas);
		scrollEntradas.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scrollEntradas.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);

		JScrollPane scrollGradas = new JScrollPane(panelGradas);
		scrollGradas.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scrollGradas.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_AS_NEEDED);

		panelEntradas.setLayout(new BoxLayout(panelEntradas, BoxLayout.Y_AXIS));
		panelEntradas.setBorder(new EmptyBorder(5, 5, 5, 5));
		panelEventos.setBorder(new EmptyBorder(5, 5, 5, 5));
		panelGradas.setBorder(new EmptyBorder(5, 5, 5, 5));
		panelEventos.setLayout(new BoxLayout(panelEventos, BoxLayout.Y_AXIS));
		panelGradas.setLayout(new GridLayout(0, 6, 10, 25));
		panelEventos.setBackground(colorprincipal);
		panelGradas.setBackground(colorprincipal);
		panelEntradas.setBackground(colorprincipal);

		panelPrincipal.add(scrollEventos, "Eventos");
		panelPrincipal.add(scrollGradas, "Gradas");
		panelPrincipal.add(scrollEntradas, "Entradas");

		/**
		 * Orden de paneles en el Pane
		 */
		GridBagConstraints gbc = new GridBagConstraints();

		// Logo
		gbc.gridx = 0;
		gbc.gridy = 0;
		gbc.gridwidth = 2;
		gbc.gridheight = 1;
		gbc.weightx = 1.0;
		gbc.weighty = 0.0;
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelLogo, gbc);
		// Login
		gbc.gridx = 2;
		gbc.gridy = 0;
		gbc.gridwidth = 1;
		gbc.gridheight = 1;
		gbc.weightx = 0.0;
		gbc.weighty = 0.0;
		gbc.fill = GridBagConstraints.VERTICAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelLogin, gbc);
		// Busqueda
		gbc.gridx = 0;
		gbc.gridy = 1;
		gbc.gridwidth = 1;
		gbc.gridheight = 1;
		gbc.weightx = 0.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.VERTICAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelBusqueda, gbc);
		// Principal
		gbc.gridx = 1;
		gbc.gridy = 1;
		gbc.gridwidth = 2;
		gbc.gridheight = 1;
		gbc.weightx = 1.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelPrincipal, gbc);

		/***********************************
		 * Action Listener
		 ***********************************/ 
		ActionListener al = new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				if (e.getSource() == LoginJB) {
					login();
					UsuarioJL.setText(DNI);
				} else if (e.getSource() == LogedJB) {
					CardLayout cl = (CardLayout) (panelLogin.getLayout());
					cl.next(panelLogin);
					DNI = "0";
				} else if (e.getSource() == RegistrarJB) {
					registro();
					UsuarioJL.setText(DNI);
				} else if (e.getSource() == MisEntradasJB) {
					misEntradas(DNI);
				} else if (e.getSource() == MisDatosJB) {
					misDatos();
				} else if (e.getSource() == BuscarJB) {
					refresh();
					String fechamins = null;
					String fechamaxs = null;
					try {
						fechamins = fecha2String(obtenerFechaHora(fechamin, horamin));
						fechamaxs = fecha2String(obtenerFechaHora(fechamax, horamax));
					} catch (NullPointerException e1) {
					}
					buscar(AdultoJCB.isSelected(), InfantilJCB.isSelected(), ParadoJCB.isSelected(),
							JubiladoJCB.isSelected(), BebeJCB.isSelected(), (String) participantes.getSelectedItem(),
							(String) espectaculos.getSelectedItem(), (String) recintos.getSelectedItem(),
							PrecioJS.getValue(), fechamins, fechamaxs);
				}
			}
		};

		LoginJB.addActionListener(al);
		LogedJB.addActionListener(al);
		RegistrarJB.addActionListener(al);
		BuscarJB.addActionListener(al);
		MisDatosJB.addActionListener(al);
		MisEntradasJB.addActionListener(al);
	}

	private void refresh() {
		ArrayList<String> array = new ArrayList<>();
		array = Aplicacion.obtenerParticipantes();
		participantes.addItem(" - Participantes - ");
		for (String string : array) {
			participantes.addItem(string);			
		}
		array = Aplicacion.obtenerEspectaculos();
		espectaculos.addItem(" - Espectáculos - ");
		for (String string : array) {
			espectaculos.addItem(string);			
		}
		array = Aplicacion.obtenerRecintos();
		recintos.addItem(" - Recintos - ");
		for (String string : array) {
			recintos.addItem(string);			
		}
		
	}

	/**
	 * Dados la caja fecha y la caja hora devuelve la fecha y hora en formato
	 * LocalDateTime
	 * 
	 * @param cajaFecha
	 * @param cajaHora
	 * @return
	 */
	@SuppressWarnings("unchecked") // se queja del Casteo @sergio si sabes que podría ser, haz lo tuyo <3
	private LocalDateTime obtenerFechaHora(Box cajaFecha, Box cajaHora) {

		Component[] fecha = cajaFecha.getComponents();
		String dia = (String) ((JComboBox<String>) fecha[0]).getSelectedItem();
		String mes = (String) ((JComboBox<String>) fecha[1]).getSelectedItem();
		String anho = (String) ((JComboBox<String>) fecha[2]).getSelectedItem();

		String hora = "0";
		String minuto = "0";
		try {
			Component[] tiempo = cajaHora.getComponents();
			hora = (String) ((JComboBox<String>) tiempo[0]).getSelectedItem();
			minuto = (String) ((JComboBox<String>) tiempo[1]).getSelectedItem();
		} catch (NullPointerException e) {
			System.out.println("Si esto no era una solicitud de registro ha habido un error: \n");
		}

		int diai;
		int mesi;
		int anhoi;
		try {
			diai = Integer.parseInt(dia);
			mesi = Integer.parseInt(mes);
			anhoi = Integer.parseInt(anho);
		} catch (NumberFormatException e) {
			return null; // Suponemos que no quiere buscar por fecha
		}

		int horai = 0;
		int minutoi = 0;
		try {
			horai = Integer.parseInt(hora);
			minutoi = Integer.parseInt(minuto);
		} catch (NumberFormatException e) {
		}

		return LocalDateTime.of(anhoi, mesi, diai, horai, minutoi); // Si sólo estnán los minutos sin valor, guarda todo
																	// menos los minutos, si la hora está sin valor
																	// guardaria la fecha con hora 00:00
	}

	/**
	 * Crea una Caja hora
	 * 
	 * @return
	 */
	private Box seleccionarHora() {
		Box caja = new Box(BoxLayout.X_AXIS);

		JComboBox<String> hora = new JComboBox<String>();
		hora.addItem(" - Hora - ");
		JComboBox<String> minuto = new JComboBox<String>();
		minuto.addItem(" - Minuto - ");

		// Carga de valores
		for (int i = 00; i <= 24; i++) {
			hora.addItem(String.valueOf(i));
		}
		for (int i = 00; i <= 55; i += 5) {
			minuto.addItem(String.valueOf(i));
		}

		caja.add(hora);
		caja.add(minuto);

		return caja;
	}

	/**
	 * Crea una Caja fecha
	 * 
	 * @return
	 */
	private Box seleccionarFecha() {
		Box caja = new Box(BoxLayout.X_AXIS);

		JComboBox<String> dia = new JComboBox<String>();
		dia.addItem(" - Día - ");
		JComboBox<String> mes = new JComboBox<String>();
		mes.addItem(" - Mes - ");
		JComboBox<String> anho = new JComboBox<String>();
		anho.addItem(" - Año - ");

		// Carga de valores
		for (int i = 1; i <= 31; i++) {
			dia.addItem(String.valueOf(i));
		}
		for (int i = 1; i <= 12; i++) {
			mes.addItem(String.valueOf(i));
		}
		for (int i = 2019; i <= 2025; i++) {
			anho.addItem(String.valueOf(i));
		}

		caja.add(dia);
		caja.add(mes);
		caja.add(anho);

		return caja;
	}

	private Box seleccionarFechaNac(String fechaPredet) {
		// año-mes-dia
		String[] fecha = new String[3];
		try {
			fecha = fechaPredet.split("-");
		} catch (NullPointerException e) {
			fecha[0] = " - Año - ";
			fecha[1] = " - Mes - ";
			fecha[2] = " - Día - ";
		}

		Box caja = new Box(BoxLayout.X_AXIS);

		JComboBox<String> dia = new JComboBox<String>();
		dia.addItem(" - Día - ");
		JComboBox<String> mes = new JComboBox<String>();
		mes.addItem(" - Mes - ");
		JComboBox<String> anho = new JComboBox<String>();
		anho.addItem(" - Año - ");

		// Carga de valores
		for (int i = 1; i <= 31; i++) {
			dia.addItem(String.valueOf(i));
		}
		for (int i = 1; i <= 12; i++) {
			mes.addItem(String.valueOf(i));
		}
		for (int i = 2019; i >= 1900; i--) {
			anho.addItem(String.valueOf(i));
		}

		anho.setSelectedItem(fecha[2]);
		mes.setSelectedItem(fecha[1]);
		dia.setSelectedItem(fecha[0]);

		caja.add(dia);
		caja.add(mes);
		caja.add(anho);

		return caja;
	}

	/**
	 * Que pasa cuando pulsamos el botón de Login
	 */
	private void login() {
		String dni = JOptionPane.showInputDialog(null, "Introduzca su DNI");
		if (Aplicacion.existeDni(dni)) {
			DNI = dni;
			CardLayout cl = (CardLayout) (panelLogin.getLayout());
			cl.next(panelLogin);
		} else {
			JOptionPane.showMessageDialog(null, "DNI no reconocido");
		}
	}

	/**
	 * Que pasa cuando pulsamos el botón de Registrarse
	 */
	private void registro() {
		JTextField username = new JTextField();
		JTextField dni = new JTextField();
		JTextField iban = new JTextField();
		Box fechaNac = seleccionarFechaNac(null);
		Object[] message = { "DNI:", dni, "Nombre:", username, "IBAN:", iban, "Fecha de Nacimiento:", fechaNac };

		int option = JOptionPane.showConfirmDialog(null, message, "Registro", JOptionPane.OK_CANCEL_OPTION);
		if (option == JOptionPane.OK_OPTION) {
			int resultadoRegistro = Aplicacion.registrarCliente(dni.getText(), username.getText(), iban.getText(),
					fechaNac2String(obtenerFechaHora(fechaNac, null)));
			switch (resultadoRegistro) {
			case 0:
				JOptionPane.showMessageDialog(null, "Registrado correctamente");
				DNI = dni.getText();
				CardLayout cl = (CardLayout) (panelLogin.getLayout());
				cl.next(panelLogin);
				break;
			case -1:
				JOptionPane.showMessageDialog(null, "DNI existente");
				break;
			case -2:
				JOptionPane.showMessageDialog(null, "Cliente menor de edad");
				break;
			case -3:
				JOptionPane.showMessageDialog(null, "Formato de DNI incorrecto");
				break;
			case -4:
				JOptionPane.showMessageDialog(null, "Formato de IBAN incorrecto");
				break;
			case -87:
				JOptionPane.showMessageDialog(null, "SQLEXception");
				break;

			default:
				JOptionPane.showMessageDialog(null, "Unexpected Error");
				break;
			}
		} else {
			System.out.println("Login canceled");
		}
	}

	/**
	 * Que pasa cuando buscamos algo
	 * 
	 * @param adulto
	 * @param infantil
	 * @param parado
	 * @param jubilado
	 * @param bebe
	 * @param participantes
	 * @param espectaculo
	 * @param recinto
	 * @param precioMax
	 * @param fechaMin
	 * @param fechaMax
	 */
	private void buscar(boolean adulto, boolean infantil, boolean parado, boolean jubilado, boolean bebe,
			String participantes, String espectaculo, String recinto, int precioMax, String fechaMin, String fechaMax) {
		ArrayList<Evento> eventosFiltrados = Aplicacion.filtrarEventos(espectaculo, recinto, fechaMax, fechaMin,
				participantes, precioMax, jubilado, adulto, parado, infantil, bebe);
		panelEventos.removeAll();
		for (Evento evento : eventosFiltrados) {
			JLabel texto = new JLabel(evento.toString());
			texto.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 16));
			texto.setForeground(Color.BLACK);
			texto.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseEntered(MouseEvent e) {
					texto.setForeground(new Color(new Random().nextInt(16777215))); // XD
//			    	texto.setForeground(Color.BLUE);
					setCursor(new Cursor(Cursor.HAND_CURSOR));
				}

				@Override
				public void mouseExited(MouseEvent e) {
					texto.setForeground(Color.BLACK);
					setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
				}

				@Override
				public void mouseClicked(MouseEvent e) {
					accederEvento(evento);
				}

				private void accederEvento(Evento evento) {
					ArrayList<Grada> gradas = Aplicacion.buscarGradas(evento);
					CardLayout cl = (CardLayout) panelPrincipal.getLayout();
					cl.show(panelPrincipal, "Gradas");
					fillGradas(gradas);
				}
			});
			panelEventos.add(texto);
			panelEventos.add(Box.createRigidArea(new Dimension(1, 10)));
		}
		CardLayout cl = (CardLayout) panelPrincipal.getLayout();
		cl.show(panelPrincipal, "Eventos");
		panelEventos.updateUI();
	}

	private void fillGradas(ArrayList<Grada> gradas) {
		HashMap<Entrada, JComboBox<Integer>> cantidades = new HashMap<>();
		panelGradas.removeAll();
		panelGradas.add(new JLabel("Gradas"));
		panelGradas.add(new JLabel("Adulto"));
		panelGradas.add(new JLabel("Infantil"));
		panelGradas.add(new JLabel("Jubilado"));
		panelGradas.add(new JLabel("Parado"));
		panelGradas.add(new JLabel("Bebé"));
		for (Grada grada : gradas) {
			panelGradas.add(new JLabel(grada.getNombre()));
			Box cajaAdulto = new Box(BoxLayout.X_AXIS);
			Box cajaInfantil = new Box(BoxLayout.X_AXIS);
			Box cajaJubilado = new Box(BoxLayout.X_AXIS);
			Box cajaParado = new Box(BoxLayout.X_AXIS);
			Box cajaBebe = new Box(BoxLayout.X_AXIS);

			JComboBox<Integer> cantidadAdulto = new JComboBox<Integer>();
			cantidadAdulto.setMaximumSize(new Dimension(50, 25));
			cajaAdulto.add(cantidadAdulto);
			for (int i = 0; i <= grada.getMaxAdulto(); i++) {
				cantidadAdulto.addItem(i);
			}
			cajaAdulto.add(new JLabel(" " + String.valueOf(grada.getPrecioAdulto())));
			panelGradas.add(cajaAdulto);
			cantidades.put(new Entrada(grada.getEvento(), 0, grada.getId_grada(), "Adulto", grada.getPrecioAdulto(), grada.getNombre()), cantidadAdulto);

			JComboBox<Integer> cantidadInfantil = new JComboBox<Integer>();
			cantidadInfantil.setMaximumSize(new Dimension(50, 25));
			cajaInfantil.add(cantidadInfantil);
			for (int i = 0; i <= grada.getMaxInfantil(); i++) {
				cantidadInfantil.addItem(i);
			}
			cajaInfantil.add(new JLabel(" " + String.valueOf(grada.getPrecioInfantil())));
			panelGradas.add(cajaInfantil);
			cantidades.put(new Entrada(grada.getEvento(), 0, grada.getId_grada(), "Infantil", grada.getPrecioInfantil(), grada.getNombre()), cantidadInfantil);

			JComboBox<Integer> cantidadJubilado = new JComboBox<Integer>();
			cantidadJubilado.setMaximumSize(new Dimension(50, 25));
			cajaJubilado.add(cantidadJubilado);
			for (int i = 0; i <= grada.getMaxJubilado(); i++) {
				cantidadJubilado.addItem(i);
			}
			cajaJubilado.add(new JLabel(" " + String.valueOf(grada.getPrecioJubilado())));
			panelGradas.add(cajaJubilado);
			cantidades.put(new Entrada(grada.getEvento(), 0, grada.getId_grada(), "Jubilado", grada.getPrecioJubilado(), grada.getNombre()), cantidadJubilado);

			JComboBox<Integer> cantidadParado = new JComboBox<Integer>();
			cantidadParado.setMaximumSize(new Dimension(50, 25));
			cajaParado.add(cantidadParado);
			for (int i = 0; i <= grada.getMaxParado(); i++) {
				cantidadParado.addItem(i);
			}
			cajaParado.add(new JLabel(" " + String.valueOf(grada.getPrecioParado())));
			panelGradas.add(cajaParado);
			cantidades.put(new Entrada(grada.getEvento(), 0, grada.getId_grada(), "Parado", grada.getPrecioParado(), grada.getNombre()), cantidadParado);

			JComboBox<Integer> cantidadBebe = new JComboBox<Integer>();
			cantidadBebe.setMaximumSize(new Dimension(50, 25));
			cajaBebe.add(cantidadBebe);
			for (int i = 0; i <= grada.getMaxBebe(); i++) {
				cantidadBebe.addItem(i);
			}
			cajaBebe.add(new JLabel(" " + String.valueOf(grada.getPrecioBebe())));
			panelGradas.add(cajaBebe);
			cantidades.put(new Entrada(grada.getEvento(), 0, grada.getId_grada(), "Bebe", grada.getPrecioBebe(), grada.getNombre()), cantidadBebe);
		}

		JButton volverJB = new JButton("Volver");
		volverJB.setMaximumSize(new Dimension(1000, 50));
		volverJB.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				CardLayout cl = (CardLayout) panelPrincipal.getLayout();
				cl.show(panelPrincipal, "Eventos");
			}
		});
		JButton preReservaJB = new JButton("Pre-Reservar");
		preReservaJB.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if(DNI.equals("0")) {
					JOptionPane.showMessageDialog(null, "Debes registrarte para realizar esta acción");
				}else {
					reservarPreReservar(DNI ,"pre-reservar" ,cantidades );
				}
			}
		});
		JButton compraJB = new JButton("Comprar");
		compraJB.addActionListener(new ActionListener() {
			@Override
			public void actionPerformed(ActionEvent e) {
				if(DNI.equals("0")) {
					JOptionPane.showMessageDialog(null, "Debes registrarte para realizar esta acción");
				}else {
					reservarPreReservar(DNI ,"reservar" ,cantidades );
				}
			}
		});
		preReservaJB.setMaximumSize(new Dimension(1000, 50));
		compraJB.setMaximumSize(new Dimension(1000, 50));

		Box cajavolver = new Box(BoxLayout.Y_AXIS);
		cajavolver.add(volverJB);
		Box cajapr = new Box(BoxLayout.Y_AXIS);
		cajapr.add(preReservaJB);
		Box cajavcom = new Box(BoxLayout.Y_AXIS);
		cajavcom.add(compraJB);

		panelGradas.add(cajavolver);
		panelGradas.add(new Box(BoxLayout.Y_AXIS));
		panelGradas.add(new Box(BoxLayout.Y_AXIS));
		panelGradas.add(new Box(BoxLayout.Y_AXIS));
		panelGradas.add(cajapr);
		panelGradas.add(cajavcom);
	}

	protected void reservar(String dni, HashMap<Entrada, JComboBox<Integer>> cantidades) {
				
	}

	protected void preReservar(String dni, HashMap<Entrada, JComboBox<Integer>> cantidades) {
		
	}
	
	protected void reservarPreReservar(String dni, String tipoTransaccion,  HashMap<Entrada, JComboBox<Integer>> cantidades) {
		HashMap<Entrada, Integer> cantidadesint = new HashMap<>();
		Set<Entrada> entradas =cantidades.keySet();
		int cantTotal = 0;
		Evento evento = null;
		for (Entrada entrada : entradas) {
			int cantidad = (int) cantidades.get(entrada).getSelectedItem();
			cantidadesint.put(entrada, cantidad);
			cantTotal += cantidad;
			evento = entrada.getEvento();
		}
		int cantMaxima = Aplicacion.obtenerMaximoPreReservas(evento);
		if (cantTotal > cantMaxima) {
			JOptionPane.showMessageDialog(null, "No se puede Pre-Reservar más de " + cantMaxima + " entradas para este evento");
		}
		
		int resultado = Aplicacion.reservarPreReservar(tipoTransaccion, dni, cantidadesint);
		switch (resultado) {
		case 0:
			if(tipoTransaccion.equals("reservar")) {
			JOptionPane.showMessageDialog(null, "Compra realizada satisfactoriamente");
			}
			break;
		case -1:
			JOptionPane.showMessageDialog(null, "Alguna localidad no está disponible");
			break;
		case -2:
			JOptionPane.showMessageDialog(null, "Tipo de usuario incorrecto");
			break;
		case -3:
			JOptionPane.showMessageDialog(null, "No se ofrecen entradas para este tipo de usuario");
			break;
		case -4:
			JOptionPane.showMessageDialog(null, "No quedan más entradas disponibles para este tipo de usario");
			break;
		case -5:
			JOptionPane.showMessageDialog(null, "No se pueden comprar tantas entradas para este evento");
			break;
		case -6:
			JOptionPane.showMessageDialog(null, "Tipo de transacción incorrecto");
			break;
		case -7:
			JOptionPane.showMessageDialog(null, "Formato de DNI incorrecto");
			break;
		case -8:
			JOptionPane.showMessageDialog(null, "Formato de fecha incorrecto");
			break;
		case -9:
			JOptionPane.showMessageDialog(null, "No se pueden conseguir entradas consecutivas");
			break;
		case -87:
			JOptionPane.showMessageDialog(null, "SQLEXception");
			break;

		default:
			JOptionPane.showMessageDialog(null, "Unexpected Error");
			break;
		}
	}

	protected void misDatos() {
		Cliente cliente = Aplicacion.obtenerCliente(DNI);
		Object[] message = { "DNI:" + DNI, "Nombre:" + cliente.getNombre(), "IBAN:" + cliente.getIban(),
				"Fecha de Nacimiento:" + cliente.getFecha_nacimiento(),Box.createRigidArea(new Dimension(1, 10)), "Desea editar sus datos personales?" };

		int resultado = JOptionPane.showConfirmDialog(null, message, "Datos personales", JOptionPane.YES_NO_OPTION);
		if(resultado == JOptionPane.YES_OPTION) {
			editarDatos(cliente);
		}
	}

	protected void editarDatos(Cliente cliente) {
		JTextField nombreJT = new JTextField(cliente.getNombre());
		JTextField ibanJT = new JTextField(cliente.getIban());
		Box fechavox = seleccionarFechaNac(cliente.getFecha_nacimiento());
		Object[] message = { "DNI: " + DNI, "Nombre: ", nombreJT, "IBAN: ", ibanJT, "Fecha de Nacimiento: ", fechavox };

		int option = JOptionPane.showConfirmDialog(null, message, "Datos personales", JOptionPane.OK_OPTION);
		if (option == JOptionPane.OK_OPTION) {
			String nombre = nombreJT.getText();
			String iban = ibanJT.getText();
			if (nombre.length() > 30) {
				JOptionPane.showMessageDialog(null, "Nombre demasiado Grande");
			} else {
				int resultado;
				try {
					String fechanac = fechaNac2String(obtenerFechaHora(fechavox, null));
					resultado = Aplicacion.modificarCliente(DNI, nombre, iban, fechanac);
				} catch (NullPointerException e) {
					System.out.println(cliente.getFecha_nacimiento());
					resultado = Aplicacion.modificarCliente(DNI, nombre, iban, cliente.getFecha_nacimiento());
				}
				switch (resultado) {
				case 0:
					JOptionPane.showMessageDialog(null, "Actualización satisfactoria");
					misEntradas(DNI);
					break;
				case -1:
					JOptionPane.showMessageDialog(null, "DNI desconocido");
					break;
				case -2:
					JOptionPane.showMessageDialog(null, "DNI incorrecto");
					break;
				case -3:
					JOptionPane.showMessageDialog(null, "Formato de IBAN incorrecto");
					break;
				case -87:
					JOptionPane.showMessageDialog(null, "SQLEXception");
					break;

				default:
					JOptionPane.showMessageDialog(null, "Unexpected Error");
					break;
				}

			}
		}
	}

	private void misEntradas(String dni) {
		ArrayList<Entrada> entradas = Aplicacion.obtenerEntradasCliente(dni);
		panelEntradas.removeAll();

		JLabel titulo = new JLabel("Estas son tus entradas, haz click sobre alguna de ellas para anularla");
		titulo.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 20));
		titulo.setForeground(Color.BLACK);
		panelEntradas.add(titulo);
		panelEntradas.add(Box.createRigidArea(new Dimension(1, 20)));

		for (Entrada entrada : entradas) {
			JLabel texto = new JLabel(entrada.toString());
			texto.setFont(new Font(Font.SANS_SERIF, Font.BOLD, 14));
			texto.setForeground(Color.BLACK);
			texto.addMouseListener(new MouseAdapter() {
				@Override
				public void mouseEntered(MouseEvent e) {
					texto.setForeground(colorDetalles);
					setCursor(new Cursor(Cursor.HAND_CURSOR));
				}

				@Override
				public void mouseExited(MouseEvent e) {
					texto.setForeground(Color.BLACK);
					setCursor(new Cursor(Cursor.DEFAULT_CURSOR));
				}

				@Override
				public void mouseClicked(MouseEvent e) {
					anularEntrada(entrada);
				}
			});
			panelEntradas.add(texto);
			panelEntradas.add(Box.createRigidArea(new Dimension(1, 10)));
		}
		CardLayout cl = (CardLayout) panelPrincipal.getLayout();
		cl.show(panelPrincipal, "Entradas");
		panelEntradas.updateUI();
	}

	protected void anularEntrada(Entrada entrada) {
		int option = JOptionPane.showConfirmDialog(null, "Seguro que desea anular la entrada?");

		if (option == JOptionPane.OK_OPTION) {
			int resultado = Aplicacion.anularReserva(entrada.getId_localidad(), entrada.getId_grada(),
					entrada.getId_recinto(), entrada.getId_espectaculo(), entrada.getFecha(), DNI);
			switch (resultado) {
			case 0:
				JOptionPane.showMessageDialog(null, "Anulación confirmada");
				misEntradas(DNI);
				break;
			case -1:
				JOptionPane.showMessageDialog(null, "Localidad no reservada");
				break;
			case -2:
				JOptionPane.showMessageDialog(null, "Localidad reservada por otro usuario");
				break;
			case -3:
				JOptionPane.showMessageDialog(null, "Formato de DNI incorrecto");
				break;
			case -87:
				JOptionPane.showMessageDialog(null, "SQLEXception");
				break;

			default:
				JOptionPane.showMessageDialog(null, "Unexpected Error");
				break;
			}
		}
	}

	private String fechaNac2String(LocalDateTime fechahora) {
		int dia = fechahora.getDayOfMonth();
		int mes = fechahora.getMonthValue();
		int anho = fechahora.getYear();
		return (anho + "-" + mes + "-" + dia);
	}

	private String fecha2String(LocalDateTime fechahora) {
		int dia = fechahora.getDayOfMonth();
		int mes = fechahora.getMonthValue();
		int anho = fechahora.getYear();
		int hora = fechahora.getHour();
		int min = fechahora.getMinute();
		return (dia + "-" + mes + "-" + String.valueOf(anho).substring(2) + " " + hora + ":" + min + ":00");
	}
}
