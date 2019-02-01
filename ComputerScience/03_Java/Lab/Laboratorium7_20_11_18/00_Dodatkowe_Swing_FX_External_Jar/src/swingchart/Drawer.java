package swingchart;

import javax.swing.*;
import java.awt.*;


public class Drawer extends JFrame {

    public static void main(String[] args) {

        Drawer drawer = new Drawer();
        drawer.setSize(1400,1000);

        MyPanel myPanel = new MyPanel();

        myPanel.setPreferredSize(new Dimension(800, 600));

        drawer.add(myPanel);


        drawer.setVisible(true);
        drawer.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);


    }
}