package com.dominik;

public class Main {

    public static void main(String[] args) {

        System.out.println("Enter one positive number:");
        int n = App.getInt();
        System.out.println("Your n is " + n);
        int [] resultArr = OddNumbers.findOdd(n);
        System.out.println("Odd numbers lower than n are: ");
        for(int i = 0 ; i < resultArr.length ; i++){
            System.out.println(resultArr[i] + " ");
        }

    }
}
