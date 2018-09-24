trigger CreateRelatedTask on Job_Application__c (after update) {
    HelperForCreateTaskTrigger helperForCreateTaskTrigger = new HelperForCreateTaskTrigger();
    helperForCreateTaskTrigger.createTask(Trigger.new, Trigger.oldMap);
}