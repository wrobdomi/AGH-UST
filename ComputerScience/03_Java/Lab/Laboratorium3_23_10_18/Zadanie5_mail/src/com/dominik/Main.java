package com.dominik;

public class Main {

    public static void main(String[] args) {

       

        // validating email by using built-in javax.mail function - validate()
        try {
            EmailMessage emailMessage = EmailMessage.builder() // returns builder
                    .addFrom("help.software.learning@gmail.com")
                    .addTo("help.software.learing@gmail.com")
                    .addSubject("Email from Javaxmail")
                    .addContent("This is email sent during lab. 3  - Java classes")
                    .build(); // returns EmailMessage

            // printing emailMessage for debugging
            System.out.println(emailMessage.toString());

            // sending email using TLS
            emailMessage.send("enter your email password");
            }
        catch (NullPointerException ex){
            System.out.println("Invalid data entered. Check email address");
        }
		
		// ----------------------------------------------------------------------------------------------------- //
        // UWAGA:
        // Wyslanie emaila metoda send powoduje:
        // javax.mail.AuthenticationFailedException: 534-5.7.14 <https://accounts.google.com/signin/continue?sarp=1&scc=1&plt=AKgnsbvx
        // ... zabezpieczenia google
        // ----------------------------------------------------------------------------------------------------- //
		
    }
}
