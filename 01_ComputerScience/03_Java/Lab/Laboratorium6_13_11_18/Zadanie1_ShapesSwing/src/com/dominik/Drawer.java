package com.dominik;

import javax.swing.*;


public class Drawer extends JFrame {

    public static void main(String[] args) {

        Drawer drawer = new Drawer();
        drawer.setSize(450,450);

        MyPanel myPanel = new MyPanel();

        drawer.add(myPanel);


        drawer.setVisible(true);
        drawer.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


    }
}
