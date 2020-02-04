package com.dominik;

import java.awt.*;

public class Triangle extends Shape{

    private double sideOneLength;
    private double sideTwoLength;
    private double sideThreeLength;
    private static int edges = 3;
    private Polygon polygon;

    private int [] xCords;
    private int [] yCords;

    public Triangle(int[] xCords, int[] yCords) {
        this.xCords = xCords;
        this.yCords = yCords;
    }

    @Override
    public void draw() {
        System.out.println("Drawing triangle");
    }

    @Override
    public double area() {
        double p = 0.5 * ( sideOneLength + sideTwoLength + sideThreeLength);
        return ( Math.sqrt( p*(p-sideOneLength)*(p-sideTwoLength)*(p-sideThreeLength)) );
    }

    @Override
    public void draw(Graphics graphics) {
        Graphics2D graphics2D = ( Graphics2D ) graphics;
        polygon = new Polygon(xCords, yCords, edges);
        graphics2D.draw(polygon);
    }

    @Override
    public void resetCords(int dx, int dy) {
        for( int i = 0 ; i < xCords.length ; i++){
            xCords[i] += dx;
            yCords[i] += dy;
        }
    }

    @Override
    public boolean areCordsInside(int x, int y) {
        return polygon.contains(x,y);
    }

}
