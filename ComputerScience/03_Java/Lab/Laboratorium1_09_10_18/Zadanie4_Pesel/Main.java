package com.dominik;

public class Main {

    public static void main(String[] args) {

        System.out.println("Enter your Pesel number: ");
        String peselNum = App.getString();
        Pesel pesel = new Pesel(peselNum);
        if(pesel.checkPesel()){
            System.out.println("Correct number");
        }
        else{
            System.out.println("You entered invalid pesel number");
        }

    }
}
