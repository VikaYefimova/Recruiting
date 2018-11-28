@isTest
public class BatchableCalloutsTest {
	@isTest
    public static void testCallouts(){
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
}