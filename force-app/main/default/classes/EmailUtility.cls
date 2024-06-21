public class EmailUtility {

    public static void sendEmail(){
       
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        List<String> toAddress=new List<String>();
        toAddress.add('girishraju2025@gmail.com');
        
        List<String> toBCAddress=new List<String>();
        toBCAddress.add('girishraju27@gmail.com');
        
        email.setSubject('My First Email from Salesforce');
        email.setPlainTextBody('Hello Dear, My First email from Salesforce ...');
        email.setToAddresses(toAddress);
        email.setBccAddresses(toBCAddress);
        
        List<Messaging.SingleEmailMessage> emailMessages=new List<Messaging.SingleEmailMessage>();
        emailMessages.add(email);
        
        List<Messaging.SendEmailResult> sendEmailResults = Messaging.sendEmail(emailMessages,false);
        for(Messaging.SendEmailResult sr : sendEmailResults){
            Boolean isSuccess=sr.isSuccess();
            if(isSuccess){
               System.debug('Email Sent Successfully !');
            }else{
                System.debug('Error while sending Email');
                List<Messaging.SendEmailError> errors=sr.getErrors();
                System.debug(errors);
            }
            
        }        
        
    }
}