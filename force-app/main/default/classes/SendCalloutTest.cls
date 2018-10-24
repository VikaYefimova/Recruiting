@isTest(SeeAllData = true)
public class SendCalloutTest {
    @isTest
    public static void returnAccessTokenTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        SendPositionUsingRestApi sendPos = new SendPositionUsingRestApi();
        String accessToken = sendPos.ReturnAccessToken(sendPos);
        System.assertEquals(1, Limits.getCallouts());
        Test.stopTest();
    }
    @isTest
    public static void createRecordTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        HttpResponse res = SendPositionUsingRestApi.createRecord(pos.Id, '{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com","id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4","token_type":"Bearer","issued_at":"1539163092870","signature":"ntCyy2HdiPC/k8zKx0xBOBMXwgvbPI7JbyI6CHMhMNA="}');
        String expectedValue = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.Id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        System.assertEquals(expectedValue, res.getBody());
        System.assertEquals(1, Limits.getCallouts());
        Test.stopTest();
    }
    @isTest
    public static void updateRecordTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        String parametrString = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.Id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        HttpResponse res = SendPositionUsingRestApi.updateRecord(pos.Id, '{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com","id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4","token_type":"Bearer","issued_at":"1539163092870","signature":"ntCyy2HdiPC/k8zKx0xBOBMXwgvbPI7JbyI6CHMhMNA="}', parametrString);
        System.debug('res body' + res.getBody());
        String expectedValue = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.Id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        System.assertEquals(expectedValue, res.getBody());
        System.assertEquals(1, Limits.getCallouts());
        Test.stopTest();
    }
    @isTest
    public static void deleteRecordTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        String parametrString = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.Id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        HttpResponse res = SendPositionUsingRestApi.deleteRecord(pos.Id, '{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com","id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4","token_type":"Bearer","issued_at":"1539163092870","signature":"ntCyy2HdiPC/k8zKx0xBOBMXwgvbPI7JbyI6CHMhMNA="}', parametrString);
        System.debug('res body' + res.getBody());
        String expectedValue = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        System.debug('futurecall: ' + Limits.getCallouts());
        System.assertEquals(expectedValue, res.getBody());
        System.assertEquals(1, Limits.getCallouts());
        Test.stopTest();
    }
    @isTest
    public static void getMinAndMaxSalaryWithoutSalaryRangeTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Location__c = 'US');
        insert pos;
        List<Integer> salaries = SendPositionUsingRestApi.getMinAndMaxSalary(pos);
        List<Integer> expectedList = new List<Integer>();
        expectedList.add(0);
        expectedList.add(0);
        System.assertEquals(expectedList, salaries);
    }
    @isTest
    public static void getMinAndMaxSalaryWithSalaryRangeTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '130K+', Location__c = 'US');
        insert pos;
        List<Integer> salaries = SendPositionUsingRestApi.getMinAndMaxSalary(pos);
        List<Integer> expectedList = new List<Integer>();
        expectedList.add(130);
        expectedList.add(130);
        System.assertEquals(expectedList, salaries);
    }
    @isTest
    public static void getDataFromtargetOrg(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        String posId = pos.Id;
        String parametrString = '{"attributes":{"type":"Job_Advertisement__c", ' + 
                             '"url":"/services/data/v43.0/sobjects/Job_Advertisement__c/a001t000001sbT5AAI"},"Name":"hibd","Description__c":"null", ' + 
                             '"Education__c":"null","Email__c":"vikaephimova1996@gmail.com","Legacy_Job_Advertisement_Number__c":"' + pos.Id +'", ' + 
                             '"Location__c":"APAC","Manager_name__c":"Kathy Cooper","Maximum_Salary__c":120,"Minimum_Salary__c":90,"Phone__c":"380958645755", ' + 
                             '"Salary__c":"90K-120K","Skills_Required__c":"skills","Status__c":"Active","Id":"a001t000001sbT5AAI"}';
        String data = SendPositionUsingRestApi.getDatafromTargetOrg('{"access_token":"SESSION_ID_REMOVED","instance_url":"https://eu16.salesforce.com","id":"https://login.salesforce.com/id/00D1t000000olmDEAQ/0051t000000KDQRAA4","token_type":"Bearer","issued_at":"1539163092870","signature":"ntCyy2HdiPC/k8zKx0xBOBMXwgvbPI7JbyI6CHMhMNA="}');
        System.assertEquals(parametrString, data);
        System.assertEquals(1, Limits.getCallouts());
    }
    @isTest
    public static void futureCallForCreateRecordTest(){
         Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        SendPositionUsingRestApi.createJobAdvertisement(pos.id);
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
        
    }
    @isTest
    public static void futureCallForUpdateRecordTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        SendPositionUsingRestApi.updateJobAdvertisement(pos.Id);
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
    @isTest
    public static void futureCallForDeleteRecordTest(){
        Position__c pos = new Position__c(Name = 'Test', Hiring_Manager__c = userInfo.getUserId(), Salary_Range__c = '50K-90K', Location__c = 'US');
        insert pos;
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new SendCaloutsMock(pos.Id));
        SendPositionUsingRestApi.deleteJobAdvertisement(pos.id);
        System.assertEquals(1, Limits.getFutureCalls());
        Test.stopTest();
    }
}