public with sharing class addingCustomSettingsController {   
    
    public String userName {get; set;}
    public Authorization_setting__c authorizationSetting {get; set;}
    
    public addingCustomSettingsController(){
        this.authorizationSetting = new Authorization_setting__c();
        
    }
    public PageReference save(){
        this.authorizationSetting.Name = userName;
        system.debug('i am in save. authorizationSetting='+ authorizationSetting);
        system.debug('userName='+userName);
        authorizationSetting.Name = userName;
        upsert authorizationSetting;
        //return new PageReference('/' + this.authorizationSetting.Id);
		return null;
    }

}