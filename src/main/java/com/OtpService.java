package com;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class OtpService {

    public static void sendOtpToEmail(String userEmail, String otp) throws MessagingException {
    	
    	
        final String username = "cpn5betting@gmail.com"; // Set your Gmail username 
        final String password = "ftnp hope csss dbhe"; // Set your Gmail password
        
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(username));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
        message.setSubject("Your OTP for Verification");
        message.setText("Your OTP is: " + otp);

        Transport.send(message);

        System.out.println("OTP sent to " + userEmail);
    }

    public static String generateOTP() {
        // Generate a 6-digit random OTP
        Random random = new Random();
        int otpValue = 100000 + random.nextInt(900000);
        return String.valueOf(otpValue);
    }
}
