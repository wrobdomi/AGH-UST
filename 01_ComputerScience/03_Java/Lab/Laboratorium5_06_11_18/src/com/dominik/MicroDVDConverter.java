package com.dominik;

import java.io.IOException;

public class MicroDVDConverter {

    public static void main(String[] args) {

        try {
            Converter.delay("gravity.txt", "movedgravity.txt", 30, 1000);
        }
        catch (IOException e) {     // handling exception generated while reading / writing file
            e.printStackTrace();    // FileNotFound extend IOException so this catch handles both
        }
        catch (InvalidDVDFormatException e){    // invalid file format, first char != '{'
            System.out.println(e.getMessage()); // printing line with error
            e.printStackTrace();                // printing number of this line and exception type
        }
        catch (InvalidFrameNumber e){           // invalid frame number, for example
            System.out.println(e.getMessage()); // {666%$378}
            e.printStackTrace();
        }
        catch(NoEndFrameException e){
            System.out.println(e.getMessage()); // no end frame detected, for example
            e.printStackTrace();                // {123456}adwadwawadwa
        }
        catch(InvalidFrameOrderException e){    // invalid frame order, for example
            System.out.println(e.getMessage()); // {123}{5678}
            e.printStackTrace();
        }
        catch (Exception e) {                   // all other exceptions, unknown exception
            System.out.println("Unknown exception occurred.");
            e.printStackTrace();
        }

    }
}