package com.dominik;

public class Main {

    public static void main(String[] args) {

        Prostokat prostokatJeden =  new Prostokat(10,10);
        System.out.println("Boki prostokatuJeden to " + prostokatJeden.getA() + " " + prostokatJeden.getB());
        System.out.println("Pole prostokatuJeden to " + prostokatJeden.area());

        Prostokat prostokatDwa =  new Prostokat(15,10);
        System.out.println("Boki prostokatuDwa to " + prostokatDwa.getA() + " " + prostokatDwa.getB());
        System.out.println("Pole prostokatuDwa to " + prostokatDwa.area());

        System.out.println("Porowania kwadratJeden.isBigger(kwadratDwa) daje " + prostokatJeden.isBigger(prostokatDwa));

    }
}
