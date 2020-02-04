package com.dominik;

import java.io.*;

public class IOFilesHandling {

     public static String readFileToString(String filePath) {

        StringBuilder wordsInFile = new StringBuilder();
        try {
            BufferedReader br = new BufferedReader(new FileReader(filePath));
            String currentLine;
            while ((currentLine = br.readLine()) != null) {
                wordsInFile.append(currentLine).append("\n");
            }

            br.close();
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return wordsInFile.toString();
    }

    public static void saveStringToFile(String outputFile, String wordsInFile)
    {
        try {
            FileWriter fileWriter = new FileWriter(outputFile);

            BufferedWriter bufferWriter = new BufferedWriter(fileWriter);

            bufferWriter.write(wordsInFile);
            bufferWriter.newLine();

            bufferWriter.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
