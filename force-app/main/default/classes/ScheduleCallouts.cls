global class ScheduleCallouts implements Schedulable {
	global void execute(SchedulableContext SC) {
        BatchableCalloutsForCandidateCV batch = new BatchableCalloutsForCandidateCV();
		Database.executeBatch(batch, 2);
   }
}