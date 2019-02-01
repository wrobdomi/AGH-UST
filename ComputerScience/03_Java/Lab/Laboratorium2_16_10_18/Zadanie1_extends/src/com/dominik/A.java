package com.dominik;

public class A {

    protected int number;
    String name;

    public A(int number, String name) {
        this.number = number;
        this.name = name;
        System.out.println("Inside A constructor");
    }

    public void callDecrement(){
        System.out.println("Inside callDecrement Class A");
        decrement();
    }

    public void callChangeName(){
        System.out.println("Inside callChangeName Class A");
        changeName();
    }

    public void callIncrement(){
        System.out.println("Inside callIncrement Class A");
        increment();
    }

    private void increment(){
        System.out.println("Inside increment private Class A");
        number++;
    }

    protected void decrement(){
        System.out.println("Inside decrement protected Class A");
        number--;
    }

    void changeName(){
        System.out.println("Inside change name package Class A");
        this.name = "Nama from Class A";
    }

}
