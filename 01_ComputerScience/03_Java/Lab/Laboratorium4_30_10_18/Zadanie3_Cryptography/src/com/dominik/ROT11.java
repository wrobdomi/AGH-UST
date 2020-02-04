package com.dominik;

public class ROT11 implements Algorithm{

    static final char[] alphaSet = {
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
            'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
            'u', 'v', 'w', 'x', 'y', 'z',
            'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
            'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
            'U', 'V', 'W', 'X', 'Y', 'Z'
            };

    static final int rotation = 11;

    @Override
    public String crypt(String wordToEncode) {
        StringBuilder sb = new StringBuilder();
        for ( int i=0; i<wordToEncode.length() ; i++){
            char c = wordToEncode.charAt(i);
            System.out.println("Before: " + c);
            int cAscii= 0;
            char result = c;
            if ( c >= 'a' && c <= 'z'){
                if( c > 'o')
                    cAscii = ( c - 'p' ) + 'a';
                else
                    cAscii = c + rotation;
                result = (char) cAscii;
            }
            if ( c >= 'A' && c <= 'Z'){
                if( c > 'O')
                    cAscii = ( c - 'P' ) + 'A';
                else
                    cAscii = c + rotation;
                result = (char) cAscii;
            }
            sb.append(result);
            System.out.println("After:" + result);
        }
        return sb.toString();
    }

    @Override
    public String decrypt(String wordToDecode) {
        StringBuilder sb = new StringBuilder();
        for ( int i=0; i<wordToDecode.length() ; i++){
            char c = wordToDecode.charAt(i);
            System.out.println("Before: " + c);
            int cAscii=0;
            char result = c;
            if ( c >= 'a' && c <= 'z'){
                if( c > 'k')
                    cAscii = c - rotation ;
                else
                    cAscii = 'p' + (c - 'a');
                result = (char) cAscii;
            }
            if ( c >= 'A' && c <= 'Z'){
                if( c > 'K')
                    cAscii = c - rotation ;
                else
                    cAscii = 'P' + (c - 'A');
                result = (char) cAscii;
            }
            sb.append(result);
            System.out.println("After: " + result);
        }
        return sb.toString();
    }

}
