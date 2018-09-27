trigger createPositionOnTargetOrg on Position__c (after update) {
    for(Position__c position: Trigger.new){
       //User recruiter = [select Name, Email from User where id =: position.Hiring_Manager__c];
       //String managerName = recruiter.Name;
       if(position.Status__c == 'Open' || (position.Status__c == 'Open' && position.Approval_Status__c == 'Approved')){
           System.debug('show me external id: ' + position.Legacy_Position_Number__c);
           SendPositionUsingRestApi.createJobAdvertisement(position.id);
           //SendPositionUsingRestApi.updateJobAdvertisement(position.id);
       }
    }
}