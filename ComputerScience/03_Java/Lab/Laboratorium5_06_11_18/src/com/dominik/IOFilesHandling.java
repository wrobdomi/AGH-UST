package com.dominik;

import java.io.*;

public class IOFilesHandling {

     public static String readFileToString(String filePath) throws IOException{

        StringBuilder wordsInFile = new StringBuilder();
        BufferedReader br = null;
        try {
            br = new BufferedReader(new FileReader(filePath));
            String currentLine;
            while ((currentLine = br.readLine()) != null) {
                wordsInFile.append(currentLine).append("\n");
            }

            br.close();
        }
        finally {
            if( br != null) {
                    br.close();
            }
        }
        return wordsInFile.toString();
    }


    public static void saveStringToFile(String outputFile, String wordsInFile) throws IOException {

        BufferedWriter bufferWriter = null;

        try {
            FileWriter fileWriter = new FileWriter(outputFile);

            bufferWriter = new BufferedWriter(fileWriter);

            bufferWriter.write(wordsInFile);
            bufferWriter.newLine();

            bufferWriter.close();

        } finally {
            if(bufferWriter != null){
                bufferWriter.close();
            }
        }
    }

}
