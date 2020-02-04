package com.dominik;

public class C extends B{

    public C(int number, String name) {
        super(number, name);
        System.out.println("Inside C constructor");
    }

    @Override
    void changeName(){
        System.out.println("Inside change name package Class C");
        super.name = "Name from Class C";
    }

}
