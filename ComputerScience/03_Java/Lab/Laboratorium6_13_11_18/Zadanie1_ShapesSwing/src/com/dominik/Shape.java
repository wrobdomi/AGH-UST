package com.dominik;

import javax.swing.*;
import java.awt.*;

public abstract class Shape  {

    public String name;

    public abstract void draw();

    public abstract double area();

    public abstract void draw(Graphics graphics);

    public abstract void resetCords(int dx, int dy);

    public abstract boolean areCordsInside(int x, int y);



}
