package com.dominik;

public class Pesel {

    private static String pesel;


    public Pesel(String pesel) {
        this.pesel = pesel;
    }



    public static boolean checkPesel(){

        int [] coef = {9,7,3,1,9,7,3,1,9,7};
        int checkSum = 0;

        for(int i = 0 ; i < 10; i++){
            System.out.print(Integer.parseInt(pesel.substring(i,i+1)));
            checkSum += Integer.parseInt(pesel.substring(i,i+1)) * coef[i];
        }

        int i = checkSum % 10;
        System.out.println("This is checkSum: " + checkSum);

        return ( i == Integer.parseInt(pesel.substring(10,10+1)) );

    }

}
