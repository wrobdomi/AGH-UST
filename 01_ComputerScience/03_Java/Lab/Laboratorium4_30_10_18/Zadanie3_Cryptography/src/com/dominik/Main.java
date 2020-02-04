package com.dominik;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {

//        String one = "inputfile.txt";
//        String two = "outputfile.txt";

        boolean quit = false;
        while(!quit) {
            Scanner sc = new Scanner(System.in);

            System.out.println("Choose your algorithm");
            System.out.println("Enter 1 for ROT11");
            System.out.println("Enter 2 for Polibius");

            int choiceAlgo = sc.nextInt();

            System.out.println("Choose your file action: ");
            System.out.println("Enter 1 for Encryption");
            System.out.println("Enter 2 for Decryption");

            int choiceAction = sc.nextInt();

            if(choiceAlgo == 1 || choiceAlgo == 2) {

                if(choiceAlgo == 1 && choiceAction == 1)
                    Cryptographer.cryptfile(args[0], args[1], new ROT11());
                else if(choiceAlgo == 1 && choiceAction == 2)
                    Cryptographer.decryptfile(args[0], args[1], new ROT11());
                else if(choiceAlgo == 2 && choiceAction == 1)
                    Cryptographer.cryptfile(args[0], args[1], new Polibiusz());
                else if(choiceAlgo == 2 && choiceAction == 2)
                    Cryptographer.decryptfile(args[0], args[1], new Polibiusz());
                else
                    quit = true;
            }

            System.out.println("Enter 1 to quit the program");
            int end = sc.nextInt();
            if(end == 1)
                quit = true;
        }

    }
}
