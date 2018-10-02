public with sharing class addingCustomSettingsController {   
    //public String userName {get; set;}
    public Authorization_setting__c authorizationSetting {get; set;}
    public String settingName ;
    public boolean flag {get; set;}
    //public List<SelectOption> settingsList {set; get;}
    
    public addingCustomSettingsController(ApexPages.StandardController controller){
        flag = false;
        getSettingsList();
        this.authorizationSetting = new Authorization_setting__c();
        
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
        return null;
    }
    public String getSettingName(){
        return settingName;
    }
    public void setSettingName(String settingName){
        this.settingName = settingName;
    }

}