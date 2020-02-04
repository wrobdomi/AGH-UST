package controllers;

import database.DatabaseService;
import entity.BooksEntity;
import javafx.application.Platform;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Dialog;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.stage.Stage;

import java.io.IOException;
import java.util.ArrayList;


public class LoginController {

    @FXML
    private TextField userName;
    @FXML
    private PasswordField userPass;
    @FXML
    private GridPane mainGrid;


    /**
     * tries to connect to db using credentials provided by user
     * invoked after 'submit' was clicked
     */
    @FXML
    public void authenticateUser(){

        // create new instance of database service
        DatabaseService databaseService = new DatabaseService(userName.getText(), userPass.getText());

        // check the connection with database
        boolean databaseReachable = databaseService.checkConnectionWithDatabase();


        if(databaseReachable){ // if db if reachable, change view

            Stage primaryStage = (Stage) mainGrid.getScene().getWindow();

            try {
                Parent dbManagerView = FXMLLoader.load(getClass().getResource("../views/dbManager.fxml"));

                Scene dbView = new Scene(dbManagerView, 1500, 800);

                primaryStage.setScene(dbView);
                primaryStage.setTitle("Database Manager");

            } catch (IOException e) {
                System.out.println("Unable to load dbManager.fxml");
                e.printStackTrace();
            }


        }
        else{ // if db unreachable, show combo box with error
            System.out.println("Database unreachable");
            this.showErrorDialog();
        }
    }


    /**
     * shows dialog pane when connection to db failed
     * after 4 attempts
     */
    public void showErrorDialog(){
        Dialog<ButtonType> dialog = new Dialog<>();
        dialog.initOwner(mainGrid.getScene().getWindow());
        try{
            Parent root = FXMLLoader.load(getClass().getResource("../views/failToConnectDialog.fxml"));
            dialog.getDialogPane().setContent(root);
        }catch(IOException e){
            System.out.println("Cant load the dialog.");
            e.printStackTrace();

        }

        dialog.showAndWait();
    }









}
