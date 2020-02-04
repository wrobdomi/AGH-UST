package com.dominik;

import javax.swing.*;
import java.awt.*;
import java.awt.geom.Ellipse2D;

public class Circle extends Shape{

    private double radius;
    private int xCord;
    private int yCord;

    private Ellipse2D ellipse2D;

    public Circle(double radius, int xCord, int yCord) {
        this.radius = radius;
        this.xCord = xCord;
        this.yCord = yCord;
    }

    @Override
    public void resetCords(int dx, int dy){
        xCord += dx;
        yCord += dy;
    }

    @Override
    public boolean areCordsInside(int x, int y) {
            return ellipse2D.getBounds2D().contains(x,y);
    }


    @Override
    public void draw() {
        System.out.println("Drawing circle");
    }

    @Override
    public double area() {
        return 3.14 * radius * radius;
    }

    @Override
    public void draw(Graphics graphics) {

        Graphics2D graphics2D = ( Graphics2D ) graphics;
        // first and second argument are coordinates of the left corner of
        // framing rectangle of this Ellipse2D
        ellipse2D = new Ellipse2D.Double(xCord - radius, yCord - radius, radius, radius);
        graphics2D.draw(ellipse2D);
    }


}
