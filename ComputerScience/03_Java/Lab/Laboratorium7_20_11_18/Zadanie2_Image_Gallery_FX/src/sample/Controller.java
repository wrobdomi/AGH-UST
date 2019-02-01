package sample;

import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.scene.control.ScrollPane;
import javafx.scene.control.TitledPane;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.StackPane;
import javafx.scene.layout.TilePane;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;

import java.awt.event.MouseEvent;
import java.io.File;

public class Controller {

    @FXML
    private BorderPane externalBorder;
    @FXML
    private StackPane imagesFullView;
    @FXML
    private ScrollPane imagesPreview;


    @FXML
    public void findDirectory(){
        System.out.println("Button pressed");
        DirectoryChooser directoryChooser = new DirectoryChooser();
        File selectedDir = directoryChooser.showDialog(externalBorder.getScene().getWindow());
        if(selectedDir == null){
            //No Directory selected
            return;
        }

        System.out.println(selectedDir.getAbsolutePath());
        File [] filesWithinDir = selectedDir.listFiles();
        TilePane tilePane = new TilePane();
        tilePane.setMaxWidth(300);
        tilePane.setHgap(10);
        tilePane.setVgap(10);
        for(int i = 0; i < filesWithinDir.length ; i++){
            Image image = new Image(filesWithinDir[i].toURI().toString());
            ImageView imageView = new ImageView(image);
            imageView.setFitHeight(300);
            imageView.setFitWidth(300);
            imageView.setPreserveRatio(true);
            tilePane.getChildren().add(imageView);

            imageView.addEventHandler(javafx.scene.input.MouseEvent.MOUSE_CLICKED, new EventHandler<javafx.scene.input.MouseEvent>() {
                @Override
                public void handle(javafx.scene.input.MouseEvent event) {
                    System.out.println("Image clicked");
                    ImageView imageView1 = (ImageView) event.getSource();
                    Image image1 = imageView1.getImage();
                    ImageView centerImageView = new ImageView(image1);
                    centerImageView.setFitWidth(700);
                    centerImageView.setFitHeight(500);
                    centerImageView.setPreserveRatio(true);
                    imagesFullView.getChildren().clear();
                    imagesFullView.getChildren().add(centerImageView);
                }
            });

        }

        imagesPreview.setContent(tilePane);

    }


}
