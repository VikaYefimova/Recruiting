global class BatchableCalloutsForJobApplication implements Database.Batchable<Integer>,   Database.AllowsCallouts, Database.stateful {
	global List<Integer> listPage = new List<Integer>();
    public Integer pageNumber;
    global List<Integer> countOfRecords = new List<Integer>();
    List<Job_Application__c> listForInsertRecords = new List<Job_Application__c>();
    public BatchableCalloutsForJobApplication(List<Integer> recordsCount){
        this.countOfRecords = recordsCount;
    }
    global Iterable<Integer> start(Database.BatchableContext BC) {
        Integer countSelectedJob = countOfRecords[1];
        pageNumber = (integer)(((countSelectedJob*1.0) / (100 *1.0)).round(RoundingMode.UP) -1);
        for(Integer i = 0; i<=pageNumber; i++){
            listPage.add(i);
        }
        return listPage;
    }
	global void execute(Database.BatchableContext BC, list<Integer> count){
        String responseBody;
		Integer level = 0;
        for(Integer i: count){
            responseBody = InsertingRecordFromSecondOrg.getJobApplicationDataFromSecondOrg(100, i);
            system.debug('responseBody + ' + responseBody);
            listForInsertRecords.addAll(InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(responseBody));
            system.debug('size ' + listForInsertRecords.size());
        }
        System.debug('before listForInsertRecords ' + listForInsertRecords);
        upsert listForInsertRecords Legacy_Job_Application_Number__c;
    }
	global void finish(Database.BatchableContext BC){
        System.debug('heap size' + Limits.getHeapSize());
        BatchableCalloutsForCandidateImages batch = new BatchableCalloutsForCandidateImages(countOfRecords);
		Database.executeBatch(batch, 3);
    }
}