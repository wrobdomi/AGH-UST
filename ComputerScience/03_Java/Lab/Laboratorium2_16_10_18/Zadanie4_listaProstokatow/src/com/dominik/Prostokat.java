package com.dominik;

public class Prostokat extends Kwadrat{

    private double b;

    public Prostokat(double a, double b) {
        super(a);
        this.b = b;
    }

    public double getB() {
        return b;
    }

    public void setB(double b) {
        this.b = b;
    }

    @Override
    public double area() {
        return super.getA() * this.b;
    }

    public boolean isBigger(Prostokat prostokat) {
        return ( this.area() < prostokat.area() );
    }



}
