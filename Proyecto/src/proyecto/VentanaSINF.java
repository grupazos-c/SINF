package proyecto;

import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.time.*;

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
	
	
	Color colorFondo = new Color(209,125,146);
	Color colorprincipal = Color.WHITE;
	Color colorDetalles = new Color(207,60,95);
	
	private String DNI = "0";
	/**
	 *  Paneles del frame:
	 * 		- panelLogo: aquí solo sale el logo
	 * 		- panelLogin: en este panel habrá dos botones para logearse, una vez dentro podremos ver nuestras entradas y nuestros datos
	 * 		- panelBusqueda: todas las opciones de busqueda
	 * 		- panelPrincipal: aquí se mostrarán los eventos, nuestras entradas, o lo que toque
	 */
	JPanel panelLogo, panelLogin, panelBusqueda, panelPrincipal;
	private JPanel contentPane;
	/**
	 * consturctor que inicializa nuestra ventana
	 */
	public VentanaSINF() {
		super();
		setTitle("Servicio de Taquilla Virtual");
		setBounds(250, 150, 1200, 800);
		setMinimumSize(new Dimension(650,750));
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
		
		/* Carta de Log in*/
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
		
		JButton BucarJB = new JButton("Buscar");
		JLabel TipoUsuarioJL = new JLabel("Tipo de entrada:");
		JCheckBox AdultoJCB = new JCheckBox("Adulto", true);
		JCheckBox InfantilJCB = new JCheckBox("Infantil", true);
		JCheckBox ParadoJCB = new JCheckBox("Parado", true);
		JCheckBox JubiladoJCB = new JCheckBox("Jubilado", true);
		JCheckBox BebeJCB = new JCheckBox("Bebé", true);
		JComboBox<String> participantes = new JComboBox<String>();
		JComboBox<String> espectaculos = new JComboBox<String>();
		JComboBox<String> recintos = new JComboBox<String>();
		JLabel PrecioJL = new JLabel("Precio máximo:");
		JSlider PrecioJS = new JSlider(0, 50, 50);
		JLabel FminJL = new JLabel("Desde:");
		JLabel FmaxJL = new JLabel("Hasta:");
		Box fechamin = seleccionarFecha();
		Box horamin = seleccionarHora();
		Box fechamax = seleccionarFecha();
		Box horamax = seleccionarHora();
		

		BucarJB.setAlignmentX(Component.LEFT_ALIGNMENT);
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
		
		//TODO de prueba
		participantes.addItem(" - Participantes - ");
		espectaculos.addItem(" - Espectáculos - ");
		recintos.addItem(" - Recintos - ");
    	
		panelBusqueda.add(BucarJB);
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
		
		/** Panel Principal */
		panelPrincipal = new JPanel();

		panelPrincipal.add(new JLabel("Soy el panel Principal"));
		
		/**
		 * Orden de paneles en el Pane
		 */
		GridBagConstraints gbc = new GridBagConstraints();
		
		//Logo
		gbc.gridx = 0; 
		gbc.gridy = 0; 
		gbc.gridwidth = 2; 
		gbc.gridheight = 1; 
		gbc.weightx = 1.0;
		gbc.weighty = 0.0;
		gbc.fill = GridBagConstraints.HORIZONTAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelLogo,gbc);
		//Login
		gbc.gridx = 2; 
		gbc.gridy = 0; 
		gbc.gridwidth = 1; 
		gbc.gridheight = 1; 
		gbc.weightx = 0.0;
		gbc.weighty = 0.0;
		gbc.fill = GridBagConstraints.VERTICAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelLogin,gbc);
		//Busqueda
		gbc.gridx = 0; 
		gbc.gridy = 1; 
		gbc.gridwidth = 1; 
		gbc.gridheight = 1;
		gbc.weightx = 0.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.VERTICAL;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelBusqueda,gbc);
		//Principal
		gbc.gridx = 1; 
		gbc.gridy = 1; 
		gbc.gridwidth = 2; 
		gbc.gridheight = 1; 
		gbc.weightx = 1.0;
		gbc.weighty = 1.0;
		gbc.fill = GridBagConstraints.BOTH;
		gbc.insets = new Insets(1, 1, 1, 1);
		contentPane.add(panelPrincipal,gbc);
		
		
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
					CardLayout cl = (CardLayout)(panelLogin.getLayout());
			        cl.next(panelLogin);
				} else if (e.getSource() == RegistrarJB) {
					registro();
					UsuarioJL.setText(DNI);
				}
			}
		};
		
		LoginJB.addActionListener(al);
		LogedJB.addActionListener(al);
		RegistrarJB.addActionListener(al);
	}
	
	/**
	 * Dados la caja fecha y la caja hora devuelve la fecha y hora en formato LocalDateTime
	 * @param cajaFecha
	 * @param cajaHora
	 * @return
	 */
	@SuppressWarnings("unchecked") //se queja del Casteo @sergio si sabes que podría ser, haz lo tuyo <3
	private LocalDateTime obtenerFechaHora(Box cajaFecha, Box cajaHora) {
		
		Component[] fecha =  cajaFecha.getComponents();
		String dia = (String) ((JComboBox<String>) fecha[0]).getSelectedItem();
		String mes = (String) ((JComboBox<String>) fecha[1]).getSelectedItem();
		String anho = (String) ((JComboBox<String>) fecha[2]).getSelectedItem();
		
		String hora = "0";
		String minuto = "0";
		try {
			Component[] tiempo =  cajaHora.getComponents();
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
			return null; //Suponemos que no quiere buscar por fecha
		}
		
		int horai = 0;
		int minutoi = 0;
		try {
			horai = Integer.parseInt(hora);
			minutoi = Integer.parseInt(minuto);
		} catch (NumberFormatException e) {
		}
		
		return LocalDateTime.of(anhoi, mesi, diai, horai, minutoi); //Si sólo estnán los minutos sin valor, guarda todo menos los minutos, si la hora está sin valor guardaria la fecha con hora 00:00
	}
	
	/**
	 * Crea una Caja hora
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
		for (int i = 00; i <= 55;i += 5) {
			minuto.addItem(String.valueOf(i));	
		}

		caja.add(hora);
		caja.add(minuto);
		
		return caja;
	}

	/**
	 * Crea una Caja fecha
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

	private Box seleccionarFechaNac() {
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
		
		caja.add(dia);
		caja.add(mes);
		caja.add(anho);
		
		return caja;
	}
	
	/**
	 * Que pasa cuando pulsamos el botón de Login
	 */
	private void login() {
		String dni = JOptionPane.showInputDialog(null, "Introduzca su DNI"); // TODO se podria poner un JText en la
																				// ventana y poner una emergente ?
		if (Cliente.existeDni()) {
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
		Box fechaNac = seleccionarFechaNac();
		Object[] message = {
		    "DNI:", dni,
		    "Nombre:", username,
		    "IBAN:", iban,
		    "Fecha de Nacimiento:",fechaNac
		};
		
		int option = JOptionPane.showConfirmDialog(null, message, "Registro", JOptionPane.OK_CANCEL_OPTION);
		if (option == JOptionPane.OK_OPTION) {
	    	int resultadoRegistro = Cliente.registrarCliente(dni.getText(), username.getText(), iban.getText(), fechaNac2String(obtenerFechaHora(fechaNac, null)));
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
				JOptionPane.showMessageDialog(null, "Formato de DNI incorrecto");
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
		} else {
		    System.out.println("Login canceled");
		}
	}

	private String fechaNac2String(LocalDateTime fechahora) {
		int dia = fechahora.getDayOfMonth();
		int mes = fechahora.getMonthValue();
		int anho = fechahora.getYear();
		return (anho + "-" + mes + "-" + dia);
	}

}
