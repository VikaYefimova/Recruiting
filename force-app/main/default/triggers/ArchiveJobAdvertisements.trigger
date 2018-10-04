trigger ArchiveJobAdvertisements on Position__c (after update) {
    for (Position__c position : Trigger.new){
        for (Position__c oldPosition: Trigger.old){
            if(position.Status__c == 'Closed' && position.Status__c != oldPosition.Status__c){
                SendPositionUsingRestApi.updateJobAdvertisement(position.Id);
            }        
        }
    }
}