@isTest(SeeAllData = true)
public class SendCalloutsControllerTest {
    @isTest
    public static void createJobAdvertisementsTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = '0050E000002z77hQAA', Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        controller.postJobAdvertisement();
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
    @IsTest
    public static void saveAuthorizationSettingTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = '0050E000002z77hQAA', Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        controller.save();
        controller.createButtonAction();
        controller.cancel();
    }
    @isTest
    public static void updateJobAdvertisementsTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = '0050E000002z77hQAA', Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        controller.updateJobAdvertisement();
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
    @isTest
    public static void deleteJobAdvertisementTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = '0050E000002z77hQAA', Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        controller.deleteJobAdvertisement();
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
}