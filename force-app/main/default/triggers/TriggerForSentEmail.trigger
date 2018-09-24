trigger TriggerForSentEmail on Position__c (after insert) {
    HelperForSendEmailTrigger helperForSendEmailTrigger = new HelperForSendEmailTrigger();
    helperForSendEmailTrigger.sendEmail(Trigger.new);
}