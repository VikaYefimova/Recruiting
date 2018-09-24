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
}