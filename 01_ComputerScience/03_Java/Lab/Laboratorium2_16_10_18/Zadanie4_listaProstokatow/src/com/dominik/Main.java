package com.dominik;

import java.util.Locale;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

        Test test = new Test();


        boolean quit = true;
        while(quit){
            System.out.println("1 - wczytaj prostokat");
            System.out.println("2 - wyświetl wszystkie prostokaty");
            System.out.println("3 - oblicz sume pol wszystkich prostokatow");
            System.out.println("4 - zakoncz");
            Scanner scanner = new Scanner(System.in).useLocale(Locale.US);;
            System.out.println("Podaj liczbe: ");
            int choice = scanner.nextInt();
            switch(choice){
                case 1:
                    System.out.println("jeden");
                    System.out.println("Podaj bok a prostokata: ");
                    double a = scanner.nextDouble();
                    System.out.println("Podaj bok b prostokata: ");
                    double b = scanner.nextDouble();
                    Prostokat prostokat = new Prostokat(a,b);
                    test.dodajProstokat(prostokat);
                    break;
                case 2:
                    System.out.println("dwa");
                    test.wyswietlProstokaty();
                    break;
                case 3:
                    System.out.println("trzy");
                    double suma = test.sumaPol();
                    System.out.println("Obliczona suma pol to " + suma);
                    break;
                case 4:
                    System.out.println("cztery");
                    System.out.println("Konczenie programu");
                    quit = false;
                    break;
                default:
                    quit = false;
            }
        }

    }
}
