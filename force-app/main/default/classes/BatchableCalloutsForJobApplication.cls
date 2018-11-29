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
            listForInsertRecords.addAll(InsertingRecordFromSecondOrg.parsingJobAppliationsRecords(responseBody));
        }
        Schema.SObjectField fieldForUpsert = Job_Application__c.fields.Legacy_Job_Application_Number__c;
        Database.upsert(listForInsertRecords, fieldForUpsert);
    }
	global void finish(Database.BatchableContext BC){
        BatchableCalloutsForCandidateImages batch = new BatchableCalloutsForCandidateImages(countOfRecords);
		Database.executeBatch(batch, 95);
    }
}