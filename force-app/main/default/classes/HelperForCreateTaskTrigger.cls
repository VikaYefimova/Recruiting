public class HelperForCreateTaskTrigger {
    public void createTask(List<Job_Application__c> jobApplications, Map<Id, Job_Application__c> oldJobApplications){
        String status = 'Normal';
        String stage = 'Open';
        List<Task> listOfTasks = new List<Task>();
        for(Job_Application__c jobApplication: jobApplications){
            Job_Application__c oldJobApplication = oldJobApplications.get(jobApplication.id);
            if(jobApplication.Stage__c != oldJobApplication.Stage__c){
                if(jobApplication.Stage__c == 'Closed - Rejected'){
                    Task newRejectedTask = new Task(Status = stage, Priority = status);
                    newRejectedTask.Subject = 'Send Rejection Letter';
                    newRejectedTask.OwnerId = jobApplication.CreatedById;
                    newRejectedTask.Description = 'Job Application '+jobApplication.Name + ' was rejected!!!';
                    listOfTasks.add(newRejectedTask); 
                } 
                if(jobApplication.Stage__c == 'Offer Extended'){
                    Task newExtendedOfferTask = new Task(Status = stage, Priority = status);
                    newExtendedOfferTask.Subject = 'Extend an Offer';
                    newExtendedOfferTask.OwnerId = jobApplication.CreatedById;
                    newExtendedOfferTask.Description = 'Candidate from Job Application: '+jobApplication.Name + ' extend an offer!!!';
                    listOfTasks.add(newExtendedOfferTask);
                }
            }
        }
        try{
            insert listOfTasks;
        }
        catch(DmlException e){	// let's cover this part of code as well (just to practise, how to do it).
            System.debug(e.getMessage());
        }
    }
}