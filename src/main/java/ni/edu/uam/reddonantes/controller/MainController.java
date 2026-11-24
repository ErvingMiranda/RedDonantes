package ni.edu.uam.reddonantes.controller;

import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.BorderPane;
import ni.edu.uam.reddonantes.RedDonantesApplication;

import java.io.IOException;
import java.net.URL;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public class MainController {
    @FXML private BorderPane panelContenido;
    @FXML private Label lblTitulo;
    @FXML private Label lblFecha;
    @FXML private Button btnInicio;
    @FXML private Button btnDonantes;
    @FXML private Button btnDonaciones;
    @FXML private Button btnInventario;
    @FXML private Button btnSolicitudes;
    @FXML private Button btnCampanas;
    @FXML private Button btnHospitales;

    private Button botonActivo;

    @FXML
    public void initialize() {
        String fecha = LocalDate.now().format(DateTimeFormatter.ofPattern("EEEE, d 'de' MMMM 'de' yyyy", Locale.of("es")));
        lblFecha.setText(fecha.substring(0, 1).toUpperCase() + fecha.substring(1));
        mostrarInicio();
    }

    @FXML
    private void mostrarInicio() {
        cargarVista("inicio-view.fxml", "Inicio", btnInicio);
    }

    @FXML
    private void mostrarDonantes() {
        cargarVista("donantes-view.fxml", "Donantes", btnDonantes);
    }

    @FXML
    private void mostrarDonaciones() {
        cargarVista("donaciones-view.fxml", "Donaciones", btnDonaciones);
    }

    @FXML
    private void mostrarInventario() {
        cargarVista("inventario-view.fxml", "Inventario de unidades", btnInventario);
    }

    @FXML
    private void mostrarSolicitudes() {
        cargarVista("solicitudes-view.fxml", "Solicitudes hospitalarias", btnSolicitudes);
    }

    @FXML
    private void mostrarCampanas() {
        cargarVista("campanas-view.fxml", "Campañas", btnCampanas);
    }

    @FXML
    private void mostrarHospitales() {
        cargarVista("hospitales-view.fxml", "Hospitales", btnHospitales);
    }

    private void cargarVista(String archivo, String titulo, Button boton) {
        URL vista = RedDonantesApplication.class.getResource(archivo);

        // Los módulos llegan en PR posteriores; mientras falte su vista se avisa en vez de fallar.
        if (vista == null) {
            mostrarAlerta(Alert.AlertType.INFORMATION, titulo, "Este módulo todavía no está disponible.");
            return;
        }

        try {
            panelContenido.setCenter(FXMLLoader.load(vista));
        } catch (IOException e) {
            mostrarAlerta(Alert.AlertType.ERROR, titulo, "No se pudo abrir la vista: " + e.getMessage());
            return;
        }

        lblTitulo.setText(titulo);
        if (botonActivo != null) {
            botonActivo.getStyleClass().remove("activo");
        }
        boton.getStyleClass().add("activo");
        botonActivo = boton;
    }

    private void mostrarAlerta(Alert.AlertType tipo, String titulo, String mensaje) {
        Alert alerta = new Alert(tipo);
        alerta.setTitle(titulo);
        alerta.setHeaderText(null);
        alerta.setContentText(mensaje);
        alerta.showAndWait();
    }
}
