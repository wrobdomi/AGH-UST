package com.dominik;

public class OddNumbers {

    public static int [] findOdd(int n){
        int [] myArr = new int[n/2];
        myArr[0] = 1;
        for( int i = 1 ; i < n/2 ; i++) {
            myArr[i] = myArr[i-1] + 2;
        }
        return myArr;
    }

}
