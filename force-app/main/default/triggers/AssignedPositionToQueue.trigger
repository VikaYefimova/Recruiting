trigger AssignedPositionToQueue on Position__c (after insert) {
    HelperForAssigningPositionTrigger helperForAssigningPositionTrigger = new HelperForAssigningPositionTrigger();
    helperForAssigningPositionTrigger.assignPosition(Trigger.new);
}