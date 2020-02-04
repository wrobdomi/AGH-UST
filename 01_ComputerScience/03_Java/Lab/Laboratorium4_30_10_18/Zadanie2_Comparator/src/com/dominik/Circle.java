package com.dominik;

public class Circle extends  Shape{

    private double radius;

    public Circle(double radius) {
        super.edges = 0;
        this.radius = radius;
    }

    @Override
    public void draw() {
        System.out.println("Drawing circle");
    }

    @Override
    public double area() {
        return 3.14 * radius * radius;
    }

}
