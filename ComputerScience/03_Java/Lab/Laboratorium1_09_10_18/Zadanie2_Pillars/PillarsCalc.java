package com.dominik;

/**
 * Calculations for pillars
 */
public class PillarsCalc {

    /**
     * Calculates overall distance between first and last pillar
     * @param numPillars number of pillars
     * @param distPillars distance between pillars
     * @param widthPillars width of a single pillar
     * @return distance between first and last pillar
     */
    public static double calculateDistance(int numPillars, int distPillars, int widthPillars){

        if(numPillars==1){
            return 0;
        }

        double distance = ( (numPillars-2) * ( ((double) widthPillars)/100.0 ) ) +
                ((double) ( distPillars * (numPillars -1) ));
        return distance;
    }

}
