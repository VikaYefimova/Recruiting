@isTest
public class ScheduleCalloutsTest {
	@isTest
    public static void scheduleCalloutsTest(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        insert testCustomSetting;
        List<Position__c> positions = new List<Position__c>();
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPr9AAE');
        Position__c pos2 = new Position__c(Name = 'Test2', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tCyFAAU');
        Position__c pos3 = new Position__c(Name = 'Test3', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPqzAAE');
        positions.add(pos);
        positions.add(pos2);
        positions.add(pos3);
        insert positions;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock());
        ScheduleCallouts job = new ScheduleCallouts();
        Datetime dt = Datetime.now().addMinutes(1);
        String CRON_EXP = '0 '+ dt.minute() + ' * ' + dt.day() + ' ' + dt.month() + ' ? ' + dt.year();
        String jobId = system.schedule('TestJob', CRON_EXP, job);
        CronTrigger ct = [Select id , CronExpression from CronTrigger where id = :jobId];
        System.assertEquals(CRON_EXP,ct.CronExpression);
        Test.stopTest();
    }
}