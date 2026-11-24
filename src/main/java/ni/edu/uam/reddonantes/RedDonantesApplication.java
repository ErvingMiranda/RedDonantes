package ni.edu.uam.reddonantes;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.stage.Stage;
import ni.edu.uam.reddonantes.database.JPAUtil;

import java.io.IOException;

public class RedDonantesApplication extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        FXMLLoader fxmlLoader = new FXMLLoader(RedDonantesApplication.class.getResource("main-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load());
        stage.setTitle("Red de Donantes de Sangre - Bienvenida");
        stage.setScene(scene);
        stage.show();
    }

    @Override
    public void stop() {
        // Cierra la fábrica de persistencia al finalizar la aplicación.
        JPAUtil.cerrar();
    }
}
