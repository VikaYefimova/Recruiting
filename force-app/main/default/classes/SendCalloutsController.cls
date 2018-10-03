public with sharing class SendCalloutsController {
    public Authorization_setting__c authorizationSetting {get; set;}
    public String settingName;
    public boolean newSettingflag {get; set;}
    public boolean approvedPositionFlag {get; set;}
    public boolean postingFlag {get; set;}
    public boolean afterDeleteFlag {get; set;}
    public String positionId;
    public String message {get; set;}
    public SendCalloutsController(ApexPages.StandardController controller){
        positionId = controller.getId();
        Position__c currentPosition = getCurrentPosition(positionId);
        newSettingflag = false;
        getSettingsList();
        this.authorizationSetting = new Authorization_setting__c();
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
        //currentPosition.
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
        Position__c currentPosition = getCurrentPosition(positionId);
        Authorization_setting__c currentSetting = [select Name, Login__c from Authorization_setting__c where id =: settingName];
        String settingTitle = currentSetting.Login__c;
        currentPosition.Posting_Setting__c = settingName;
        update currentPosition;
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
    public String getSettingName(){
        return settingName;
    }
    public void setSettingName(String settingName){
        this.settingName = settingName;
    }
    public Position__c getCurrentPosition(id posId){
        Position__c currentPosition = [select id, Posting_Status__c, Status__c, Approval_Status__c from Position__c where id=: posId];
        return currentPosition;
    }
}