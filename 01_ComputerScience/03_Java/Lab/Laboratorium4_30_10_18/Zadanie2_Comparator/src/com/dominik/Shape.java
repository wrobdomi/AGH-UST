package com.dominik;

import java.util.Comparator;

public abstract class Shape  {

    public String name;
    public int edges;

    public abstract void draw();

    public abstract double area();



    public int getEdges() {
        return edges;
    }



}
