package com.dominik;

public class Main {

    public static void main(String[] args) {

        Shape squareShape = new Square(5.0);
        squareShape.draw();
        System.out.println("calling area() squareShape: " + squareShape.area());

        Shape rectangleShape = new Rectangle(5.0, 10.0);
        rectangleShape.draw();
        System.out.println("calling area() rectangleShape: " + rectangleShape.area());

        Shape circleShape = new Circle(3.5);
        circleShape.draw();
        System.out.println("calling area() circleShape: " + circleShape.area());

        Shape triangleShape = new Triangle(5.0,3.0,4.0);
        triangleShape.draw();
        System.out.println("calling area() triangleShape: " + triangleShape.area());

    }
}
