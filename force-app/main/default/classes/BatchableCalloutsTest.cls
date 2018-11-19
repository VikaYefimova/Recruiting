@isTest
public class BatchableCalloutsTest {
	@isTest
    public static void testCallouts(){
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
        BatchableCalloutsForCandidateCV batch = new BatchableCalloutsForCandidateCV();
        Database.executeBatch(batch, 100);
        Test.stopTest();
        List<Candidate__c> cons  = [select id from Candidate__c ];
        system.assertEquals(3, cons.size());
        List<Job_Application__c> jobApplications = [select id from Job_Application__c];
        system.assertEquals(9, jobApplications.size());
        List<ContentVersion> candidatesImages = [select id, ContentDocumentId from ContentVersion];
        system.assertEquals(3, candidatesImages.size());
    }
    @isTest
    public static void testSendCalloutsWhenGetImagesCalloutsThrowEception(){
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
        Test.setMock(HttpCalloutMock.class, new CalloutExceptionMock());
        BatchableCalloutsForCandidateCV batch = new BatchableCalloutsForCandidateCV();
        Database.executeBatch(batch, 100);
        Test.stopTest();
        system.debug('callouts: ' + Limits.getCallouts());
        List<Candidate__c> cons  = [select id from Candidate__c ];
        system.assertEquals(3, cons.size());
        List<Job_Application__c> jobApplications = [select id from Job_Application__c];
        system.assertEquals(9, jobApplications.size());
        List<ContentVersion> candidatesImages = [select id, ContentDocumentId from ContentVersion];
        system.assertEquals(3, candidatesImages.size());
    }
}