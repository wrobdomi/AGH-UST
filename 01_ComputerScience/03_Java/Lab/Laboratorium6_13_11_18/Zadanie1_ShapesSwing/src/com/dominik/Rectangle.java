package com.dominik;

import java.awt.*;
import java.awt.geom.Rectangle2D;

public class Rectangle extends Shape{

    private double sideOneLength;
    private double sideTwoLength;

    private int xCord;
    private int yCord;

    private Rectangle2D rectangle2D;

    public Rectangle(double sideOneLength, double sideTwoLength, int xCord, int yCord) {
        this.sideOneLength = sideOneLength;
        this.sideTwoLength = sideTwoLength;
        this.xCord = xCord;
        this.yCord = yCord;
    }

    @Override
    public void draw() {
        System.out.println("Drawing rectangle");
    }

    @Override
    public double area() {
        return sideOneLength * sideTwoLength;
    }

    @Override
    public void draw(Graphics graphics) {
        Graphics2D graphics2D = ( Graphics2D ) graphics;
        rectangle2D = new Rectangle2D.Double(xCord - (sideTwoLength/2), yCord - (sideOneLength/2), sideOneLength, sideTwoLength);
        graphics2D.draw(rectangle2D);
    }

    @Override
    public void resetCords(int dx, int dy) {
        xCord += dx;
        yCord += dy;
    }

    @Override
    public boolean areCordsInside(int x, int y) {
        return rectangle2D.getBounds2D().contains(x,y);
    }
}
