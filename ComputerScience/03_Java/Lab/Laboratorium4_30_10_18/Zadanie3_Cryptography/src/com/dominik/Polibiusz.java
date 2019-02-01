package com.dominik;

public class Polibiusz implements Algorithm{

    private static final int[] codeArr = {
                            11,12,13,14,15,21,22,23,24,
                            25,31,32,33,34,35,41,42,43,
                            44,45,51,52,53,54,55};

    private static final char[] alphaSet = {
                'A','B','C','D','E','F','G','I','J','K',
                'L','M','N','O','P','Q','R','S','T','U',
                'V','W','X','Y','Z'};

    public String crypt(String wordToEncode) {
        StringBuilder sb = new StringBuilder();
        wordToEncode = wordToEncode.toUpperCase();
        for (int i=0; i<wordToEncode.length() ; i++) {
            char c = wordToEncode.charAt(i);
            int cAscii= 0;
            int index = 0;
            String result = "";

            if(c >= 'A' && c <= 'Z') {
                if(c == 'I' || c == 'J')
                    result = "24";
                else if(c > 'J') {
                    index = (c - 'A' - 1);
                    result = String.valueOf(codeArr[index]);
                }
                else {
                    index = (c - 'A');
                    result = String.valueOf(codeArr[index]);
                }
                sb.append(result);
            }
            else
                sb.append(c);
        }
        return sb.toString();
    }

    public String decrypt(String wordToDecode) {

        StringBuilder sb = new StringBuilder();

        for(int i=0; i < wordToDecode.length() ; i++){

            char c = wordToDecode.charAt(i);
            if(c != ' ' && c != '\n') {
                int k = Integer.parseInt(String.valueOf(wordToDecode.charAt(i)));
                i++;
                int m = Integer.parseInt(String.valueOf(wordToDecode.charAt(i)));
                sb.append( alphaSet[k*5 - (6-m)] );
            }
            else {
                sb.append(c);
            }
        }
        return sb.toString();
    }


}
