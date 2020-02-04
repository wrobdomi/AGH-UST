package controllers;

import javafx.application.Platform;
import javafx.fxml.FXML;

public class DialogController {

    /**
     * Exits program when connection to db failed
     */
    @FXML
    public void exitProgram(){
        Platform.exit();
        System.exit(0);
    }

}
