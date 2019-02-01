package com.dominik;

public class B extends A {

    public B(int number, String name) {
        super(number, name);
        System.out.println("Inside B constructor");
    }

    @Override
    protected void decrement() {
        System.out.println("Inside decrement Class B");
        super.number = super.number - 2;
    }

    @Override
    void changeName() {
        System.out.println("Inside changeName class B");
        super.name = "Name from Class B";
    }

    private void increment(){
        System.out.println("Inside increment class B");
        super.number =   super.number + 2;
    }

}
