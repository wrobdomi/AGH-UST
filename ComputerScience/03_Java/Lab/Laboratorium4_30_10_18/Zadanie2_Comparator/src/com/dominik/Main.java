package com.dominik;

import java.util.Collections;

public class Main {

    public static void main(String[] args) {

        Shape squareShape = new Square(5.0);
        Shape rectangleShape = new Rectangle(5.0, 10.0);
        Shape circleShape = new Circle(3.5);
        Shape triangleShape = new Triangle(5.0,3.0,4.0);

        ShapesList shapeList = new ShapesList();

        shapeList.addShapeToList(squareShape);
        shapeList.addShapeToList(rectangleShape);
        shapeList.addShapeToList(circleShape);
        shapeList.addShapeToList(triangleShape);

        shapeList.printAllShapes();
        shapeList.printOneShape(2);

        System.out.println("== Sorting by number ef edges, using comparable and comparator ==");

        Collections.sort(shapeList.getShapesArrayList(), new ShapeComparator());
        shapeList.printAllShapes();

    }
}
