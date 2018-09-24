@isTest
public class TestTriggerForSentEmail {
    @isTest
    public static void testForSentEmail(){
        Test.startTest();        
        List<Position__c> positions = TestDataFactory.createPositions(3);
        System.assertEquals(1, Limits.getEmailInvocations());
        Test.stopTest();
    }
}