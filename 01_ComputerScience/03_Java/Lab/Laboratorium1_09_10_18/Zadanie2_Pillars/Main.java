package com.dominik;

/**
 * Main class
 */
public class Main {

    public static void main(String[] args) {

        int numPillars;
        int distPillars;
        int widthPillars;

        do{
            System.out.println("Number of pillars ( more than 0 ): ");
            numPillars = App.getInt();
        } while( numPillars < 1 );

        do {
            System.out.println("Distance between pillars between 30 and 10 ( meters ): ");
            distPillars = App.getInt();
        } while( distPillars > 30 || distPillars < 10 );

        do{
            System.out.println("Width of a single pillar between 10 and 50 ( centimeters ) : ");
            widthPillars = App.getInt();
        } while( widthPillars > 50 || widthPillars < 10  );


        double result = PillarsCalc.calculateDistance(numPillars, distPillars, widthPillars);
        System.out.println("Overall distance betwwen first and last ( not including width of first and last ) is "
                + result);

    }
}
