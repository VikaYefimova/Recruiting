public class exampleController {
	public List_Setting__c authorizationSetting {get; set;}
    public boolean newSettingflag {get; set;}
    public String settingName;
    public exampleController(){
        authorizationSetting = List_Setting__c.getOrgDefaults();
    }
    public PageReference save(){
        upsert authorizationSetting;
        system.debug('i am in save. authorizationSetting='+ authorizationSetting);
        settingName = authorizationSetting.Id;
        newSettingflag = false;
		return null;
    }
    public PageReference cancel(){
        newSettingflag = false;
        return null;
    }
}