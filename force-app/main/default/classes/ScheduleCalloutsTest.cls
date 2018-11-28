@isTest
public class ScheduleCalloutsTest {
	@isTest
    public static void scheduleCalloutsTest(){
        TestDataFactory.insertCustomSetting();
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