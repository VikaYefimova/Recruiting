@isTest//(SeeAllData = true)
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
        /*Blob file = Blob.valueOf('image for upload in test');
        Blob file2 = Blob.valueOf('image for upload in test 2222222');
        Blob file3 = Blob.valueOf('image for upload in test 3333333');
        List<ContentVersion> versions = new List<ContentVersion>();
        ContentVersion testImage = new ContentVersion();
        testImage.VersionData = file;
        testImage.title = 'testversion';
        testImage.PathOnClient = '/image.jpg';
        testImage.IsMajorVersion = false;
        testImage.Content_Version_Candidate_Number__c = 'a011t000006pRBZAA2';
        versions.add(testImage);
        ContentVersion testImage2 = new ContentVersion();
        testImage2.VersionData = file2;
        testImage2.title = 'testversion2';
        testImage2.PathOnClient = '/image.jpg';
        testImage2.IsMajorVersion = false;
        testImage2.Content_Version_Candidate_Number__c = 'a011t000006pTq2AAE';
        versions.add(testImage2);
        ContentVersion testImage3 = new ContentVersion();
        testImage3.VersionData = file3;
        testImage3.title = 'testversion';
        testImage3.PathOnClient = '/image.jpg';
        testImage3.IsMajorVersion = false;
        testImage3.Content_Version_Candidate_Number__c = 'a011t000006pTq7AAE';
        versions.add(testImage3);
        insert versions;*/
        List<Position__c> positions = new List<Position__c>();
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPr9AAE');
        
        Position__c pos2 = new Position__c(Name = 'Test2', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tCyFAAU');
        
        Position__c pos3 = new Position__c(Name = 'Test3', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Legacy_Position_Number__c = 'a001t000001tPqzAAE');
        positions.add(pos);
        positions.add(pos2);
        positions.add(pos3);
        insert positions;
        
        
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new InsertingRecordFromSecondOrgMock(positions));
        BatchableCalloutsForCandidateCV batch = new BatchableCalloutsForCandidateCV();
        Database.executeBatch(batch, 100);
        Test.stopTest();
        
        //List<Candidate__c> cans = [select id]
        List<Candidate__c> cons  = [select id from Candidate__c ];
        system.debug('consssssssssssssssssssssssssssssssssssssssssssssssss' + cons.size());
        
    }
}