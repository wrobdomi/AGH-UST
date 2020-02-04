package com.dominik;

import java.util.Comparator;

public class ShapeComparator implements Comparator<Shape> {

    @Override
    public int compare(Shape o1, Shape o2) {
        if(o1.getEdges() > o2.getEdges() )
            return 1;
        if(o1.getEdges() == o2.getEdges() )
            return 0;
        if(o1.getEdges() < o2.getEdges() )
            return -1;
        return 0;
    }
}
