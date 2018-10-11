public with sharing class SendCalloutsController {
    public List_Setting__c authorizationSetting {get; set;}
    public string position {get; set;}
    public String settingName;
    public boolean newSettingAfterChangeflag {get; set;}
    public boolean approvedPositionFlag {get; set;}
    public boolean postingFlag {get; set;}
    public boolean afterChangeFlag {get; set;}
    public boolean afterDeleteFlag {get; set;}
    public String positionId;
    
    public SendCalloutsController(ApexPages.StandardController controller){
        positionId = controller.getId();
        //position.Id = positionId;
        Position__c currentPosition = getCurrentPosition(positionId);
        position = currentPosition.Posting_Setting__c;
        newSettingAfterChangeflag = false;
        afterChangeFlag = false;
        authorizationSetting = List_Setting__c.getOrgDefaults();
        if(currentPosition.Status__c == 'Open' && currentPosition.Approval_Status__c == 'Approved'){
            approvedPositionFlag = true;
        }
        else {
            approvedPositionFlag = false;
        }
        if(currentPosition.Posting_Status__c == 'Posted' ){
            postingFlag = true;
        }
        else if(currentPosition.Posting_Status__c == 'Not posted'){
            postingFlag = false;
        }
        if(currentPosition.Posting_Setting__c == 'Delete successfully'){
            afterDeleteFlag = true;
        }
    }
    public PageReference save(){
        upsert authorizationSetting;
        newSettingAfterChangeflag = true;
        afterChangeFlag = false;
		return null;
    }
    public PageReference createButtonAction(){
        afterChangeFlag = true;
        return null;
    }
    public PageReference cancel(){
        afterChangeFlag = false;
        return null;
    }
    public PageReference postJobAdvertisement(){
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
        Position__c currentPosition = getCurrentPosition(positionId);
        postingFlag = true; 
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + positionId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    public PageReference deleteJobAdvertisement(){
        SendPositionUsingRestApi.deleteJobAdvertisement(positionId);
        Position__c currentPosition = getCurrentPosition(positionId);
        if(currentPosition.Posting_Setting__c == 'Delete successfully'){
            afterDeleteFlag = true;
        }
        else if (currentPosition.Posting_Setting__c == 'Error deleting'){
            afterDeleteFlag = false;
        } 
        PageReference pageRef = new PageReference(URL.getSalesforceBaseUrl().toExternalForm() + '/' + positionId);
        pageRef.setRedirect(true);
        return pageRef;
    }
    public Position__c getCurrentPosition(id posId){
        Position__c currentPosition = [select id, Posting_Status__c, Posting_Setting__c, Status__c, Approval_Status__c from Position__c where id=: posId];
        return currentPosition;
    }
}