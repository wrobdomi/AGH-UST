package com.dominik;

public class Cryptographer {

    public static void cryptfile(String inputFile, String encodedFile, Algorithm algorithm) {

        String encoded = algorithm.crypt(IOFilesHandling.readFileToString(inputFile));
        IOFilesHandling.saveStringToFile(encodedFile, encoded);

    }

    public static void decryptfile(String inputFile, String decodedFile, Algorithm algorithm) {

        String encoded = algorithm.decrypt(IOFilesHandling.readFileToString(inputFile));
        IOFilesHandling.saveStringToFile(decodedFile, encoded);

    }

}
