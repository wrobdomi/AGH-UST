import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.geometry.Insets;
import javafx.scene.Node;
import javafx.scene.chart.LineChart;
import javafx.scene.chart.NumberAxis;
import javafx.scene.chart.XYChart;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.text.TextAlignment;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;


public class PlotController {

    private double xMin = 0;
    private double xMax = 10;
    private int samples = 18;
    private int polyDegree;
    private double [] coef;

    @FXML
    private TextField maximumX;
    @FXML
    private TextField minimumX;
    @FXML
    private TextField howManySamples;
    @FXML
    private TextField degree;
    @FXML
    private VBox factorBox;
    @FXML
    private Pane mainPane;

    NumberAxis yAxis = new NumberAxis();
    NumberAxis xAxis = new NumberAxis();
    LineChart<Number,Number> lineChart = new LineChart<Number,Number>(xAxis,yAxis);

    @FXML
    public void menageGUI()
    {

        // get user preferences
        polyDegree = Integer.parseInt(degree.getText());
        xMax = Double.parseDouble(maximumX.getText());
        xMin = Double.parseDouble(minimumX.getText());
        samples = Integer.parseInt(howManySamples.getText());

        // clear inputs for coefficients
        factorBox.getChildren().clear();

        for(int i = 0; i< polyDegree; i++)
        {
            TextField node = new TextField();
            node.setPromptText("Factor " + String.valueOf(polyDegree));
            node.setPadding(new Insets(5,0,5,0));
            node.setText("0");
            node.setMaxWidth(20);

            Label text = new Label();
            text.setText(" *   x^" + i);
            text.setTextAlignment(TextAlignment.CENTER);
            text.setPadding(new Insets(5,0,5,10));

            HBox box = new HBox();
            box.getChildren().add(node);
            box.getChildren().add(text);

            factorBox.getChildren().add(box);
        }

        Button draw = new Button();
        draw.setText("Draw");
        draw.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                drawPlot();
            }
        });
        factorBox.getChildren().add(draw);
    }


    public void drawPlot() {

        this.getCoefFromGUI();

        if(factorBox.getChildren().size() > 1)
        {
            lineChart.getData().clear();

            // calculate xAxis points basing on xMix, xMax and samples
            ArrayList<Double> xValues = this.calculatePoly().get("xValues");
            ArrayList<Double> yValues = this.calculatePoly().get("yValues");
            // debugging: System.out.println(xValues);
            // debugging: System.out.println(yValues);

            XYChart.Series series = new XYChart.Series();
            for(int i=0; i < samples; i++) {
                double argY = yValues.get(i);
                double argX = xValues.get(i);
                series.getData().add(new XYChart.Data(argX,argY));
            }
            lineChart.getData().add(series);
            if(mainPane.getChildren().size() == 0) mainPane.getChildren().add(lineChart);
        }
    }

    private void getCoefFromGUI(){

        ArrayList<Double> coefList = new ArrayList<>();

        for(Node e : factorBox.getChildren()) {
            if(e instanceof HBox) {
                TextField tf = ((TextField)((HBox) e).getChildren().get(0));
                coefList.add(Double.valueOf(tf.getText()));
            }
        }
        coef = new double[coefList.size()];
        for(int i = 0; i < coefList.size() ; i++){
            coef[coefList.size()-1-i] = coefList.get(i);
        }

    }

    public void initialize() {
        lineChart.setMaxHeight(300);
        lineChart.setMaxWidth(800);
    }

    public Map<String, ArrayList<Double>> calculatePoly(){

        Map<String, ArrayList<Double>> chartValues = new HashMap<>();

        double dx  = ( xMax - xMin ) / ( samples - 1 );

        ArrayList<Double> yValues = new ArrayList<>();
        ArrayList<Double> xValues = new ArrayList<>();

        for(int i = 0 ; i < samples ; i++){
            double x = 0;
            if( i == samples - 1){
                x = xMax;
            }
            else {
                x = xMin + dx * i;
            }
            double result = 0;
            for(int j = 0 ; j < coef.length ; j++ ){
                if(j == 0){
                    result += coef[coef.length-1];
                }
                else{
                    result += coef[coef.length-j-1] * Math.pow(x, j);
                }
            }

            yValues.add(result);
            xValues.add(x);

        }

        chartValues.put("xValues", xValues);
        chartValues.put("yValues", yValues);

        return chartValues;
    }



}
