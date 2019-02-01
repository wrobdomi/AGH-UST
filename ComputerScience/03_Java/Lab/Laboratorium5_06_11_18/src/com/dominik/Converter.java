package com.dominik;

import java.io.IOException;

public class Converter {

    /**
     *
     * @param input input file with text and frames
     * @param output file with delayed frames and text
     * @param delay delay ( miliseconds !!! )
     * @param fps frames per second
     */
    public static void delay(String input, String output, int delay, int fps) throws Exception{

        String filmContent;
        StringBuilder sb;
        StringBuilder sbOut;

        // because delay is specified in miliseconds and fps is 'frames / seconds'
        // then fps * delay must be divided by 1000
        int frameChange = ( fps * delay ) / 1000;
        // debugging: System.out.println(frameChange);

        // read film text content to string
        try{
            filmContent = IOFilesHandling.readFileToString(input);
        } catch (IOException e) {
            throw e;
        }

        // debugging : System.out.println(filmContent);
        // create StringBuilder to build output string
        sbOut = new StringBuilder();

        try {
            // check if first char of the file i '{'
            boolean checkFormat = (filmContent.charAt(0) == '{');
            if (!checkFormat) {
                throw new InvalidDVDFormatException("First char in file is " + filmContent.charAt(0) + ". Invalid file.");
            } else {
                // loop through the input string and look for exceptions
                for (int i = 0; i < filmContent.length(); i++) {

                    // if beginning of the start frame is detected
                    if (filmContent.charAt(i) == '{') {

                        i++;
                        sb = new StringBuilder();

                        // repeat until frame number is read
                        while (filmContent.charAt(i) != '}') {
                            if (Character.isDigit(filmContent.charAt(i))) { // check if char in frame number is digit
                                sb.append(filmContent.charAt(i));
                                i++;
                            } else { // invalid frame number, not digit char detected
                                sb.append(filmContent.charAt(i));
                                throw new InvalidFrameNumber("Number of frame is " + sb.toString() + ". Invalid number." );
                            }
                        }

                        // add frameChange and append new frame to output text
                        int startFrameNumber = Integer.parseInt(sb.toString());
                        String outStartFrame = '{' + String.valueOf(Integer.parseInt(sb.toString()) + frameChange) + '}';
                        sbOut.append(outStartFrame);
                        i++;

                        // there must be end frame after start frame
                        if (filmContent.charAt(i) == '{') {

                            i++;
                            sb = new StringBuilder();

                            // repeat until frame number is read
                            while (filmContent.charAt(i) != '}') {
                                if (Character.isDigit(filmContent.charAt(i))) { // check if char in frame number is digit
                                    sb.append(filmContent.charAt(i));
                                    i++;
                                } else { // invalid frame number, not digit char detected
                                    sb.append(filmContent.charAt(i));
                                    throw new InvalidFrameNumber("Number of frame is " + sb.toString() + ". Invalid number." );
                                }
                            }

                            // add frameChange and append new frame to output text
                            int endFrameNumber = Integer.parseInt(sb.toString());

                            if(endFrameNumber < startFrameNumber){
                                throw new InvalidFrameOrderException("Start frame number is " + startFrameNumber +
                                                                        " but end frame is " + endFrameNumber + ".Invalid data");
                            }

                            String outEndFrame = '{' + String.valueOf(Integer.parseInt(sb.toString()) + frameChange) + '}';
                            sbOut.append(outEndFrame);
                            i++;

                        } else {
                            throw new NoEndFrameException("Start frame is " + startFrameNumber + " but no end frame specified.");
                        }

                    } else {
                        sbOut.append(filmContent.charAt(i));
                    }

                }
            }
        }finally {
            sbOut.append("Invalid data");
        }


        // debugging: System.out.println(sbOut.toString());
        try{
            IOFilesHandling.saveStringToFile(output, sbOut.toString());
        } catch (IOException e){
            throw e;
        }


    }

}
