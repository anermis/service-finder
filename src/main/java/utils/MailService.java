package utils;

import org.simplejavamail.email.Email;
import org.simplejavamail.email.EmailBuilder;
import org.simplejavamail.mailer.MailerBuilder;

/**
 * @author tsamo
 */
public class MailService {
    public void sendMail(String receiverMail, String subject, String text) {
        Email email = EmailBuilder.startingBlank()
                .from("Awesome Inc.", "throwawayTsamo@hotmail.com")
                .to(receiverMail)
                .withSubject(subject)
                .withPlainText(text)
                .buildEmail();

        MailerBuilder
                .withSMTPServer("smtp-mail.outlook.com", 587, "throwawayTsamo@hotmail.com", "1234567890!@#$%^&*()")
                .buildMailer()
                .sendMail(email);
    }
}
