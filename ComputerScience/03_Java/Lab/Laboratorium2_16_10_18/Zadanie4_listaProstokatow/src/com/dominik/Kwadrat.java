package com.dominik;

public class Kwadrat {

    private double a;

    public Kwadrat(double a) {
        this.a = a;
    }

    public double getA() {
        return a;
    }

    public void setA(double a) {
        this.a = a;
    }

    public double area(){
        return this.a * this.a;
    }

    public boolean isBigger(Kwadrat kwadrat){
        return ( this.area() < kwadrat.area() );
    }



}
