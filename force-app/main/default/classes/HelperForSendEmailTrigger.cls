public class HelperForSendEmailTrigger {
    public void sendEmail(List<Position__c> positions){
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        List<Profile> profiles = new List<Profile>([SELECT Id FROM Profile WHERE Name IN ('Recruiter: NonTechnical', 'Recruiter: Technical')]); // this request is independent of the cycle
        Set<id> profilesID = new Set<Id>();
        for(Profile prof : profiles){
            profilesID.add(prof.Id);
        }
        List<User> users = [select Email from User where ProfileId IN :profilesID];
        List<String> usersEmails = new List<String>();
        for (User user : users){
            usersEmails.add(user.Email);
        }
        
        for(Position__c position : positions){
            String recordlink = URL.getSalesforceBaseUrl().toExternalForm()+'/'+position.Id;
            String mailBody = 'New position: ' + recordlink + ' was opened!'; 
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(usersEmails);
            mail.setSubject('New Position');
            mail.setHtmlBody(mailBody);
            mails.add(mail);
        }
        // all the commented code should not be presented in the final version of the code (it should be removed) - you can leave it for now (if it helps you in some way)
        Messaging.sendEmail(mails);
    }
}