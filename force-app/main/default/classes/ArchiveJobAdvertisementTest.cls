@isTest(SeeAllData = true)
public class ArchiveJobAdvertisementTest {
    @isTest
    public static void makeJobeAdvertisementsArchive(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        pos.Approval_Status__c = 'Approved';
        pos.Status__c = 'Closed';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        update pos;
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
}