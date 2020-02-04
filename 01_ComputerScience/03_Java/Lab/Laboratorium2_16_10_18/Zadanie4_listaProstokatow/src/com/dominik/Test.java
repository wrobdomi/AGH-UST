package com.dominik;

import java.util.LinkedList;

public class Test {

    private LinkedList<Prostokat> listaProstokatow;

    public Test() {
        listaProstokatow = new LinkedList<Prostokat>();
    }


    public boolean dodajProstokat(Prostokat prostokat){
        listaProstokatow.add(prostokat);
        System.out.println("Dodano prostokat");
        return true;
    }

    public void wyswietlProstokaty(){
        for( Prostokat pr : listaProstokatow){

            System.out.println("-- Bok a prostokata to " + pr.getA() +
                        " a bok b prostokata to " + pr.getB() );
        }
    }


    public double sumaPol(){
        double suma = 0;
        for( Prostokat pr : listaProstokatow){

            suma += pr.area();
        }

        return suma;
    }

}
