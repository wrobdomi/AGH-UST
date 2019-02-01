package com.dominik;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

/**
 * Gets String or Int from user
 */
public class App {

    /**
     * Gets string from user
     * @return users String
     */
    public static String getString(){
        String text = null;
        try
        {
            InputStreamReader rd = new InputStreamReader(System.in);
            BufferedReader bfr =  new BufferedReader(rd);
            text = bfr.readLine();
        }
        catch (IOException e){
            e.printStackTrace();
        }
        return text;
    }


    /**
     * Gets int from user
     * @return users int
     */
    public static int getInt(){
        int myInt;
        Scanner in = new Scanner(System.in);
        myInt = in.nextInt();
        return myInt;
    }


    /**
     * Asks user for name and prints HelloWorld
     * @param args
     */
    public void Start(String[] args){
        System.out.print("Type your name: ");
        String name = App.getString();
        System.out.println("Hello World");
        System.out.println("And hello " +name);
    }

}
