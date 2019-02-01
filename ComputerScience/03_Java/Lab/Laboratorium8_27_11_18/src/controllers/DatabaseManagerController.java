package controllers;

import database.DatabaseService;
import entity.BooksEntity;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.concurrent.Task;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.control.*;
import javafx.scene.layout.BorderPane;

import java.io.IOException;
import java.util.ArrayList;

public class DatabaseManagerController {

    @FXML
    private Label queryLabel;
    @FXML
    private BorderPane mainBorder;
    @FXML
    private TableView<BooksEntity> booksTable;
    @FXML
    private TextField selectedAuthor;
    @FXML
    private TextField selectedISBN;
    @FXML
    private TextField isbnToInsert;
    @FXML
    private TextField authorToInsert;
    @FXML
    private TextField titleToInsert;
    @FXML
    private TextField yearToInsert;



    @FXML
    public void showAllBooks(){

        if(DatabaseService.checkConnectionWithDatabase()){
            Task<ObservableList<BooksEntity>> task = new GetAllBooksTask();
            booksTable.itemsProperty().bind(task.valueProperty());
            new Thread(task).start();
        }
        else{
            showErrorDialog();
        }
    }


    @FXML
    public void showBooksByAuthor(){

        if(DatabaseService.checkConnectionWithDatabase()){
            Task<ObservableList<BooksEntity>> task = new GetBooksByAuthor();
            ((GetBooksByAuthor) task).sur = selectedAuthor.getText();
            booksTable.itemsProperty().bind(task.valueProperty());
            new Thread(task).start();
        }
        else{
            showErrorDialog();
        }

    }


    @FXML
    public void showBooksByISBN(){

        if(DatabaseService.checkConnectionWithDatabase()){
            Task<ObservableList<BooksEntity>> task = new GetBooksByIsbn();
            ((GetBooksByIsbn) task).isbn = selectedISBN.getText();
            booksTable.itemsProperty().bind(task.valueProperty());
            new Thread(task).start();
        }
        else{
            // show dialog and close the program
            showErrorDialog();
        }
    }

    @FXML
    public void addBook(){

        if(DatabaseService.checkConnectionWithDatabase()){
            BooksEntity book = new BooksEntity();
            book.setIsbn(isbnToInsert.getText());
            book.setAuthor(authorToInsert.getText());
            book.setTitle(titleToInsert.getText());
            book.setYear(Integer.parseInt(yearToInsert.getText()));

            DatabaseService.addBook(book);

            this.showAllBooks();
        }
        else{
            showErrorDialog();
        }
    }



    public void showErrorDialog(){
        Dialog<ButtonType> dialog = new Dialog<>();
        dialog.initOwner(mainBorder.getScene().getWindow());
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


/***
 * separate class for running background ( concurrent ) query to db
 */
class GetAllBooksTask extends Task {

    /**
     * queries all books in separate thread
     * @return ObservableList to make use of data binding
     */
    @Override
    public ObservableList<BooksEntity> call() {
        return FXCollections.observableArrayList
                (DatabaseService.queryAll());
    }

}

/**
 * similarly to the above
 */
class GetBooksByAuthor extends Task {

    public String sur;
    /**
     * queries all books in separate thread
     * @return ObservableList to make use of data binding
     */
    @Override
    public ObservableList<BooksEntity> call() {
        return FXCollections.observableArrayList
                (DatabaseService.queryByAuthorSurname(sur));
    }

}


/**
 * similarly to the above
 */
class GetBooksByIsbn extends Task {

    public String isbn;
    /**
     * queries all books in separate thread
     * @return ObservableList to make use of data binding
     */
    @Override
    public ObservableList<BooksEntity> call() {
        return FXCollections.observableArrayList
                (DatabaseService.queryByIsbn(isbn));
    }

}