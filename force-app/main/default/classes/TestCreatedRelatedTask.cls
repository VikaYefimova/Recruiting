@isTest
public class TestCreatedRelatedTask {
    @isTest
    public static void testCreatRejectedTask(){
        List<Candidate__c> candidates = TestDataFactory.createCandidates(1);
        List<Position__c> positions = TestDataFactory.createPositions(1);
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplications(3, candidates, positions);
        for(Integer i = 0; i<jobApplications.size(); i++){
            Job_Application__c jobApplication = jobApplications[i];
            jobApplication.Stage__c = 'Closed - Rejected';
            jobApplication.Status__c = 'Closed';
        }
        Test.startTest(); 
        update jobApplications;
        Test.stopTest();
        List<Task> tasksforRejected = new List<Task>([select id from Task where Subject like 'Send Rejection Letter']);
        List<Task> tasksForExtendOffer = new List<Task>([select id from Task where Subject like 'Extend an Offer']);
        List<Task> listOfTasks = new List<Task>([select id from Task]);
        System.assertEquals(3, listOfTasks.size());
        
    }
    @isTest
    public static void testCreatOfferExtendedTask(){
        List<Candidate__c> candidates = TestDataFactory.createCandidates(1);
        List<Position__c> positions = TestDataFactory.createPositions(1);
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplications(3, candidates, positions);
        for(Integer i = 0; i<jobApplications.size(); i++){
            Job_Application__c jobApplication = jobApplications[i];
            jobApplication.Stage__c = 'Offer Extended';
            jobApplication.Status__c = 'Hold';
        }
        Test.startTest(); 
        update jobApplications;
        Test.stopTest();
        List<Task> tasksforRejected = new List<Task>([select id from Task where Subject like 'Send Rejection Letter']);
        List<Task> tasksForExtendOffer = new List<Task>([select id from Task where Subject like 'Extend an Offer']);
        List<Task> listOfTasks = new List<Task>([select id from Task]);
        System.assertEquals(3, listOfTasks.size());
        
    }
    @isTest
    public static void testNotCreateTask(){
        List<Candidate__c> candidates = TestDataFactory.createCandidates(1);
        List<Position__c> positions = TestDataFactory.createPositions(1);
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplications(3, candidates, positions);
        for(Integer i = 0; i<jobApplications.size(); i++){
            Job_Application__c jobApplication = jobApplications[i];
            jobApplication.Stage__c = 'Closed - Accepted';
            jobApplication.Status__c = 'Closed';
        }
        Test.startTest(); 
        update jobApplications;
        Test.stopTest();
        List<Task> tasksforRejected = new List<Task>([select id from Task where Subject like 'Send Rejection Letter']);
        List<Task> tasksForExtendOffer = new List<Task>([select id from Task where Subject like 'Extend an Offer']);
        List<Task> listOfTasks = new List<Task>([select id from Task]);
        System.assertEquals(0, listOfTasks.size());
    }
    public static void testException(){
         List<Candidate__c> candidates = TestDataFactory.createCandidates(1);
        List<Position__c> positions = TestDataFactory.createPositions(1);
        List<Job_Application__c> jobApplications = TestDataFactory.createJobApplications(3, candidates, positions);
        for(Integer i = 0; i<jobApplications.size(); i++){
            Job_Application__c jobApplication = jobApplications[i];
            jobApplication.Stage__c = 'Closed - Accepted';
            jobApplication.Status__c = 'Closed';
        }
        
    }
}