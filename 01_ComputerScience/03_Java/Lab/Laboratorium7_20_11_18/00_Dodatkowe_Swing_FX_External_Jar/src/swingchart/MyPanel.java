package swingchart;

import polyhelp.PolyHelper;

import javax.swing.*;
import java.awt.*;
import java.beans.PropertyChangeEvent;
import java.beans.PropertyChangeListener;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

public class MyPanel extends JPanel  implements PropertyChangeListener {

    // Labels to identify the fields
    private JLabel samplesLabel;
    private JLabel minLabel;
    private JLabel maxLabel;
    private JLabel x4Label;
    private JLabel x3Label;
    private JLabel x2Label;
    private JLabel x1Label;
    private JLabel x0Label;

    // Strings for the labels
    private static String samplesName = "Samples: ";
    private static String minName = "Min: ";
    private static String maxName = "Max: ";
    private static String x4Name = "x^4: ";
    private static String x3Name = "x^3: ";
    private static String x2Name = "x^2: ";
    private static String x1Name = "x^1: ";
    private static String x0Name = "x^0: ";

    // Fields for data entry
    private JFormattedTextField samplesField;
    private JFormattedTextField minField;
    private JFormattedTextField maxField;
    private JFormattedTextField x4Field;
    private JFormattedTextField x3Field;
    private JFormattedTextField x2Field;
    private JFormattedTextField x1Field;
    private JFormattedTextField x0Field;

    // Formats to format and parse numbers
    private NumberFormat samplesFormat = NumberFormat.getNumberInstance();
    private NumberFormat minFormat = NumberFormat.getNumberInstance();
    private NumberFormat maxFormat = NumberFormat.getNumberInstance();
    private NumberFormat x4Format = NumberFormat.getNumberInstance();
    private NumberFormat x3Format = NumberFormat.getNumberInstance();
    private NumberFormat x2Format = NumberFormat.getNumberInstance();
    private NumberFormat x1Format = NumberFormat.getNumberInstance();
    private NumberFormat x0Format = NumberFormat.getNumberInstance();

    // constants for placing chart nicely in JPanel
    private static final int AXIS_PADDING = 30; // gap from border to label or from border to chart
    private static final int LABEL_PADDING = 30; // gap from label to chart
    private static final int TOTAL_PADDING = AXIS_PADDING + LABEL_PADDING; // gap from border to chart

    // constants for scaling yAxis and xAxis
    private static final int Y_LABEL_SAMPLES = 11;
    private static final int X_LABEL_SAMPLES = 11;

    // axis and bullets appearance
    private static final int MARKER_WIDTH = 5;
    private static final double BULLET_RADIUS = 10;

    // charts parameters
    private double xMin = -10; // start point
    private double xMax = 10; // end point
    private double yMin;
    private double yMax;
    private int samples = 11; // number of samples
    private int [] coef = new int [] {0, 0, 1, 0, 0}; // polynomial coefficients


    public MyPanel() {
        Map<String, ArrayList<Double>> polyValues = PolyHelper.calculatePoly(xMax, xMin, samples, int2doubleArr(coef));
        System.out.println(polyValues.toString());
        Map<String, ArrayList<Double>> labelsValues = PolyHelper.calculateAxis(xMin, xMax, samples, coef);
        yMin = labelsValues.get("yRange").get(0);
        yMax = labelsValues.get("yRange").get(1);
        System.out.println(labelsValues.toString());

        // Create the labels.
        samplesLabel = new JLabel(samplesName);
        minLabel = new JLabel(minName);
        maxLabel = new JLabel(maxName);
        x4Label = new JLabel(x4Name);
        x3Label = new JLabel(x3Name);
        x2Label = new JLabel(x2Name);
        x1Label = new JLabel(x1Name);
        x0Label = new JLabel(x0Name);

        // Create the text fields and set them up.
        samplesField = new JFormattedTextField(samplesFormat);
        samplesField.setValue(new Integer(samples));
        samplesField.setColumns(10);
        samplesField.addPropertyChangeListener("value", this);

        minField = new JFormattedTextField(minFormat);
        minField.setValue(new Double(xMin));
        minField.setColumns(10);
        minField.addPropertyChangeListener("value", this);

        maxField = new JFormattedTextField(maxFormat);
        maxField.setValue(new Double(xMax));
        maxField.setColumns(10);
        maxField.addPropertyChangeListener("value", this);

        x4Field = new JFormattedTextField(x4Format);
        x4Field.setValue(new Double(coef[0]));
        x4Field.setColumns(10);
        x4Field.addPropertyChangeListener("value", this);

        x3Field = new JFormattedTextField(x3Format);
        x3Field.setValue(new Double(coef[1]));
        x3Field.setColumns(10);
        x3Field.addPropertyChangeListener("value", this);

        x2Field = new JFormattedTextField(x2Format);
        x2Field.setValue(new Double(coef[2]));
        x2Field.setColumns(10);
        x2Field.addPropertyChangeListener("value", this);

        x1Field = new JFormattedTextField(x1Format);
        x1Field.setValue(new Double(coef[3]));
        x1Field.setColumns(10);
        x1Field.addPropertyChangeListener("value", this);

        x0Field = new JFormattedTextField(x0Format);
        x0Field.setValue(new Double(coef[4]));
        x0Field.setColumns(10);
        x0Field.addPropertyChangeListener("value", this);

        // Tell accessibility tools about label/textfield pairs.
        samplesLabel.setLabelFor(samplesField);
        minLabel.setLabelFor(minField);
        maxLabel.setLabelFor(maxField);
        x4Label.setLabelFor(x4Field);
        x3Label.setLabelFor(x3Field);
        x2Label.setLabelFor(x2Field);
        x1Label.setLabelFor(x1Field);
        x0Label.setLabelFor(x0Field);

        // Lay out the labels and fields in a panel.
        this.add(samplesLabel);
        this.add(samplesField);
        this.add(minLabel);
        this.add(minField);
        this.add(maxLabel);
        this.add(maxField);
        this.add(x4Label);
        this.add(x4Field);
        this.add(x3Label);
        this.add(x3Field);
        this.add(x2Label);
        this.add(x2Field);
        this.add(x1Label);
        this.add(x1Field);
        this.add(x0Label);
        this.add(x0Field);

    }


    /**
     * draws chart
     * @param g
     */
    @Override
    public void paintComponent(Graphics g) {
        super.paintComponent(g);

        Graphics2D graphics2D = (Graphics2D) g;

        // drawing chart context
        graphics2D.setColor(Color.WHITE);
        graphics2D.fillRect(TOTAL_PADDING, AXIS_PADDING, getWidth() - TOTAL_PADDING - AXIS_PADDING,
                                    getHeight() - TOTAL_PADDING - AXIS_PADDING);
        graphics2D.setColor(Color.WHITE); // back to black

        Map<String, ArrayList<Double>> labelsList = PolyHelper.calculateAxis(xMax, xMin, samples, coef);
        yMin = labelsList.get("yRange").get(0);
        yMax = labelsList.get("yRange").get(1);

        // y axis - grid and markers
        for (int i = 0; i < Y_LABEL_SAMPLES; i++) {
            int x0 = LABEL_PADDING + AXIS_PADDING;
            int x1 = MARKER_WIDTH + AXIS_PADDING + LABEL_PADDING;
            int y0 = getHeight() - (  (i * (getHeight() - AXIS_PADDING * 2 - LABEL_PADDING)) / (Y_LABEL_SAMPLES-1) + AXIS_PADDING + LABEL_PADDING  );
            int y1 = y0;
            graphics2D.setColor(Color.GRAY);
            graphics2D.drawLine(AXIS_PADDING + LABEL_PADDING + 1 + MARKER_WIDTH, y0, getWidth() - AXIS_PADDING, y1);
            graphics2D.setColor(Color.BLACK);

            double number = Math.round(labelsList.get("yLabels").get(i) * 100);
            number = number/100;

            String yLabel =   String.valueOf(number);
            FontMetrics metrics = graphics2D.getFontMetrics();
            int labelWidth = metrics.stringWidth(yLabel);
            graphics2D.drawString(yLabel, x0 - labelWidth - 5, y0 + (metrics.getHeight() / 2) - 3);
            graphics2D.drawLine(x0, y0, x1, y1);
        }


        // x axis - grid and markers
        for (int i = 0; i < X_LABEL_SAMPLES; i++) {
            int x0 =  (  (i * (getWidth() - AXIS_PADDING * 2 - LABEL_PADDING)) / (X_LABEL_SAMPLES-1) + AXIS_PADDING + LABEL_PADDING  );
            int x1 = x0;
            int y0 = getHeight() - AXIS_PADDING - LABEL_PADDING;
            int y1 = y0 - MARKER_WIDTH;
            graphics2D.setColor(Color.GRAY);
            graphics2D.drawLine(x0, getHeight() - AXIS_PADDING - LABEL_PADDING - 1 - MARKER_WIDTH, x1, AXIS_PADDING);
            graphics2D.setColor(Color.BLACK);

            double number = Math.round(labelsList.get("xLabels").get(i) * 100);
            number = number/100;

            String xLabel = String.valueOf(number);
            FontMetrics metrics = graphics2D.getFontMetrics();
            int labelWidth = metrics.stringWidth(xLabel);
            graphics2D.drawString(xLabel, x0 - labelWidth / 2, y0 + metrics.getHeight() + 3);
            graphics2D.drawLine(x0, y0, x1, y1);
        }


        // drawing xAxis and yAxis
        graphics2D.drawLine(AXIS_PADDING + LABEL_PADDING, getHeight() - AXIS_PADDING - LABEL_PADDING,
                                                    AXIS_PADDING + LABEL_PADDING, AXIS_PADDING);
        graphics2D.drawLine(AXIS_PADDING + LABEL_PADDING, getHeight() - AXIS_PADDING - LABEL_PADDING,
                                                    getWidth() - AXIS_PADDING, getHeight() -
                                                                                AXIS_PADDING - LABEL_PADDING);

        Map<String, ArrayList<Double>> pointsValuesList = PolyHelper.calculatePoly(xMax, xMin, samples, int2doubleArr(coef));

        graphics2D.setColor(Color.BLUE);
        for (int i = 0 ; i < pointsValuesList.get("xValues").size()-1 ; i++) {
            System.out.println(pointsValuesList.get("xValues").get(i));
            System.out.println(pointsValuesList.get("yValues").get(i));
            double x1 = PolyHelper.normalizeXCord(pointsValuesList.get("xValues").get(i), xMax, xMin, samples, getWidth());
            double y1 = PolyHelper.normalizeYCord(pointsValuesList.get("yValues").get(i), yMax, yMin, samples, getHeight());
            double x2 = PolyHelper.normalizeXCord(pointsValuesList.get("xValues").get(i+1), xMax, xMin, samples, getWidth());
            double y2 = PolyHelper.normalizeYCord(pointsValuesList.get("yValues").get(i+1), yMax, yMin, samples, getHeight());
            System.out.println("x1 is " + x1 + " x2 is " + x2 + " y1 is " + y1 + " y2 is " + y2);
            graphics2D.drawLine((int) x1, (int) y1, (int) x2, (int) y2);
        }

        graphics2D.setColor(Color.YELLOW);
        for (int i = 0; i < pointsValuesList.get("xValues").size() ; i++) {
            double x = PolyHelper.normalizeXCord(pointsValuesList.get("xValues").get(i), xMax, xMin, samples, getWidth()) - BULLET_RADIUS / 2;
            double y = PolyHelper.normalizeYCord(pointsValuesList.get("yValues").get(i), yMax, yMin, samples, getHeight()) - BULLET_RADIUS / 2;
            graphics2D.fillOval((int) x, (int) y, (int) BULLET_RADIUS, (int) BULLET_RADIUS);
        }

    }

    @Override
    public void propertyChange(PropertyChangeEvent evt) {

        System.out.println("Inside handler ");
        Object source = evt.getSource();
        if (source == samplesField) {
            int samplesIn = ((Number)samplesField.getValue()).intValue();
            System.out.println("Inside handler " + samplesIn);
            samples = samplesIn;
            repaint();
        }
        if (source == minField) {
            double xMinIn = ((Number)minField.getValue()).doubleValue();
            System.out.println("Inside handler " + xMinIn);
            xMin = xMinIn;
            repaint();
        }
        if (source == maxField) {
            double xMaxIn = ((Number)maxField.getValue()).doubleValue();
            System.out.println("Inside handler " + xMaxIn);
            xMax = xMaxIn;
            repaint();
        }


        if (source == x4Field) {
            int x4 = ((Number)x4Field.getValue()).intValue();
            System.out.println("Inside handler " + x4);
            coef[0] = x4;
            repaint();
        }
        if (source == x3Field) {
            int x3 = ((Number)x3Field.getValue()).intValue();
            System.out.println("Inside handler " + x3);
            coef[1] = x3;
            repaint();
        }
        if (source == x2Field) {
            int x2 = ((Number)x2Field.getValue()).intValue();
            System.out.println("Inside handler " + x2);
            coef[2] = x2;
            repaint();
        }
        if (source == x1Field) {
            int x1 = ((Number)x1Field.getValue()).intValue();
            System.out.println("Inside handler " + x1);
            coef[3] = x1;
            repaint();
        }
        if (source == x0Field) {
            int x0 = ((Number)x0Field.getValue()).intValue();
            System.out.println("Inside handler " + x0);
            coef[4] = x0;
            repaint();
        }

    }

    public double [] int2doubleArr(int [] arr) {
        double [] values = new double[arr.length];
        for( int i = 0; i < arr.length ; i++){
            values[i] = (double) arr[i];
        }
        return values;
    }



}
