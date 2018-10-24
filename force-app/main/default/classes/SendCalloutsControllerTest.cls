@isTest(SeeAllData = true)
public class SendCalloutsControllerTest {
    @isTest
    public static void createJobAdvertisementsTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
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
        System.assert(controller.postingFlag);
        Test.stopTest();
    }
    @IsTest
    public static void saveAuthorizationSettingTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        controller.save();
        System.assert(controller.newSettingAfterChangeflag);
        System.assert(!controller.afterChangeFlag);
        /*controller.createButtonAction();
        controller.cancel();*/
    }
    @isTest
    public static void createButtonActionTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        controller.createButtonAction();
        System.assert(controller.afterChangeFlag);
    }
    @isTest
    public static void cancelButtonTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        controller.cancel();
        System.assert(!controller.afterChangeFlag);
    }
    @isTest
    public static void updateJobAdvertisementsTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
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
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
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
    @isTest
    public static void afterDeleteTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Posting_Status__c = 'Posted', Posting_Setting__c = 'Delete successfully');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        controller.deleteJobAdvertisement();
        System.assert(controller.afterDeleteFlag);
        Test.stopTest();
    }
    @isTest
    public static void afterDeleteFlagFalseTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US', Posting_Status__c = 'Posted', Posting_Setting__c = 'Error deleting');
        insert pos;
        PageReference pageRef = Page.UploadCandidatesImage;
        pageRef.getParameters().put('id', pos.id);
        Test.setCurrentPage(pageRef);
        ApexPages.StandardController sc = new ApexPages.StandardController(pos);
    	SendCalloutsController controller = new SendCalloutsController(sc);
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        controller.deleteJobAdvertisement();
        System.assert(!controller.afterDeleteFlag);
        Test.stopTest();
    }
}