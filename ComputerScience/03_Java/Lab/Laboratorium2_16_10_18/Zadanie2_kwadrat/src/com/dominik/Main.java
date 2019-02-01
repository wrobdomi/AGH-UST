package com.dominik;

public class Main {

    public static void main(String[] args) {

        Kwadrat kwadratJeden = new Kwadrat(10);
        System.out.println("Bok kwadratuJeden to " + kwadratJeden.getA());
        System.out.println("Pole kwadratuJeden to " + kwadratJeden.area());

        Kwadrat kwadratDwa = new Kwadrat(50);
        System.out.println("Bok kwadratuDwa to " + kwadratDwa.getA());
        System.out.println("Pole kwadratuDwa to " + kwadratDwa.area());

        System.out.println("Porowania kwadratJeden.isBigger(kwadratDwa) daje " + kwadratJeden.isBigger(kwadratDwa));
    }
}
