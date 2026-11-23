module ni.edu.uam.reddonantes {
    requires javafx.controls;
    requires javafx.fxml;

    opens ni.edu.uam.reddonantes to javafx.fxml;
    opens ni.edu.uam.reddonantes.controller to javafx.fxml;
    exports ni.edu.uam.reddonantes;
}
