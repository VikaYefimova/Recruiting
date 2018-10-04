public with sharing class SendCalloutsController {
    public List_Setting__c authorizationSetting {get; set;}
    public String settingName;
    public boolean newSettingAfterChangeflag {get; set;}
    public boolean approvedPositionFlag {get; set;}
    public boolean postingFlag {get; set;}
    public boolean afterDeleteFlag {get; set;}
    public String positionId;
    public String message {get; set;}
    public SendCalloutsController(ApexPages.StandardController controller){
        positionId = controller.getId();
        Position__c currentPosition = getCurrentPosition(positionId);
        newSettingAfterChangeflag = false;
        afterChangeFlag = false;
        authorizationSetting = List_Setting__c.getOrgDefaults();
        if(currentPosition.Status__c == 'Open' && currentPosition.Approval_Status__c == 'Approved'){
            approvedPositionFlag = true;
        }
        else {
            approvedPositionFlag = false;
        }
        if(currentPosition.Posting_Status__c == 'Posting successfully' || currentPosition.Posting_Status__c == 'Updating successfully' 
           || currentPosition.Posting_Status__c == 'Error updating' || currentPosition.Posting_Status__c == 'Error deleting' ){
            postingFlag = true;
        }
        else if(currentPosition.Posting_Status__c == 'Error posting'){
            SendPositionUsingRestApi pos = new SendPositionUsingRestApi();
            postingFlag = false;
        }
        else postingFlag = false;
        if(currentPosition.Posting_Status__c == 'Deleting successfully'){
            afterDeleteFlag = true;
        }
    }
    public PageReference save(){
        system.debug('i am in save. authorizationSetting='+ authorizationSetting);
        upsert authorizationSetting;
        newSettingAfterChangeflag = true;
        afterChangeFlag = false;
        Position__c currentPosition = getCurrentPosition(positionId);
        currentPosition.Posting_Status__c = '';
		return null;
    }
    public PageReference createButtonAction(){
        afterChangeFlag = true;
        System.debug(authorizationSetting);
        return null;
    }
    public PageReference cancel(){
        afterChangeFlag = false;
        return null;
    }
    public PageReference postJobAdvertisement(){
        System.debug(authorizationSetting);
        System.debug('show me setting id: ' + authorizationSetting);
        SendPositionUsingRestApi.createJobAdvertisement(positionId);
        postingFlag = true;
        Position__c currentPosition = getCurrentPosition(positionId);
        afterChangeFlag = false;
        newSettingAfterChangeflag = false;
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + positionId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    public PageReference updateJobAdvertisement(){
        SendPositionUsingRestApi.updateJobAdvertisement(positionId);
        postingFlag = true;
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + positionId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    public PageReference deleteJobAdvertisement(){
        System.debug(authorizationSetting);
        SendPositionUsingRestApi.deleteJobAdvertisement(positionId);
        Position__c currentPosition = getCurrentPosition(positionId);
        if(currentPosition.Status__c == 'Deleting successfully'){
            afterDeleteFlag = true;
        }
        else afterDeleteFlag = false;
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + positionId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    public Position__c getCurrentPosition(id posId){
        Position__c currentPosition = [select id, Posting_Status__c, Status__c, Approval_Status__c from Position__c where id=: posId];
        return currentPosition;
    }
}