package com.dominik;

public class Square extends Shape{

    private double sideLength;

    public Square(double sideLength) {
        super.edges = 4;
        this.sideLength = sideLength;
    }

    @Override
    public void draw() {
        System.out.println("Drawing square");
    }

    @Override
    public double area() {
        return sideLength * sideLength;
    }


}
