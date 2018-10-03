public with sharing class SendCalloutsController {
    public Authorization_setting__c authorizationSetting {get; set;}
    public String settingName {get; set;}
    public boolean newSettingflag {get; set;}
    public boolean approvedPositionFlag {get; set;}
    public boolean postingFlag {get; set;}
    public boolean afterDeleteFlag {get; set;}
    public String positionId;
    public String message {get; set;}
    public SendCalloutsController(ApexPages.StandardController controller){
        newSettingflag = false;
        getSettingsList();
        this.authorizationSetting = new Authorization_setting__c();
        positionId = controller.getId();
        Position__c currentPosition = getCurrentPosition(positionId);
        if(currentPosition.Status__c == 'Open' && currentPosition.Approval_Status__c == 'Approved'){
            approvedPositionFlag = true;
        }
        else approvedPositionFlag = false;
        if(currentPosition.Posting_Status__c == 'Posting successfully' || currentPosition.Posting_Status__c == 'Updating successfully' 
           || currentPosition.Posting_Status__c == 'Error updating' || currentPosition.Posting_Status__c == 'Error deleting' ){
            SendPositionUsingRestApi pos = new SendPositionUsingRestApi();
        	message = pos.getStatus();
            postingFlag = true;
        }
        else if(currentPosition.Posting_Status__c == 'Error posting'){
            SendPositionUsingRestApi pos = new SendPositionUsingRestApi();
        	message = pos.getStatus();
            postingFlag = false;
        }
        else postingFlag = false;
        if(currentPosition.Posting_Status__c == 'Deleting successfully'){
            afterDeleteFlag = true;
        }
    }
    public PageReference save(){
        system.debug('i am in save. authorizationSetting='+ authorizationSetting);
        insert authorizationSetting;
        settingName = authorizationSetting.Id;
        newSettingflag = false;
		return null;
    }
    public List<SelectOption> getSettingsList(){
        List<SelectOption> settingsList = new List<SelectOption>();
        List<Authorization_setting__c> settings = [select Name from Authorization_setting__c];
        for(Authorization_setting__c setting: settings){
            settingsList.add(new SelectOption(setting.id, setting.Name));
        }
        return settingsList;
    }
    public PageReference createButtonAction(){
        newSettingflag = true;
        System.debug(settingName);
        return null;
    }
    public PageReference cancel(){
        newSettingflag = false;
        return null;
    }
    public PageReference postJobAdvertisement(){
        System.debug(settingName);
        System.debug('show me setting id: ' + settingName);
        SendPositionUsingRestApi.createJobAdvertisement(positionId, settingName);
        postingFlag = true;
        return null;
    }
    public PageReference updateJobAdvertisement(){
        SendPositionUsingRestApi.updateJobAdvertisement(positionId, settingName);
        postingFlag = true;
        return null;
    }
    public PageReference deleteJobAdvertisement(){
        System.debug(settingName);
        SendPositionUsingRestApi.deleteJobAdvertisement(positionId, settingName);
        Position__c currentPosition = getCurrentPosition(positionId);
        if(currentPosition.Status__c == 'Deleting successfully'){
            afterDeleteFlag = true;
        }
        else afterDeleteFlag = false;
        return null;
    }
    public Position__c getCurrentPosition(id posId){
        Position__c currentPosition = [select id, Posting_Status__c, Status__c, Approval_Status__c from Position__c where id=: posId];
        return currentPosition;
    }
}