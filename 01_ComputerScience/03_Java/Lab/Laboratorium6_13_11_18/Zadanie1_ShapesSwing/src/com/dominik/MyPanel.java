package com.dominik;

import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.awt.event.MouseMotionListener;
import java.util.ArrayList;

public class MyPanel extends JPanel implements MouseListener, MouseMotionListener {

    int xCursor;
    int yCursor;

    ArrayList<Shape> myShapes;

    public MyPanel() {
        addMouseListener(this);
        addMouseMotionListener(this);
        myShapes = new ArrayList<>();
        myShapes.add(new Circle(25, 50,50));
        myShapes.add(new Circle(15,50,30));
        myShapes.add(new Circle(35,150,150));
        myShapes.add(new Circle(50,300,300));
        myShapes.add(new Square(30, 80, 80));
        myShapes.add(new Square(15, 150, 150));
        myShapes.add(new Square(20, 320, 100));
        myShapes.add(new Square(25, 300, 280));
        myShapes.add(new Rectangle(25,30,79,180));
        myShapes.add(new Rectangle(5,55,30,220));
        myShapes.add(new Rectangle(70,35,150,120));
        myShapes.add(new Rectangle(25,90,120,280));
        myShapes.add(new Triangle(new int[]{10,60,80}, new int[]{80, 120, 180}));
        myShapes.add(new Triangle(new int[]{90,120,180}, new int[]{30, 300, 80}));
        myShapes.add(new Triangle(new int[]{180,60,80}, new int[]{150, 120, 180}));
        myShapes.add(new Triangle(new int[]{20,60,80}, new int[]{80, 90, 30}));

    }

    @Override
    public void paint(Graphics g) {
        super.paint(g);
        for(Shape shape : myShapes){
            shape.draw(g);
        }
    }


    @Override
    public void mousePressed(MouseEvent e) {
        xCursor = e.getX();
        yCursor = e.getY();
    }


    @Override
    public void mouseClicked(MouseEvent e) {

    }

    @Override
    public void mouseReleased(MouseEvent e) {

    }

    @Override
    public void mouseEntered(MouseEvent e) {

    }

    @Override
    public void mouseExited(MouseEvent e) {

    }

    @Override
    public void mouseDragged(MouseEvent e) {
        int dx = e.getX() - xCursor;
        int dy = e.getY() - yCursor;

        for( Shape myShape : myShapes ){
            if (myShape.areCordsInside(xCursor, yCursor)) {
                myShape.resetCords(dx, dy);
            }
        }

        repaint();

        xCursor += dx;
        yCursor += dy;
    }



    @Override
    public void mouseMoved(MouseEvent e) {

    }
}
