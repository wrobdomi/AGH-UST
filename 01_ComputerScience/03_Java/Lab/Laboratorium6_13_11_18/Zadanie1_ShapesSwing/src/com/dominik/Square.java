package com.dominik;

import java.awt.*;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;

public class Square extends Shape{

    private double sideLength;
    private int xCord;
    private int yCord;

    private Rectangle2D rectangle2D;

    public Square(double sideLength, int xCord, int yCord) {
        this.sideLength = sideLength;
        this.xCord = xCord;
        this.yCord = yCord;
    }

    @Override
    public void draw() {
        System.out.println("Drawing square");
    }

    @Override
    public double area() {
        return sideLength * sideLength;
    }

    @Override
    public void draw(Graphics graphics) {
        Graphics2D graphics2D = ( Graphics2D ) graphics;
        rectangle2D = new Rectangle2D.Double(xCord - (sideLength/2), yCord - (sideLength/2), sideLength, sideLength);
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
