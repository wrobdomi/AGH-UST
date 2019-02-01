package com.dominik;

public class Main {

    public static void main(String[] args) {

        A aObj = new A(0,"");
        B bObj = new B(10, "");
        C cObj = new C(20, "");

        aObj.callChangeName();
        System.out.println("\n");

        aObj.callDecrement();
        System.out.println("\n");

        aObj.callIncrement();
        System.out.println("\n");

        bObj.callChangeName();
        System.out.println("\n");

        bObj.callDecrement();
        System.out.println("\n");

        bObj.callIncrement();
        System.out.println("\n");

        cObj.callChangeName();
        System.out.println("\n");

        cObj.callDecrement();
        System.out.println("\n");

        cObj.callIncrement();
        System.out.println("\n");


    }
}
