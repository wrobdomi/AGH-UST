package com.dominik;

import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.LinkedList;
import java.util.Properties;



public class EmailMessage {

    public String from; //required (must be e-mail)
    public LinkedList<String> to; //required at least one (must be e-mail)
    private String subject; //optional
    private String content; //optional
    private String mimeType;  // optional
    private LinkedList<String> cc; //optional
    private LinkedList<String> bcc; // optional

    // protected constructor -> user is unable to implicitly create EmailMessage instance,
    // forced to use builder instead
    protected EmailMessage( String fromArg, LinkedList<String> toArg, String subjectArg,
                            String contentArg, String mimeTypeArg, LinkedList<String> ccArg,
                            LinkedList<String> bccArg) {
        from = fromArg;
        to = toArg;
        subject = subjectArg;
        content = contentArg;
        mimeType = mimeTypeArg;
        cc = ccArg;
        bcc = bccArg;
    }

    // -------------------------------------------------------------------------- //
    // static inner class for creating emailMessage in an elegant way
    static public class Builder{
        String fromBuild;
        String subjectBuild;
        String contentBuild;
        String mimeTypeBuild;
        LinkedList<String> toBuild = new LinkedList<String>();
        LinkedList<String> ccBuild = new LinkedList<String>();
        LinkedList<String> bccBuild = new LinkedList<String>();

        // methods build EmailMessage by assigning values
        // to Builder inner fields, every method needs to return
        // this pointer in order to enable creating many calls
        // like Builder.addParamOne("").addParamTwo("").addParam()... and so on
        public Builder addFrom(String fromArg) {
            if(validateEmail(fromArg)){
                this.fromBuild = fromArg;
                return this;
            }
            return null;
        }

        public Builder addTo(String toArg) {
            if(validateEmail(toArg)){
                this.toBuild.add(toArg);
                return this;
            }
            return null;
        }

        public Builder addSubject(String subjectArg) {
            this.subjectBuild = subjectArg;
            return this;
        }

        public Builder addContent(String contentArg) {
            this.contentBuild = contentArg;
            return this;
        }

        public Builder addMimeType(String mimeTypeArg) {
            this.mimeTypeBuild = mimeTypeArg;
            return this;
        }

        public Builder addCC(String ccArg) {
            this.ccBuild.add(ccArg);
            return this;
        }

        public Builder addBCC(String bccArg) {
            this.bccBuild.add(bccArg);
            return this;
        }

        public EmailMessage build() {
            return new EmailMessage(fromBuild, toBuild, subjectBuild,
                                    contentBuild,mimeTypeBuild,ccBuild,bccBuild);
        }

        public static boolean validateEmail(String email) {
            boolean result = true;
            try {
                InternetAddress internetAddress = new InternetAddress(email);
                internetAddress.validate();
            } catch (AddressException ex) {
                result = false;
            }
            return result;
        }

    }
    // -------------------------------------------------------------------------- //

    // create new static Builder
    public static Builder builder() {
        return new EmailMessage.Builder();
    }


    // printing EmailMessage for debugging
    @Override
    public String toString() {
        return "EmailMessage{" +
                "from='" + from + '\'' +
                ", to=" + to +
                ", subject='" + subject + '\'' +
                ", content='" + content + '\'' +
                ", mimeType='" + mimeType + '\'' +
                ", cc=" + cc +
                ", bcc=" + bcc +
                '}';
    }


    public void send(final String password) {

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(from, password);
                    }
                });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(from));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to.getFirst()));
            message.setSubject(subject);
            message.setText(content);

            Transport.send(message);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }


}
