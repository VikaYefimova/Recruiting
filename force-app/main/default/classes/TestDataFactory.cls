@isTest
public class TestDataFactory {
    public static Integer candidatesListSize;
    public static Integer positionsListSize;
    public static List<Candidate__c> createCandidates(Integer numCandidates){
        List<Candidate__c> candidates = new List<Candidate__c>();
        for(Integer i = 0; i< numCandidates; i++){
            Candidate__c candidate = new Candidate__c(First_Name__c = 'Candidate ' + i, City__c = 'NY');
            candidates.add(candidate);
        }
        insert candidates;
        candidatesListSize = numCandidates;
        return candidates;
    }
    public static List<Position__c> createPositions(Integer numPositions){
        List<Position__c> positions = new List<Position__c>();
        for(Integer j = 0; j< numPositions; j++){
            Position__c position = new Position__c(Name = 'Position ' + j);
            positions.add(position);
        }
        insert positions;
        positionsListSize = numPositions;
        return positions;
    }
    public static List<Job_Application__c> createJobApplications(Integer numApp, List<Candidate__c> candidates, List<Position__c> positions){
        candidates = createCandidates(candidatesListSize);
        positions = createPositions(positionsListSize);
        List<Job_Application__c> jobApplications = new List<Job_Application__c>();
        for(Integer k = 0; k<numApp; k++){
            Candidate__c candidate = candidates[0];
                Position__c position = positions[0];
                    jobApplications.add(new Job_Application__c(Position__c = position.Id, Candidate__c = candidate.id, Stage__c = 'Open', Status__c = 'New'));
        }
        insert jobApplications;
        return jobApplications;
    }
    public static void insertCustomSetting(){
        List_Setting__c testCustomSetting = new List_Setting__c();
        testCustomSetting.Client_Secret__c = '6062214781788623861';
        testCustomSetting.Consumer_Secret__c = '3MVG9fTLmJ60pJ5I9d8FcNmhnOyWg4QBXzptmhuhTNPXtWTsLGzeihB6UX.YrwAW6wOsB2SpHWM8AeoR8FUyz	';
        testCustomSetting.Login_c__c = 'vikaephimova1996@mycomp.com';
        testCustomSetting.Password__c = 'Hibd2014';
        testCustomSetting.Link_to_connected_org__c = 'https://eu16.salesforce.com/';
        testCustomSetting.RecordsCountOnTargetOrg__c = 'https://eu16.salesforce.com/services/apexrest/recordsCount';
        testCustomSetting.ImagesOnTargetOrg__c = 'https://eu16.salesforce.com/services/apexrest/getImages/';
        testCustomSetting.queryLink__c = 'https://eu16.salesforce.com/services/data/v44.0/query/';
        testCustomSetting.tokenLink__c = 'https://eu16.salesforce.com/services/oauth2/token';
        insert testCustomSetting;
    }
}