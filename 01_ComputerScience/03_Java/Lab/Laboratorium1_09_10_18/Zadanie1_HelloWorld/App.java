package com.dominik;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class App {

    public static String getString(){
        String text = null;
        try
        {
            InputStreamReader rd = new InputStreamReader(System.in); // for wrapping
            BufferedReader bfr = new BufferedReader(rd); // Wrapper
            text = bfr.readLine(); // reads one line, returns String
        }
        catch (IOException e){
            e.printStackTrace();
        }
        return text;
    }

    public void Start(String[] args){
        System.out.print("Type your name: ");
        String name = App.getString();
        System.out.println("Hello World");
        System.out.println("And hello " +name);
    }

}
