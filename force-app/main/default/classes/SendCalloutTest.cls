@isTest(SeeAllData = true)
public class SendCalloutTest {
    @isTest
    public static void testGetDataFromTargetOrg(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = '0050E000002z77hQAA', Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        System.debug('user' + UserInfo.getUserId());
        System.debug('user' + System.UserInfo.getFirstName());
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        SendPositionUsingRestApi.createJobAdvertisement(pos.Id);
        String str = SendPositionUsingRestApi.getDatafromTargetOrg();
        //System.assertEquals('{"attributes":{"type":"Job_Advertisement__c","url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sKeXAAU"},"Name":"hibd","Description__c":"null","Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.id + '","Location__c":"null","Manager_name__c":"Kathy Cooper","Phone__c":"380958645755","Salary__c":"75K-90K","Skills_Required__c":"null","Status__c":"Active","Id":"a001t000001sKeXAAU"}', str);
        Test.stopTest();
        //System.debug('body: ++++ ' + str);
       // res.getBody();
        //System.debug('body: ' + res.getBody());
        
    }
}