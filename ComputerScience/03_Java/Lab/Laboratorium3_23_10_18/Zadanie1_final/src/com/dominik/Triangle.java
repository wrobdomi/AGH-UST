package com.dominik;

public class Triangle extends Shape{

    private double sideOneLength;
    private double sideTwoLength;
    private double sideThreeLength;

    public Triangle(double sideOneLength, double sideTwoLength, double sideThreeLength) {
        this.sideOneLength = sideOneLength;
        this.sideTwoLength = sideTwoLength;
        this.sideThreeLength = sideThreeLength;
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
}
