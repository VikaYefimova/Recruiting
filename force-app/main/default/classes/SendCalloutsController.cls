public with sharing class SendCalloutsController {
    public Authorization_setting__c authorizationSetting {get; set;}
    public String settingName ;
    public boolean flag {get; set;}
    public String positionId;
    public String message {get; set;}
    public SendCalloutsController(ApexPages.StandardController controller){
        flag = false;
        getSettingsList();
        this.authorizationSetting = new Authorization_setting__c();
        //SendPositionUsingRestApi.settingId = settingName;
        positionId = controller.getId();
       SendPositionUsingRestApi pos = new SendPositionUsingRestApi();
        message = pos.getStatus();
        
    }
    public PageReference save(){
        system.debug('i am in save. authorizationSetting='+ authorizationSetting);
        insert authorizationSetting;
        settingName = authorizationSetting.Id;
        flag = false;
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
        flag = true;
        //SendPositionUsingRestApi.settingId = settingName;
        System.debug(settingName);
        return null;
    }
    public PageReference cancel(){
        flag = false;
        return null;
    }
    public String getSettingName(){
        return settingName;
    }
    public void setSettingName(String settingName){
        this.settingName = settingName;
    }
    public PageReference postJobAdvertisement(){
        Position__c position = [select id from Position__c where id =: positionId];
        position.Posting_Status__c = 'Callout in process';
        update position;
        System.debug(settingName);
        System.debug('show me setting id: ' + settingName);
        SendPositionUsingRestApi.createJobAdvertisement(positionId, settingName);
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
    public PageReference updateJobAdvertisement(){
        Position__c position = [select id from Position__c where id =: positionId];
        position.Posting_Status__c = 'Callout in process';
        update position;
        SendPositionUsingRestApi.updateJobAdvertisement(positionId, settingName);
        PageReference tempPage = ApexPages.currentPage();            
        //tempPage.setRedirect(true);
        return tempPage;
        //jgjhghgjhgjgjgjgjgjghhjhhjhgj
    }
    public PageReference deleteJobAdvertisement(){
        Position__c position = [select id from Position__c where id =: positionId];
        position.Posting_Status__c = 'Callout in process';
        update position;
        System.debug(settingName);
        SendPositionUsingRestApi.deleteJobAdvertisement(positionId, settingName);
        PageReference tempPage = ApexPages.currentPage();            
        tempPage.setRedirect(true);
        return tempPage;
    }
}